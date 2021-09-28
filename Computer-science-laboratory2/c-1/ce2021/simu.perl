#!/usr/bin/perl -w

use strict; 

my $TRUE = 1; 
my $FALSE = 0; 
my $SEP = ','; 
my $ERR = 'Error:'; 
my $OK = 'OK:'; 
my $CONT = 'CONT:'; 
my $HALT = 'HALT:'; 
my $TIMEOVER = 'TIME OVER'; 
my $TIME = 'TIME'; 
my $UNDEF = 'UNDEF'; 
my $ILL = 'ILLEGAL'; 
my $NOINST = 'NOINST'; 
#my $exec_head = "num     instruction     R1  R2   X   action"; 
my $exec_head = "num      instruction    R1  R2   X   action"; 
my $none = 'none'; 
my $EXLIM = 1000; 

my %format_reg; 

my %opr_of; 
my %inst_form; 
my %symreg; 
my %errmsg; 

my %labels; 
my @refs = (); 
my $dum; 
my $lim; 

my @prog; 
my %mem; 
my %reg; 
my %lin_num_of; 
my %label_of; 

my $lin_num; 

# const =========================================
$opr_of{'LOD'}  = 'adr'; 
$opr_of{'LODI'} = 'num'; 
$opr_of{'LODX'} = 'num'; 

$opr_of{'STR'}  = 'adr'; 
$opr_of{'STRX'} = 'num'; 

$opr_of{'ADD'}  = 'adr'; 
$opr_of{'ADDI'} = 'num'; 
$opr_of{'ADDX'} = 'num'; 

$opr_of{'SUB'}  = 'adr'; 
$opr_of{'SUBI'} = 'num'; 
$opr_of{'SUBX'} = 'num'; 

$opr_of{'JMP'}  = 'label'; 

$inst_form{'LOD'}  = 'reg <- [M(opr)]'; 
$inst_form{'LODI'} = 'reg <- opr'; 
$inst_form{'LODX'} = 'reg <- [M([X]offset)]'; 
$inst_form{'STR'}  = '[reg] -> M(opr)'; 
$inst_form{'STRX'} = '[reg] -> M([X]offset)'; 
$inst_form{'ADD'}  = 'reg <- [reg] + [M(opr)]'; 
$inst_form{'ADDI'} = 'reg <- [reg] + opr'; 
$inst_form{'ADDX'} = 'reg <- [reg] + [M([X]offset)]'; 
$inst_form{'SUB'}  = 'reg <- [reg] - [M(opr)]'; 
$inst_form{'SUBI'} = 'reg <- [reg] - opr'; 
$inst_form{'SUBX'} = 'reg <- [reg] - [M([X]offset)]'; 
$inst_form{'JMP'}  = '[reg] != 0 then jump to opr'; 
$inst_form{'HLT'}  = 'halt'; 
$inst_form{'Data'}  = ''; 

$symreg{1} = 'R1'; 
$symreg{2} = 'R2'; 
$symreg{'X'} = 'X'; 

$format_reg{1}   = "%4d        "; 
$format_reg{2}   = "    %4d    "; 
$format_reg{'X'} = "        %4d"; 
$format_reg{'none'} = "           %s"; 

$reg{'none'} = ' '; 

$errmsg{'label'} = 'illegal label'; 
$errmsg{'opc'} = 'illegal opecode'; 
$errmsg{'reg'} = 'illegal opr(reg)'; 
$errmsg{'opr'} = 'illegal operand'; 
$errmsg{'ref'} = 'undefined label'; 

# =========================================
my $sw = $ARGV[0]; 
my $prflg = $TRUE; 

if (!defined $sw or $sw eq '-p') {
  pp_prog(); 
}
elsif (defined $sw and $sw =~ /^-e/) {
  ($dum, $lim) = split /=/, $sw; 
  $EXLIM = $lim if (defined $lim); 
  ex_prog();
}
elsif (defined $sw and $sw =~ /^-n/) {
  $prflg = $FALSE; 
  ($dum, $lim) = split /=/, $sw; 
  $EXLIM = $lim if (defined $lim); 
  ex_prog();
}

