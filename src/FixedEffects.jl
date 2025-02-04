module FixedEffects

##############################################################################
##
## Dependencies
##
##############################################################################

using Base: @propagate_inbounds
using LinearAlgebra: LinearAlgebra, Adjoint, mul!, rmul!, norm, axpy!
using StatsBase: AbstractWeights, UnitWeights, Weights, uweights
using GroupedArrays: GroupedArray
using Requires: @require
using Printf: @printf

##############################################################################
##
## Load files
##
##############################################################################
include("utils/lsmr.jl")
include("utils/progressbar.jl")

include("FixedEffect.jl")
include("AbstractFixedEffectSolver.jl")
include("FixedEffectSolvers/FixedEffectLinearMap.jl")
include("FixedEffectSolvers/FixedEffectSolverCPU.jl")


has_CUDA() = false
function __init__()
	    @require CUDA="052768ef-5323-5732-b1bb-66c8b64840ba" begin
	    if CUDA.functional()
		    has_CUDA() = true
	    	include("FixedEffectSolvers/FixedEffectSolverGPU.jl")
	    end
	end
end


include("precompile.jl")
_precompile_()

##############################################################################
##
## Exported methods and types
##
##############################################################################


export FixedEffect,
AbstractFixedEffectSolver,
solve_residuals!,
solve_coefficients!


end  # module FixedEffects
