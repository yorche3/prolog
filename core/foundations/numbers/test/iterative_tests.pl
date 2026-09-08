:- use_module(library(plunit)).
:- consult('../src/numbers.pl').

:- begin_tests(iterative_tests).

test(sum_of_first_n_ite) :-
    sum_of_first_n_ite(0, R1),
    assertion(R1 == 0),
    sum_of_first_n_ite(3, R2),
    assertion(R2 == 6).

test(factorial_ite) :-
    factorial_ite(0, R1),
    assertion(R1 == 1),
    factorial_ite(4, R2),
    assertion(R2 == 24).

test(fibonacci_ite) :-
    fibonacci_ite(0, R1),
    assertion(R1 == 0),
    fibonacci_ite(1, R2),
    assertion(R2 == 1),
    fibonacci_ite(6, R3),
    assertion(R3 == 8).

test(greatest_common_divisor_ite) :-
    greatest_common_divisor_ite(12, 8, R1),
    assertion(R1 == 4),
    greatest_common_divisor_ite(7, 5, R2),
    assertion(R2 == 1).

test(least_common_multiple_ite) :-
    least_common_multiple_ite(4, 6, R1),
    assertion(R1 == 12),
    least_common_multiple_ite(6, 8, R2),
    assertion(R2 == 24).

:- end_tests(iterative_tests).

:- initialization(run_tests(iterative_tests), main).
