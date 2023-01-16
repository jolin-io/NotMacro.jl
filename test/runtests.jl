using NotMacro
using Test
using Documenter

doctest(NotMacro, manual=false)

@testset "NotMacro.jl" begin
    @test (@not true || false) == false
    @test (@not false && true) == true
    @test (@not true | false) == false
    @test (@not false & true) == true
    @test (@not false ⊻ false) == true
    @test (@not false ⊼ true) == false
    @test (@not true ⊽ false) == true
end
