using NotMacro
using Documenter

DocMeta.setdocmeta!(NotMacro, :DocTestSetup, :(using NotMacro); recursive=true)

makedocs(;
    modules=[NotMacro],
    authors="Stephan Sahm <stephan.sahm@jolin.io> and contributors",
    repo="https://github.com/jolin-io/NotMacro.jl/blob/{commit}{path}#{line}",
    sitename="NotMacro.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jolin-io.github.io/NotMacro.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jolin-io/NotMacro.jl",
    devbranch="main",
)
