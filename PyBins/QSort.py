import sys
import time
from random import randrange

def qsort_benchmark(n_set):
    n_set.sort()
    return n_set

n = 10000000
rng = 100000000

if len(sys.argv) > 1:
    n = int(sys.argv[1])

if len(sys.argv) > 2:
    rng = int(sys.argv[2])

set = []

for i in range(0, n):
    set.append(randrange(1, rng+1))

start = time.time()
set_out = qsort_benchmark(set)
end = time.time()

elapsed = end - start

print(f"Python quick sorted array of {n} random integers in range (1, {rng}) = in {int(elapsed*1000)} ms")