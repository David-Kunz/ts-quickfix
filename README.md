# ts-quickfix

Populate a [quickfix](https://neovim.io/doc/user/quickfix.html) list with [Tree-Sitter](https://tree-sitter.github.io/tree-sitter/) queries


## Installation

```lua
use 'David-Kunz/ts-quickfix
```

## Usage

```lua
require('ts-quickfix').query([[
  ((comment) @comment
   (#match? @comment "[^a-zA-Z0-9](TODO|HACK|WARNING|BUG|FIXME|XXX|REVISIT)"))
]])
```

You can also define queries in your `queries` folder and reference them by name:

```lua
require('ts-quickfix').query_name('myName')
```
