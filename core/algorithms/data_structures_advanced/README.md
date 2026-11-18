# Data Structures Advanced — Prolog

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced) en **Prolog**, con un enfoque manual y minimalista.

**ES:** Términos compuestos inmutables para un árbol binario de búsqueda (`binary_tree/2`) y un grafo dirigido (`graph/3`) con registro canónico propio de vértices (`graph_node/3`), sin colecciones estándar de alto nivel ni estructuras asociativas de biblioteca. Se ejecuta e inspecciona con **SWI-Prolog** (`swipl`) y su framework integrado **plunit**.

**EN:** Immutable compound terms for a binary search tree (`binary_tree/2`) and a directed graph (`graph/3`) featuring a manual canonical vertex registry (`graph_node/3`), without high-level standard collections or library associative structures. Executed and inspected with **SWI-Prolog** (`swipl`) and its built-in **plunit** framework.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`src/data_structures_advanced.pl`](src/data_structures_advanced.pl) | Base de conocimiento con los funtores `tree_node/3`, `binary_tree/2`, `graph_node/3`, `graph/3` y sus predicados públicos y auxiliares / Knowledge base with terms, public predicates and internal helpers |
| [`test/data_structures_advanced_tests.pl`](test/data_structures_advanced_tests.pl) | Suite de pruebas unitarias en plunit: 24 tests unitarios cubriendo todos los casos de `TreeNode`, `BinaryTree` y `Graph` / plunit unit test suite: 24 unit tests covering all spec cases for `TreeNode`, `BinaryTree` and `Graph` |
| [`.gitignore`](.gitignore) | Excluye artefactos transitorios y compilados (`*.qlf`, `*~`) / Ignores transient and compiled artifacts |
| `README.md` | Documentación del módulo / Module documentation |

**Estructura de directorios / Directory layout:**

```text
data_structures_advanced/
├── .gitignore
├── README.md
├── src/
│   └── data_structures_advanced.pl
└── test/
    └── data_structures_advanced_tests.pl
```

**Nota de desviación / Deviation note:**

**ES:** La especificación propone `test/data_structures_advanced_test.ext` y `test/run_tests.ext`. En este repositorio, la convención homologada para Prolog (`numbers`, `naive_sort`, `data_structures_basics`) emplea el sufijo plural `_tests.pl` (`test/data_structures_advanced_tests.pl`). No existe un script `run_tests` separado: la suite incluye la directiva `:- initialization(run_tests(data_structures_advanced_tests), main).` y se ejecuta directamente con el comando nativo `swipl`.

**EN:** The specification suggests `test/data_structures_advanced_test.ext` and `test/run_tests.ext`. In this repository, the established Prolog convention (`numbers`, `naive_sort`, `data_structures_basics`) uses the plural suffix `_tests.pl` (`test/data_structures_advanced_tests.pl`). There is no separate `run_tests` launcher script: the test file embeds `:- initialization(run_tests(data_structures_advanced_tests), main).` and runs directly via the native `swipl` CLI.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Proyecto estructurado manualmente sin generadores externos (`mkdir -p src test`). Los términos de Prolog son inmutables por diseño: cada predicado que conceptualmente muta una estructura toma la instancia original en un argumento de entrada (`+`) y unifica la estructura actualizada resultante en su último argumento (`-`). La base conceptual `Node(value)` se implementa mediante valor embebido en el primer argumento de los funtores `tree_node/3` y `graph_node/3`.

**EN:** Handcrafted project layout without external generators (`mkdir -p src test`). Prolog terms are immutable by design: every predicate that conceptually mutates a structure takes the original instance as an input argument (`+`) and unifies the resulting updated structure in its final argument (`-`). The conceptual base `Node(value)` is realized through an embedded value in the first argument of the `tree_node/3` and `graph_node/3` functors.

```bash
mkdir -p src test
```

---

## 📄 Configuración clave / Key Configuration

No se requieren archivos de manifiesto o build externos; la base de conocimiento y los tests se cargan y ejecutan directamente con SWI-Prolog.

- `test/data_structures_advanced_tests.pl`: Carga `library(plunit)` y consulta `../src/data_structures_advanced.pl`. Declara una suite con 24 casos `test(...)` organizados en tres grupos lógicos (`TreeNode`, `BinaryTree`, `Graph`).
- `.gitignore`: Excluye artefactos generados por `qcompile/1` (`*.qlf`).

---

## 🚀 Compilación y ejecución / Build & Run

