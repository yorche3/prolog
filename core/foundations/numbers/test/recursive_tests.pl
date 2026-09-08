:- use_module(library(plunit)).
:- consult('../src/numbers.pl').

:- begin_tests(recursive_tests).

test(sum_of_first_n_rec) :-
    sum_of_first_n_rec(0, R1),
    assertion(R1 == 0),
    sum_of_first_n_rec(3, R2),
    assertion(R2 == 6).

test(factorial_rec) :-
    factorial_rec(0, R1),
    assertion(R1 == 1),
    factorial_rec(4, R2),
    assertion(R2 == 24).

test(fibonacci_rec) :-
    fibonacci_rec(0, R1),
    assertion(R1 == 0),
    fibonacci_rec(1, R2),
    assertion(R2 == 1),
    fibonacci_rec(6, R3),
    assertion(R3 == 8).

test(greatest_common_divisor_rec) :-
    greatest_common_divisor_rec(12, 8, R1),
    assertion(R1 == 4),
    greatest_common_divisor_rec(7, 5, R2),
    assertion(R2 == 1).

test(least_common_multiple_rec) :-
    least_common_multiple_rec(4, 6, R1),
    assertion(R1 == 12),
    least_common_multiple_rec(6, 8, R2),
    assertion(R2 == 24).

:- end_tests(recursive_tests).

:- initialization(run_tests(recursive_tests), main).
