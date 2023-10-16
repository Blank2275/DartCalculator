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

arr = range(0, 100, 1)

fun addOne(n) do
    return n + 1
end

fun quickRange(n) do
    return range(0, n, 1)
end

print apply(quickRange, arr)