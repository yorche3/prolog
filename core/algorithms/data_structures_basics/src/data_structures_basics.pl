% DataStructuresBasics — estructuras de datos básicas sobre Node.
%
% Especificación: 06_Data_Structures_Basics
%
% Contrato Prolog:
%   node(Value, Next)
%   linked_list(Head, Tail, Count)
%   stack(Top, Count)
%   queue(Front, Rear, Count)
%
% Prolog no declara tipos separados: los cuatro funtores anteriores son los
% términos de dominio.
%
% Adaptaciones:
%   - Los términos de Prolog son inmutables, así que cada operación que
%     mutaría la estructura recibe el término y devuelve el actualizado en su
%     último argumento (`-UpdatedNode`, `-UpdatedList`, `-UpdatedStack`,
%     `-UpdatedQueue`); no hay actualización en el sitio y `node_set_next/3`
%     reconstruye el nodo.
%   - `null` es la única representación de ausencia y solo aparece como enlace
%     de un `Node` (`node(Value, null)`): el nodo sin enlace y la lista, pila o
%     cola vacías. Ninguna otra operación usa `null`.
%   - El indicador de fallo de las lecturas que pueden fallar es que el
%     predicado **falle**, que es el indicador natural del lenguaje: no se
%     inventan indicadores numéricos como `-1`.
%   - Los valores de prueba son enteros positivos.
%   - Los identificadores van en inglés y los comentarios en español.
%
% Los helpers internos de cadena se prefijan con `dsb_` para evitar colisiones
% con otros módulos consultados en `user`, y usan if-then-else para que la
% recursión sea determinista (sin choicepoints que plunit reporte).
%
% Node:
%   node_init(+Value, -Node)
%   node_get_value(+Node, -Value)
%   node_get_next(+Node, -Next)
%   node_set_next(+Node, +Next, -UpdatedNode)
node_init(Value, node(Value, null)).

node_get_value(node(Value, _), Value).

node_get_next(node(_, Next), Next).

node_set_next(node(Value, _), Next, node(Value, Next)).

% ---------------------------------------------------------------------------
% Helpers internos (prefijados `dsb_`)
% ---------------------------------------------------------------------------

% Añade NewNode al final de la cadena reconstruyendo el camino: los términos
% son inmutables, así que cada nivel devuelve su copia con el enlace nuevo.
dsb_append_node(null, NewNode, NewNode).
dsb_append_node(node(Value, Next), NewNode, node(Value, NewNext)) :-
    dsb_append_node(Next, NewNode, NewNext).

% Última celda de una cadena.
dsb_find_tail(Node, Tail) :-
    node_get_next(Node, Next),
    ( Next = null -> Tail = Node ; dsb_find_tail(Next, Tail) ).

% Elimina la primera aparición de Value: falla si no está. El tercer argumento
% es la cadena resultante (la original menos esa celda).
dsb_remove_first(null, _, _) :-
    fail.
dsb_remove_first(node(Value, Next), Value, Next) :- !.
dsb_remove_first(node(Value, Next), Target, node(Value, NewNext)) :-
    dsb_remove_first(Next, Target, NewNext).

% LinkedList:
%   linked_list_init(-List)
%   linked_list_get_head(+List, -Value)
%   linked_list_insert_head(+List, +Value, -UpdatedList)
%   linked_list_insert_tail(+List, +Value, -UpdatedList)
%   linked_list_delete(+List, +Value, -UpdatedList)
%   linked_list_is_empty(+List)
%   linked_list_size(+List, -Count)
linked_list_init(List) :-
    List = linked_list(null, null, 0).

linked_list_get_head(linked_list(Head, _, _), Value) :-
    ( Head = null -> fail ; node_get_value(Head, Value) ).

