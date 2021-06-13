#include <stdio.h>
#include <stdlib.h>
#include <math.h>
/* 関数のプロトタイプ宣言 */
unsigned char *read_ppm(char *fname, int *width, int *height);
void save_pgm(char *fname, unsigned char *gray, int width, int height);
void trans(unsigned char *src, unsigned char *out, int width, int height, int g[]);
void edge5(unsigned char *src, unsigned char *out, int width, int height, int threshold);
void edge6(unsigned char *src, unsigned char *out, int width, int height, int threshold);
void sobel(unsigned char *src, unsigned char *out, int width, int height, int threshold);
void laplacian(unsigned char *src, unsigned char *out, int width, int height, int threshold);


int main(int argc, char *argv[]){
    int width, height;        /* 入力画像のサイズ */
    unsigned char *src, *out; /* 白黒画像：それぞれ入力用と出力用に対応 */
    int f;                    /* 入力の画素値（入力：図 1 の横軸に相当） */
    int g[256] = {0};         /* 出力の画素値（出力：図 1 の縦軸に相当） */
    int f_L = 0, f_H = 9;   /* 適切に値を変更 ：必ず f_L < f_H とすること */
    double gamma = 4.0;
    int kadai = 0;            /* 課題番号 : 実行ファイルの引数で値を指定 <== argv[3][0] （一文字）*/
    /* 入力ファイル名 <== argv[1], 出力ファイル名 <== argv[2] */
    if (argc != 4){
        printf("usage: %s <source-image.ppm> <output-image.pgm> <kadai No.>\n", argv[0]);
        return 0;
    }
    /* 課題番号 */
    kadai = argv[3][0] - '0'; /* 1 文字目を数値化　*/
    /* カラー画像のファイルを白黒化して読み込み */
    src = read_ppm(argv[1], &width, &height);
    if (kadai == 1){ /* 白黒化した入力画像の保存 */
        save_pgm(argv[2], src, width, height);
        free(src);
        return 0;
    }
    /* 出力画像バッファの作成 */
    out = (unsigned char *)malloc(width * height);
    switch (kadai)
    {
    case 2: /* 濃度変換 ： 白黒反転 */
        for (f = 0; f <= 255; f++){
            g[f] = 255 - f; /* ルックアップテーブル */
        }
        /* 濃度変換関数を用いた変換 */
        trans(src, out, width, height, g);
        break;
    case 3: /* 濃度変換 ： 図 1 */
        for (f = 0; f < f_L; f++){
            g[f] = 0; /* ルックアップテーブル */
        }
        for (f = f_L; f < f_H; f++){
            g[f] = (int)(255.0 / (f_H - f_L) * (f - f_L) + 0.5); /* ルックアップテーブル */
        }
        for (f = f_H; f <= 255; f++){
            g[f] = 255; /* ルックアップテーブル */
        }
        /* 濃度変換関数を用いた変換 */
        trans(src, out, width, height, g);
        break;
    case 4: /* 濃度変換 ： ガンマ変換 */
        for (f = 0; f <= 255; f++){
            g[f] = 255*pow(((1.0*f/255)), (1.0/gamma));; /* ルックアップテーブル */
        }
        /* 濃度変換関数を用いた変換 */
        trans(src, out, width, height, g);
        break;
    case 5: /* エッジ検出 ： 図 2(a) */
        edge5(src, out, width, height, 40);
        break;
    case 6: /* エッジ検出 ： 図 2(b) */
        edge6(src, out, width, height, 60);
        break;
    case 7: /* エッジ検出 ： sobel */
        sobel(src, out, width, height, 100);
        break;
    case 8: /* エッジ検出 ： ラプラシアン */
        laplacian(src, out, width, height, 110);
        break;
    default:
        fprintf(stderr, "正しい課題番号を指定してください！\n");
        free(src);
        free(out);
        return -1;
    }
    /* 出力画像の保存 */
    save_pgm(argv[2], out, width, height);
    free(src);
    free(out);
    return 0;
}

