#in env sin | cos | PI
#in state f | a | b

#out env fun test(number c) {
    if(a + b >= c) do
        return f((a + b) / c)
    end
    else do 
        return (a + b) / c
    end
}