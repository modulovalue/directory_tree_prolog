/* 
 To use call 'directoryTree(+root in the dataset, +dataset id, +character id, -output list)'.
 
 • Call directoryTreePreview to view an example.
 • See below at the Dataset registry for how to add new datasets.
 • See below at the Symbol registry for how to add new symbols. 
 • Note: append is redefined for a custom prolog interpreter that doesn't have many builtins.
 • Repo: https://github.com/modulovalue/directory_tree_prolog
*/
directoryTree(ROOT, DATASET, SYMBOLS, OUT) :-
    datasetRegistry(DATASET, ROOT, NAME, CHILDREN),
    directoryTree_(CHILDREN, [], [NAME, '\n'], DATASET, SYMBOLS, OUT).
directoryTree_([], _, IN, _, _, IN).
directoryTree_([H|T], P, IN, DATASET, SYMBOLS, OUT2) :- 
    symbolRegistry(SYMBOLS, [H|T], PAD, INDICATE),
    datasetRegistry(DATASET, H, NAME, CHILDREN),
    append_(IN, P, INP),
    append(P, [PAD], PREFIXLIST2),
    append_(INP, [INDICATE, NAME, '\n'], OUT),
    directoryTree_(CHILDREN, PREFIXLIST2, OUT, DATASET, SYMBOLS, OUT1),
    directoryTree_(T, P, OUT1, DATASET, SYMBOLS, OUT2).

directoryTreePreview :- 
    directoryTree(_ROOT, _DATASET, _BOXDRAWINGSYMBOLS, LIST),
    atomic_list_concat(LIST, OUT), 
    format('~w', OUT).

append_([], RESULT, RESULT).
append_([H|T], LIST, [H|RESULT]) :- append_(T, LIST, RESULT).

%%%
%%% Symbol registry.
%%%
symbolRegistry(boxDrawingSymbols1, A, B, C) :- boxDrawingSymbols1(A, B, C).
symbolRegistry(boxDrawingSymbols2, A, B, C) :- boxDrawingSymbols2(A, B, C).
symbolRegistry(asciiSymbols, A, B, C) :- asciiSymbols(A, B, C).
boxDrawingSymbols1([_], '.  ', '╚═ ').
boxDrawingSymbols1([_,_|_], '║  ', '╠═ ').
boxDrawingSymbols2([_], '.  ', '┗━ ').
boxDrawingSymbols2([_,_|_], '┃  ', '┣━ ').
asciiSymbols([_], '.  ', '\'- ').
asciiSymbols([_,_|_], '|  ', '|- ').

%%%
%%% Dataset registry.
%%%
datasetRegistry(testData1, A, B, C) :- testData1(A, B, C).
datasetRegistry(testData2, A, B, C) :- testData2(A, B, C). 
% Test dataset 1.
testData1(ROOT, NAME, CHILDREN) :-
    directoryTreeChildName(ROOT, NAME),
    directoryTreeChildrenOrEmpty(ROOT, CHILDREN).
directoryTreeChildren(entity, [token, value]).
directoryTreeChildren(token, [leftbracket, rightbracket, leftcurly, rightcurly, comma, colon]).
directoryTreeChildren(value, [array, object, string, number, null]).
directoryTreeChildren(number, [double, integer]).
directoryTreeChildrenOrEmpty(N, C) :- directoryTreeChildren(N, C).
directoryTreeChildrenOrEmpty(N, []) :- not(directoryTreeChildren(N, _)).
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
% Test dataset 2. 
testData2(X, X, DATA) :- testData2_(X, DATA).
testData2(X, X, []) :- not(testData2_(X, _)).
testData2_('Root', ['Child 1', 'Child 2', 'Child 3']).
testData2_('Child 1', ['Child 11', 'Child 12', 'Child 13']).
