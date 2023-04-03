
function f_debug(n)
    out = []
    for i in n:-1:-n
        push!(out, log(i))
    end
    out
end
