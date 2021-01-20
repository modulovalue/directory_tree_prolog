# Prolog directory tree

A prolog pretty printer for directory trees.

v2: Call `directoryTreePreview` to get this preview:

```
Entity
╠═ Token
║  ╠═ Left Bracket
║  ╠═ Right Bracket
║  ╠═ Left Curly
║  ╠═ Right Curly
║  ╠═ Comma
║  ╚═ Colon
╚═ Value
.  ╠═ Array
.  ╠═ Object
.  ╠═ String
.  ╠═ Number
.  ║  ╠═ Double
.  ║  ╚═ Integer
.  ╚═ Null
Entity
┣━ Token
┃  ┣━ Left Bracket
┃  ┣━ Right Bracket
┃  ┣━ Left Curly
┃  ┣━ Right Curly
┃  ┣━ Comma
┃  ┗━ Colon
┗━ Value
.  ┣━ Array
.  ┣━ Object
.  ┣━ String
.  ┣━ Number
.  ┃  ┣━ Double
.  ┃  ┗━ Integer
.  ┗━ Null
Entity
|- Token
|  |- Left Bracket
|  |- Right Bracket
|  |- Left Curly
|  |- Right Curly
|  |- Comma
|  '- Colon
'- Value
.  |- Array
.  |- Object
.  |- String
.  |- Number
.  |  |- Double
.  |  '- Integer
.  '- Null
...
```
