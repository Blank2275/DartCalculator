fun apply(function func, array arr) do
    res = []

    for (element in arr) do
        res = res.add(func(element))
    end

    return res
end

fun square(number x) do
    return x ^ 2
end

print apply(square, [0, 1, 2, 3, 4, 5])