# pp_prog ---------------------------------------
sub pp_prog {
  $lin_num = 1; 
  while (my $lin = <STDIN>) {
    chomp $lin; 
    if ($lin =~ /^#/) {
      pr_comm($lin); 
      next; 
    }
    my $chk = chk_inst($lin); 
    if ($chk =~ /^$ERR/) {
      err_pr_inst($lin_num, $lin, $chk); 
    }
    else {
      pr_inst($lin_num, $lin); 
    }
    ++$lin_num; 
  }
  my $chk = chk_refs(); 
  if ($chk =~ /^$ERR/) {
    err_pr_refs($chk); 
  }
}

# ex_prog ---------------------------------------
sub ex_prog {
  my $today = `date`;  
  chomp $today; 
  $prog[0] = '# ' . $today; 

  my $exflg = $TRUE; 
  $lin_num = 1; 
  while (my $lin = <STDIN>) {
    chomp $lin; 
    next if ($lin =~ /^#/); 
    my $chk = chk_inst($lin); 
    if ($chk =~ /^$ERR/) {
      $exflg = $FALSE; 
      err_pr_inst($lin_num, $lin, $chk); 
      ++$lin_num; 
    }
    else {
      $lin_num = load_inst($lin_num, $lin); 
    }
  }
  my $chk = chk_refs(); 
  if ($chk =~ /^$ERR/) {
    $exflg = $FALSE; 
    err_pr_refs($chk); 
  }

  return if (!$exflg);

  pr_mem(); 
  $lin_num = 1; 
  pr_exec(ex_insts()); 
  pr_mem(); 
  pr_reg(); 
}

# ex_insts ---------------------------------------
sub ex_insts {
  my $ex; 
  my $tc = 1; 
  pr_exec_head() if ($prflg); 
  do {
    if ($tc > $EXLIM) {
      return join $SEP, ($TIMEOVER, $EXLIM); 
    }
    if (!defined $prog[$lin_num]) {
      return join $SEP, ($NOINST, $lin_num); 
    }
    my $inst = $prog[$lin_num]; 
    pr_label_inst($lin_num) if ($prflg); 
    $ex = ex_inst($inst); 
    pr_ex_inst($ex) if ($prflg); 
    ++$tc; 
  }
  while ($ex =~ /^$CONT/); 
  return $ex; 
}

# ex_inst ---------------------------------------
sub ex_inst {
  my ($inst) = @_; 

  (my $opc, my $r, my $anl) = split $SEP, $inst; 
# LODx
  if ($opc eq 'LOD') {
    if (!exists $mem{$anl}) {
      return join $SEP, ($UNDEF, "M($anl)"); 
    }
    $reg{$r} = $mem{$anl}; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $r, "$symreg{$r} <- [M($anl)]"); 
  }
  if ($opc eq 'LODI') {
    $reg{$r} = $anl; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $r, "$symreg{$r} <- $anl"); 
  }
  if ($opc eq 'LODX') {
    if (!exists $reg{'X'}) {
      return join $SEP, ($UNDEF, $symreg{'X'}); 
    }
    my $adr = $reg{'X'} + $anl; 
    if ($adr < 0) {
      return join $SEP, ($ILL, $adr); 
    }
    if (!exists $mem{$adr}) {
      return join $SEP, ($UNDEF, "M($adr)"); 
    }
    $reg{$r} = $mem{$adr}; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $r, "$symreg{$r} <- [M($adr)]"); 
  }

# ADDx
  if ($opc eq 'ADD') {
    if (!exists $reg{$r}) {
      return join $SEP, ($UNDEF, "$symreg{$r}"); 
    }
    if (!exists $mem{$anl}) {
      return join $SEP, ($UNDEF, "M($anl)"); 
    }
    $reg{$r} = $reg{$r} + $mem{$anl}; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $r, "$symreg{$r} <- [$symreg{$r}] + [M($anl)]"); 
  }
  if ($opc eq 'ADDI') {
    if (!exists $reg{$r}) {
      return join $SEP, ($UNDEF, "$symreg{$r}"); 
    }
    $reg{$r} = $reg{$r} + $anl; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $r, "$symreg{$r} <- [$symreg{$r}] + $anl"); 
  }
  if ($opc eq 'ADDX') {
    if (!exists $reg{$r}) {
      return join $SEP, ($UNDEF, "$symreg{$r}"); 
    }
    if (!exists $reg{'X'}) {
      return join $SEP, ($UNDEF, $symreg{'X'}); 
    }
    my $adr = $reg{'X'} + $anl; 
    if ($adr < 0) {
      return join $SEP, ($ILL, $adr); 
    }
    if (!exists $mem{$adr}) {
      return join $SEP, ($UNDEF, "M($adr)"); 
    }
    $reg{$r} = $reg{$r} + $mem{$adr}; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $r, "$symreg{$r} <- [$symreg{$r}] + [M($adr)]"); 
  }

