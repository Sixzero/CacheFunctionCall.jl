module CacheFunctionCall

using Serialization

export @cache_call, cache_loadcall

# Create cache directory in package root
const CACHE_DIR = joinpath(@__DIR__, "..", ".cache")
isdir(CACHE_DIR) || mkpath(CACHE_DIR)

# Helper to create safe filenames
function safe_cache_filename(fn, scope)
    fn_str = string(fn)
    # TODO: Check if filename would be valid
    base = fn_str
    return joinpath(CACHE_DIR, "$(base)_$(scope)_call.cache")
end

"""
    @cache_call [scope] function_call
    
Caches a function call and its arguments to a file with optional scope name.
Example:
    @cache_call myfunction(arg1, arg2; kwarg1=1)
    @cache_call "case1" myfunction(arg1, arg2; kwarg1=1)
"""
macro cache_call(args...)
    if length(args) == 1
        scope = "default"
        expr = args[1]
    else
        scope = args[1]
        expr = args[2]
    end

    if expr.head != :call
        error("Expression must be a function call")
    end
    
    fn = expr.args[1]
    args = expr.args[2:end]
    
    # Handle parameters expression
    if length(args) > 0 && args[1] isa Expr && args[1].head == :parameters
        kwargs = args[1].args
        posargs = args[2:end]
    else
        kwargs = []
        posargs = args
    end
    
    return quote
        let fn = $(esc(fn)),
            posargs = $(esc(Expr(:vect, posargs...))),
            kwargs = Dict{Symbol,Any}($(map(k -> :($(QuoteNode(k.args[1])) => $(esc(k.args[2]))), kwargs)...))
            
            cache_file = safe_cache_filename(fn, $scope)
            open(cache_file, "w") do io
                serialize(io, (fn, posargs, kwargs))
            end
            fn(posargs...; kwargs...)
        end
    end
end

"""
    cache_loadcall(fn, scope="default") -> (function, args, kwargs)

Loads the cached function call arguments for the given function and scope.
"""
function cache_loadcall(fn, scope="default")
    cache_file = safe_cache_filename(fn, scope)
    !isfile(cache_file) && error("No cached call found for function $fn with scope $scope")
    open(cache_file) do io
        deserialize(io)
    end
end

end
