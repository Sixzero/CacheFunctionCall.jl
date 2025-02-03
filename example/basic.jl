# Example usage:
#
# Define a test function.
using CacheFunctionCall

function myfunction(a, b; c=10)
  println("Inside myfunction: a = $a, b = $b, c = $c")
  return a + b + c
end

# Use the macro to “cache” the call. This will:
#  1. Write the call parameters to a file named "cache_myfunction.jls".
#  2. Execute myfunction(1, 2; c=3) and return its result.
result = @cache_call myfunction(1, 2; c=3)
println("Result from cached call: ", result)

# Later (or in a different session) you can load the cached call:
fn, args, kwargs = cache_loadcall(myfunction)
println("Loaded call parameters:")
println("  Function: ", fn)
println("  Positional args: ", args)
println("  Keyword args: ", kwargs)

# You can then re-run the call (or use it however you need):
result2 = fn(args...; kwargs...)
println("Result from re-running the loaded call: ", result2)