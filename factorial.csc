#out state fun factorial(number n) {
    if (n <= 2) do
        return n
    end

    return n * factorial(n - 1);
}

// in calculator: 
// import factorial
// factorial(10)