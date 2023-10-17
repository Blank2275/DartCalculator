fun apply(function func, array arr) do
    res = []

    for (element in arr) do
        if (typeof(element) != "array") do
            res = res.add(func(element))
        end else
            res = res.add(apply(func, element))
        end
    end

    return res
end