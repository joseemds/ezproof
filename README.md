_ezproof_ is a DSL to write [bussproof](https://ctan.org/pkg/bussproofs) proof trees easier with a lisp-like syntax.

It is available as a pandoc filter and will soon be available as a latex package.



## Syntax
```ebnf
<rule> ::= '(' <rulename>? <premises> <conclusion> ')'
<rulename> ::= '#' ident
<premises> ::= <list> | <expr>
<list> = '(' <expr>+ ')'
<expr> ::= <inline_math> | <ident>
<inline_math> ::= '$' '"' body '"'
<ident> ::= [a-zA-z]+

```

## How to use it

### Pandoc

For pandoc, all you need to have is a codeblock fenced with backticks three backticks and with the language `proof`:


````
```proof
(#init a a)
```
````

This will produce:

```latex
\begin{prooftree}
  \AxiomC{a}
  \RightLabel{init}
  \UnaryInfC{a}
\end{prooftree}
```

To achieve this you can run:

```bash
pandoc --lua-filter=ezproof-pandoc.lua pandoc-test.md -o pandoc-test.pdf
```

