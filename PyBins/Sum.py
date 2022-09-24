import sys
import time
from random import randrange

def sum_benchmark(n_set):
    sum_val = 0
    for i in n_set:
        sum_val += i
    return sum_val


n = 10000000
rng = 100

if len(sys.argv) > 1:
    n = int(sys.argv[1])

if len(sys.argv) > 2:
    rng = int(sys.argv[2])

set = []

for i in range(0, n):
    set.append(randrange(1, rng+1))

start = time.time()
sum_out = sum_benchmark(set)
end = time.time()

elapsed = end - start

print(f"Python computed sum of {n} random integers in range {1, rng} = {sum_out} in {int(elapsed*1000)} ms")