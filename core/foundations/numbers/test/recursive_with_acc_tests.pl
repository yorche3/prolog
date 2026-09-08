:- use_module(library(plunit)).
:- consult('../src/numbers.pl').

:- begin_tests(recursive_with_acc_tests).

test(sum_of_first_n_acc) :-
    sum_of_first_n_acc(0, R1),
    assertion(R1 == 0),
    sum_of_first_n_acc(3, R2),
    assertion(R2 == 6).

test(factorial_acc) :-
    factorial_acc(0, R1),
    assertion(R1 == 1),
    factorial_acc(4, R2),
    assertion(R2 == 24).

test(fibonacci_acc) :-
    fibonacci_acc(0, R1),
    assertion(R1 == 0),
    fibonacci_acc(1, R2),
    assertion(R2 == 1),
    fibonacci_acc(6, R3),
    assertion(R3 == 8).

test(greatest_common_divisor_acc) :-
    greatest_common_divisor_acc(12, 8, R1),
    assertion(R1 == 4),
    greatest_common_divisor_acc(7, 5, R2),
    assertion(R2 == 1).

test(least_common_multiple_acc) :-
    least_common_multiple_acc(4, 6, R1),
    assertion(R1 == 12),
    least_common_multiple_acc(6, 8, R2),
    assertion(R2 == 24).

:- end_tests(recursive_with_acc_tests).

:- initialization(run_tests(recursive_with_acc_tests), main).