# SUBx
  if ($opc eq 'SUB') {
    if (!exists $reg{$r}) {
      return join $SEP, ($UNDEF, "$symreg{$r}"); 
    }
    if (!exists $mem{$anl}) {
      return join $SEP, ($UNDEF, "M($anl)"); 
    }
    $reg{$r} = $reg{$r} - $mem{$anl}; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $r, "$symreg{$r} <- [$symreg{$r}] - [M($anl)]"); 
  }
  if ($opc eq 'SUBI') {
    if (!exists $reg{$r}) {
      return join $SEP, ($UNDEF, "$symreg{$r}"); 
    }
    $reg{$r} = $reg{$r} - $anl; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $r, "$symreg{$r} <- [$symreg{$r}] - $anl"); 
  }
  if ($opc eq 'SUBX') {
    if (!exists $reg{$r}) {
      return join $SEP, ($UNDEF, "$symreg{$r}"); 
    }
    if (!exists $reg{'X'}) {
      return join $SEP, ($UNDEF, $symreg{'X'}); 
    }
    my $adr = $reg{'X'} + $anl; 
    if ($adr < 0) {
      return join $SEP, ($ILL, $adr); 
    }
    if (!exists $mem{$adr}) {
      return join $SEP, ($UNDEF, "M($adr)"); 
    }
    $reg{$r} = $reg{$r} - $mem{$adr}; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $r, "$symreg{$r} <- [$symreg{$r}] - [M($adr)]"); 
  }

# STRx
  if ($opc eq 'STR') {
    if (!exists $reg{$r}) {
      return join $SEP, ($UNDEF, "$symreg{$r}"); 
    }
    $mem{$anl} = $reg{$r}; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $none, "[$symreg{$r}] = $reg{$r} -> M($anl)"); 
  }
  if ($opc eq 'STRX') {
    if (!exists $reg{$r}) {
      return join $SEP, ($UNDEF, "$symreg{$r}"); 
    }
    if (!exists $reg{'X'}) {
      return join $SEP, ($UNDEF, $symreg{'X'}); 
    }
    my $adr = $reg{'X'} + $anl; 
    if ($adr < 0) {
      return join $SEP, ($ILL, $adr); 
    }
    $mem{$adr} = $reg{$r}; 
    $lin_num = $lin_num + 1; 
    return join $SEP, ($CONT, $none, "[$symreg{$r}] = $reg{$r} -> M($adr)"); 
  }

# JMP
  if ($opc eq 'JMP') {
    if (!exists $reg{$r}) {
      return join $SEP, ($UNDEF, "$symreg{$r}"); 
    }
    if ($reg{$r} == 0) {
      $lin_num = $lin_num + 1; 
      return join $SEP, ($CONT, $none, "[$symreg{$r}] == 0 then go next"); 
    }
    else {
      $lin_num = $lin_num_of{$anl}; 
      return join $SEP, ($CONT, $none, "[$symreg{$r}] != 0 then jump to line $lin_num"); 
    }
  }

# HLT
  if ($opc eq 'HLT') {
    return $HALT; 
  }
}

