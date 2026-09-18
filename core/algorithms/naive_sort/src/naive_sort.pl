% NaiveSort — ordenamientos elementales O(n²).
%
% Especificación: 05_Naive_Sort
%
% Predicados del contrato (lista de entrada y lista ordenada de menor a mayor):
%   selection_sort(+Lista, -Ordenada)
%   bubble_sort(+Lista, -Ordenada)
%   insertion_sort(+Lista, -Ordenada)

selection_sort([], []).
selection_sort([X|Xs], Ordenada) :-
    selection_sort(Xs, OrdenadaXs),
    insert_min(X, OrdenadaXs, Ordenada).

insert_min(X, [], [X]).
insert_min(X, [Y|Ys], [X,Y|Ys]) :- X =< Y.
insert_min(X, [Y|Ys], [Y|Zs]) :-
    X > Y,
    insert_min(X, Ys, Zs).

bubble_sort([], []).
bubble_sort([X|Xs], Ordenada) :-
    bubble_sort(Xs, OrdenadaXs),
    insert_bubble(X, OrdenadaXs, Ordenada).

insert_bubble(X, [], [X]).
insert_bubble(X, [Y|Ys], [X,Y|Ys]) :- X =< Y.
insert_bubble(X, [Y|Ys], [Y|Zs]) :-
    X > Y,
    insert_bubble(X, Ys, Zs).

insertion_sort([], []).
insertion_sort([X|Xs], Ordenada) :-
    insertion_sort(Xs, OrdenadaXs),
    insert(X, OrdenadaXs, Ordenada).

insert(X, [], [X]).
insert(X, [Y|Ys], [X,Y|Ys]) :- X =< Y.
insert(X, [Y|Ys], [Y|Zs]) :-
    X > Y,
    insert(X, Ys, Zs).