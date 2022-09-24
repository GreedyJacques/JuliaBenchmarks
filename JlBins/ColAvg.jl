using Random

ar = 5000
ac = 5000

rng = 10000

function compute_element(col)
    sum_val = 0
    for i in col
        sum_val += i
    end
    return sum_val / length(col)
end

function colavg_benchmark(A, n_set)
    for (i, col) in enumerate(eachcol(A))
        n_set[i] = compute_element(col)
    end
    return n_set
end

if length(ARGS) > 0
    ar = parse(Int, ARGS[1])
end

if length(ARGS) > 1
    ac = parse(Int, ARGS[2])
end

if length(ARGS) > 2
    rng = parse(Int, ARGS[3])
end

A = Array{Float64, 2}(undef, ar, ac)
set_out_c = Array{Float64, 1}(undef, 2)
set_out = Array{Float64, 1}(undef, ac)

for r in range(1, ar)
    for c in range(1, ac)
        A[r, c] = rand(Float64) * rng
    end
end

set_out_c = colavg_benchmark([1.1 1.1; 1.1 1.1], set_out_c)

elapsed = @elapsed begin
    set_out = colavg_benchmark(A, set_out)
end

println("Julia computed the column averages of a ($ar x $ac) matrix containing floating point values in range (0, $rng) in $(trunc(Int, 1000*elapsed)) ms\n")