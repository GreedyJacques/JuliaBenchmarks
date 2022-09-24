import sys
import time
from random import randrange

def compute_element(A,c):
    out = 0
    for i in range(0, len(A)):
        out += A[i][c]
    return out/len(A)

def colavg_benchmark(A, n_set):
    for i in range(0, len(A[0])):
        n_set[i] = compute_element(A, i)
    return n_set


ar = 5000
ac = 5000

rng = 10000

if len(sys.argv) > 1:
    ar = int(sys.argv[1])

if len(sys.argv) > 2:
    ac = int(sys.argv[2])

if len(sys.argv) > 3:
    rng = int(sys.argv[3])


A = []

for r in range(0, ar):
    tmp = []
    for c in range(0, ac):
        tmp.append(randrange(1,rng + 1))
    A.append(tmp)

set_out = []

for c in range(0, ac):
    set_out.append(0.0)

start = time.time()
set_out = colavg_benchmark(A, set_out)
end = time.time()

elapsed = end - start

print(f"Python computed the column averages of a ({ar} x {ac}) matrix containing floating point values in range (0, {rng}) in {int(elapsed*1000)} ms")