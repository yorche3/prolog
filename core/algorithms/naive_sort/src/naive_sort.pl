% NaiveSort — ordenamientos elementales O(n²).
%
% Especificación: 05_Naive_Sort
%
% Predicados del contrato (lista de entrada y lista ordenada de menor a mayor).
% Las listas de Prolog son inmutables, así que cada algoritmo devuelve una lista
% nueva en lugar de reordenar la recibida:
%   selection_sort(+Arr, -Sorted)
%   bubble_sort(+Arr, -Sorted)
%   insertion_sort(+Arr, -Sorted)

% --- selection sort: encuentra el mínimo del tramo no ordenado y lo ubica al
% --- inicio, recursando sobre el resto.

selection_sort([], []).
selection_sort(Arr, [Min|SortedRest]) :-
    pick_min(Arr, Min, Rest),
    selection_sort(Rest, SortedRest).

% pick_min(+Arr, -Min, -Rest): Min es el menor elemento de Arr y Rest es Arr sin
% su primera aparición, conservando el orden original.
pick_min([X|Xs], Min, Rest) :-
    smallest(Xs, X, Min),
    remove_first(Min, [X|Xs], Rest).

% smallest(+Arr, +BestSoFar, -Min)
smallest([], Min, Min).
smallest([Y|Ys], Best, Min) :-
    ( Y < Best ->
        smallest(Ys, Y, Min)
    ;
        smallest(Ys, Best, Min)
    ).

% remove_first(+Element, +Arr, -Rest)
remove_first(X, [X|Xs], Xs) :- !.
remove_first(X, [Y|Ys], [Y|Rest]) :-
    remove_first(X, Ys, Rest).

% --- bubble sort: compara e intercambia elementos adyacentes y repite mientras
% --- la pasada haya cambiado algo.

bubble_sort(Arr, Sorted) :-
    ( bubble_pass(Arr, Passed, true) ->
        bubble_sort(Passed, Sorted)
    ;
        Sorted = Arr
    ).

% bubble_pass(+Arr, -Result, -Swapped): una pasada de burbuja que arrastra el
% mayor al final. Swapped queda en true si la pasada intercambió al menos un par,
% que es la bandera de salida temprana.
bubble_pass([X,Y|Rest], Result, true) :-
    X > Y, !,
    bubble_pass([X|Rest], Tail, _),
    Result = [Y|Tail].
bubble_pass([X,Y|Rest], Result, Swapped) :-
    X =< Y, !,
    bubble_pass([Y|Rest], Tail, Swapped),
    Result = [X|Tail].
bubble_pass([X], [X], false) :- !.
bubble_pass([], [], false).

% --- insertion sort: inserta cada elemento en su posición dentro del sub-array
% --- ya ordenado.

insertion_sort([], []).
insertion_sort([X|Xs], Sorted) :-
    insertion_sort(Xs, SortedXs),
    insert(X, SortedXs, Sorted).

% insert(+Element, +SortedArr, -Sorted)
insert(X, [], [X]).
insert(X, [Y|Ys], [X,Y|Ys]) :-
    X =< Y, !.
insert(X, [Y|Ys], [Y|Zs]) :-
    X > Y,
    insert(X, Ys, Zs).
