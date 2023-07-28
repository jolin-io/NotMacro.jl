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
    if isdefined(Base, :⊼)
        @test (@not false ⊼ true) == false
    end
    if isdefined(Base, :⊽)
        @test (@not true ⊽ false) == true
    end

    # double negation

    @test (@not @not true && false) == false

    # test three operators
    @test (@not true && false || false) == false

    for a in [true, false],
        b in [true, false],
        c in [true, false],
        expr in [
            :((a && b) && c),
            :((a && b) || c),
            :((a || b) && c),
            :((a || b) || c),

            :(a && (b && c)),
            :(a && (b || c)),
            :(a || (b && c)),
            :(a || (b || c)),

            :((a & b) & c),
            :((a & b) | c),
            :((a | b) & c),
            :((a | b) | c),

            :(a & (b & c)),
            :(a & (b | c)),
            :(a | (b & c)),
            :(a | (b | c)),

            :((a && b) & c),
            :((a & b) && c),
            :((a && b) | c),
            :((a & b) || c),
            :((a || b) & c),
            :((a | b) && c),
            :((a || b) | c),
            :((a | b) || c),

            :(a && (b & c)),
            :(a & (b && c)),
            :(a && (b | c)),
            :(a & (b || c)),
            :(a || (b & c)),
            :(a | (b && c)),
            :(a || (b | c)),
            :(a | (b || c)),
        ]
        exclamation = :( ((a, b, c) -> $expr)(!$a, $b, $c) )
        notmacro = :( ((a, b, c) -> $NotMacro.@not $expr)($a, $b, $c) )
        @test @eval $exclamation == $notmacro
    end
end
