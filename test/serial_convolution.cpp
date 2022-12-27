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
    const char *fname = "serial_convolution_data.txt";
    char buf[4096];
    memset(buf, 0x0, (sizeof(buf) / sizeof(buf[0])) * sizeof(uint8_t));
    //

    FILE *f = fopen(fname, "w");

    int k = 0;
    for (int i0 = 0; i0 < 2; i0++)
        for (int j0 = 0; j0 < 2; j0++){
            for (int i = 0; i < 3; i++){
                for (int j = 0; j < 3; j++){
                    sprintf(buf + strlen(buf), "S%02d:begin CUR_WEIGHT=A%d%d; CUR_DATA=B%d%d; end\n", k, i0+i, j0+j, 2-i, 2-j);
                    k++;
                }
            }
        }

    cout << buf;
    fclose(f);
    return 0;
}