% Call directoryTree(entity, OUTPUTLIST).

% Accepts a tree root and outputs a list of atoms that represent the directory tree.
directoryTree(ROOT, OUT) :-
    directoryTreeChildName(ROOT, NAME),
    directoryTreeChildrenOrEmpty(ROOT, CHILDREN),
    directoryTree_(CHILDREN, '', [NAME], OUT).
    
% Unifies if there is one child. The cut stops backtracking so that there is only one solution here.
% The distinction between one and many children is important because when there is only one child,
% The symbols need to be different.
directoryTree_([VALUE], PREFIX, IN, OUT1) :- 
    addPrefix(VALUE, PREFIX, "┗━ ", IN, OUT),
    directoryTreeChildrenOrEmpty(VALUE, CHILDREN),
    atom_concat(PREFIX, '.  ', PREFIX2),
    directoryTree_(CHILDREN, PREFIX2, OUT, OUT1), !.
% Unifies with any non negative amount of children.
directoryTree_([H|T], PREFIX, IN, OUT2) :- 
    addPrefix(H, PREFIX, '┣━ ', IN, OUT),
    directoryTreeChildrenOrEmpty(H, CHILDREN),
    atom_concat(PREFIX, '┃  ', PREFIX2),
    directoryTree_(CHILDREN, PREFIX2, OUT, OUT1),
    directoryTree_(T, PREFIX, OUT1, OUT2).
% Unifies with an empty list of children and just says that the input is the output.
directoryTree_([], _, IN, IN).

% Takes the name of the given child and adds 2 prefixes to it.
addPrefix(CHILD, PREFIXPART1, PREFIXPART2, IN, OUT):-
    directoryTreeChildName(CHILD, NAME),
    atom_concat(PREFIXPART1, PREFIXPART2, PREFIX),
    atom_concat(PREFIX, NAME, OUT2),
    append_(IN, [OUT2], OUT).

% A reimplementation of prologs internal append.
append_([], RESULT, RESULT).
append_([H|T], LIST, [H|RESULT]) :- append_(T, LIST, RESULT).

directoryTreeChildrenOrEmpty(N, C) :- directoryTreeChildren(N, C).
% This predicate allows prolog to unify with directoryTreeChildren 
% when there are no children, to an empty list of children.
directoryTreeChildrenOrEmpty(N, []) :- not(directoryTreeChildren(N, _)).

% Dataset.
% You should replace the dataset with your own data.

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


