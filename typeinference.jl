
z = 0
function f_global(x::AbstractVector)
    for v in x
        global z += v
    end
    return z
end

function f_stable(x::AbstractVector)
    z = zero(eltype(x))
    for v in x
        z += v
    end
    return z
end
