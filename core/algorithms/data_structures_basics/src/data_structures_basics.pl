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
% Implementación pendiente: la escribe el autor. Esta delegación solo genera el
% contrato y el esqueleto de todas sus operaciones (los cuerpos `fail`).
%
% Node:
%   node_init(+Value, -Node)
%   node_get_value(+Node, -Value)
%   node_get_next(+Node, -Next)
%   node_set_next(+Node, +Next, -UpdatedNode)
node_init(_, _) :-
    fail.

node_get_value(_, _) :-
    fail.

node_get_next(_, _) :-
    fail.

node_set_next(_, _, _) :-
    fail.

% LinkedList:
%   linked_list_init(-List)
%   linked_list_get_head(+List, -Value)
%   linked_list_insert_head(+List, +Value, -UpdatedList)
%   linked_list_insert_tail(+List, +Value, -UpdatedList)
%   linked_list_delete(+List, +Value, -UpdatedList)
%   linked_list_is_empty(+List)
%   linked_list_size(+List, -Count)
linked_list_init(_) :-
    fail.

linked_list_get_head(_, _) :-
    fail.

linked_list_insert_head(_, _, _) :-
    fail.

linked_list_insert_tail(_, _, _) :-
    fail.

linked_list_delete(_, _, _) :-
    fail.

linked_list_is_empty(_) :-
    fail.

linked_list_size(_, _) :-
    fail.

% Stack:
%   stack_init(-Stack)
%   stack_push(+Stack, +Value, -UpdatedStack)
%   stack_pop(+Stack, -Value, -UpdatedStack)
%   stack_peek(+Stack, -Value)
%   stack_is_empty(+Stack)
%   stack_size(+Stack, -Count)
stack_init(_) :-
    fail.

stack_push(_, _, _) :-
    fail.

stack_pop(_, _, _) :-
    fail.

stack_peek(_, _) :-
    fail.

stack_is_empty(_) :-
    fail.

stack_size(_, _) :-
    fail.

% Queue:
%   queue_init(-Queue)
%   queue_enqueue(+Queue, +Value, -UpdatedQueue)
%   queue_dequeue(+Queue, -Value, -UpdatedQueue)
%   queue_peek(+Queue, -Value)
%   queue_is_empty(+Queue)
%   queue_size(+Queue, -Count)
queue_init(_) :-
    fail.

queue_enqueue(_, _, _) :-
    fail.

queue_dequeue(_, _, _) :-
    fail.

queue_peek(_, _) :-
    fail.

queue_is_empty(_) :-
    fail.

queue_size(_, _) :-
    fail.
