using Random

n = 10000
rng = 100000

function nsort_benchmark(n_set)
    for i in range(1,length(n_set) - 1)
        for j in range(i + 1,length(n_set))
            if n_set[j] < n_set[i]
                tmp = n_set[j]
                n_set[j] = n_set[i]
                n_set[i] = tmp
            end
        end
    end
    return n_set
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

set_out = nsort_benchmark([1,2])

elapsed = @elapsed begin
    set_out = nsort_benchmark(set)
end

println("Julia naive sorted array of $n random integers in range (1, $rng) in $(trunc(Int, 1000*elapsed)) ms")