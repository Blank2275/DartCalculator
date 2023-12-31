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
    relX = x - 20
    relY = y - 20

    return sin(relX / 3.14) + cos(relY / 3.14)
end

mat = quickMat(40, 40, paraboloid)

print mat

