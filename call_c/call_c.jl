# gcc -shared -o lib.so lib.C

function axpy!(y::Vector, a::Number, x::Vector)
    length(x) == length(y) || error("inconsistent length between `x` and `y`")
    @ccall "./lib.so".axpy(a::Float64, x::Ptr{Float64}, y::Ptr{Float64}, length(x)::Cint)::Cvoid
    return y
end

a = 2.0
x = rand(3)
y = rand(3)

@show a*x + y
axpy!(y, a, x)
