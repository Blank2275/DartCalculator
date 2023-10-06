fun exp(number val, boolean echo) do
    res = 2.71 ^ val

    if (echo) do
        print res
    end

    return res
end

exec "exp" [2, 1]