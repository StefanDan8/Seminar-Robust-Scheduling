include("../src/knapsack.jl");
include("../src/scheduling/general.jl")
include("../src/scheduling/single_machine.jl")
using Test

@testset "Simple Knapsack instances with integer values" begin
	# test cases from https://people.sc.fsu.edu/~jburkardt/datasets/knapsack_01/knapsack_01.html
	maxWeight = 165
	weights = [23, 31, 29, 44, 53, 38, 63, 85, 89, 82]
	values = [92, 57, 49, 68, 60, 43, 67, 84, 87, 72]
	optimal = Set([1, 2, 3, 4, 6])
	@test issetequal(dp_knapsack(weights, values, maxWeight), optimal)

	maxWeight = 26
	weights = [12, 7, 11, 8, 9]
	values = [24, 13, 23, 15, 16]
	optimal = Set([2, 3, 4])
	@test issetequal(dp_knapsack(weights, values, maxWeight), optimal)

	maxWeight = 190
	weights = [56, 59, 80, 64, 75, 17]
	values = [50, 50, 64, 46, 50, 5]
	optimal = Set([1, 2, 5])
	@test issetequal(dp_knapsack(weights, values, maxWeight), optimal)

	maxWeight = 50
	weights = [31, 10, 20, 19, 4, 3, 6]
	values = [70, 20, 39, 37, 7, 5, 10]
	optimal = Set([1, 4])
	@test issetequal(dp_knapsack(weights, values, maxWeight), optimal)

	maxWeight = 104
	weights = [25, 35, 45, 5, 25, 3, 2, 2]
	values = [350, 400, 450, 20, 70, 8, 5, 5]
	optimal = Set([1, 3, 4, 5, 7, 8])
	@test issetequal(dp_knapsack(weights, values, maxWeight), optimal)

	maxWeight = 170
	weights = [41, 50, 49, 59, 55, 57, 60]
	values = [442, 525, 511, 593, 546, 564, 617]
	optimal = Set([2, 4, 7])
	@test issetequal(dp_knapsack(weights, values, maxWeight), optimal)

	maxWeight = 750
	weights = [70, 73, 77, 80, 82, 87, 90, 94, 98, 106, 110, 113, 115, 118, 120]
	values = [135, 139, 149, 150, 156, 163, 173, 184, 192, 201, 210, 214, 221, 229, 240]
	optimal = Set([1, 3, 5, 7, 8, 9, 14, 15])
	@test issetequal(dp_knapsack(weights, values, maxWeight), optimal)

	maxWeight = 6404180
	weights = [382745, 799601, 909247, 729069, 467902, 44328, 34610, 698150, 823460, 903959, 853665, 551830, 610856, 670702, 488960, 951111, 323046, 446298, 931161, 31385, 496951, 264724, 224916, 169684]
	values = [825594, 1677009, 1676628, 1523970, 943972, 97426, 69666, 1296457, 1679693, 1902996, 1844992, 1049289, 1252836, 1319836, 953277, 2067538, 675367, 853655, 1826027, 65731, 901489, 577243, 466257, 369261]
	optimal = Set([1, 2, 4, 5, 6, 10, 11, 13, 16, 22, 23, 24])
	@test issetequal(dp_knapsack(weights, values, maxWeight), optimal)


end
# jobs = Job[]
# push!(jobs, Job(1, 3, 5))
# push!(jobs, Job(2, 1, 3))
# push!(jobs, Job(3, 2, 7))
# push!(jobs, Job(4, 10, 4))
# print(doubling(jobs))
f(x) = x^2
id(x) = x
instance = SchedulingInstance(6, [3, 1, 2, 10, 4, 6], [5, 3, 7, 4, 1, 2])
pi = doubling(instance)
println(pi)
println(compute_cost(instance, pi, f))
smith = smith_rule(instance)
println(smith)
println("Smith: ", compute_cost(instance, smith, id))
println("Doubling: ", compute_cost(instance, pi, id))

