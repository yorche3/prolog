:- use_module(library(plunit)).
:- consult('../src/data_structures_advanced.pl').

% Casos de prueba de la especificación 07_Data_Structures_Advanced.md:
% 6 de TreeNode, 7 de BinaryTree y 10 de Graph (un test por fila).
%
% Adaptación: Prolog usa términos inmutables; cada actualización devuelve el
% término nuevo en el último argumento. `null` representa exclusivamente un
% enlace ausente; el fallo del predicado es el indicador de fallo de
% contains/has_edge/get_neighbors. Los casos se observan solo con el contrato.

node_value(10).
node_left_value(20).
node_right_value(30).
node_absent(null).

tree_root(50).
tree_lower(30).
tree_higher(70).
tree_lower_left(20).
tree_lower_right(40).
tree_missing(99).

graph_label_a(10).
graph_label_b(30).
graph_label_c(50).
graph_label_d(70).
graph_missing(99).
graph_other_missing(98).

% Si el objetivo no se cumple, el mensaje dice qué caso y qué se esperaba.
should_hold(Case, Expectation, Goal) :-
    (   call(Goal)
    ->  true
    ;   format(user_error, "~w should ~w~n", [Case, Expectation]),
        fail
    ).

should_fail(Case, Expectation, Goal) :-
    (   call(Goal)
    ->  format(user_error, "~w should ~w~n", [Case, Expectation]),
        fail
    ;   true
    ).

should_equal(Case, Expectation, Goal, Expected) :-
    (   call(Goal, Actual), Actual == Expected
    ->  true
    ;   format(user_error, "~w should ~w (expected ~q)~n",
               [Case, Expectation, Expected]),
        fail
    ).

% ---------- TreeNode ----------

parent_with_children(Case, Left, Right, Linked) :-
    node_value(PV), node_left_value(LV), node_right_value(RV),
    should_hold(Case, link_parent_and_children,
                ( tree_node_init(PV, Parent),
                  tree_node_init(LV, Left),
                  tree_node_init(RV, Right),
                  tree_node_set_left(Parent, Left, WithLeft),
                  tree_node_set_right(WithLeft, Right, Linked) )).

% ---------- BinaryTree ----------

insert_all(_, Tree, [], Tree).
insert_all(Case, Tree, [V|Vs], Final) :-
    should_hold(Case, insert_succeeds(V), binary_tree_insert(Tree, V, Next)),
    insert_all(Case, Next, Vs, Final).

contains_all(_, _, []).
contains_all(Case, Tree, [V|Vs]) :-
    should_hold(Case, contain(V), binary_tree_contains(Tree, V)),
    contains_all(Case, Tree, Vs).

tree_size_is(Case, Tree, Expected) :-
    should_equal(Case, have_expected_size, binary_tree_size(Tree), Expected).

% ---------- Graph ----------

add_vertices(_, G, [], G).
add_vertices(Case, G, [L|Ls], Final) :-
    should_hold(Case, add_vertex_succeeds(L), graph_add_vertex(G, L, Next)),
    add_vertices(Case, Next, Ls, Final).

add_edges(_, G, [], G).
add_edges(Case, G, [F-T|Es], Final) :-
    should_hold(Case, add_edge_succeeds(F, T), graph_add_edge(G, F, T, Next)),
    add_edges(Case, Next, Es, Final).

graph_counts(Case, G, VertexCount, EdgeCount) :-
    should_equal(Case, have_expected_vertex_count,
                 graph_vertex_count(G), VertexCount),
    should_equal(Case, have_expected_edge_count,
                 graph_edge_count(G), EdgeCount).

neighbors_are(Case, G, Label, Expected) :-
    should_equal(Case, have_expected_neighbors(Label),
                 graph_get_neighbors(G, Label), Expected).

graph_with_vertices(Case, Labels, G) :-
    should_hold(Case, initialise, graph_init(Empty)),
    add_vertices(Case, Empty, Labels, G).

:- begin_tests(data_structures_advanced_tests).

% ----- TreeNode -----

test(tree_node_create) :-
    node_value(V),
    should_hold(tree_node_create, initialise, tree_node_init(V, Node)),
    should_equal(tree_node_create, return_the_value,
                 tree_node_get_value(Node), V).

