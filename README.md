# CacheFunctionCall [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://sixzero.github.io/CacheFunctionCall.jl/stable/) [![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://sixzero.github.io/CacheFunctionCall.jl/dev/) [![Build Status](https://github.com/sixzero/CacheFunctionCall.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/sixzero/CacheFunctionCall.jl/actions/workflows/CI.yml?query=branch%3Amaster) [![Coverage](https://codecov.io/gh/sixzero/CacheFunctionCall.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/sixzero/CacheFunctionCall.jl) [![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

Cache function arguments and kwargs to debug them later on.

## Installation
```julia
using Pkg
Pkg.add("CacheFunctionCall")
```

## Usage
```julia
using CacheFunctionCall

# Basic usage
@cache_call myfunction(1, 2; c=3)
fn, args, kwargs = cache_loadcall(myfunction)

# With scope
@cache_call "case1" myfunction(1, 2; c=3)
fn, args, kwargs = cache_loadcall(myfunction, "case1")
```
