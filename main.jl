function input(prompt)
    print(prompt)
    return readline(stdin)
end

function run_Sum(n, rng)
    println("Running Sum benchmark, on $n integers in range (1, $rng)...\n")
    run(`.\\CBins\\Sum.exe $n $rng`)
    run(`python .\\PyBins\\Sum.py $n $rng`)
    run(`julia .\\JlBins\\Sum.jl $n $rng`)
    println("Sum benchmark complete.\n")
end

function run_SumFP(n, rng)
    println("Running SumFP benchmark, on $n floating point numbers in range (0, $rng)...\n")
    run(`.\\CBins\\SumFP.exe $n $rng`)
    run(`python .\\PyBins\\SumFP.py $n $rng`)
    run(`julia .\\JlBins\\SumFP.jl $n $rng`)
    println("SumFP benchmark complete.\n")
end

function run_NSort(n, rng)
    println("Running NSort benchmark, on $n integers in range (1, $rng)...\n")
    run(`.\\CBins\\NSort.exe $n $rng`)
    run(`python .\\PyBins\\NSort.py $n $rng`)
    run(`julia .\\JlBins\\NSort.jl $n $rng`)
    println("NSort benchmark complete.\n")
end

function run_QSort(n, rng)
    println("Running QSort benchmark, on $n integers in range (1, $rng)...\n")
    run(`.\\CBins\\QSort.exe $n $rng`)
    run(`python .\\PyBins\\QSort.py $n $rng`)
    run(`julia .\\JlBins\\QSort.jl $n $rng`)
    println("QSort benchmark complete.\n")
end

function run_ColAvg(ar, ac, rng)
    println("Running ColAvg benchmark, on a ($ar x $ac) matrix containing floating point numbers in range (0, $rng)...\n")
    run(`.\\CBins\\ColAvg.exe $ar $ac $rng`)
    run(`python .\\PyBins\\ColAvg.py $ar $ac $rng`)
    run(`julia .\\JlBins\\ColAvg.jl $ar $ac $rng`)
    println("ColAvg benchmark complete.\n")
end

function run_MatMul(ar, acbr, bc, rng)
    println("Running MatMul benchmark, on matrices A = ($ar x $acbr) and B = ($acbr x $bc) containing integers in range (1, $rng)...\n")
    run(`.\\CBins\\MatMul.exe $ar $acbr $bc $rng`)
    run(`python .\\PyBins\\MatMul.py $ar $acbr $bc $rng`)
    run(`julia .\\JlBins\\MatMul.jl $ar $acbr $bc $rng`)
    println("MatMul benchmark complete.\n")
end

function run_All()
    println("Running all benchmarks...\n")
    run_Sum(10000000, 100)
    run_SumFP(10000000, 100)
    run_NSort(10000, 100000)
    run_QSort(10000000, 100000000)
    run_ColAvg(5000, 5000, 10000)
    run_MatMul(500, 500, 500, 1000)
    println("All benchmarks complete.")
end

