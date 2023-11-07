struct Job
	index::Int
	weight::Int
	processing_time::Int
end

struct SchedulingInstance
	n::Int
	weights::Vector{Int}
	processing_times::Vector{Int}
	SchedulingInstance(n, weights, processing_times) =
		(n == length(weights) && n == length(processing_times)) ? new(n, weights, processing_times) : error("dimensions don't match")
end

function compute_cost(instance::SchedulingInstance, schedule::Vector{Int}, f::Function)
	ellapsed = 0
	cost = 0
	for job in schedule
		ellapsed += instance.processing_times[job]
		cost += f(ellapsed) * instance.weights[job]
	end
	return cost
end

