using Random

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

set = Array{Int64, 1}(undef, n)

for i in range(1, n)
    set[i] = rand(1:rng)
end

sum_out = sum_benchmark([1,2])

elapsed = @elapsed begin
    sum_out = sum_benchmark(set)
end

println("Julia computed sum of $n random integers in range (1, $rng) = $sum_out in $(trunc(Int, 1000*elapsed)) ms")