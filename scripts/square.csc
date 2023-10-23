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

fun f(x, y) do
    return sin(x / 5 + y / 10)
end

mat = quickMat(20, 20, f)

print mat