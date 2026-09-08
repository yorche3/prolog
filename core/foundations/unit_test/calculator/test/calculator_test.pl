:- use_module(library(plunit)).
:- consult('../src/calculator.pl').

:- begin_tests(calculator_test).

test(addition) :-
    addition(2, 3, Result),
    assertion(Result == 5).

test(subtraction) :-
    subtraction(5, 2, Result),
    assertion(Result == 3).

test(multiplication) :-
    multiplication(3, 4, Result),
    assertion(Result == 12).

test(division) :-
    division(10, 3, Result),
    assertion(Result == 3).

test(modulus) :-
    modulus(10, 3, Result),
    assertion(Result == 1).

:- end_tests(calculator_test).

:- initialization(run_tests(calculator_test), main).
