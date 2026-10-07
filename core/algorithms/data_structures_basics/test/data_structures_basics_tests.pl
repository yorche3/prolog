:- use_module(library(plunit)).
:- consult('../src/data_structures_basics.pl').

:- begin_tests(data_structures_basics_tests).

:- end_tests(data_structures_basics_tests).

:- initialization(run_tests(data_structures_basics_tests), main).
