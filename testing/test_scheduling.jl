include("../src/knapsack.jl");
include("../src/scheduling/general.jl")
include("../src/scheduling/single_machine.jl")

using Random, StatsBase
# f(x) = x^2
# id(x) = x
# instance = SchedulingInstance(6, [3, 1, 2, 10, 4, 6], [5, 3, 7, 4, 1, 2])
# pi = doubling(instance, knapsack_dp)
# println(pi)
# println(compute_cost(instance, pi, f))
# smith = smith_rule(instance)
# println(smith)
# println("Smith: ", compute_cost(instance, smith, id))
# println("Doubling: ", compute_cost(instance, pi, id))
SEED = 42
n = 10000
rng = MersenneTwister(SEED)
weights = sample(rng, 1:50, n)
values = sample(rng, 1:100, n)
instance = SchedulingInstance(n, weights, values)
pi = doubling(instance, knapsack_dp)
#println(pi)
#println(compute_cost(instance, pi, f))
smith = smith_rule(instance)
#println(smith)
cost_smith = compute_cost(instance, smith, id)
cost_doubling = compute_cost(instance, pi, id)
println("Smith: ", cost_smith)
println("Doubling: ", cost_doubling)
println((cost_doubling - cost_smith) / cost_smith * 100)

