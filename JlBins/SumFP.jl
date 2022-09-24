using Random
using Printf

n = 10000000
rng = 100

function sum_benchmark(n_set)
    sum_val = 0
    for i in n_set
        sum_val += i
    end
    return sum_val
end

if length(ARGS) > 0
    n = parse(Int, ARGS[1])
end

if length(ARGS) > 1
    rng = parse(Int, ARGS[2])
end

set = Array{Float64, 1}(undef, n)

for i in range(1, n)
    set[i] = rand(Float64) * rng
end

sum_out = sum_benchmark([1.1,2.2])

elapsed = @elapsed begin
    sum_out = sum_benchmark(set)
end

@printf "Julia computed sum of %i random floating point numbers in range (0, %i) = %f in %i ms\n" n rng sum_out (elapsed*1000)