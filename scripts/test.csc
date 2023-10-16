fun remove(array arr, number index) do 
    res = []

    i = 0
    for (element in arr) do 
        if (i != index) do
            res = add(res, element)
        end
        i = i + 1
    end
    return res
end

fun zeros(array size) do
    arr = []
    for (i in range(0, get(size, 0), 1)) do 
        if (len(size) == 1) do 
            arr = arr.add(0)
        end
        else
            arr = add(arr, zeros(size.remove(0))) 
        end
    end

    return arr
end

shape = [2, 3]
mat = zeros([2, 3])
print mat
