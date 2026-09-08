:- use_module(library(lists)).
:- use_module(library(apply)).

% Direct recursion (_rec)

sum_of_first_n_rec(N, 0) :-
    N =< 0, !.
sum_of_first_n_rec(N, Result) :-
    N1 is N - 1,
    sum_of_first_n_rec(N1, R1),
    Result is N + R1.

factorial_rec(N, 1) :-
    N =< 0, !.
factorial_rec(N, Result) :-
    N1 is N - 1,
    factorial_rec(N1, R1),
    Result is N * R1.

fibonacci_rec(N, Result) :-
    N =< 1, !,
    Result = N.
fibonacci_rec(N, Result) :-
    N1 is N - 1,
    N2 is N - 2,
    fibonacci_rec(N1, F1),
    fibonacci_rec(N2, F2),
    Result is F1 + F2.

greatest_common_divisor_rec(A, 0, A).
greatest_common_divisor_rec(A, B, Result) :-
    B > 0,
    R1 is A mod B,
    greatest_common_divisor_rec(B, R1, Result), !.

least_common_multiple_rec(A, B, Result) :-
    greatest_common_divisor_rec(A, B, Gcd),
    Result is (A / Gcd) * B.

% Accumulator recursion (_acc)

sum_of_first_n_acc(N, Result) :-
    sum_of_first_n_acc_help(N, 0, Result), !.

sum_of_first_n_acc_help(N, Acc, Result) :-
    N =< 0, !,
    Result is Acc.
sum_of_first_n_acc_help(N, Acc, Result) :-
    N1 is N - 1,
    sum_of_first_n_acc_help(N1, Acc + N, Result), !.

factorial_acc(N, Result) :-
    factorial_acc_help(N, 1, Result), !.

factorial_acc_help(N, Acc, Result) :-
    N =< 1, !,
    Result is Acc.
factorial_acc_help(N, Acc, Result) :-
    N1 is N - 1,
    factorial_acc_help(N1, Acc * N, Result), !.

fibonacci_acc(N, Result) :-
    fibonacci_acc_help(N, 0, 1, Result), !.

fibonacci_acc_help(N, Acc2, _, Result) :-
    N =< 0, !,
    Result is Acc2.
fibonacci_acc_help(N, Acc2, Acc1, Result) :-
    N =< 2, !,
    Result is Acc1 + Acc2.
fibonacci_acc_help(N, Acc2, Acc1, Result) :-
    N1 is N - 1,
    fibonacci_acc_help(N1, Acc1, Acc1 + Acc2, Result), !.

greatest_common_divisor_acc(A, B, Result) :-
    greatest_common_divisor_acc_help(A, B, Result), !.

greatest_common_divisor_acc_help(A, 0, A).
greatest_common_divisor_acc_help(A, B, Result) :-
    B > 0,
    R1 is A mod B,
    greatest_common_divisor_acc_help(B, R1, Result), !.

least_common_multiple_acc(A, B, Result) :-
    greatest_common_divisor_acc(A, B, Gcd),
    Result is (A / Gcd) * B.

% Iterative (_ite)

sum_of_first_n_ite(N, Result) :-
    (   N =< 0
    ->  Result = 0
    ;   numlist(1, N, Numbers),
        sum_list(Numbers, Result)
    ).

factorial_ite(N, Result) :-
    (   N =< 1
    ->  Result = 1
    ;   numlist(2, N, Numbers),
        foldl(factorial_step, Numbers, 1, Result)
    ).

factorial_step(Number, Acc, Result) :-
    Result is Acc * Number.

fibonacci_ite(N, Result) :-
    (   N =< 1
    ->  Result = N
    ;   N1 is N - 1,
        numlist(1, N1, Steps),
        foldl(fibonacci_step, Steps, (0, 1), (_, Result))
    ).

fibonacci_step(_, (Acc2, Acc1), (Acc1, Result)) :-
    Result is Acc1 + Acc2.

greatest_common_divisor_ite(A, B, Result) :-
    State = gcd(A, B),
    repeat,
    arg(2, State, Y),
    (   Y =:= 0
    ->  arg(1, State, Result),
        !
    ;   arg(1, State, X),
        Next is X mod Y,
        nb_setarg(1, State, Y),
        nb_setarg(2, State, Next),
        fail
    ).

least_common_multiple_ite(A, B, Result) :-
    greatest_common_divisor_ite(A, B, Gcd),
    Result is (A / Gcd) * B.
