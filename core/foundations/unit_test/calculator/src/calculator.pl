addition(A, B, Result) :- Result is A + B.

subtraction(A, B, Result) :- Result is A - B.

multiplication(A, B, Result) :-
    multiplication_loop(B, 0, A, Result).

multiplication_loop(N, Acc, A, Result) :-
    (   N =< 0
    ->  Result = Acc
    ;   N1 is N - 1,
        addition(Acc, A, Acc1),
        multiplication_loop(N1, Acc1, A, Result)
    ).

division(A, B, Quotient) :-
    division_loop(A, B, 0, Quotient).

division_loop(A, B, Acc, Quotient) :-
    (   A < B
    ->  Quotient = Acc
    ;   subtraction(A, B, A1),
        addition(Acc, 1, Acc1),
        division_loop(A1, B, Acc1, Quotient)
    ).

modulus(A, B, Result) :-
    division(A, B, Q),
    multiplication(Q, B, P),
    subtraction(A, P, Result).
