# Gems of Discrete Optimization 2023: Robustness and Approximation for Universal Scheduling
(Work in Progress)
This repository contains implementations in Julia of algorithms related to 
robust scheduling and benchmarks/examples for their use. 



## References

1. Megow, N. (2015). Robustness and Approximation for Universal Sequencing. In: Schulz, A., Skutella, M., Stiller, S., Wagner, D. (eds) Gems of Combinatorial Optimization and Graph Algorithms . Springer, Cham. https://doi.org/10.1007/978-3-319-24971-1_13

Main paper for the seminar on robust scheduling for the $1||\sum w_j*f(C_j)$ problem. It describes the first two doubling algorithms in src/scheduling/single_machine.jl
The paper is strongly related to 

2. Epstein, L., Levin, A., Marchetti-Spaccamela, A., Megow, N., Mestre, J., Skutella, M., Stougie, L.: Universal sequencing on a single unreliable machine. SIAM J. Comput. 41(3), 565–586 (2012)

which is a generalization of the results and provides results for many more scheduling problems. It presents randomized_doubling.

3. Smith, W.E.: Various optimizers for single-stage production. Nav. Res. Logist. Q. 3, 59–66 (1956)

Optimality of Smith's Rule for the $1 || \sum w_j*C_j$ (Section IV).
