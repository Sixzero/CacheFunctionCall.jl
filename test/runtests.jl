using CacheFunctionCall
using Test
using Aqua

@testset "CacheFunctionCall.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(CacheFunctionCall)
    end

    @testset "Basic functionality" begin
        # Test function with positional args
        f1(x, y) = x + y
        result = @cache_call f1(1, 2)
        @test result == 3
        
        # Test cached call loading
        fn, args, kwargs = cache_loadcall(f1)
        @test fn(1, 2) == f1(1, 2)
        @test args == [1, 2]
        @test isempty(kwargs)
        @test fn(args...; kwargs...) == 3

        # Test scoped cache
        result = @cache_call "case1" f1(2, 3)
        @test result == 5
        fn, args, kwargs = cache_loadcall(f1, "case1")
        @test args == [2, 3]
        @test fn(args...; kwargs...) == 5

        # Test function with kwargs
        f2(x; y=1) = x + y
        result = @cache_call "test" f2(1; y=2)
        @test result == 3
        
        fn, args, kwargs = cache_loadcall(f2, "test")
        @test fn(1; y=2) == f2(1; y=2)
        @test args == [1]
        @test kwargs == Dict(:y => 2)
        @test fn(args...; kwargs...) == 3
    end

    @testset "Error handling" begin
        f3(x) = x
        @test_throws ErrorException cache_loadcall(:nonexistent_fn)
        @test_throws ErrorException cache_loadcall(f3, "nonexistent_scope")
    end

    # Cleanup cache directory
    rm(CacheFunctionCall.CACHE_DIR, force=true, recursive=true)
end
;