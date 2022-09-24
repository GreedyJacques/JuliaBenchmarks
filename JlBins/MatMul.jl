using Random
using LinearAlgebra

ar = 500
ac = 500
br = 500
bc = 500

rng = 1000

function matmul_benchmark(A, B)
    return A * B
end

if length(ARGS) > 0
    ar = parse(Int, ARGS[1])
end

if length(ARGS) > 1
    ac = parse(Int, ARGS[2])
    br = parse(Int, ARGS[2])
end

if length(ARGS) > 2
    bc = parse(Int, ARGS[3])
end

if length(ARGS) > 3
    rng = parse(Int, ARGS[4])
end

A = Array{Int64, 2}(undef, ar, ac)
B = Array{Int64, 2}(undef, br, bc)

for r in range(1, ar)
    for c in range(1, ac)
        A[r, c] = rand(1:rng)
    end
end

for r in range(1, br)
    for c in range(1, bc)
        B[r, c] = rand(1:rng)
    end
end

C = matmul_benchmark([1 1; 1 1], [1 1; 1 1])

elapsed = @elapsed begin
    C = matmul_benchmark(A, B)
end

println("Julia computed the product of matrices A($ar x $ac) and B($br x $bc) with integer values in range (1, $rng) in $(trunc(Int, 1000*elapsed)) ms")