:- use_module(library(plunit)).
:- consult('../src/naive_sort.pl').

% Casos de prueba de la especificación 05_Naive_Sort.md
%
% Caso nulo omitido: en Prolog el array es una lista y una lista no admite
% `null` ni una entrada nula, así que el caso no es representable y se conservan
% los 7 casos de la especificación. Al ser las listas inmutables, cada caso
% puede usar la constante compartida sin riesgo de contaminar los siguientes.

standard_input([5, 2, 9, 1, 5, 6]).
standard_output([1, 2, 5, 5, 6, 9]).

sorted_input([1, 2, 3, 4, 5]).
sorted_output([1, 2, 3, 4, 5]).

reverse_input([5, 4, 3, 2, 1]).
reverse_output([1, 2, 3, 4, 5]).

identical_input([7, 7, 7, 7]).
identical_output([7, 7, 7, 7]).

negative_input([3, -1, 4, -5, 0]).
negative_output([-5, -1, 0, 3, 4]).

single_input([42]).
single_output([42]).

empty_input([]).
empty_output([]).

case(an_unsorted_array, Input, Expected) :-
    standard_input(Input),
    standard_output(Expected).

case(an_already_sorted_array, Input, Expected) :-
    sorted_input(Input),
    sorted_output(Expected).

case(a_reverse_ordered_array, Input, Expected) :-
    reverse_input(Input),
    reverse_output(Expected).

case(an_array_of_identical_elements, Input, Expected) :-
    identical_input(Input),
    identical_output(Expected).

case(an_array_with_negative_numbers, Input, Expected) :-
    negative_input(Input),
    negative_output(Expected).

case(a_single_element_array, Input, Expected) :-
    single_input(Input),
    single_output(Expected).

case(an_empty_array, Input, Expected) :-
    empty_input(Input),
    empty_output(Expected).

% Predicado de aserción: plunit imprime el goal de la aserción al fallar, así que
% su nombre y sus argumentos son el mensaje del contrato, equivalente a
% "{Algorithm} should sort {Description}".
should_sort(_Algorithm, _Description, Actual, Expected) :-
    Actual == Expected.

% Helper compartido: recibe el predicado a probar y el nombre del algoritmo, y
% ejecuta todos los casos con un mensaje descriptivo cada uno.
assert_sorts_all_cases(Sort, Algorithm) :-
    forall(case(Description, Input, Expected),
           assert_sorts_case(Sort, Algorithm, Description, Input, Expected)).

assert_sorts_case(Sort, Algorithm, Description, Input, Expected) :-
    Goal =.. [Sort, Input, Actual],
    call(Goal),
    assertion(should_sort(Algorithm, Description, Actual, Expected)).

:- begin_tests(naive_sort_tests).

test(selection_sort) :-
    assert_sorts_all_cases(selection_sort, selection_sort).

test(bubble_sort) :-
    assert_sorts_all_cases(bubble_sort, bubble_sort).

test(insertion_sort) :-
    assert_sorts_all_cases(insertion_sort, insertion_sort).

:- end_tests(naive_sort_tests).

:- initialization(run_tests(naive_sort_tests), main).
