:- use_module(library(plunit)).
:- consult('../src/data_structures_basics.pl').

% Casos de prueba de la especificación 06_Data_Structures_Basics.md.
%
% Adaptación: Prolog representa las estructuras mediante términos inmutables;
% cada operación de actualización devuelve el término actualizado. `null`
% representa exclusivamente un enlace ausente y el fallo de un predicado es el
% indicador natural para lecturas o eliminaciones que no pueden completarse.

node_initial_value(10).
node_linked_value(20).
node_absent_next(null).

linked_list_first_tail_value(10).
linked_list_second_tail_value(20).
linked_list_head_value(5).
linked_list_absent_value(99).
linked_list_initial_size(0).
linked_list_populated_size(4).
linked_list_after_delete_size(3).
linked_list_empty_size(0).
linked_list_populated_head(5).
linked_list_after_delete_head(5).
linked_list_after_head_delete_head(20).
linked_list_after_second_delete_head(10).

stack_first_value(10).
stack_second_value(20).
stack_third_value(30).
stack_reused_value(40).
stack_empty_size(0).
stack_populated_size(3).

queue_first_value(10).
queue_second_value(20).
queue_third_value(30).
queue_reused_value(40).
queue_empty_size(0).
queue_populated_size(3).

should_equal(Subject, Description, Actual, Expected) :-
    Actual == Expected,
    Subject = Subject,
    Description = Description.

should_fail(Subject, Description, Goal) :-
    \+ call(Goal),
    Subject = Subject,
    Description = Description.

assert_node_cases(Subject) :-
    node_initial_value(InitialValue),
    node_absent_next(AbsentNext),
    node_init(InitialValue, InitialNode),
    node_get_value(InitialNode, InitialActualValue),
    assertion(should_equal(Subject, initialize_and_observe_value_link,
                           InitialActualValue, InitialValue)),
    node_get_next(InitialNode, InitialActualNext),
    assertion(should_equal(Subject, initialize_and_observe_value_link,
                           InitialActualNext, AbsentNext)),
    node_linked_value(LinkedValue),
    node_init(LinkedValue, LinkedNode),
    node_set_next(InitialNode, LinkedNode, UpdatedNode),
    node_get_next(UpdatedNode, ActualLinkedNode),
    node_get_value(ActualLinkedNode, ActualLinkedValue),
    assertion(should_equal(Subject, initialize_another_node_link_traverse,
                           ActualLinkedValue, LinkedValue)),
    node_get_next(LinkedNode, ActualLinkedNext),
    assertion(should_equal(Subject, initialize_another_node_link_traverse,
                           ActualLinkedNext, AbsentNext)).

assert_linked_list_cases(Subject) :-
    linked_list_init(EmptyList),
    linked_list_initial_size(InitialSize),
    assertion(should_equal(Subject, empty_state, EmptyList, EmptyList)),
    assertion(linked_list_is_empty(EmptyList)),
    linked_list_size(EmptyList, ActualInitialSize),
    assertion(should_equal(Subject, empty_state, ActualInitialSize, InitialSize)),
    assertion(should_fail(Subject, empty_state,
                          linked_list_get_head(EmptyList, _))),
    linked_list_first_tail_value(FirstTailValue),
    linked_list_second_tail_value(SecondTailValue),
    linked_list_head_value(HeadValue),
    linked_list_insert_tail(EmptyList, FirstTailValue, FirstTailList),
    linked_list_insert_tail(FirstTailList, SecondTailValue, SecondTailList),
    linked_list_insert_head(SecondTailList, HeadValue, HeadList),
    linked_list_insert_tail(HeadList, FirstTailValue, PopulatedList),
    linked_list_populated_size(PopulatedSize),
    linked_list_size(PopulatedList, ActualPopulatedSize),
    assertion(should_equal(Subject, insert_at_both_ends,
                           ActualPopulatedSize, PopulatedSize)),
    linked_list_get_head(PopulatedList, ActualPopulatedHead),
    linked_list_populated_head(PopulatedHead),
    assertion(should_equal(Subject, insert_at_both_ends,
                           ActualPopulatedHead, PopulatedHead)),
    linked_list_delete(PopulatedList, FirstTailValue, DeletedList),
    linked_list_after_delete_size(AfterDeleteSize),
    linked_list_size(DeletedList, ActualAfterDeleteSize),
    assertion(should_equal(Subject, delete_first_occurrence,
                           ActualAfterDeleteSize, AfterDeleteSize)),
    linked_list_get_head(DeletedList, ActualAfterDeleteHead),
    linked_list_after_delete_head(AfterDeleteHead),
    assertion(should_equal(Subject, delete_first_occurrence,
                           ActualAfterDeleteHead, AfterDeleteHead)),
    linked_list_absent_value(AbsentValue),
    assertion(should_fail(Subject, absent_value,
                          linked_list_delete(DeletedList, AbsentValue, _))),
    linked_list_size(DeletedList, ActualUnchangedSize),
    assertion(should_equal(Subject, absent_value,
                           ActualUnchangedSize, AfterDeleteSize)),
    linked_list_delete(DeletedList, HeadValue, AfterHeadDeleteList),
    linked_list_get_head(AfterHeadDeleteList, ActualAfterHeadDeleteHead),
    linked_list_after_head_delete_head(AfterHeadDeleteHead),
    assertion(should_equal(Subject, empty_the_list,
                           ActualAfterHeadDeleteHead, AfterHeadDeleteHead)),
    linked_list_delete(AfterHeadDeleteList, SecondTailValue, AfterSecondDeleteList),
    linked_list_get_head(AfterSecondDeleteList, ActualAfterSecondDeleteHead),
    linked_list_after_second_delete_head(AfterSecondDeleteHead),
    assertion(should_equal(Subject, empty_the_list,
                           ActualAfterSecondDeleteHead, AfterSecondDeleteHead)),
    linked_list_delete(AfterSecondDeleteList, FirstTailValue, EmptyAgainList),
    assertion(linked_list_is_empty(EmptyAgainList)),
    linked_list_empty_size(EmptySize),
    linked_list_size(EmptyAgainList, ActualEmptySize),
    assertion(should_equal(Subject, empty_the_list, ActualEmptySize, EmptySize)),
    assertion(should_fail(Subject, empty_the_list,
                          linked_list_get_head(EmptyAgainList, _))).

