:- use_module(library(plunit)).
:- consult('../src/data_structures_advanced.pl').

:- begin_tests(data_structures_advanced_tests).

:- end_tests(data_structures_advanced_tests).

:- initialization(run_tests(data_structures_advanced_tests), main).