void trans(unsigned char *src, unsigned char *out, int width, int height, int g[]){
    int x, y, i;
    for (y = 0; y < height; y++){
        for (x = 0; x < width; x++){
            i = width * y + x;
            out[i] = g[src[i]];
        }
    }

    return;
}

void edge5(unsigned char *src, unsigned char *out, int width, int height, int threshold){
    int x, y, i, val;
    int op[9] = {-1, 0, 1, -2, 0, 2, -1, 0, 1};
    /* 上下左右の縁 */
    for (x = 0; x < width; x++){
        out[x] = 0;                        /* 上端 */
        out[width * (height - 1) + x] = 0; /* 下端 */
    }
    for (y = 1; y < height - 1; y++){
        out[width * y] = 0;             /* 左端 */
        out[width * y + width - 1] = 0; /* 右端 */
    }
    /* 内側の処理 */
    for (y = 1; y < height - 1; y++){
        for (x = 1; x < width - 1; x++){
            i = width * y + x;
            val = op[0] * src[i - width - 1] + op[1] * src[i - width] + op[2] * src[i - width + 1] +
                  op[3] * src[i - 1] + op[4] * src[i] + op[5] * src[i + 1] +
                  op[6] * src[i + width - 1] + op[7] * src[i + width] + op[8] * src[i + width + 1];

            if (val >= threshold){
                out[i] = 255;
            }else{
                out[i] = 0;
            }
        }
    }

    return;
}

void edge6(unsigned char *src, unsigned char *out, int width, int height, int threshold){
    int x, y, i, val;
    int op[9] = {-1, -2, -1, 0, 0, 0, 1, 2, 1};
    /* 上下左右の縁 */
    for (x = 0; x < width; x++){
        out[x] = 0;                        /* 上端 */
        out[width * (height - 1) + x] = 0; /* 下端 */
    }
    for (y = 1; y < height - 1; y++){
        out[width * y] = 0;             /* 左端 */
        out[width * y + width - 1] = 0; /* 右端 */
    }
    /* 内側の処理 */
    for (y = 1; y < height - 1; y++){
        for (x = 1; x < width - 1; x++){
            i = width * y + x;
            val = op[0] * src[i - width - 1] + op[1] * src[i - width] + op[2] * src[i - width + 1] +
                  op[3] * src[i - 1] + op[4] * src[i] + op[5] * src[i + 1] +
                  op[6] * src[i + width - 1] + op[7] * src[i + width] + op[8] * src[i + width + 1];

            if (val >= threshold){
                out[i] = 255;
            }else{
                out[i] = 0;
            }
        }
    }

    return;
}

void sobel(unsigned char *src, unsigned char *out, int width, int height, int threshold){
    int x, y, i, val, valH, valW;
    int op1[9] = {-1, 0, 1, -2, 0, 2, -1, 0, 1};
    int op2[9] = {-1, -2, -1, 0, 0, 0, 1, 2, 1};

    /* 上下左右の縁 */
    for (x = 0; x < width; x++){
        out[x] = 0;                        /* 上端 */
        out[width * (height - 1) + x] = 0; /* 下端 */
    }
    for (y = 1; y < height - 1; y++){
        out[width * y] = 0;             /* 左端 */
        out[width * y + width - 1] = 0; /* 右端 */
    }
    /* 内側の処理 */
    for (y = 1; y < height - 1; y++){
        for (x = 1; x < width - 1; x++){
            i = width * y + x;

            valH = op1[0] * src[i - width - 1] + op1[1] * src[i - width] + op1[2] * src[i - width + 1] +
                  op1[3] * src[i - 1] + op1[4] * src[i] + op1[5] * src[i + 1] +
                  op1[6] * src[i + width - 1] + op1[7] * src[i + width] + op1[8] * src[i + width + 1];

            valW = op2[0] * src[i - width - 1] + op2[1] * src[i - width] + op2[2] * src[i - width + 1] +
                  op2[3] * src[i - 1] + op2[4] * src[i] + op2[5] * src[i + 1] +
                  op2[6] * src[i + width - 1] + op2[7] * src[i + width] + op2[8] * src[i + width + 1];

            val = sqrt(valH*valH + valW*valW);

            if (val >= threshold){
                out[i] = 255;
            }else{
                out[i] = 0;
            }
        }
    }
    return;
}

