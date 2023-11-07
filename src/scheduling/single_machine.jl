include("general.jl")
include("../knapsack.jl")

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
	doubling(::SchedulingInstance, ::Function)

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

"Computes a permutation of jobs' indices based on Smith's Rule, i.e
sorting in non-increasing order based on the ratio between weight and processing_time. \n
Note: for linear cost functions, this scheduling is proven to be optimal"
function smith_rule(instance::SchedulingInstance)::Vector{Int}
	ratios = instance.weights ./ instance.processing_times
	return sortperm(ratios, rev = true)
end
