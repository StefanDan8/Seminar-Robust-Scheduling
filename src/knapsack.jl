using LinearAlgebra
using OffsetArrays

"Computes a solution for the 0/1 Knapsack problem using dynamic programming."
function dp_knapsack(weights::Vector{Int}, values::Vector{Int}, maxWeight::Int)::Set{Int}
	# dividing all weights and maxWeight by their greatest common divisor does
	# not change the solution, yet can drastically reduce the size of the val_matrix
	my_gcd = gcd(gcd(weights), maxWeight)
	weights = weights .÷ my_gcd
	maxWeight = maxWeight ÷ my_gcd

	n = length(weights)
	if n != length(values)
		error("The lengths of weights and values don't match!")
	end
	# use a matrix indexed from 0, due to the semantic value of indices
	val_matrix = OffsetArray{Int}(-ones(Int, n + 1, maxWeight + 1), 0:n, 0:maxWeight)

	"Computes maximum value that can be achieved with the first `i` items with a weight within `j`."
	function max_val(i::Int, j::Int)
		if i == 0 || j <= 0
			val_matrix[i, j] = 0
			return
		end
		if val_matrix[i-1, j] == -1
			max_val(i - 1, j)
		end
		if weights[i] > j
			val_matrix[i, j] = val_matrix[i-1, j]
		else
			if val_matrix[i, j] == -1
				max_val(i - 1, j - weights[i])
			end
			val_matrix[i, j] = max(val_matrix[i-1, j], val_matrix[i-1, j-weights[i]] + values[i])
		end
	end

	function retrieve_solution(i::Int, j::Int)::Set{Int}
		if i == 0
			return Set()
		end
		#= due to the backwards run of max_value, some values on the first row 
		of val_matrix can remain - 1, thus sometimes adding the first item to the
		set. Therefore the comparison with max(., .). =#
		if val_matrix[i, j] > max(val_matrix[i-1, j], 0)
			return push!(retrieve_solution(i - 1, j - weights[i]), i)
		else
			return retrieve_solution(i - 1, j)
		end

	end
	max_val(n, maxWeight)
	# display(val_matrix)
	return retrieve_solution(n, maxWeight)
end