test(tree_node_absent_initial_links) :-
    Case = tree_node_absent_initial_links,
    node_value(V), node_absent(Absent),
    should_hold(Case, initialise, tree_node_init(V, Node)),
    should_equal(Case, have_absent_left, tree_node_get_left(Node), Absent),
    should_equal(Case, have_absent_right, tree_node_get_right(Node), Absent).

test(tree_node_link_two_children) :-
    Case = tree_node_link_two_children,
    parent_with_children(Case, _, _, Linked),
    node_left_value(LV), node_right_value(RV),
    should_hold(Case, expose_left, tree_node_get_left(Linked, L)),
    should_hold(Case, expose_right, tree_node_get_right(Linked, R)),
    should_equal(Case, lead_left_to_value, tree_node_get_value(L), LV),
    should_equal(Case, lead_right_to_value, tree_node_get_value(R), RV).

test(tree_node_traverse_each_link) :-
    Case = tree_node_traverse_each_link,
    parent_with_children(Case, _, _, Linked),
    node_left_value(LV), node_right_value(RV), node_absent(Absent),
    should_hold(Case, expose_left, tree_node_get_left(Linked, L)),
    should_hold(Case, expose_right, tree_node_get_right(Linked, R)),
    should_equal(Case, reach_left_value, tree_node_get_value(L), LV),
    should_equal(Case, reach_right_value, tree_node_get_value(R), RV),
    should_equal(Case, have_absent_left_child_left,
                 tree_node_get_left(L), Absent),
    should_equal(Case, have_absent_left_child_right,
                 tree_node_get_right(L), Absent),
    should_equal(Case, have_absent_right_child_left,
                 tree_node_get_left(R), Absent),
    should_equal(Case, have_absent_right_child_right,
                 tree_node_get_right(R), Absent).

test(tree_node_unlink_children) :-
    Case = tree_node_unlink_children,
    parent_with_children(Case, _, Right, Linked),
    node_value(PV), node_right_value(RV), node_absent(Absent),
    should_hold(Case, clear_left, tree_node_set_left(Linked, Absent, NoLeft)),
    should_equal(Case, keep_value_after_clearing_left,
                 tree_node_get_value(NoLeft), PV),
    should_equal(Case, have_absent_left_after_clearing_left,
                 tree_node_get_left(NoLeft), Absent),
    should_equal(Case, keep_right_child_after_clearing_left,
                 tree_node_get_right(NoLeft), Right),
    should_equal(Case, keep_right_child_value,
                 tree_node_get_value(Right), RV),
    should_hold(Case, clear_right,
                tree_node_set_right(NoLeft, Absent, NoChildren)),
    should_equal(Case, have_absent_left_after_clearing_right,
                 tree_node_get_left(NoChildren), Absent),
    should_equal(Case, have_absent_right_after_clearing_right,
                 tree_node_get_right(NoChildren), Absent),
    should_equal(Case, keep_value_after_clearing_right,
                 tree_node_get_value(NoChildren), PV).

test(tree_node_immutable_adaptation) :-
    Case = tree_node_immutable_adaptation,
    node_value(PV), node_left_value(LV), node_absent(Absent),
    should_hold(Case, initialise_parent, tree_node_init(PV, Original)),
    should_hold(Case, initialise_child, tree_node_init(LV, Child)),
    should_hold(Case, return_a_new_node,
                tree_node_set_left(Original, Child, Updated)),
    should_equal(Case, link_child_in_new_node,
                 tree_node_get_left(Updated), Child),
    should_equal(Case, leave_original_left_unchanged,
                 tree_node_get_left(Original), Absent),
    should_equal(Case, leave_original_value_unchanged,
                 tree_node_get_value(Original), PV).

% ----- BinaryTree -----

test(binary_tree_create_empty) :-
    Case = binary_tree_create_empty,
    tree_root(Root),
    should_hold(Case, initialise, binary_tree_init(Tree)),
    should_hold(Case, be_empty, binary_tree_is_empty(Tree)),
    tree_size_is(Case, Tree, 0),
    should_fail(Case, not_contain_root, binary_tree_contains(Tree, Root)).

