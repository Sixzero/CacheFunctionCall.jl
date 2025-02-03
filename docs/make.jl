using CacheFunctionCall
using Documenter

DocMeta.setdocmeta!(CacheFunctionCall, :DocTestSetup, :(using CacheFunctionCall); recursive=true)

makedocs(;
    modules=[CacheFunctionCall],
    authors="SixZero <havliktomi@hotmail.com> and contributors",
    sitename="CacheFunctionCall.jl",
    format=Documenter.HTML(;
        canonical="https://sixzero.github.io/CacheFunctionCall.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/sixzero/CacheFunctionCall.jl",
    devbranch="master",
)
