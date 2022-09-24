using Random

n = 10000000
rng = 100000000

function qsort_benchmark(n_set)
    return sort(n_set)
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

set_out = qsort_benchmark([1,2])

elapsed = @elapsed begin
    set_out = qsort_benchmark(set)
end

println("Julia quick sorted array of $n random integers in range (1, $rng) in $(trunc(Int, 1000*elapsed)) ms")