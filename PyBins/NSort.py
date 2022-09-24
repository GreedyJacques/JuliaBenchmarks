import sys
import time
from random import randrange

def nsort_benchmark(n_set):
    for i in range(0,len(n_set)-1):
        for j in range(i+1,len(n_set)):
            if n_set[j] < n_set[i]:
                tmp = n_set[j]
                n_set[j] = n_set[i]
                n_set[i] = tmp
    return n_set

n = 10000
rng = 100000

if len(sys.argv) > 1:
    n = int(sys.argv[1])

if len(sys.argv) > 2:
    rng = int(sys.argv[2])

set = []

for i in range(0, n):
    set.append(randrange(1, rng+1))

start = time.time()
set_out = nsort_benchmark(set)
end = time.time()

elapsed = end - start

print(f"Python naive sorted array of {n} random integers in range (1, {rng}) = in {int(elapsed*1000)} ms")