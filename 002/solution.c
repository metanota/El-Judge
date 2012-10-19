#include <stdio.h>

int main() {

    long first[1000];
    long second[1000];
    long third[1000];
    int digit;
    int co1 = 0;
    int co2 = 0;
    int temp;
    int count = 0;
    int flag  = 1;
    int x;
    int y;
    int z;

    for(;;) {
        scanf("%d", &digit);
        if (digit != -1) {
        first[co1] = digit;
            co1++;
        }
        else break;
    }
    for(;;) {
        scanf("%d", &digit);
        if(digit != -1) {
            second[co2] = digit;
            co2++;
        }
        else break;
    }

    for (x = 0; x < co1; x++) {
        for (y = 0; y < co2; y++) {
            if (first[x] == second[y]) {
                for (z = 0; z < count; z++) {
                    if (third[z] == first[x]) {
                        flag = 0;
                        break;
                    }
                }
                if (flag) {
                    third[count] = first[x];
                    count++;
                }
                flag = 1;
                break;
            }
        }
    }

    if (!count) {
        printf("empty");
        return 0;
    }
    else {
        temp = 0;
        while (temp < count) {
            printf("%d ", third[temp]);
            temp++;
        }
    }

    return 0;
}
