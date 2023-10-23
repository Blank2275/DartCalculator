fun f(x) do
    return (5 * x ^ 2) / sin(x + 3)
end

xs = range(0, 10, 1 / 1024 * 10)

print "length: " + len(xs)
for (i in quickRange(60)) do
    print apply(f, xs)
end