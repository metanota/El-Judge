#include <iostream>

int main() {

    long input[1000];
    int digit;

    int co1 = 0;
    for(;;) {
        std::cin >> digit;
        if (digit != -1) {
            input[co1] = digit;
            co1++;
        }
        else break;
    }

    long *first = new long[co1];
    for (int temp = 0; temp < co1; temp++)
        first[temp] = input[temp];

    int co2=0;
    for (;;) {
        std::cin >> digit;
        if (digit != -1) {
            input[co2] = digit;
            co2++;
        }
        else break;
    }

    long *second = new long[co2];
    for (int temp = 0; temp < co2; temp++)
        second[temp] = input[temp];

    long *third = new long[co1 < co2 ? co1 : co2];

    int count = 0;
    bool flag = true;

    for (int x = 0; x < co1; x++) {
        for (int y = 0; y < co2; y++) {
            if (first[x] == second[y]) {
                for (int z = 0; z < count; z++) {
                    if (third[z] == first[x]) {
                        flag = false;
                        break;
                    }
                }
                if (flag) {
                    third[count] = first[x];
                    count++;
                }
                flag = true;
                break;
            }
        }
    }

    if (!count) {
        std::cout << "empty";
        return 0;
    }
    for (int temp = 0; temp < count; temp++) {
        std::cout << third[temp] << ' ';
    }

    return 0;
}
