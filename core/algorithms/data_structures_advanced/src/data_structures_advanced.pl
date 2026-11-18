:- module(data_structures_advanced, [
    tree_node_init/2,
    tree_node_get_value/2,
    tree_node_get_left/2,
    tree_node_get_right/2,
    tree_node_set_left/3,
    tree_node_set_right/3,
    binary_tree_init/1,
    binary_tree_insert/3,
    binary_tree_contains/2,
    binary_tree_is_empty/1,
    binary_tree_size/2,
    graph_init/1,
    graph_add_vertex/3,
    graph_add_edge/4,
    graph_has_edge/3,
    graph_get_neighbors/3,
    graph_is_empty/1,
    graph_vertex_count/2,
    graph_edge_count/2
]).

% Términos del dominio: tree_node(Value, Left, Right),
% binary_tree(Root, Count), graph_node(Label, Neighbors, NextVertex),
% graph(Vertices, VertexCount, EdgeCount). Los enlaces ausentes son null.
% Indicadores: el fallo de contains, has_edge y get_neighbors es el fallo del
% predicado; las actualizaciones devuelven el término nuevo en el último
% argumento y dejan intacto el de entrada.

% tree_node_init(+Value, -Node)
tree_node_init(Value, tree_node(Value, null, null)).

% tree_node_get_value(+Node, -Value)
tree_node_get_value(tree_node(Value, _, _), Value).

% tree_node_get_left(+Node, -Left)
tree_node_get_left(tree_node(_, Left, _), Left).

% tree_node_get_right(+Node, -Right)
tree_node_get_right(tree_node(_, _, Right), Right).

% tree_node_set_left(+Node, +Left, -UpdatedNode)
tree_node_set_left(tree_node(Value, _, Right), Left,
                   tree_node(Value, Left, Right)).

% tree_node_set_right(+Node, +Right, -UpdatedNode)
tree_node_set_right(tree_node(Value, Left, _), Right,
                    tree_node(Value, Left, Right)).

% binary_tree_init(-Tree)
binary_tree_init(binary_tree(null, 0)).

% binary_tree_insert(+Tree, +Value, -UpdatedTree)
binary_tree_insert(binary_tree(Root, Count), Value,
                   binary_tree(NewRoot, NewCount)) :-
    tree_insert(Root, Value, NewRoot, Result),
    (Result == inserted -> NewCount is Count + 1 ; NewCount is Count).

tree_insert(null, Value, tree_node(Value, null, null), inserted).
tree_insert(tree_node(NodeValue, Left, Right), Value,
            tree_node(NodeValue, NewLeft, Right), Result) :-
    Value < NodeValue,
    tree_insert(Left, Value, NewLeft, Result).
tree_insert(tree_node(NodeValue, Left, Right), Value,
            tree_node(NodeValue, Left, NewRight), Result) :-
    Value > NodeValue,
    tree_insert(Right, Value, NewRight, Result).
tree_insert(Node, Value, Node, present) :-
    Node = tree_node(NodeValue, _, _),
    Value =:= NodeValue.

% binary_tree_contains(+Tree, +Value)
binary_tree_contains(binary_tree(Root, _), Value) :-
    tree_contains(Root, Value).

tree_contains(tree_node(NodeValue, _, _), Value) :-
    Value =:= NodeValue.
tree_contains(tree_node(NodeValue, Left, _), Value) :-
    Value < NodeValue,
    tree_contains(Left, Value).
tree_contains(tree_node(NodeValue, _, Right), Value) :-
    Value > NodeValue,
    tree_contains(Right, Value).

% binary_tree_is_empty(+Tree)
binary_tree_is_empty(binary_tree(null, 0)).

% binary_tree_size(+Tree, -Count)
binary_tree_size(binary_tree(_, Count), Count).

% graph_node_init(+Label, +NextVertex, -Node)
graph_node_init(Label, NextVertex, graph_node(Label, [], NextVertex)).

% graph_init(-Graph)
graph_init(graph(null, 0, 0)).

% graph_add_vertex(+Graph, +Label, -UpdatedGraph)
graph_add_vertex(graph(Vs, VC, EC), Label, Result) :-
    (   find_vertex(Vs, Label, _)
    ->  Result = graph(Vs, VC, EC)
    ;   NewVC is VC + 1,
        graph_node_init(Label, Vs, NewVertex),
        Result = graph(NewVertex, NewVC, EC)
    ).

find_vertex(graph_node(Label, Neighbors, Next), Label,
            graph_node(Label, Neighbors, Next)).
find_vertex(graph_node(NodeLabel, _, Next), Label, Node) :-
    NodeLabel =\= Label,
    find_vertex(Next, Label, Node).

% graph_add_edge(+Graph, +From, +To, -UpdatedGraph)
graph_add_edge(graph(Vs, VC, EC), From, To, Result) :-
    find_vertex(Vs, From, _),
    find_vertex(Vs, To, _),
    (   neighbor_exists(Vs, From, To)
    ->  Result = graph(Vs, VC, EC)
    ;   insert_neighbor(Vs, From, To, NewVs),
        NewEC is EC + 1,
        Result = graph(NewVs, VC, NewEC)
    ).

neighbor_exists(graph_node(From, Neighbors, _), From, To) :-
    member(To, Neighbors).
neighbor_exists(graph_node(Label, _, Next), From, To) :-
    Label =\= From,
    neighbor_exists(Next, From, To).

insert_neighbor(graph_node(From, Neighbors, Next), From, To,
                graph_node(From, NewNeighbors, Next)) :-
    insert_sorted(To, Neighbors, NewNeighbors).
insert_neighbor(graph_node(Label, Neighbors, Next), From, To,
                graph_node(Label, Neighbors, NewNext)) :-
    Label =\= From,
    insert_neighbor(Next, From, To, NewNext).

insert_sorted(Value, [], [Value]).
insert_sorted(Value, [Head|Tail], [Value, Head|Tail]) :-
    Value < Head.
insert_sorted(Value, [Head|Tail], [Head|NewTail]) :-
    Value > Head,
    insert_sorted(Value, Tail, NewTail).
insert_sorted(Value, [Head|Tail], [Head|Tail]) :-
    Value =:= Head.

% graph_has_edge(+Graph, +From, +To)
graph_has_edge(graph(Vs, _, _), From, To) :-
    find_vertex(Vs, From, graph_node(_, Neighbors, _)),
    member(To, Neighbors).

% graph_get_neighbors(+Graph, +Label, -Neighbors)
graph_get_neighbors(graph(Vs, _, _), Label, Neighbors) :-
    find_vertex(Vs, Label, graph_node(_, Neighbors, _)).

% graph_is_empty(+Graph)
graph_is_empty(graph(null, 0, 0)).

% graph_vertex_count(+Graph, -Count)
graph_vertex_count(graph(_, Count, _), Count).

% graph_edge_count(+Graph, -Count)
graph_edge_count(graph(_, _, Count), Count).
