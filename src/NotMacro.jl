module NotMacro
export @not

"""
@not someboolean

a human readable alternative to `!`

Example
-------

```jldoctest
julia> using NotMacro

julia> if @not isodd(2) && @not iseven(3) && true
           println("works")
       end
works

julia> @macroexpand if @not isodd(2) & @not iseven(3) & true
           println("works")
       end
:(if (!)(isodd(2)) & ((!)(iseven(3)) & true)
      #= none:2 =#
      println("works")
  end)
```
"""
macro not(expr)
    isbinaryoperator = Meta.isexpr(expr, :call) && Meta.isbinaryoperator(expr.args[1])
    isbinaryboolsyntax = isa(expr, Expr) && expr.head ∈ (:&&, :||)
    if isbinaryoperator
        # go into any binary+ operator
        not2 = Expr(:call, !, expr.args[2])
        esc(Expr(:call, expr.args[1], not2, expr.args[3:end]...))
    elseif isbinaryboolsyntax
        # go into any binary bool syntax
        not1 = Expr(:call, !, expr.args[1])
        esc(Expr(expr.head, not1, expr.args[2:end]...))
    else
        esc(Expr(:call, !, expr))
    end
end

end