# chk_XXX ---------------------------------------
sub chk_inst {
  my ($inst) = @_; 
  my $chk; 

  (my $lab_adr, my $opc, my $r_num, my $opr) = split /\s+/, $inst; 
  $lab_adr = '' if (!defined $lab_adr); 
  $opc = '' if (!defined $opc); 
  $r_num = '' if (!defined $r_num); 
  $opr = '' if (!defined $opr); 
  if (chk_adr($lab_adr)) { # adr Data num
    if ($opc ne 'Data') {
      return join $SEP, ($ERR, 'opc'); 
    }
    elsif (!chk_num($r_num)) {
      return join $SEP, ($ERR, 'opr'); 
    }
    else {
      return $OK; 
    }
  }

  if (chk_label($lab_adr)) {
    $labels{$lab_adr} = 0; 
  }
  elsif ($lab_adr ne "") {
    return join $SEP, ($ERR, 'label'); 
  }

  if ($opc eq 'HLT') { # HLT
    return $OK; 
  }

  if (!chk_opc($opc)) { # LOD*, STR*, ADD*, SUB*, JMP
    return join $SEP, ($ERR, 'opc'); 
  }

  if (!chk_reg($r_num)) {
    return join $SEP, ($ERR, 'reg'); 
  }

  if ($opr_of{$opc} eq 'adr') {
    if (chk_adr($opr)) {
      return $OK; 
    }
  }
  elsif ($opr_of{$opc} eq 'num') {
    if (chk_num($opr)) {
      return $OK; 
    }
  }
  elsif ($opr_of{$opc} eq 'label') {
    if (chk_label($opr)) {
      push @refs, $opr; 
      return $OK; 
    }
  }
  return join $SEP, ($ERR, 'opr'); 
}

sub chk_label {
  my ($l) = @_; 

  if ($l =~ /^[A-Z]\w?$/) {
    return $TRUE; 
  }
  return $FALSE; 
}

sub chk_opc {
  my ($o) = @_; 

  if (exists $opr_of{$o}) {
    return $TRUE; 
  }
  return $FALSE; 
}

sub chk_reg {
  my ($r) = @_; 

  $r = '' if (!defined $r); 
  if ($r eq '1' or $r eq '2' or $r eq 'X') {
    return $TRUE; 
  }
  return $FALSE; 
}

sub chk_adr {
  my ($a) = @_; 

  $a = '' if (!defined $a); 
  if ($a =~ /^[1-9]\d*$/ or $a eq '0') {
    return $TRUE; 
  }
  return $FALSE; 
}

sub chk_num {
  my ($n) = @_; 

  if ($n =~ /^-?[1-9]\d*$/ or $n eq '0') {
    return $TRUE; 
  }
  return $FALSE; 
}

sub chk_refs {
  my @err_labels = ($ERR); 
  foreach my $label (@refs) {
    if (!exists $labels{$label}) {
      push @err_labels, $label; 
    }
    else {
      ++$labels{$label}; 
    }
  }
  if ($#err_labels == 0) {
    return $OK; 
  }
  else {
    return join $SEP, @err_labels;
  }
}

# pr_XXX, err_pr_XXX ---------------------------------------
sub pr_comm {
  my ($comm) = @_; 
  print "     $comm\n"; 
}

sub pr_mem {
  my @adrs = sort {$a <=> $b} keys %mem; 
  if (@adrs == 0) {
    return; 
  }
  print "[Memory]\n"; 
  print "adr value\n"; 
  foreach my $adr (@adrs) {
    printf "%3d%6d\n", $adr, $mem{$adr}; 
  }
  print "\n"; 
}

sub pr_reg {
  print "[Register]\n"; 
  foreach my $r (sort keys %symreg) {
    if (defined $reg{$r}) {
      printf "%2s: %3s\n", $symreg{$r}, $reg{$r}; 
    }
    else {
      printf "%2s: %3s\n", $symreg{$r}, 'undef'; 
    }
  }
  print "\n"; 
}

sub pr_inst {
  my ($lin_num, $inst) = @_; 
  pr_lin_num_inst($lin_num, $inst); 

  ($dum, my $opc, my $reg, my $opr) = split /\s+/, $inst; 
  $opc = '' if (!defined $opc); 
  $reg = '' if (!defined $reg); 
  $opr = '' if (!defined $opr); 
  my $offset = $opr; 
  if (chk_num($offset) and $offset >= 0) {
    $offset = '+' . $offset; 
  }
  my $form = $inst_form{$opc}; 
  $form =~ s/reg/$symreg{$reg}/g; 
  $form =~ s/opr/$opr/g; 
  $form =~ s/offset/$offset/g; 
  print " #  $form\n"; 
}

