include("general.jl")
include("../knapsack.jl")
using Documenter
using Random, StatsBase

"""
	doubling(::Vector{Job})

Compute a universal 4-robust schedule for the given set of jobs.

A universal α-robust schedule is a schedule whose cost differs from optimality by 
a factor of at most α, regardless of which cost function is used.

Returns a permutation of the jobs' indices.
"""
# function doubling(jobs::Vector{Job})::Array{Int}
# 	pi = Int[]
# 	total_weight = sum(getproperty.(jobs, :weight))
# 	println(total_weight)
#     for i in 0:ceil(log2(total_weight))
#         J = dp_knapsack()
#     end
# 	return pi
# end

"""
	doubling(instance::SchedulingInstance, knapsack::Function)

Compute a universal 4-robust schedule for the given set of jobs, passed through
a `SchedulingInstance`. The knapsack routine is passed through the `kanpsack` 
argument.

A universal α-robust schedule is a schedule whose cost differs from optimality by 
a factor of at most α, regardless of which cost function is used.

Returns a permutation of the jobs' indices.
"""
function doubling(instance::SchedulingInstance, knapsack::Function)::Vector{Int}
	pi = Int[]
	total_weight = sum(instance.weights)
	for i in 0:ceil(log2(total_weight))
		J = knapsack(instance.weights, instance.processing_times, round(Int, 2^i))
		for index in J
			if ~(index in pi)
				# here order is arbitrary within the same J, so instead of 
				# prepending, one can append and then reverse.
				push!(pi, index)
			end
		end
	end
	return reverse(pi)
end

"""
	generalized_doubling(instance::SchedulingInstance, ρ::Real, knapsack::Function)

Computes a ρ²/(ρ-1)-robust scheduling for the given set of jobs, passed through
a `SchedulingInstance`, for `ρ` > 1. The knapsack routine is passed through the `kanpsack` 
argument.  
The scheduling is (1 + ρ/(ρ-1))-approximate.

A universal α-robust schedule is a schedule whose cost differs from optimality by 
a factor of at most α, regardless of which cost function is used.
An β-approximate is a schedule whose cost for linear functions differs from 
optimality (Smith's Rule) by a factor of at most β.

Returns a permutation of the jobs' indices.

Note: A knapsack solver that accepts real-valued weights must be used.
"""
function generalized_doubling(instance::SchedulingInstance, rho::Real, knapsack::Function)::Vector{Int}
	if rho <= 1
		error("rho must be bigger than 1.")
	end
	pi = Int[]
	total_weight = sum(instance.weights)
	ratio::Function = job -> instance.weights[job] / instance.processing_times[job]
	for i in 0:ceil(log(rho, total_weight))
		J = collect(knapsack(instance.weights, instance.processing_times, rho^i))
		sort!(J, by = ratio)
		for index in J
			if ~(index in pi)
				push!(pi, index)
			end
		end
	end
	return reverse(pi)
end

"""
	randomized_doubling(instance::SchedulingInstance, knapsack::Function, rng::AbstractRNG)

Computes a schedule that is in expectation ℯ-robust, where ℯ = 2.71828182...
is Euler's number. 

Returns a permutation of the jobs' indices.

Note: A knapsack solver that accepts real-valued weights must be used.
"""
function randomized_doubling(instance::SchedulingInstance, knapsack::Function, rng::AbstractRNG)::Vector{Int}
	pi = Int[]
	x = ℯ^rand(rng, 1)[1]
	println(x)
	total_weight = sum(instance.weights)
	for i in 0:ceil(log(total_weight))
		J = knapsack(instance.weights, instance.processing_times, x * ℯ^i)
		for index in J
			if ~(index in pi)
				push!(pi, index)
			end
		end
	end
	return reverse(pi)
end

"Computes a permutation of jobs' indices based on Smith's Rule, i.e
sorting in non-increasing order based on the ratio between weight and processing_time. \n
Note: for linear cost functions, this scheduling is proven to be optimal"
function smith_rule(instance::SchedulingInstance)::Vector{Int}
	ratios = instance.weights ./ instance.processing_times
	return sortperm(ratios, rev = true)
end