% Inserta al principio: el nodo nuevo enlaza con la cabeza anterior; si la
% lista estaba vacía, la cola pasa a ser el nodo nuevo. O(1).
linked_list_insert_head(List, Value, UpdatedList) :-
    List = linked_list(Head, Tail, Count),
    node_init(Value, NewNode),
    node_set_next(NewNode, Head, NewHead),
    ( Tail = null -> NewTail = NewHead ; NewTail = Tail ),
    NewCount is Count + 1,
    UpdatedList = linked_list(NewHead, NewTail, NewCount).

% Inserta al final: la celda de cola no se puede enlazar en el sitio (los
% términos son inmutables), así que se reconstruye el camino hasta ella. O(n).
linked_list_insert_tail(List, Value, UpdatedList) :-
    List = linked_list(Head, _, Count),
    node_init(Value, NewNode),
    dsb_append_node(Head, NewNode, NewHead),
    NewCount is Count + 1,
    UpdatedList = linked_list(NewHead, NewNode, NewCount).

% Elimina la primera aparición: falla si el valor no está (el indicador
% natural del lenguaje). Tras eliminar, la cola se recalcula con la última
% celda de la cadena resultante. O(n).
linked_list_delete(List, Value, UpdatedList) :-
    List = linked_list(Head, _, Count),
    dsb_remove_first(Head, Value, NewHead),
    ( NewHead = null -> NewTail = null ; dsb_find_tail(NewHead, NewTail) ),
    NewCount is Count - 1,
    UpdatedList = linked_list(NewHead, NewTail, NewCount).

linked_list_is_empty(linked_list(_, _, Count)) :-
    Count =:= 0.

linked_list_size(linked_list(_, _, Count), Count).

% Stack:
%   stack_init(-Stack)
%   stack_push(+Stack, +Value, -UpdatedStack)
%   stack_pop(+Stack, -Value, -UpdatedStack)
%   stack_peek(+Stack, -Value)
%   stack_is_empty(+Stack)
%   stack_size(+Stack, -Count)
stack_init(Stack) :-
    Stack = stack(null, 0).

stack_push(stack(Head, Count), Value, stack(NewHead, NewCount)) :-
    node_init(Value, NewNode),
    (   Head = null
    ->  NewHead = NewNode
    ;   node_set_next(NewNode, Head, NewHead)
    ),
    NewCount is Count + 1.

stack_pop(stack(Head, Count), Value, stack(NewHead, NewCount)) :-
    ( Head = null -> fail ; node_get_value(Head, Value), node_get_next(Head, NewHead), NewCount is Count - 1 ).

stack_peek(stack(Head, _), Value) :-
    ( Head = null -> fail ; node_get_value(Head, Value) ).

stack_is_empty(stack(_, Count)) :-
    Count =:= 0.

stack_size(stack(_, Count), Count).

% Queue:
%   queue_init(-Queue)
%   queue_enqueue(+Queue, +Value, -UpdatedQueue)
%   queue_dequeue(+Queue, -Value, -UpdatedQueue)
%   queue_peek(+Queue, -Value)
%   queue_is_empty(+Queue)
%   queue_size(+Queue, -Count)
queue_init(Queue) :-
    Queue = queue(null, null, 0).

queue_enqueue(queue(Head, Tail, Count), Value, queue(NewHead, NewTail, NewCount)) :-
    node_init(Value, NewNode),
    (   Tail = null
    ->  NewHead = NewNode
    ;   dsb_append_node(Head, NewNode, NewHead)
    ),
    NewTail = NewNode,
    NewCount is Count + 1.

queue_dequeue(queue(Head, Tail, Count), Value, queue(NewHead, NewTail, NewCount)) :-
    ( Head = null -> fail ; node_get_value(Head, Value), node_get_next(Head, NewHead), ( NewHead = null -> NewTail = null ; NewTail = Tail ), NewCount is Count - 1 ).

queue_peek(queue(Head, _, _), Value) :-
    ( Head = null -> fail ; node_get_value(Head, Value) ).

queue_is_empty(queue(_, _, Count)) :-
    Count =:= 0.

queue_size(queue(_, _, Count), Count).
