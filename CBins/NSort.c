#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>

int64_t* nsort_benchmark(int64_t n, int64_t *set){
    int64_t tmp;
    for(int64_t i = 0; i < n - 1; ++i)
    {
        for(int64_t j = i + 1; j < n; ++j)
        {
            if(set[j] < set[i]){
                tmp = set[j];
                set[j] = set[i];
                set[i] = tmp;
            }
        }
    }
    return set;
}


int main (int argc, char *argv[])
{
    int64_t n = 10000;
    int64_t rng = 100000;

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

    int64_t *set_out;
    int64_t elapsed;

    clock_t start = clock();

    set_out = nsort_benchmark(n, n_set);

    clock_t stop = clock();

    double d_elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    elapsed = (int64_t)d_elapsed;

    printf("C naive sorted array of %lld random integers in range (1, %lld) in %lld ms\n", n, rng, elapsed);

    free(n_set);

    return 0;
}