#include <iostream>
#include <array>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include <stdbool.h>
#include <string.h>

using namespace std;

int main(void)
{
    //
    const char *fname = "test_data.txt";
    char buf[4096];
    memset(buf, 0x0, (sizeof(buf) / sizeof(buf[0])) * sizeof(uint8_t));
    bool is_rand_test = true;
    uint8_t a[4][4] = {
        {11, 12, 13, 14},
        {21, 22, 23, 24},
        {31, 32, 33, 34},
        {41, 42, 43, 44}};
    uint8_t b[3][3] = {
        {11, 12, 13},
        {21, 22, 23},
        {31, 32, 33}};

    //

    array<array<uint8_t, 4>, 4> A;
    array<array<uint8_t, 3>, 3> B;
    array<array<uint8_t, 2>, 2> C;

    FILE *f = fopen(fname, "w");

    srand((unsigned)time(NULL));

    for (int i = 0; i < 4; i++)
        for (int j = 0; j < 4; j++)
            if (!is_rand_test)
                A[i][j] = a[i][j];
            else
                A[i][j] = ((uint8_t)rand()) % ((uint8_t)4);

    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 3; j++)
            if (!is_rand_test)
                B[i][j] = b[i][j];
            else
                B[i][j] = ((uint8_t)rand()) % ((uint8_t)4);

    C[0].fill(0);
    C[1].fill(0);
    for (int i0 = 0; i0 < 2; i0++)
        for (int j0 = 0; j0 < 2; j0++)
            for (int i = 0; i < 3; i++)
                for (int j = 0; j < 3; j++)
                    C[i0][j0] += A[i0 + i][j0 + j] * B[2 - i][2 - j];

    sprintf(buf, "// Matrix A\n");
    for (int i = 0; i < A.size(); i++)
        for (int j = 0; j < A[i].size(); j++)
            sprintf(buf + strlen(buf), "parameter[0:7] INPUT_A%d%d = 8\'d%u;\n", i+1, j+1, (unsigned)A[i][j]);

    sprintf(buf + strlen(buf), "\n// Matrix B\n");
    for (int i = 0; i < B.size(); i++)
        for (int j = 0; j < B[i].size(); j++)
            sprintf(buf + strlen(buf), "parameter[0:7] INPUT_B%d%d = 8\'d%u;\n", i+1, j+1, (unsigned)B[i][j]);

    sprintf(buf + strlen(buf), "\n// Matrix C\n");
    for (int i = 0; i < C.size(); i++)
        for (int j = 0; j < C[i].size(); j++)
            sprintf(buf + strlen(buf), "parameter[0:7] ANS_C%d%d = 8\'d%u;\n", i+1, j+1, (unsigned)C[i][j]);

    fprintf(f, "%s", buf);
    cout << buf;

    fclose(f);
    return 0;
}