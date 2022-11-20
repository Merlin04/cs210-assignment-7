#include <stdint.h>
#include <stdio.h>

// original implementation
uint32_t decaying_sum(uint16_t* values, uint16_t length, uint16_t decay) {
    // printf("decaying_sum(%d, %d, %d)\n", values[0], length, decay);
    if(length <= 0) {
        return 0;
    }
    uint32_t rest = decaying_sum(&values[1], length - 1, decay);
    uint32_t decayed = rest / decay;
    return values[0] + decayed;
}

// tail recursive implementation

uint32_t _decaying_sum_tr(uint32_t res, uint16_t* values, uint16_t length, uint16_t decay) {
    // printf("_decaying_sum_tr(%d, %d, %d, %d)\n", res, *values, length, decay);
    if(length <= 0) return res;
    return _decaying_sum_tr(res + (values[0] / decay), &values[1], length - 1, decay * decay);
}
uint32_t decaying_sum_tr(uint16_t* values, uint16_t length, uint16_t decay) {
    // printf("decaying_sum_tr(%d, %d, %d)\n", values[0], length, decay);
    return _decaying_sum_tr(values[0], &values[1], length - 1, decay);
}

int main() {
    // random enough
    uint16_t values[] = { 1, 5, 8, 3 };
    uint16_t length = sizeof(values) / sizeof(values[0]);
    uint16_t decay = 2;
    printf("about to run\n");
    uint32_t sum = decaying_sum(values, length, decay);
    printf("sum: %d\n", sum);
    uint32_t sum_tr = decaying_sum_tr(values, length, decay);
    printf("sum_tr: %d\n", sum_tr);
    
    return 0;
}