assert_stack_cases(Subject) :-
    stack_init(EmptyStack),
    stack_empty_size(EmptySize),
    assertion(stack_is_empty(EmptyStack)),
    stack_size(EmptyStack, ActualEmptySize),
    assertion(should_equal(Subject, empty_state_and_failed_removal,
                           ActualEmptySize, EmptySize)),
    assertion(should_fail(Subject, empty_state_and_failed_removal,
                          stack_peek(EmptyStack, _))),
    assertion(should_fail(Subject, empty_state_and_failed_removal,
                          stack_pop(EmptyStack, _, _))),
    stack_first_value(FirstValue),
    stack_second_value(SecondValue),
    stack_third_value(ThirdValue),
    stack_push(EmptyStack, FirstValue, FirstStack),
    stack_push(FirstStack, SecondValue, SecondStack),
    stack_push(SecondStack, ThirdValue, PopulatedStack),
    stack_peek(PopulatedStack, ActualPeekedValue),
    assertion(should_equal(Subject, lifo_and_non_mutating_peek,
                           ActualPeekedValue, ThirdValue)),
    stack_populated_size(PopulatedSize),
    stack_size(PopulatedStack, ActualPopulatedSize),
    assertion(should_equal(Subject, lifo_and_non_mutating_peek,
                           ActualPopulatedSize, PopulatedSize)),
    stack_pop(PopulatedStack, FirstPoppedValue, AfterFirstPopStack),
    assertion(should_equal(Subject, removal_and_reuse,
                           FirstPoppedValue, ThirdValue)),
    stack_reused_value(ReusedValue),
    stack_push(AfterFirstPopStack, ReusedValue, ReusedStack),
    stack_pop(ReusedStack, SecondPoppedValue, AfterSecondPopStack),
    assertion(should_equal(Subject, removal_and_reuse,
                           SecondPoppedValue, ReusedValue)),
    stack_pop(AfterSecondPopStack, ThirdPoppedValue, AfterThirdPopStack),
    assertion(should_equal(Subject, removal_and_reuse,
                           ThirdPoppedValue, SecondValue)),
    stack_pop(AfterThirdPopStack, FourthPoppedValue, EmptyAgainStack),
    assertion(should_equal(Subject, removal_and_reuse,
                           FourthPoppedValue, FirstValue)),
    assertion(stack_is_empty(EmptyAgainStack)),
    stack_size(EmptyAgainStack, ActualFinalSize),
    assertion(should_equal(Subject, removal_and_reuse,
                           ActualFinalSize, EmptySize)),
    assertion(should_fail(Subject, empty_after_removal,
                          stack_pop(EmptyAgainStack, _, _))),
    assertion(stack_is_empty(EmptyAgainStack)).