```bash
# Verificación estática (análisis de sintaxis y referencias) / Static check
swipl -s src/data_structures_advanced.pl -g "check,halt" -t "halt(1)"

# Ejecución de pruebas unitarias / Run unit tests
swipl -g "run_tests,halt" -t "halt(1)" test/data_structures_advanced_tests.pl
```

**Salida real / Actual output:**

```text
$ swipl -s src/data_structures_advanced.pl -g "check,halt" -t "halt(1)"
% Checking undefined predicates ...
% Checking trivial failures ...
% Checking format/2,3 and debug/3 templates ...
% Checking redefined system and global predicates ...
% Checking predicates with declarations but without clauses ...
% Checking predicates that need autoloading ...
% Disabled autoloading (loaded 36 files)
% Checking predicate options lists ...

$ swipl -g "run_tests,halt" -t "halt(1)" test/data_structures_advanced_tests.pl
% Start unit: data_structures_advanced_tests
% [1/24] data_structures_a..ts:tree_node_create ..... passed (0.002 sec)
% [2/24] data_structures_a..bsent_initial_links ..... passed (0.000 sec)
% [3/24] data_structures_a..e_link_two_children ..... passed (0.000 sec)
% [4/24] data_structures_a.._traverse_each_link ..... passed (0.000 sec)
% [5/24] data_structures_a..ode_unlink_children ..... passed (0.000 sec)
% [6/24] data_structures_a..mmutable_adaptation ..... passed (0.000 sec)
% [7/24] data_structures_a..y_tree_create_empty ..... passed (0.000 sec)
% [8/24] data_structures_a..ry_tree_insert_root ..... passed (0.000 sec)
% [9/24] data_structures_a..rt_lower_and_higher ..... passed (0.000 sec)
% [10/24] data_structures_a..multilevel_branches .... passed (0.000 sec)
% [11/24] data_structures_a..ue_in_nonempty_tree .... passed (0.000 sec)
% [12/24] data_structures_a..dempotent_duplicate .... passed (0.000 sec)
% [13/24] data_structures_a.._ordered_insertions .... passed (0.000 sec)
% [14/24] data_structures_a..:graph_create_empty .... passed (0.000 sec)
% [15/24] data_structures_a..aph_isolated_vertex .... passed (0.000 sec)
% [16/24] data_structures_a..s_and_directed_edge .... passed (0.000 sec)
% [17/24] data_structures_a..preserves_adjacency .... passed (0.000 sec)
% [18/24] data_structures_a..raph_duplicate_edge .... passed (0.000 sec)
% [19/24] data_structures_a..nt_without_mutation .... passed (0.000 sec)
% [20/24] data_structures_a..ighbours_and_counts .... passed (0.000 sec)
% [21/24] data_structures_a.._missing_edge_query .... passed (0.000 sec)
% [22/24] data_structures_a..s_of_missing_vertex .... passed (0.000 sec)
% [23/24] data_structures_a.._loop_and_duplicate .... passed (0.000 sec)
% [24/24] data_structures_a..ur_result_isolation .... passed (0.000 sec)
% End unit data_structures_advanced_tests: passed (0.007 sec CPU)
% All 24 tests passed in 0.010 seconds (0.010 cpu)
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `tree_node_init/2` | `+Value, -Node` | $O(1)$ | Crea término `tree_node(Value, null, null)` / Creates `tree_node(Value, null, null)` term |
| `tree_node_get_value/2` | `+Node, -Value` | $O(1)$ | Extrae valor embebido del nodo / Extracts embedded node value |
| `tree_node_get_left/2` | `+Node, -Left` | $O(1)$ | Extrae enlace izquierdo; unifica con `null` si ausente / Extracts left link; unifies `null` if absent |
| `tree_node_get_right/2` | `+Node, -Right` | $O(1)$ | Extrae enlace derecho; unifica con `null` si ausente / Extracts right link; unifies `null` if absent |
| `tree_node_set_left/3` | `+Node, +Left, -UpdatedNode` | $O(1)$ | Reconstruye nodo inmutable con nuevo enlace izquierdo / Reconstructs immutable node with updated left link |
| `tree_node_set_right/3` | `+Node, +Right, -UpdatedNode` | $O(1)$ | Reconstruye nodo inmutable con nuevo enlace derecho / Reconstructs immutable node with updated right link |
| `binary_tree_init/1` | `-Tree` | $O(1)$ | Unifica con `binary_tree(null, 0)` / Initializes empty binary search tree |
| `binary_tree_insert/3` | `+Tree, +Value, -UpdatedTree` | $O(h)$ | Inserta según invariante de ABB; duplicado es idempotente / Inserts following BST invariant; duplicate is idempotent |
| `binary_tree_contains/2` | `+Tree, +Value` | $O(h)$ | Búsqueda binaria según invariante de ABB; falla si ausente / BST membership traversal; fails if absent |
| `binary_tree_is_empty/1` | `+Tree` | $O(1)$ | Tiene éxito si el árbol no tiene raíz (`binary_tree(null, 0)`) / Succeeds iff tree has no nodes |
| `binary_tree_size/2` | `+Tree, -Count` | $O(1)$ | Unifica con contador de nodos almacenado / Unifies with stored node count |
| `graph_node_init/3` | `+Label, +NextVertex, -Node` | $O(1)$ | Helper interno: crea `graph_node(Label, [], NextVertex)` / Internal helper: creates `graph_node(Label, [], NextVertex)` |
| `graph_init/1` | `-Graph` | $O(1)$ | Unifica con `graph(null, 0, 0)` / Initializes empty directed graph |
| `graph_add_vertex/3` | `+Graph, +Label, -UpdatedGraph` | $O(V)$ | Registra vértice en registro enlazado si no existe; idempotente / Adds vertex to linked registry if absent; idempotent |
| `graph_add_edge/4` | `+Graph, +From, +To, -UpdatedGraph` | $O(V + d(u))$ | Añade arista dirigida ordenada; admite bucles e ignora duplicadas; falla si falta extremo / Adds directed edge; allows self-loops and duplicate edges; fails if endpoint missing |
| `graph_has_edge/3` | `+Graph, +From, +To` | $O(V + d(u))$ | Comprueba arista dirigida; falla si no existe o falta extremo / Verifies directed edge; fails if absent |
| `graph_get_neighbors/3` | `+Graph, +Label, -Neighbors` | $O(V + d(u))$ | Devuelve lista ordenada de vecinos; falla si vértice no existe / Returns sorted neighbour list; fails if vertex missing |
| `graph_is_empty/1` | `+Graph` | $O(1)$ | Tiene éxito si el grafo no tiene vértices (`graph(null, 0, 0)`) / Succeeds iff graph has no vertices |
| `graph_vertex_count/2` | `+Graph, -Count` | $O(1)$ | Unifica con contador de vértices almacenado / Unifies with stored vertex count |
| `graph_edge_count/2` | `+Graph, -Count` | $O(1)$ | Unifica con contador de aristas almacenado / Unifies with stored edge count |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Reutilización de `Node` con valor embebido en `tree_node/3` y `graph_node/3` | Envoltura anidada `node(Value)` o herencia simulada | Prolog carece de herencia orientada a objetos; embeber el valor en el primer argumento evita niveles superfluos de desreferenciación en la unificación y preserva la paridad con la semántica de la base `Node(value)` / Prolog lacks OOP inheritance; embedding value in first argument avoids superfluous dereferencing during unification and preserves parity with `Node(value)` |
| Registro canónico manual de vértices como cadena de términos `graph_node(Label, Neighbors, Next)` | Módulos asociativos de biblioteca (`library(assoc)`, `library(rbtrees)`) o lista nativa de pares | La especificación prohíbe delegar el registro en tablas hash o árboles de biblioteca y exige recorrido y búsqueda manual con coste $O(V)$ / The spec strictly forbids library maps/trees for the registry and mandates manual traversal with $O(V)$ complexity |
| Secuencia de vecinos como lista nativa ordenada ascendentemente | Términos compuestos de lista enlazada propia `neighbor(Label, Next)` o conjuntos ordenados de biblioteca (`library(ordsets)`) | La especificación permite explícitamente usar la lista del lenguaje para el almacenamiento de vecinos, siempre que la búsqueda e inserción ordenada se implementen manualmente (`insert_sorted/3`) sin bibliotecas externas / Spec explicitly allows standard list for neighbour storage, provided sorted insertion is manually coded without external libraries |
| Términos inmutables con paso de estructura actualizada en el último argumento | Mutación destructiva con `setarg/3` o base de hechos dinámica (`assertz`/`retract`) | La mutación destructiva rompe la pureza lógica y es frágil ante backtracking; el paso funcional de términos inmutables garantiza aislamiento total entre estados e históricos / Destructive mutation breaks logical purity and backtracking safety; functional threading guarantees complete state isolation |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Mutación en el sitio (`set_left`, `set_right`, `add_vertex`, `add_edge`) | Reconstrucción inmutable: el predicado toma la estructura previa y unifica la nueva (`-Updated`) | Los términos de Prolog son inmutables por diseño; no existe asignación destructiva de campos en programación lógica pura / Prolog terms are immutable by design; no destructive field assignment exists in pure logic programming |
| Indicador de fallo ante búsqueda insatisfecha o extremo ausente | Fallo del predicado (`fail` / insatisfactorio) | Es el mecanismo natural y declarativo de Prolog para señalizar condiciones no cumplidas; evita centinelas ambiguos y es verificable mediante negación por fallo (`\+ Goal`) / Prolog's natural declarative signaling mechanism; avoids ambiguous sentinels and is verified via negation-as-failure |
| Ausencia de enlace nativa | Átomo `null` en enlaces vacíos de `tree_node` y final de cadena en el registro de vértices | Término atómico cerrado que evita variables libres accidentales y asegura unificación determinista / Closed atomic term avoiding accidental free variables and ensuring deterministic unification |
| Mutación de copia de vecinos en aislamiento de resultados (`graph_neighbour_result_isolation`) | Comprobación de que el término unificado conserva su valor tras inserciones posteriores en el grafo | Las listas y términos de Prolog son inherentemente inmutables y no admiten mutación destructiva in-place; la inmutabilidad intrínseca garantiza aislamiento absoluto / Prolog lists are immutable and cannot be mutated in-place; intrinsic immutability guarantees absolute isolation |
| `test/data_structures_advanced_test.ext` y `test/run_tests.ext` | `test/data_structures_advanced_tests.pl` ejecutado con `swipl` | Convención homologada del repositorio para suites de plunit; los tests se invocan directamente desde el CLI de SWI-Prolog / Monorepo convention for plunit suites; tests run directly via SWI-Prolog CLI |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `tree_node_init/2` | Ninguna / None | No aplica / Not applicable | — |
| `tree_node_get_value/2` | Término de entrada no es `tree_node/3` / Term is not `tree_node/3` | Fallo del predicado (`fail`) | `\+ tree_node_get_value(invalid, _)` |
| `tree_node_get_left/2`, `tree_node_get_right/2` | Enlace ausente / Absent link | Átomo `null` / `null` atom | `tree_node_get_left(Node, null)` |
| `tree_node_set_left/3`, `tree_node_set_right/3` | Término de entrada no es `tree_node/3` / Term is not `tree_node/3` | Fallo del predicado (`fail`) | `\+ tree_node_set_left(invalid, _, _)` |
| `binary_tree_init/1` | Ninguna / None | No aplica / Not applicable | — |
| `binary_tree_insert/3` | Capacidad agotada / Capacity limit | Sin fallo por límite contractual / No capacity limit failure | No aplica / Not applicable |
| `binary_tree_contains/2` | Valor ausente en el árbol / Value absent from tree | Fallo del predicado (`fail`) | `\+ binary_tree_contains(Tree, 99)` |
| `binary_tree_is_empty/1` | Árbol no vacío / Non-empty tree | Fallo del predicado (`fail`) | `\+ binary_tree_is_empty(NonEmptyTree)` |
| `binary_tree_size/2` | Ninguna / None | No aplica / Not applicable | — |
| `graph_node_init/3` | Ninguna / None | No aplica / Not applicable | — |
| `graph_init/1` | Ninguna / None | No aplica / Not applicable | — |
| `graph_add_vertex/3` | Capacidad agotada / Capacity limit | Sin fallo por límite contractual / No capacity limit failure | No aplica / Not applicable |
| `graph_add_edge/4` | Extremo origen o destino inexistente / Missing source or target vertex | Fallo del predicado (`fail`) | `\+ graph_add_edge(Graph, 10, 99, _)` |
| `graph_has_edge/3` | Arista ausente o extremos inexistentes / Missing edge or endpoints | Fallo del predicado (`fail`) | `\+ graph_has_edge(Graph, 10, 30)` |
| `graph_get_neighbors/3` | Vértice inexistente en el grafo / Vertex missing from graph | Fallo del predicado (`fail`) | `\+ graph_get_neighbors(Graph, 99, _)` |
| `graph_is_empty/1` | Grafo con 1 o más vértices / Non-empty graph | Fallo del predicado (`fail`) | `\+ graph_is_empty(NonEmptyGraph)` |
| `graph_vertex_count/2`, `graph_edge_count/2` | Ninguna / None | No aplica / Not applicable | — |
| Entrada nula o inválida / Null or invalid input | Argumentos que no unifican con los funtores esperados | Fallo del predicado (`fail`) | `\+ graph_has_edge(null, 10, 20)` |

---

## ✅ Cobertura de pruebas / Test coverage

Mapeo de unidades y variantes a la suite de pruebas:
- `TreeNode` (variante inmutable única) → 6 casos → grupo lógico `TreeNode` (`test/data_structures_advanced_tests.pl:76-150`) → suite `data_structures_advanced_tests` → runner `swipl` (`library(plunit)`).
- `BinaryTree` (variante inmutable única) → 7 casos → grupo lógico `BinaryTree` (`test/data_structures_advanced_tests.pl:152-215`) → suite `data_structures_advanced_tests` → runner `swipl` (`library(plunit)`).
- `Graph` (variante inmutable única) → 11 casos → grupo lógico `Graph` (`test/data_structures_advanced_tests.pl:217-332`) → suite `data_structures_advanced_tests` → runner `swipl` (`library(plunit)`).

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Crear un nodo de árbol / Create a tree node | Sí | `tree_node_create` (`test:78-82`) | Verifica inicialización con valor 10 y lectura con `tree_node_get_value/2` |
| Enlaces iniciales ausentes / Absent initial links | Sí | `tree_node_absent_initial_links` (`test:84-89`) | `tree_node_get_left/2` y `tree_node_get_right/2` unifican con `null` |
| Enlazar dos hijos / Link two children | Sí | `tree_node_link_two_children` (`test:91-98`) | Enlaza hijos 20 y 30 al padre 10; `get_value` en hijos devuelve 20 y 30 |
| Recorrer cada enlace / Traverse each link | Sí | `tree_node_traverse_each_link` (`test:100-115`) | Verifica navegación a hijos 20 y 30 y confirma que sus enlaces son `null` |
| Desenlazar hijos / Unlink children | Sí | `tree_node_unlink_children` (`test:117-136`) | Desvincula hijo izquierdo con `null` conservando derecho, y luego limpia derecho |
| Adaptación inmutable (si aplica) / Immutable adaptation (if applicable) | Sí | `tree_node_immutable_adaptation` (`test:138-148`) | `tree_node_set_left/3` unifica un nuevo nodo; nodo original conserva enlaces intactos |
| Crear vacío / Create empty (BinaryTree) | Sí | `binary_tree_create_empty` (`test:152-158`) | `is_empty` = true, `size` = 0, `contains(50)` falla |
| Insertar la raíz / Insert the root | Sí | `binary_tree_insert_root` (`test:160-167`) | Inserta 50; `size` = 1, `is_empty` falla, `contains(50)` tiene éxito |
| Insertar menor y mayor / Insert lower and higher | Sí | `binary_tree_insert_lower_and_higher` (`test:169-176`) | Inserta 50, 30, 70; `size` = 3, pertenencia de los tres valores |
| Ramas de varios niveles / Multilevel branches | Sí | `binary_tree_multilevel_branches` (`test:178-186`) | Inserta 50, 30, 70, 20, 40; `size` = 5, pertenencia de todos los valores |
| Valor ausente en árbol no vacío / Missing value in nonempty tree | Sí | `binary_tree_missing_value_in_nonempty_tree` (`test:188-196`) | Árbol con 50; `contains(99)` falla; `size` permanece 1 y 50 sigue presente |
| Duplicado idempotente / Idempotent duplicate | Sí | `binary_tree_idempotent_duplicate` (`test:198-204`) | Inserta 50, 30, 70, 30; `size` permanece 3, conserva los tres valores |
| Inserciones ordenadas / Ordered insertions | Sí | `binary_tree_ordered_insertions` (`test:206-215`) | Inserta 20, 30, 40, 50, 70; `size` = 5, todos presentes, `contains(99)` falla |
| Crear vacío / Create empty (Graph) | Sí | `graph_create_empty` (`test:217-225`) | `is_empty` = true, 0 vértices, 0 aristas, `has_edge` y `get_neighbors` fallan |
| Vértice aislado / Isolated vertex | Sí | `graph_isolated_vertex` (`test:227-233`) | Registra 10; `is_empty` falla, 1 vértice, 0 aristas, vecinos vacíos `[]` |
| Etiquetas no consecutivas y arista dirigida / Nonconsecutive labels and directed edge | Sí | `graph_nonconsecutive_labels_and_directed_edge` (`test:235-243`) | Vértices 10 y 70, arista 10→70 presente, 70→10 ausente; 2 vértices, 1 arista |
| Vértice duplicado conserva adyacencia / Duplicate vertex preserves adjacency | Sí | `graph_duplicate_vertex_preserves_adjacency` (`test:245-253`) | Registra 10 duplicado tras arista 10→30; conserva 2 vértices, 1 arista y vecinos `[30]` |
| Arista duplicada / Duplicate edge | Sí | `graph_duplicate_edge` (`test:255-262`) | Añade 10→30 dos veces; conserva 2 vértices, 1 arista y vecinos `[30]` |
| Extremo inexistente sin mutación / Missing endpoint without mutation | Sí | `graph_missing_endpoint_without_mutation` (`test:264-282`) | Altas con 99 o 98 fallan; conserva 2 vértices, 1 arista y consultas fallan |
| Vecinos ordenados y contadores / Sorted neighbours and counts | Sí | `graph_sorted_neighbours_and_counts` (`test:284-294`) | Altas desordenadas en 10; vecinos resultantes `[30, 50, 70]`; 4 vértices, 4 aristas |
| Consulta de arista ausente / Missing-edge query | Sí | `graph_missing_edge_query` (`test:296-302`) | Consulta 10→30 sin aristas agregadas; falla; 2 vértices, 0 aristas |
| Vecinos de vértice inexistente / Neighbours of missing vertex | Sí | `graph_neighbours_of_missing_vertex` (`test:304-310`) | `get_neighbors(99)` falla distintamente de los vecinos vacíos del vértice 10 |
| Bucle y duplicado / Self-loop and duplicate | Sí | `graph_self_loop_and_duplicate` (`test:312-319`) | Arista 10→10 dos veces; bucle presente, vecinos `[10]`, 1 vértice, 1 arista |
| Aislamiento del resultado de vecinos / Neighbour-result isolation | Sí | `graph_neighbour_result_isolation` (`test:321-332`) | Guarda resultado `[30]`; añade 10→50; término guardado permanece `[30]`, nueva consulta `[30, 50]` |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Ninguna / None | Ninguno / None | La implementación cumple estrictamente todas las invariantes, cotas de complejidad y contratos exigidos por la especificación para Prolog sin dependencias de terceros ni limitaciones de capacidad artificiales / The implementation strictly satisfies all invariants, complexity bounds, and contracts required by the specification for Prolog without third-party dependencies or artificial capacity constraints |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Se utiliza valor embebido en términos compuestos (`tree_node(Value, Left, Right)` y `graph_node(Label, Neighbors, NextVertex)`), cumpliendo la exigencia de la base conceptual `Node(value)` en un lenguaje declarativo puro sin orientación a objetos.
- **EN:** Embedded values inside compound terms (`tree_node(Value, Left, Right)` and `graph_node(Label, Neighbors, NextVertex)`) fulfill the conceptual `Node(value)` base requirement in a pure declarative language without OOP inheritance.
- **ES:** Se preserva la semántica inmutable de Prolog: las operaciones que modifican la estructura unifican un nuevo término en el último argumento reconstruyendo la espina relevante, manteniendo intactos los estados previos.
- **EN:** Prolog's immutable term semantics are preserved: modifying operations unify a newly constructed term into the output argument along the traversal spine, leaving previous states intact.
- **ES:** El indicador de fallo natural es el fracaso lógico del predicado (`fail`), evaluable mediante negación por fallo (`\+ Goal`).
- **EN:** Natural failure is signaled through logical predicate failure (`fail`), easily verified via negation-as-failure (`\+ Goal`).
- **ES:** El recorrido del registro de vértices (`find_vertex/3`) y la inserción ordenada de vecinos (`insert_sorted/3`) aprovechan la optimización de última llamada (LCO / TCO) en SWI-Prolog.
- **EN:** Vertex registry traversal (`find_vertex/3`) and sorted neighbour insertion (`insert_sorted/3`) take advantage of Last Call Optimization (LCO / TCO) in SWI-Prolog.
- **ES:** No se importan otros módulos del monorepo, cumpliendo con la independencia exigida por la especificación.
- **EN:** No dependencies or imports from other monorepo modules exist, keeping full autonomy as required by the specification.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`../data_structures_basics/`](../data_structures_basics/) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`../../foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [SWI-Prolog — Documentation & PLUnit](https://www.swi-prolog.org/pldoc/doc_for?object=section(%27packages/plunit.html%27)) |
