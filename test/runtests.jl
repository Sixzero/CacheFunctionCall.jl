using CacheFunctionCall
using Test
using Aqua

@testset "CacheFunctionCall.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(CacheFunctionCall)
    end
    # Write your tests here.
end