sub err_pr_inst {
  my ($lin_num, $inst, $chk) = @_; 
  pr_lin_num_inst($lin_num, $inst); 
  (my $dum, my $lcr) = split /$SEP/, $chk; 
  printf "## %s", $errmsg{$lcr}; 
  print "\n"; 
}

sub err_pr_refs {
  my ($chk) = @_; 
  my @errs = split /$SEP/, $chk; 

  printf "# %s -- ", $errmsg{'ref'}; 
  for (my $k = 1; $k <= $#errs; ++$k) {
    print " $errs[$k]"; 
  }
  print "\n"; 
}

sub pr_lin_num_inst {
  my ($lin_num, $inst) = @_; 

  (my $lab_adr, my $opc, my $r_num, my $opr) = split /\s+/, $inst; 
  $lab_adr = '' if (!defined $lab_adr); 
  $opr = '' if (!defined $opr); 
  $r_num = '' if (!defined $r_num); 
  $opc = '' if (!defined $opc); 
  if ($opc eq 'HLT') {
    $r_num = ''; 
    $opr = ''; 
  }
  if ($opc eq 'Data') {
    $opr = ''; 
  }
#  printf "%3d: %-2s %-4s %2s %3s ", $lin_num, $lab_adr, $opc, $r_num, $opr; 
  if ($opc eq 'Data') {
    printf "%3d: %-3s %-4s %3s ", $lin_num, $lab_adr, $opc, $r_num; 
  }
  else {
    printf "%3d: %-3s %-4s %1s %3s ", $lin_num, $lab_adr, $opc, $r_num, $opr; 
  }
}

sub pr_exec {
  my $htime = time;  
  my ($ex) = @_; 
  (my $code, my $val) = split $SEP, $ex; 
  if ($code eq $HALT) {
    print "## halt ($htime)\n\n"; 
  }
  elsif ($code eq $NOINST) {
    print "!! no instruction -- line $val\n\n"; 
  }
  elsif ($code eq $TIMEOVER) {
    print "!! time over -- $val\n\n"; 
  }
}

sub pr_label_inst {
  my ($lin_num) = @_; 
  my $label = ''; 
  if (exists $label_of{$lin_num}) {
    $label = $label_of{$lin_num}; 
  }
  (my $opc, my $r, my $opr) = split $SEP, $prog[$lin_num]; 
#  printf "%3d: %-2s %-4s %2s %3s ", $lin_num, $label, $opc, $r, $opr; 
  printf "%3d: %-3s %-4s %1s %3s ", $lin_num, $label, $opc, $r, $opr; 
}

sub pr_ex_inst {
  my ($ex) = @_; 
  (my $cond, my $r_val, my $action) = split $SEP, $ex; 
  if ($cond eq $CONT) {
    printf "# $format_reg{$r_val} # %s\n", $reg{$r_val}, $action; 
    return; 
  }
  if ($cond eq $HALT) {
    print "\n"; 
    return; 
  }
  if ($cond eq $UNDEF) {
    printf "# undefined -- %s\n\n", $r_val; 
    return; 
  }
  if ($cond eq $ILL) {
    printf "# illegal address -- %s\n\n", $r_val; 
    return; 
  }
}

sub pr_exec_head {
  my $len_head = length $exec_head; 
  print "[Execution]\n"; 
  printf "%s\n%s\n", $exec_head, '-' x ($len_head+20); 
}

# load_inst ---------------------------------------
sub load_inst {
  my ($lin_num, $inst) = @_; 

  (my $lab_adr, my $opc, my $r_num, my $opr) = split /\s+/, $inst; 

  if ($opc eq 'Data') { # Data
    $mem{$lab_adr} = $r_num; 
    return $lin_num; 
  }

  if (chk_label($lab_adr)) { # Label
    $lin_num_of{$lab_adr} = $lin_num; 
    $label_of{$lin_num} = $lab_adr; 
  }
  if ($opc eq 'HLT') { # HLT
    $r_num = ''; 
    $opr = ''; 
  }
  $prog[$lin_num] = $opc . $SEP . $r_num . $SEP . $opr; 
  return $lin_num+1; 
}