assert_queue_cases(Subject) :-
    queue_init(EmptyQueue),
    queue_empty_size(EmptySize),
    assertion(queue_is_empty(EmptyQueue)),
    queue_size(EmptyQueue, ActualEmptySize),
    assertion(should_equal(Subject, empty_state_and_failed_removal,
                           ActualEmptySize, EmptySize)),
    assertion(should_fail(Subject, empty_state_and_failed_removal,
                          queue_peek(EmptyQueue, _))),
    assertion(should_fail(Subject, empty_state_and_failed_removal,
                          queue_dequeue(EmptyQueue, _, _))),
    queue_first_value(FirstValue),
    queue_second_value(SecondValue),
    queue_third_value(ThirdValue),
    queue_enqueue(EmptyQueue, FirstValue, FirstQueue),
    queue_enqueue(FirstQueue, SecondValue, SecondQueue),
    queue_enqueue(SecondQueue, ThirdValue, PopulatedQueue),
    queue_peek(PopulatedQueue, ActualPeekedValue),
    assertion(should_equal(Subject, fifo_and_non_mutating_peek,
                           ActualPeekedValue, FirstValue)),
    queue_populated_size(PopulatedSize),
    queue_size(PopulatedQueue, ActualPopulatedSize),
    assertion(should_equal(Subject, fifo_and_non_mutating_peek,
                           ActualPopulatedSize, PopulatedSize)),
    queue_dequeue(PopulatedQueue, FirstDequeuedValue, AfterFirstDequeueQueue),
    assertion(should_equal(Subject, removal_and_reuse,
                           FirstDequeuedValue, FirstValue)),
    queue_reused_value(ReusedValue),
    queue_enqueue(AfterFirstDequeueQueue, ReusedValue, ReusedQueue),
    queue_dequeue(ReusedQueue, SecondDequeuedValue, AfterSecondDequeueQueue),
    assertion(should_equal(Subject, removal_and_reuse,
                           SecondDequeuedValue, SecondValue)),
    queue_dequeue(AfterSecondDequeueQueue, ThirdDequeuedValue, AfterThirdDequeueQueue),
    assertion(should_equal(Subject, removal_and_reuse,
                           ThirdDequeuedValue, ThirdValue)),
    queue_dequeue(AfterThirdDequeueQueue, FourthDequeuedValue, EmptyAgainQueue),
    assertion(should_equal(Subject, removal_and_reuse,
                           FourthDequeuedValue, ReusedValue)),
    assertion(queue_is_empty(EmptyAgainQueue)),
    queue_size(EmptyAgainQueue, ActualFinalSize),
    assertion(should_equal(Subject, removal_and_reuse,
                           ActualFinalSize, EmptySize)),
    assertion(should_fail(Subject, empty_after_removal,
                          queue_dequeue(EmptyAgainQueue, _, _))),
    assertion(queue_is_empty(EmptyAgainQueue)).

:- begin_tests(data_structures_basics_tests).

test(node_init) :-
    assert_node_cases(node_init).

test(node_get_value) :-
    assert_node_cases(node_get_value).

test(node_get_next) :-
    assert_node_cases(node_get_next).

test(node_set_next) :-
    assert_node_cases(node_set_next).

test(linked_list_init) :-
    assert_linked_list_cases(linked_list_init).

test(linked_list_get_head) :-
    assert_linked_list_cases(linked_list_get_head).

test(linked_list_insert_head) :-
    assert_linked_list_cases(linked_list_insert_head).

test(linked_list_insert_tail) :-
    assert_linked_list_cases(linked_list_insert_tail).

test(linked_list_delete) :-
    assert_linked_list_cases(linked_list_delete).

test(linked_list_is_empty) :-
    assert_linked_list_cases(linked_list_is_empty).

test(linked_list_size) :-
    assert_linked_list_cases(linked_list_size).

test(stack_init) :-
    assert_stack_cases(stack_init).

test(stack_push) :-
    assert_stack_cases(stack_push).

test(stack_pop) :-
    assert_stack_cases(stack_pop).

test(stack_peek) :-
    assert_stack_cases(stack_peek).

test(stack_is_empty) :-
    assert_stack_cases(stack_is_empty).

test(stack_size) :-
    assert_stack_cases(stack_size).

test(queue_init) :-
    assert_queue_cases(queue_init).

test(queue_enqueue) :-
    assert_queue_cases(queue_enqueue).

test(queue_dequeue) :-
    assert_queue_cases(queue_dequeue).

test(queue_peek) :-
    assert_queue_cases(queue_peek).

test(queue_is_empty) :-
    assert_queue_cases(queue_is_empty).

test(queue_size) :-
    assert_queue_cases(queue_size).

:- end_tests(data_structures_basics_tests).

:- initialization(run_tests(data_structures_basics_tests), main).
