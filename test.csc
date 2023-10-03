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
    arr = [0, 1, 2, 3]
    print remove(arr, 2)

end

zeros([])