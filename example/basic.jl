# Example usage:
#
# Define a test function.
using CacheFunctionCall

function myfunction(a, b; c=10)
    println("Inside myfunction: a = $a, b = $b, c = $c")
    return a + b + c
end

# Cache with default scope
result1 = @cache_call myfunction(1, 2; c=3)
println("Result from default cached call: ", result1)

# Cache with custom scope
result2 = @cache_call "case1" myfunction(2, 3; c=4)
println("Result from case1 cached call: ", result2)

# Load different scopes
fn1, args1, kwargs1 = cache_loadcall(myfunction)  # default scope
println("Default scope parameters:")
println("  Args: ", args1)
println("  Kwargs: ", kwargs1)

fn2, args2, kwargs2 = cache_loadcall(myfunction, "case1")
println("Case1 scope parameters:")
println("  Args: ", args2)
println("  Kwargs: ", kwargs2)
#%%
using PromptingTools: UserMessage

api_kwargs = (; )
@cache_call aigenerate(
            [UserMessage("Hello, how are you?")];
            model="claude",
            cache=:all_but_last, 
            api_kwargs,
            verbose=false
        )