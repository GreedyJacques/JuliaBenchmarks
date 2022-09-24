#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>

typedef struct matrix {
    double **data;
    int64_t rows;
    int64_t cols;
} matrix;

void matrix_insert(matrix *A, double element, int64_t row, int64_t col){
    A->data[row][col] = element;
}

double matrix_get(matrix *A, int64_t row, int64_t col){
    return A->data[row][col];
}

matrix *matrix_create(int64_t rows, int64_t cols){
    matrix *out = malloc(sizeof(matrix));
    out->rows = rows;
    out->cols = cols;
    out->data = malloc(sizeof(double*)*rows);

    for(int i = 0; i < rows; ++i){
        out->data[i] = malloc(sizeof(double)*cols);
    }

    return out;
}

void matrix_destroy(matrix *A){
    for(int i = 0; i < A->rows; ++i){
        free(A->data[i]);
    }
    free(A->data);
    free(A);
    return;
}

void matrix_print(matrix *A){
    for(int r = 0; r<A->rows; ++r){
        for(int c = 0; c<A->cols; ++c){
            printf("%llf ", matrix_get(A,r,c));
        }
        printf("\n");
    }
    printf("\n");
}

void matrix_fill(matrix *A, int64_t rng){
    for(int r = 0; r<A->rows; ++r){
        for(int c = 0; c<A->cols; ++c){
            matrix_insert(A, (double)rand()/(double)(RAND_MAX) * rng, r, c);
        }
    }
}

double compute_element(matrix *A, int64_t col){
    double out = 0;
    for (int64_t i = 0; i < A->rows; ++i){
        out += A->data[i][col];
    }
    return out/A->rows;
}

double *colavg_benchmark(double *n_set ,matrix *A){
    for(int64_t i = 0; i < A->cols; ++i){
        n_set[i] = compute_element(A, i);
    }
    return n_set;
}


int main (int argc, char *argv[])
{
    int64_t ar = 5000;
    int64_t ac = 5000;

    int64_t rng = 10000;

    if (argc>1){
        ar = atoi(argv[1]);
    }

    if (argc>2){
        ac = atoi(argv[2]);
    }

    if (argc>3){
        rng = atoi(argv[3]);
    }

    matrix *A = matrix_create(ar,ac);

    matrix_fill(A, rng);

    int64_t elapsed;

    double *set_out = calloc(A->cols, sizeof(double));

    clock_t start = clock();
    set_out = colavg_benchmark(set_out, A);
    clock_t stop = clock();

    double d_elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    elapsed = (int64_t)d_elapsed;

    printf("C computed the column averages of a (%lld x %lld) matrix containing floating point values in range (0, %lld) in %lld ms\n", ar, ac, rng, elapsed);

    matrix_destroy(A);
    free(set_out);
    
    return 0;
}