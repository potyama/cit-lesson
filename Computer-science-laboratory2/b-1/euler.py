import numpy as np # あとで必要
import matplotlib.pyplot as plt # グラフ描画用

def euler(x0, tau, ts, tf, f):
    ti = ts  # ti: 前進オイラー法のアルゴリズムのti
    xi = x0 # xi: 前進オイラー法のアルゴリズムのx(ti)
    tlist = [ ti ]
    xlist = [ x0 ]
    # tiがtfにたどり着いたら終了
    while ti < tf:
        tip1 = ti + tau # tipi: 前進オイラー法のアルゴリズムのt_{i+1} (次の時刻)
        xip1 = xi + (tip1 - ti)* f(ti, xi) # [入力]:問7の解答(前進オイラー法のアルゴリズム)を記入
        tlist.append(tip1) # 時刻記録用: リストの末尾に時刻を追加
        xlist.append(xip1) # 結果の記録用: リストの末尾に結果xip1を追加
        ti, xi = tip1, xip1 # 時刻tip1と結果xip1は、次の時刻における初期値

    return (tlist, xlist)

def population( t, N ):
    fN = np.zeros_like(N)
    gamma = 0.03 # [入力]: 人口の増減率(マルサスモデルのパラメータ)を入力
    fN[0] = gamma*N[0] # マルサスモデルの右辺: N[0]が方程式の未知変数N
    return fN

N0 = np.zeros(1)
N0[0] =  5500    # [入力]:人口の初期値(1920年の人口を万人で入力。10万人なら10と入力)
begin_year = 1920 # [入力]: 解き始めの時刻を西暦で入力.西暦2000年なら2000と入力)
end_year = 2008  # [入力]: 終了時刻を西暦で入力.西暦2000年なら2000と入力)

t, N = euler(N0, 0.1, begin_year, end_year, population) # 前進オイラー法で解く

plt.plot(t, N) # 図の描画
plt.xlabel('Year')
plt.ylabel('Population [* 10,000]')
plt.show() # 図の描画