test(binary_tree_insert_root) :-
    Case = binary_tree_insert_root,
    tree_root(Root),
    should_hold(Case, initialise, binary_tree_init(Empty)),
    insert_all(Case, Empty, [Root], Tree),
    tree_size_is(Case, Tree, 1),
    should_fail(Case, not_be_empty, binary_tree_is_empty(Tree)),
    contains_all(Case, Tree, [Root]).

test(binary_tree_insert_lower_and_higher) :-
    Case = binary_tree_insert_lower_and_higher,
    tree_root(R), tree_lower(L), tree_higher(H),
    should_hold(Case, initialise, binary_tree_init(Empty)),
    insert_all(Case, Empty, [R, L, H], Tree),
    tree_size_is(Case, Tree, 3),
    contains_all(Case, Tree, [R, L, H]).

test(binary_tree_multilevel_branches) :-
    Case = binary_tree_multilevel_branches,
    tree_root(R), tree_lower(L), tree_higher(H),
    tree_lower_left(LL), tree_lower_right(LR),
    should_hold(Case, initialise, binary_tree_init(Empty)),
    insert_all(Case, Empty, [R, L, H, LL, LR], Tree),
    contains_all(Case, Tree, [R, L, H, LL, LR]),
    tree_size_is(Case, Tree, 5).

test(binary_tree_missing_value_in_nonempty_tree) :-
    Case = binary_tree_missing_value_in_nonempty_tree,
    tree_root(Root), tree_missing(Missing),
    should_hold(Case, initialise, binary_tree_init(Empty)),
    insert_all(Case, Empty, [Root], Tree),
    should_fail(Case, not_contain_missing,
                binary_tree_contains(Tree, Missing)),
    tree_size_is(Case, Tree, 1),
    contains_all(Case, Tree, [Root]).

test(binary_tree_idempotent_duplicate) :-
    Case = binary_tree_idempotent_duplicate,
    tree_root(R), tree_lower(L), tree_higher(H),
    should_hold(Case, initialise, binary_tree_init(Empty)),
    insert_all(Case, Empty, [R, L, H, L], Tree),
    tree_size_is(Case, Tree, 3),
    contains_all(Case, Tree, [R, L, H]).

test(binary_tree_ordered_insertions) :-
    Case = binary_tree_ordered_insertions,
    tree_lower_left(A), tree_lower(B), tree_lower_right(C),
    tree_root(D), tree_higher(E), tree_missing(Missing),
    should_hold(Case, initialise, binary_tree_init(Empty)),
    insert_all(Case, Empty, [A, B, C, D, E], Tree),
    tree_size_is(Case, Tree, 5),
    contains_all(Case, Tree, [A, B, C, D, E]),
    should_fail(Case, not_contain_missing,
                binary_tree_contains(Tree, Missing)).

% ----- Graph -----

test(graph_create_empty) :-
    Case = graph_create_empty,
    graph_label_a(A), graph_label_b(B),
    should_hold(Case, initialise, graph_init(G)),
    should_hold(Case, be_empty, graph_is_empty(G)),
    graph_counts(Case, G, 0, 0),
    should_fail(Case, have_no_edge, graph_has_edge(G, A, B)),
    should_fail(Case, fail_for_neighbors, graph_get_neighbors(G, A, _)).

test(graph_isolated_vertex) :-
    Case = graph_isolated_vertex,
    graph_label_a(A),
    graph_with_vertices(Case, [A], G),
    should_fail(Case, not_be_empty, graph_is_empty(G)),
    graph_counts(Case, G, 1, 0),
    neighbors_are(Case, G, A, []).

test(graph_nonconsecutive_labels_and_directed_edge) :-
    Case = graph_nonconsecutive_labels_and_directed_edge,
    graph_label_a(A), graph_label_d(D),
    graph_with_vertices(Case, [A, D], G0),
    add_edges(Case, G0, [A-D], G),
    should_hold(Case, have_forward_edge, graph_has_edge(G, A, D)),
    should_fail(Case, not_have_reverse_edge, graph_has_edge(G, D, A)),
    graph_counts(Case, G, 2, 1).

