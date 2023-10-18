fun pad(n) do
    return [0, n, 0]
end

fun quickMat(x, y, function val) do
    mat = []

    for (i in quickRange(y)) do
        mat = mat.add([])
        for (j in quickRange(x)) do
            row = mat.get(i)
            row = row.add(val(j, i))
            mat = mat.set(i, row)
        end
    end

    return mat
end

fun paraboloid(x, y) do
    return (x - 10) ^ 2 + (y - 10) ^ 2
end

mat = quickMat(20, 20, paraboloid)

print mat

