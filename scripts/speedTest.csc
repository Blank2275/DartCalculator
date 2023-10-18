fun f(x) do
    return (5 * x ^ 2) / sin(x + 3)
end

xs = range(0, 1024, 1)

print "length: " + len(xs)
for (i in quickRange(60)) do
    apply(f, xs)
    print i 
end