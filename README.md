# Dart Calculator

## goal

The goal of this project is to create a powerful and extendable calculator with a scripting language for custom functions.

This project is entirely a command line interface with two parts: a calculator repl that keeps track of a state of the project including user defined functions and variables and a scripting language to add more advanced functionality for the calculator that may persist accross runs.

## scripting language

The scripting language has a vaguely python/ruby like syntax but much simpler. Currently it has three data types: numbers, booleans, and strings. you can declare variables without specifying a type and it is a loosely typed language. the language supports if/elif/else, for loops, while loops, and functions

### syntax

to print a value to the screen

```
print value
```

to declare a variable 'name' with the value 'value'

```
name = value
```

if/elif/else are done with

```
if (condition) do
    print "condition one true"
end
elif (condition2) do
    print "condition two true"
end
else do
    print "no conditions were true"
end
```

for loops loop through an array like an enhanced for loop in java or the normal for loop in python

```
for (iterator in [0, 1, 2]) do
    print iterator
end
```

note: to help with for loops, there is a built in range function - range(start, stop step), all parameters are necessary

```
for (i in range(0, 10, 1)) do
    print i ^ 2
end
```

prints 0-10 not inclusive squared

while loops do with:

```
while(condition) do
end
```

```
i = 5

while(i > 0) do
    print i
    i = i - 1
end
```

prints 5 4 3 2 1 with new lines

### functions

functions are declared as

```
fun name(type parameter1, type parameter2) do
end

fun factorial(number n) do
    if (n <= 2) do
        return n
    end

    return n * factorial(n - 1)
end

print factorial(5)
```

you can pass in a variable to the first argument of a function lile this

```
arr = [0, 1, 2]

fun print(array a) do
    for (element in a) do
        print a
    end
end

arr.print()
```

which is equivalent to

```
print(arr)
```

which is handy for some array functions to make it a little nicer.

### expressions

1 + 2 - 3 \* 4 / 2 ^ 2
evaluates with normal order of operations as 2

supports >, <, >=, <=, ==, !=, ||, && for booleans

the language supports the ternary operator

```
condition ? onTrue : onFalse
```

this should return around 3

```
sin(3.1415 / 2) * 3
```

when you use a math operation on an array, it does that operation element wise

```
arr = [0, 1, 2]
print arr + 1
```

prints [1, 2, 3]

### current implemented functions

generates a range
range(number start, number stop, number step) -> array

sin in radians
sin(number x) -> number

cos in radians
cos(number x) -> number

tan in radians
tan(number x) -> number

returns the provided array with the provided value appended, does not modify the array
add(array arr, any value) -> array

returns length of provided array arr
len(array arr) -> number

returns element at index from array arr
get(array arr, number index) -> any

sets element at index to val returning new array, does not modify the array
set(array arr, number index, any val) -> array

returns the type of the provided value:

-   number
-   boolean
-   string
-   array
-   null

typeof(any value) -> string