test(graph_duplicate_vertex_preserves_adjacency) :-
    Case = graph_duplicate_vertex_preserves_adjacency,
    graph_label_a(A), graph_label_b(B),
    graph_with_vertices(Case, [A, B], G0),
    add_edges(Case, G0, [A-B], G1),
    add_vertices(Case, G1, [A], G),
    graph_counts(Case, G, 2, 1),
    neighbors_are(Case, G, A, [B]).

test(graph_duplicate_edge) :-
    Case = graph_duplicate_edge,
    graph_label_a(A), graph_label_b(B),
    graph_with_vertices(Case, [A, B], G0),
    add_edges(Case, G0, [A-B, A-B], G),
    graph_counts(Case, G, 2, 1),
    neighbors_are(Case, G, A, [B]).

test(graph_missing_endpoint_without_mutation) :-
    Case = graph_missing_endpoint_without_mutation,
    graph_label_a(A), graph_label_b(B),
    graph_missing(M), graph_other_missing(O),
    graph_with_vertices(Case, [A, B], G0),
    add_edges(Case, G0, [A-B], G),
    should_fail(Case, reject_edge_to_missing, graph_add_edge(G, A, M, _)),
    should_fail(Case, reject_edge_from_missing, graph_add_edge(G, M, A, _)),
    should_fail(Case, reject_edge_between_missing, graph_add_edge(G, O, M, _)),
    should_fail(Case, reject_missing_self_loop, graph_add_edge(G, M, M, _)),
    graph_counts(Case, G, 2, 1),
    neighbors_are(Case, G, A, [B]),
    neighbors_are(Case, G, B, []),
    should_fail(Case, not_have_edge_to_missing, graph_has_edge(G, A, M)),
    should_fail(Case, not_have_edge_from_missing, graph_has_edge(G, M, A)),
    should_fail(Case, not_have_edge_between_missing, graph_has_edge(G, O, M)),
    should_fail(Case, not_have_missing_self_loop, graph_has_edge(G, M, M)),
    should_fail(Case, fail_for_neighbors_of_other_missing,
                graph_get_neighbors(G, O, _)),
    should_fail(Case, fail_for_neighbors_of_missing,
                graph_get_neighbors(G, M, _)).

test(graph_sorted_neighbours_and_counts) :-
    Case = graph_sorted_neighbours_and_counts,
    graph_label_a(A), graph_label_b(B), graph_label_c(C), graph_label_d(D),
    graph_with_vertices(Case, [A, B, C, D], G0),
    add_edges(Case, G0, [A-D, A-B, A-C, B-C], G),
    neighbors_are(Case, G, A, [B, C, D]),
    neighbors_are(Case, G, B, [C]),
    neighbors_are(Case, G, C, []),
    neighbors_are(Case, G, D, []),
    graph_counts(Case, G, 4, 4).

test(graph_missing_edge_query) :-
    Case = graph_missing_edge_query,
    graph_label_a(A), graph_label_b(B),
    graph_with_vertices(Case, [A, B], G),
    should_fail(Case, have_no_edge, graph_has_edge(G, A, B)),
    graph_counts(Case, G, 2, 0),
    should_fail(Case, not_be_empty, graph_is_empty(G)).

test(graph_neighbours_of_missing_vertex) :-
    Case = graph_neighbours_of_missing_vertex,
    graph_label_a(A), graph_missing(M),
    graph_with_vertices(Case, [A], G),
    should_fail(Case, fail_for_missing_vertex, graph_get_neighbors(G, M, _)),
    neighbors_are(Case, G, A, []),
    graph_counts(Case, G, 1, 0).

test(graph_self_loop_and_duplicate) :-
    Case = graph_self_loop_and_duplicate,
    graph_label_a(A),
    graph_with_vertices(Case, [A], G0),
    add_edges(Case, G0, [A-A, A-A], G),
    should_hold(Case, have_loop, graph_has_edge(G, A, A)),
    neighbors_are(Case, G, A, [A]),
    graph_counts(Case, G, 1, 1).

:- end_tests(data_structures_advanced_tests).

:- initialization(run_tests(data_structures_advanced_tests), main).
