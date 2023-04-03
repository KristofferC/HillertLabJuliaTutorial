include("ad_implementation.jl")

# Use our own implementation:
function gaussian_pdf(x, μ=0.0, σ=1.0)
    coeff = 1 / (σ * sqrt(2π))
    exponent = -0.5 * ((x - μ) / σ) ^ 2
    return coeff * exp(exponent)
end


deriv = derivative(gaussian_pdf, 0.26)
@show deriv

second_deriv = second_derivative(gaussian_pdf, 0.26)
@show second_deriv

# Using a package:
using ForwardDiff

deriv2 = ForwardDiff.derivative(gaussian_pdf, 0.26)
@show deriv2


using Plots

plot([gaussian_pdf
      x->derivative(gaussian_pdf, x)
      x->second_derivative(gaussian_pdf, x)], xlim = (-3, 3),
    label = ["gaussian_pdf" "derivative" "second derivative"],
    title = "Gaussian PDF and its derivatives"
    )
