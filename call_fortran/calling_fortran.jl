# Adapted from
# https://github.com/da-james/djs-office-hours/blob/master/julia-learning-src/advance/10-calling_fortran.jl
# gfortran -shared -fPIC mod_julafort.f90 -o mod_julfort.so

using LinearAlgebra

# Name mangled
function fortran_dot(x, y)
    @assert length(x) == length(y)
    l = length(x)
    return @ccall "./mod_julfort.so".__mod_julfort_MOD_dot(
        l::Ref{Int64}, x::Ptr{Float64}, y::Ptr{Float64}
    )::Float64
end

# C interface
function fortran_mult_arr!(x, s)
    l = length(x)
    @ccall "./mod_julfort.so".mult_arr(
        l::Ref{Int64}, x::Ptr{Float64}, s::Ref{Float64}
    )::Cvoid
end

function main()
    x = [2.0, 3.0, 5.0]
    y = [1.0, 2.0, 3.0]
    @show fortran_dot(x, y)
    @show dot(x, y)


    z = [1.0, 3.0, 2.0, 4.0]
    s = 3.0
    @show z
    @show z .* s .+ s
    # Mutates z
    fortran_mult_arr!(z, s)
    @show z

end


main()
