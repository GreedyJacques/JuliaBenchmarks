import sys
import time
from random import randrange

def compute_element(A,B,r,c):
    out = 0
    for i in range(0, len(B)):
        out += A[r][i] * B[i][c]
    return out

def matrix_multiply(A,B):
    C = []
    for r in range(0, len(A)):
        tmp = []
        for c in range(0, len(B[0])):
            tmp.append(compute_element(A, B, r, c))
        C.append(tmp)
    return C

def matmul_benchmark(A, B):
    return matrix_multiply(A, B)


ar = 500
ac = 500
br = 500
bc = 500

rng = 1000

if len(sys.argv) > 1:
    ar = int(sys.argv[1])

if len(sys.argv) > 2:
    ac = int(sys.argv[2])
    br = int(sys.argv[2])


if len(sys.argv) > 3:
    bc = int(sys.argv[3])

if len(sys.argv) > 4:
    rng = int(sys.argv[4])


A = []
B = []

for r in range(0, ar):
    tmp = []
    for c in range(0, ac):
        tmp.append(randrange(1,rng + 1))
    A.append(tmp)

for r in range(0, br):
    tmp = []
    for c in range(0, bc):
        tmp.append(randrange(1,rng + 1))
    B.append(tmp)

start = time.time()
matmul_benchmark(A,B)
end = time.time()

elapsed = end - start

print(f"Python computed the product of matrices A({ar} x {ac}) and B({br} x {bc}) with integer values in range (1, {rng}) in {int(elapsed*1000)} ms")