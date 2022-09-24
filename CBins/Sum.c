#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>

int64_t sum_benchmark(int64_t n, int64_t *n_set){
    int64_t sum_val = 0;
    for(int64_t i=0; i < n; ++i){   
        sum_val += n_set[i];}
    return sum_val;
}

int main (int argc, char *argv[])
{
    int64_t n = 10000000;
    int64_t rng = 100;

    if (argc>1){
        n = atoi(argv[1]);
    }

    if (argc>2){
        rng = atoi(argv[2]);
    }

    int64_t *n_set = calloc(n, sizeof(int64_t));
    srand(time(NULL));


    for(int64_t i=0; i < n; ++i)
    {
        n_set[i] = (rand() % rng) + 1;
    }

    int64_t sum_out;
    int64_t elapsed;

    clock_t start = clock();

    sum_out = sum_benchmark(n, n_set);

    clock_t stop = clock();

    double d_elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    elapsed = (int64_t)d_elapsed;

    printf("C computed sum of %lld random integers in range (1, %lld) = %lld in %lld ms\n", n, rng, sum_out, elapsed);

    free(n_set);

    return 0;
}