void laplacian(unsigned char *src, unsigned char *out, int width, int height, int threshold){
    int x, y, i, val;
    int op[9] = {1, 1, 1, 1, -8, 1, 1, 1, 1};
    /* 上下左右の縁 */
    for (x = 0; x < width; x++){
        out[x] = 0;                        /* 上端 */
        out[width * (height - 1) + x] = 0; /* 下端 */
    }
    for (y = 1; y < height - 1; y++){
        out[width * y] = 0;             /* 左端 */
        out[width * y + width - 1] = 0; /* 右端 */
    }
    /* 内側の処理 */
    for (y = 1; y < height - 1; y++){
        for (x = 1; x < width - 1; x++){
            i = width * y + x;
            val = op[0] * src[i - width - 1] + op[1] * src[i - width] + op[2] * src[i - width + 1] +
                  op[3] * src[i - 1] + op[4] * src[i] + op[5] * src[i + 1] +
                  op[6] * src[i + width - 1] + op[7] * src[i + width] + op[8] * src[i + width + 1];

            if(val < 0){
                val = -val;
            }

            if (val >= threshold){
                out[i] = 255;
            }else{
                out[i] = 0;
            }
        }
    }
    return;
}

unsigned char *read_ppm(char *fname, int *width, int *height){
    char str[256], c;
    int max = 0;
    unsigned char *gray = NULL;
    int r = 0, g = 0, b = 0;
    int size = 0;
    int i;
    FILE *fp = fopen(fname, "rb");
    if (fp == NULL)
    {
        fprintf(stderr, "error: %s cannot open!", fname);
        exit(-1);
    }
    /* ------------ Magic number ---------- */
    fscanf(fp, "%s", str);
    c = str[1];
    if (c == '3' || c == '6')
    {
        /* ------------ comment, space, or size ---------- */
        fscanf(fp, "%s", str);
        if (str[0] == '#' || str[0] == ' ')
        {
            while (fscanf(fp, "%c", &str[0]))
            { /* comment skip */
                if (str[0] == '\n')
                    break;
            }
            fscanf(fp, "%d %d", width, height);
        }
        else
        {
            sscanf(str, "%d", width);
            fscanf(fp, "%d", height);
        }
        /* ------------ comment, space, or max value ---------- */
        fscanf(fp, "%d", &max);
        /* ------------ memory create ---------- */
        size = (*width) * (*height);
        gray = (unsigned char *)malloc(size);
        /* ------------ pixel value ---------- */
        if (c == '3'){ /* テキストデータ */
            for (i = 0; i < size; i++)
            {
                fscanf(fp, "%d %d %d", &r, &g, &b);
                gray[i] = (unsigned char)(0.299 * r + 0.587 * g + 0.114 * b + 0.5);
            }
        }
        else
        {                        /* バイナリデータ */
            fread(&r, 1, 1, fp); /* LF */
            for (i = 0; i < size; i++)
            {
                fread(&r, 1, 1, fp);
                fread(&g, 1, 1, fp);
                fread(&b, 1, 1, fp);
                gray[i] = (unsigned char)(0.299 * r + 0.587 * g + 0.114 * b + 0.5);
            }
        }
    }
    else
        fprintf(stderr, "[%s] is not a ppm-file!\n", fname);
    fclose(fp);
    return gray;
}

void save_pgm(char *fname, unsigned char *gray, int width, int height)
{
    int x, y;
    FILE *fp = fopen(fname, "wb");
    fprintf(fp, "P5\n");
    fprintf(fp, "%d %d\n", width, height);
    fprintf(fp, "255\n");

    for (y = 0; y < height; y++){
        for (x = 0; x < width; x++){
            fwrite(&gray[width * y + x], 1, 1, fp);
        }
    }

    fclose(fp);
    return;
}
