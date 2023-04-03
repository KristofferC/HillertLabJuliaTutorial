struct Dual{T<:Number} <: Number
    a::T
    b::T
end

Base.:+(q_1::Dual, q_2::Dual) = Dual(q_1.a + q_2.a, q_1.b + q_2.b)
Base.:-(q_1::Dual, q_2::Dual) = Dual(q_1.a - q_2.a, q_1.b - q_2.b)
Base.:*(q_1::Dual, q_2::Dual) = Dual(q_1.a * q_2.a, q_1.a * q_2.b + q_1.b * q_2.a)
Base.:/(q_1::Dual, q_2::Dual) = Dual(q_1.a / q_2.a, (q_1.b * q_2.a - q_1.a * q_2.b) / q_2.a^2)

Base.sin(q::Dual) = Dual(sin(q.a), cos(q.a) * q.b)
Base.cos(q::Dual) = Dual(cos(q.a), -sin(q.a) * q.b)
Base.exp(q::Dual) = Dual(exp(q.a), exp(q.a) * q.b)
Base.log(q::Dual) = Dual(log(q.a), q.b / q.a)

function Base.show(io::IO, f::Dual)
    sign_str = signbit(f.b) ? " - " : " + "
    print(io, "(", f.a, sign_str, abs(f.b), "ε)")
end

Base.promote_rule(::Type{Dual{T}}, ::Type{S}) where {T<:Number, S<:Number} = Dual{promote_type(T, S)}
Base.convert(::Type{Dual{T}}, x::Dual) where T <: Number = Dual(convert(T, x.a), convert(T, x.b))
Base.convert(::Type{Dual{T}}, x::Number) where T <: Number = Dual(convert(T, x), zero(T))

function derivative(f, x)
    input = Dual(x, one(x))
    dual_result = f(input)
    return dual_result.b
end

second_derivative(f, x) = derivative(x -> derivative(f, x), x)
