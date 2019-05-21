function generate_2D_dataset(n::Int, x1_scope::Tuple, x2_scope::Tuple, accurancy::Number, equidistant::Bool=false)
# n: Number of generated points in 2D (i.e. points in the form [x1, x2])
# x1_scope: Definition domain of the 2D function if x=x1,y=x2.
# x2_scope: Function range of the 2D function if x=x1,y=x2.
# accurancy: Decimal number representing valid decimal places in function values.
# equidistant: Whether x1 points should be equidistant or not(defaut), i.e. generated randomly as x2 points.
    x1_first, x1_last = x1_scope
    x1_min, x1_max = x1_scope
    x2_min, x2_max = x2_scope

    if equidistant == true
        step = x1_scope/n
        x1_set = collect(x1_min : step : x1_max)
    else
        x1_set = rand(x1_min : accurancy : x1_max, n)
    end
    x2_set = rand(x2_min : accurancy : x2_max, n)
    return [x1_set x2_set]
end

function create_2D_linear_function(omega,b)
    # returns anonymous function which accepts single number 'x1' as input
    # a*x + b*y +c = 0 --> y = -(c+ax)/b
    # omega1*x1 + omega2*x2 + b = 0 --> x2 = -(b+w1*x1)/w2
    w1,w2 = omega[1],omega[2]
    f(x1) = -(b+w1*x1)/w2
    return f
end

function get_minmax_vals(dataset::Array, two_dimensions=true)
    if two_dimensions != true
        println(stderr, "Only 2D supported, exiting...\n")
        exit(1)
    end
    x1 = dataset[:,1]
    x2 = dataset[:,2]
    x1_bounds=[minimum(x1),maximum(x1)]
    x2_bounds=[minimum(x2),maximum(x2)]
    return x1_bounds, x2_bounds
end

