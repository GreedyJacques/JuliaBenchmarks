#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>

typedef struct matrix {
    int64_t *data;
    int64_t rows;
    int64_t cols;
} matrix;

void matrix_insert(matrix *A, int64_t element, int64_t row, int64_t col){
    A->data[(row*A->cols)+col] = element;
}

int64_t matrix_get(matrix *A, int64_t row, int64_t col){
    return A->data[(row*A->cols)+col];
}

matrix *matrix_create(int64_t rows, int64_t cols){
    matrix *out = malloc(sizeof(matrix));
    out->rows = rows;
    out->cols = cols;
    out->data = malloc(sizeof(int64_t)*rows*cols);

    return out;
}

void matrix_destroy(matrix *A){
    free(A->data);
    free(A);
    return;
}

void matrix_print(matrix *A){
    for(int r = 0; r<A->rows; ++r){
        for(int c = 0; c<A->cols; ++c){
            printf("%lld ", matrix_get(A,r,c));
        }
        printf("\n");
    }
    printf("\n");
}

void matrix_fill(matrix *A, int64_t rng){
    for(int r = 0; r<A->rows; ++r){
        for(int c = 0; c<A->cols; ++c){
            matrix_insert(A, (rand() % rng) + 1, r, c);
        }
    }
}

int64_t compute_element(matrix *A, matrix *B, int64_t row, int64_t col){
    int64_t out = 0;
    for (int64_t i = 0; i < A->cols; ++i){
        out += A->data[(row*A->cols)+i] * B->data[(i*A->cols)+col];
    }
    return out;
}

matrix *matrix_multiply(matrix *A, matrix *B){
    matrix *C = matrix_create(A->rows, B->cols);
    for(int r = 0; r<C->rows; ++r){
        for(int c = 0; c<C->cols; ++c){
            matrix_insert(C, compute_element(A,B,r,c), r, c);
        }
    }
    return C;
}

matrix *matmul_benchmark(matrix *A, matrix *B){
    matrix *C = matrix_multiply(A,B);
    return C;
}


int main (int argc, char *argv[])
{
    int64_t ar = 500;
    int64_t ac = 500;

    int64_t br = 500;
    int64_t bc = 500;

    int64_t rng = 1000;

    if (argc>1){
        ar = atoi(argv[1]);
    }

    if (argc>2){
        ac = atoi(argv[2]);
        br = atoi(argv[2]);
    }

    if (argc>3){
        bc = atoi(argv[3]);
    }

    if (argc>4){
        rng = atoi(argv[4]);
    }

    matrix *A = matrix_create(ar,ac);
    matrix *B = matrix_create(br,bc);

    matrix_fill(A, rng);
    matrix_fill(B, rng);

    int64_t elapsed;

    clock_t start = clock();
    matrix *C = matmul_benchmark(A, B);
    clock_t stop = clock();

    double d_elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    elapsed = (int64_t)d_elapsed;

    printf("C computed the product of matrixes A(%lld x %lld) and B(%lld x %lld) with integer values in range (1, %lld) in %lld ms\n", ar, ac, br, bc, rng, elapsed);

    matrix_destroy(A);
    matrix_destroy(B);
    matrix_destroy(C);
    
    return 0;
}