function main_loop()
    while (true)
        msg = lowercase(input("> "))

        if startswith(msg, "help ") || msg == "help"
            msg_s = split(msg, " ")
            if length(msg_s) < 2
                println("\nThere are six different benchmarks:")
                println("Sum, SumFP, NSort, Qsort, ColAvg, MatMul.")
                println("For information on one of the benchmarks type \"help\" followed by the name of the benchmark (e.g. \"help MatMul\")\n")
                println("To run all benchmarks with default parameters type \"run all\".")
                println("To run a single benchmark type \"run\" followed by the name of the benchmark (e.g. \"run MatMul\").")
                println("Custom parameters can be specified by appending them on the run instruction (e.g. \"run MatMul 10 10 10 100\").")
                println("Parameter descriptions and default values are available in each benchmark's description.\n")
                println("To exit the program type \"exit\".")

            else
                if msg_s[2] == "sum"
                    println("Usage: \"run Sum [N] [RANGE]\"\n")
                    println("The benchmark Sum will generate an array of N 64-bit integers (in the languages where it is possible to specify integer lenght)")
                    println("each element of the array will then be set to a randomly generated value between 1 and RANGE")
                    println("a timer will start, and all of the elements of the array will be added together")
                    println("after the last element is added the value is returned and the timer is stopped.\n")
                    println("Default values: N = 10000000 (10^7); RANGE = 100")
                elseif msg_s[2] == "sumfp"
                    println("Usage: \"run SumFP [N] [RANGE]\"\n")
                    println("The benchmark SumFP will generate an array of N 64-bit floating point numbers (in the languages where it is possible to specify floating point number length)")
                    println("each element of the array will then be set to a randomly generated value between 0 and RANGE")
                    println("a timer will start, and all of the elements of the array will be added together")
                    println("after the last element is added the value is returned and the timer is stopped.\n")
                    println("Default values: N = 10000000 (10^7); RANGE = 100")
                elseif msg_s[2] == "nsort"
                    println("Usage: \"run NSort [N] [RANGE]\"")
                    println("The benchmark NSort will generate an array of N 64-bit integers (in the languages where it is possible to specify integer length)\n")
                    println("each element of the array will then be set to a randomly generated value between 1 and RANGE")
                    println("a timer will start, and a Naive sorting algorithm will sort the array")
                    println("after the array is sorted it is returned and the timer is stopped.\n")
                    println("Default values: N = 10000 (10^5); RANGE = 100000 (10^6)")
                elseif msg_s[2] == "qsort"
                    println("Usage: \"run QSort [N] [RANGE]\"\n")
                    println("The benchmark QSort will generate an array of N 64-bit integers (in the languages where it is possible to specify integer length)")
                    println("each element of the array will then be set to a randomly generated value between 1 and RANGE")
                    println("a timer will start, and an algorithm will sort the array")
                    println("the sorting algorithms used are the ones present in the standard libraries of the languages:")
                    println("qsort() for C, list.sort() for Python, and sort() for Julia")
                    println("after the array is sorted it is returned and the timer is stopped.\n")
                    println("Default values: N = 1000000 (10^7); RANGE = 10000000 (10^8)")
                elseif msg_s[2] == "colavg"
                    println("Usage: \"run ColAvg [ROWS] [COLS] [RANGE]\"\n")
                    println("The benchmark ColAvg will generate matrix with ROWS rows and COLS columns")
                    println("the elements of the matrix are 64-bit floating point numbers (in the languages where it is possible to specify floating point number length)")
                    println("each element of the matrix will be set to a randomly generated value between 0 and RANGE")
                    println("a timer will start, and the average value of each column will be calculated and put into an array")
                    println("after the average of the last column is calculated the array is returned and the timer is stopped.\n")
                    println("Default values: ROWS = 5000; COLS = 5000; RANGE = 10000 (10^5)")
                elseif msg_s[2] == "matmul"
                    println("Usage: \"run MatMul [AROWS] [ACOLSBROWS] [BCOLS] [RANGE]\"\n")
                    println("The benchmark MatMul will generate two conformable matrices, A and B with AROWS rows, ACOLSBROWS columns and ACOLSBROWS rows, BCOLS columns, respectively")
                    println("the elements of the matrices are 64-bit integers (in the languages where it is possible to specify integer length)")
                    println("each element of the matrices will be set to a randomly generated value between 1 and RANGE")
                    println("a timer will start, the matrix product of the two matrices is calculated")
                    println("after the product is calculated the resulting matrix is returned and the timer is stopped.\n")
                    println("Default values: AROWS = 500; ACOLSBROWS = 500; BCOLS = 500; RANGE = 1000)")
                else
                    println("There is no benchmark called $(msg_s[2]).")
                end
            end

        elseif startswith(msg, "run ") || msg == "run"
            msg_s = split(msg, " ")
            if length(msg_s) < 2
                println("Please specify which benchmark to run.")
            else
                if msg_s[2] == "all"
                    run_All()
                elseif msg_s[2] == "sum"
                    n = 10000000
                    rng = 100
                    if length(msg_s) > 2
                        try
                            n = parse(Int, msg_s[3])
                        catch e
                            println("Error: couldn't parse first parameter, assuming default value.")
                        end
                    end
                    if length(msg_s) > 3
                        try
                            rng = parse(Int, msg_s[4])
                        catch e
                            println("Error: couldn't parse second parameter, assuming default value.")
                        end
                    end
                    run_Sum(n, rng)

                elseif msg_s[2] == "sumfp"
                    n = 10000000
                    rng = 100
                    if length(msg_s) > 2
                        try
                            n = parse(Int, msg_s[3])
                        catch e
                            println("Error: couldn't parse first parameter, assuming default value.")
                        end
                    end
                    if length(msg_s) > 3
                        try
                            rng = parse(Int, msg_s[4])
                        catch e
                            println("Error: couldn't parse second parameter, assuming default value.")
                        end
                    end
                    run_SumFP(n, rng)

                elseif msg_s[2] == "nsort"
                    n = 10000
                    rng = 100000
                    if length(msg_s) > 2
                        try
                            n = parse(Int, msg_s[3])
                        catch e
                            println("Error: couldn't parse first parameter, assuming default value.")
                        end
                    end
                    if length(msg_s) > 3
                        try
                            rng = parse(Int, msg_s[4])
                        catch e
                            println("Error: couldn't parse second parameter, assuming default value.")
                        end
                    end
                    run_NSort(n, rng)

                elseif msg_s[2] == "qsort"
                    n = 10000000
                    rng = 100000000
                    if length(msg_s) > 2
                        try
                            n = parse(Int, msg_s[3])
                        catch e
                            println("Error: couldn't parse first parameter, assuming default value.")
                        end
                    end
                    if length(msg_s) > 3
                        try
                            rng = parse(Int, msg_s[4])
                        catch e
                            println("Error: couldn't parse second parameter, assuming default value.")
                        end
                    end
                    run_QSort(n, rng)

                elseif msg_s[2] == "colavg"
                    ar = 5000
                    ac = 5000
                    rng = 10000
                    if length(msg_s) > 2
                        try
                            ar = parse(Int, msg_s[3])
                        catch e
                            println("Error: couldn't parse first parameter, assuming default value.")
                        end
                    end
                    if length(msg_s) > 3
                        try
                            ac = parse(Int, msg_s[4])
                        catch e
                            println("Error: couldn't parse second parameter, assuming default value.")
                        end
                    end
                    if length(msg_s) > 4
                        try
                            rng = parse(Int, msg_s[5])
                        catch e
                            println("Error: couldn't parse third parameter, assuming default value.")
                        end
                    end
                    run_ColAvg(ar, ac, rng)

                elseif msg_s[2] == "matmul"
                    ar = 500
                    acbr = 500
                    bc = 500
                    rng = 1000
                    if length(msg_s) > 2
                        try
                            ar = parse(Int, msg_s[3])
                        catch e
                            println("Error: couldn't parse first parameter, assuming default value.")
                        end
                    end
                    if length(msg_s) > 3
                        try
                            acbr = parse(Int, msg_s[4])
                        catch e
                            println("Error: couldn't parse second parameter, assuming default value.")
                        end
                    end
                    if length(msg_s) > 4
                        try
                            bc = parse(Int, msg_s[5])
                        catch e
                            println("Error: couldn't parse third parameter, assuming default value.")
                        end
                    end
                    if length(msg_s) > 5
                        try
                            rng = parse(Int, msg_s[6])
                        catch e
                            println("Error: couldn't parse fourth parameter, assuming default value.")
                        end
                    end
                    run_MatMul(ar, acbr, bc, rng)
                else
                    println("There is no benchmark called $(msg_s[2]).")
                end
            end
        elseif msg == "exit"
            return 0
        end
    end
end

println("Welcome!")
println("This program is an automated benchmarking tool used to compare execution")
println("times of various tasks between the programming languages C, Python and Julia.")
println("Type \"help\" for a quick guide.")

main_loop()

println("Goodbye")