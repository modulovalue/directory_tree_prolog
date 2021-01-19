directoryTree(ROOT, OUT2) :-
    directoryTreeChildName(ROOT, NAME),
    directoryTreeChildrenOrEmpty(ROOT, CHILDREN),
    directoryTree_(CHILDREN, '', [NAME], OUT2).
    
directoryTree_([VALUE], PREFIX, IN, OUT1) :- 
    addPrefix(VALUE, PREFIX, "┗━ ", IN, OUT),
    directoryTreeChildrenOrEmpty(VALUE, CHILDREN),
    atom_concat(PREFIX, '.  ', PREFIX2),
    directoryTree_(CHILDREN, PREFIX2, OUT, OUT1), !.
directoryTree_([H|T], PREFIX, IN, OUT2) :- 
    addPrefix(H, PREFIX, '┣━ ', IN, OUT),
    directoryTreeChildrenOrEmpty(H, CHILDREN),
    atom_concat(PREFIX, '┃  ', PREFIX2),
    directoryTree_(CHILDREN, PREFIX2, OUT, OUT1),
    directoryTree_(T, PREFIX, OUT1, OUT2).
directoryTree_([], _, IN, IN).

addPrefix(CHILD, PREFIXPART1, PREFIXPART2, IN, OUT):-
    directoryTreeChildName(CHILD, NAME),
    atom_concat(PREFIXPART1, PREFIXPART2, PREFIX),
    atom_concat(PREFIX, NAME, OUT2),
    append_(IN, [OUT2], OUT).

append_([], RESULT, RESULT).
append_([H|T], LIST, [H|RESULT]) :- append_(T, LIST, RESULT).

directoryTreeChildrenOrEmpty(N, C) :- directoryTreeChildren(N, C).
directoryTreeChildrenOrEmpty(N, []) :- not(directoryTreeChildren(N, _)).

% Dataset.

directoryTreeChildren(entity, [token, value]).
directoryTreeChildren(token, [leftbracket, rightbracket, leftcurly, rightcurly, comma, colon]).
directoryTreeChildren(value, [array, object, string, number, null]).
directoryTreeChildren(number, [double, integer]).

directoryTreeChildName(entity, 'Entity').
directoryTreeChildName(token, 'Token').
directoryTreeChildName(value, 'Value').
directoryTreeChildName(leftbracket, 'Left Bracket').
directoryTreeChildName(rightbracket, 'Right Bracket').
directoryTreeChildName(leftcurly, 'Left Curly').
directoryTreeChildName(rightcurly, 'Right Curly').
directoryTreeChildName(comma, 'Comma').
directoryTreeChildName(colon, 'Colon').
directoryTreeChildName(array, 'Array').
directoryTreeChildName(object, 'Object').
directoryTreeChildName(string, 'String').
directoryTreeChildName(number, 'Number').
directoryTreeChildName(double, 'Double').
directoryTreeChildName(integer, 'Integer').
directoryTreeChildName(null, 'Null').


