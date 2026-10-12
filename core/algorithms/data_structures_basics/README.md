# Data Structures Basics — Prolog

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics) en **Prolog**, con un enfoque manual y minimalista.

**ES:** Un único funtor `node/2` compartido y tres estructuras de datos (`linked_list/3`, `stack/2`, `queue/3`) construidas sobre términos compuestos inmutables en Prolog, sin colecciones estándar ni delegación interna en `linked_list`. Se ejecuta e inspecciona con **SWI-Prolog** (`swipl`) y su framework integrado **plunit**.

**EN:** A single shared `node/2` functor and three data structures (`linked_list/3`, `stack/2`, `queue/3`) built over Prolog's immutable compound terms, without standard collections or internal delegation to `linked_list`. Run and inspected with **SWI-Prolog** (`swipl`) and its built-in **plunit** framework.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`src/data_structures_basics.pl`](src/data_structures_basics.pl) | Base de conocimiento con los términos `node/2`, `linked_list/3`, `stack/2`, `queue/3`, sus predicados públicos y helpers `dsb_*` / Knowledge base with terms, public predicates and `dsb_*` helpers |
| [`test/data_structures_basics_tests.pl`](test/data_structures_basics_tests.pl) | Suite de pruebas unitarias en plunit: 23 tests unitarios (uno por predicado del contrato) cubriendo los 15 pasos de la especificación / plunit unit test suite: 23 tests (one per contract predicate) covering all 15 spec steps |
| [`.gitignore`](.gitignore) | Excluye archivos temporales y compilados (`*.qlf`, `*~`) / Ignores transient and compiled files |
| `README.md` | Documentación del módulo / Module documentation |

**Estructura de directorios / Directory layout:**

```text
data_structures_basics/
├── .gitignore
├── README.md
├── src/
│   └── data_structures_basics.pl
└── test/
    └── data_structures_basics_tests.pl
```

**Nota de desviación / Deviation note:**

**ES:** La especificación propone `test/data_structures_basics_test.ext` y `test/run_tests.ext`. En este repositorio, la convención homologada para Prolog (`numbers`, `naive_sort`) emplea el sufijo plural `_tests.pl` (`test/data_structures_basics_tests.pl`). No existe un script `run_tests` separado: la suite incluye la directiva `:- initialization(run_tests(data_structures_basics_tests), main).` y se ejecuta directamente con el comando nativo `swipl`.

**EN:** The specification suggests `test/data_structures_basics_test.ext` and `test/run_tests.ext`. In this repository, the established Prolog convention (`numbers`, `naive_sort`) uses the plural suffix `_tests.pl` (`test/data_structures_basics_tests.pl`). There is no separate `run_tests` launcher script: the test file embeds `:- initialization(run_tests(data_structures_basics_tests), main).` and runs directly via the native `swipl` CLI.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Proyecto estructurado manualmente sin generadores externos (`mkdir -p src test`). Los términos de Prolog son inmutables por diseño: cada predicado que conceptualmente muta una estructura toma la instancia original en un argumento de entrada (`+`) y unifica la estructura actualizada resultante en su último argumento (`-`).

**EN:** Handcrafted project layout without external generators (`mkdir -p src test`). Prolog terms are immutable by design: every predicate that conceptually mutates a structure takes the original instance as an input argument (`+`) and unifies the resulting updated structure in its final argument (`-`).

```bash
mkdir -p src test
```

---

## 📄 Configuración clave / Key Configuration

No se requieren archivos de manifiesto o build externos; la base de conocimiento y los tests se cargan y ejecutan directamente con SWI-Prolog.

- `test/data_structures_basics_tests.pl`: Carga `library(plunit)` y consulta `../src/data_structures_basics.pl`. Declara una suite con 23 casos `test(...)` que cubren cada predicado observable.
- `.gitignore`: Excluye artefactos generados por `qcompile/1` (`*.qlf`).

---

## 🚀 Compilación y ejecución / Build & Run

```bash
# Verificación estática (análisis de sintaxis y referencias) / Static check
swipl -q -g "consult('src/data_structures_basics.pl'), halt"
swipl -s src/data_structures_basics.pl -g "check,halt" -t "halt(1)"

# Ejecución de pruebas unitarias / Run unit tests
swipl -g "run_tests,halt" -t "halt(1)" test/data_structures_basics_tests.pl
```

**Salida real / Actual output:**

```text
$ swipl -s src/data_structures_basics.pl -g "check,halt" -t "halt(1)"
% Checking undefined predicates ...
% Checking trivial failures ...
% Checking format/2,3 and debug/3 templates ...
% Checking redefined system and global predicates ...
% Checking predicates with declarations but without clauses ...
% Checking predicates that need autoloading ...
% Disabled autoloading (loaded 36 files)
% Checking predicate options lists ...

$ swipl -g "run_tests,halt" -t "halt(1)" test/data_structures_basics_tests.pl
[1/23] data_structures_basics_tests:node_init .... passed (0.003 sec)[2/23] data_structures_b..ests:node_get_value .... passed (0.000 sec)[3/23] data_structures_b..tests:node_get_next .... passed (0.000 sec)[4/23] data_structures_b..tests:node_set_next .... passed (0.000 sec)[5/23] data_structures_b..ts:linked_list_init .... passed (0.000 sec)[6/23] data_structures_b..inked_list_get_head .... passed (0.000 sec)[7/23] data_structures_b..ed_list_insert_head .... passed (0.000 sec)[8/23] data_structures_b..ed_list_insert_tail .... passed (0.000 sec)[9/23] data_structures_b..:linked_list_delete .... passed (0.000 sec)[10/23] data_structures_b..inked_list_is_empty ... passed (0.000 sec)[11/23] data_structures_b..ts:linked_list_size ... passed (0.000 sec)[12/23] data_structures_b..cs_tests:stack_init ... passed (0.000 sec)[13/23] data_structures_b..cs_tests:stack_push ... passed (0.000 sec)[14/23] data_structures_basics_tests:stack_pop ... passed (0.000 sec)[15/23] data_structures_b..cs_tests:stack_peek ... passed (0.000 sec)[16/23] data_structures_b..ests:stack_is_empty ... passed (0.000 sec)[17/23] data_structures_b..cs_tests:stack_size ... passed (0.000 sec)[18/23] data_structures_b..cs_tests:queue_init ... passed (0.000 sec)[19/23] data_structures_b..tests:queue_enqueue ... passed (0.000 sec)[20/23] data_structures_b..tests:queue_dequeue ... passed (0.000 sec)[21/23] data_structures_b..cs_tests:queue_peek ... passed (0.000 sec)[22/23] data_structures_b..ests:queue_is_empty ... passed (0.000 sec)[23/23] data_structures_b..cs_tests:queue_size ... passed (0.000 sec)
% All 23 tests passed in 0.010 seconds (0.010 cpu)
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `node_init/2` | `+Value, -Node` | $O(1)$ | Crea término `node(Value, null)` / Creates `node(Value, null)` term |
| `node_get_value/2` | `+Node, -Value` | $O(1)$ | Extrae el valor / Extracts node value |
| `node_get_next/2` | `+Node, -Next` | $O(1)$ | Extrae enlace; unifica con `null` si no hay / Extracts link; unifies `null` if absent |
| `node_set_next/3` | `+Node, +Next, -UpdatedNode` | $O(1)$ | Reconstruye nodo inmutable con nuevo enlace / Reconstructs immutable node |
| `linked_list_init/1` | `-List` | $O(1)$ | Unifica con `linked_list(null, null, 0)` / Initializes empty linked list |
| `linked_list_get_head/2` | `+List, -Value` | $O(1)$ | Obtiene valor de la cabeza; falla si vacía / Head value; fails if empty |
| `linked_list_insert_head/3` | `+List, +Value, -UpdatedList` | $O(1)$ | Inserta al inicio y actualiza cabeza/cola / Prepends node and updates pointers |
| `linked_list_insert_tail/3` | `+List, +Value, -UpdatedList` | $O(n)$ | Reconstruye la espina hasta la cola inmutable / Rebuilds chain to tail in immutable term |
| `linked_list_delete/3` | `+List, +Value, -UpdatedList` | $O(n)$ | Elimina primera aparición; falla si ausente / Deletes first match; fails if absent |
| `linked_list_is_empty/1` | `+List` | $O(1)$ | Tiene éxito si tamaño es 0 / Succeeds iff size is 0 |
| `linked_list_size/2` | `+List, -Count` | $O(1)$ | Unifica con contador almacenado / Unifies stored count |
| `stack_init/1` | `-Stack` | $O(1)$ | Unifica con `stack(null, 0)` / Initializes empty stack |
| `stack_push/3` | `+Stack, +Value, -UpdatedStack` | $O(1)$ | Inserta en el tope del stack / Pushes value onto top |
| `stack_pop/3` | `+Stack, -Value, -UpdatedStack` | $O(1)$ | Extrae valor y actualiza stack; falla si vacío / Pops value; fails if empty |
| `stack_peek/2` | `+Stack, -Value` | $O(1)$ | Observa valor en tope; falla si vacío / Peeks top value; fails if empty |
| `stack_is_empty/1` | `+Stack` | $O(1)$ | Tiene éxito si tamaño es 0 / Succeeds iff size is 0 |
| `stack_size/2` | `+Stack, -Count` | $O(1)$ | Unifica con contador almacenado / Unifies stored count |
| `queue_init/1` | `-Queue` | $O(1)$ | Unifica con `queue(null, null, 0)` / Initializes empty queue |
| `queue_enqueue/3` | `+Queue, +Value, -UpdatedQueue` | $O(n)$ | Reconstruye la espina hasta encolar al final / Rebuilds chain to append to rear |
| `queue_dequeue/3` | `+Queue, -Value, -UpdatedQueue` | $O(1)$ | Desencola del frente; falla si vacía / Dequeues from front; fails if empty |
| `queue_peek/2` | `+Queue, -Value` | $O(1)$ | Observa valor al frente; falla si vacía / Peeks front value; fails if empty |
| `queue_is_empty/1` | `+Queue` | $O(1)$ | Tiene éxito si tamaño es 0 / Succeeds iff size is 0 |
| `queue_size/2` | `+Queue, -Count` | $O(1)$ | Unifica con contador almacenado / Unifies stored count |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Funtores explícitos `node/2`, `linked_list/3`, `stack/2`, `queue/3` | Listas nativas de Prolog `[H\|T]` | La especificación prohíbe sustituir la estructura por colecciones estándar y exige que compartan la unidad `Node(value, next)` / Spec requires explicit shared `Node` and forbids replacing ADTs with stdlib lists |
| Términos inmutables con paso de estructura actualizada en el último argumento | Mutación con variables no instanciadas (*open lists*) o `setarg/3` / `nb_setarg/3` | `setarg` rompe la pureza lógica y es frágil ante backtracking; el paso funcional de términos inmutables garantiza aislamiento total entre estados / Destructive assignment breaks purity and backtracking safety; immutable term threading guarantees total isolation |
| Fallo del predicado (`fail`) para operaciones sobre vacío o elemento ausente | Devolver un átomo de error (`error`, `empty`) o un centinela numérico (`-1`) | En Prolog el fallo es el mecanismo natural de señalización de ausencia o condición insatisfecha, evitando ambigüedades con valores de dominio / Predicate failure is Prolog's idiomatic signaling mechanism for absent/impossible results |
| Átomo `null` como enlace ausente de `Node` | Variable libre o átomo `nil`/`none` | `null` es un término cerrado que evita crear choicepoints no deseados al comprobar fin de cadena / Closed atom avoids accidental variable bindings and keeps predicates deterministic |
| Helpers con prefijo `dsb_` e *if-then-else* | Cláusulas separadas sin prefijo | Evita colisiones de nombres en el módulo `user` y asegura determinismo (evita choicepoints reportados por plunit) / Prevents collisions in `user` and ensures determinism without spurious plunit choicepoints |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Mutación en el sitio (`set_next`, `node.next = head`, `tail.next = node`) | Reconstrucción inmutable: el predicado toma la estructura previa y unifica la nueva (`-Updated`) | Los términos de Prolog son inmutables; no existe asignación destructiva idiomática de campos / Prolog terms are immutable; destructive mutation is unidiomatic |
| `insert_tail` y `enqueue` en $O(1)$ en el pseudocódigo imperativo | Complejidad $O(n)$: helper `dsb_append_node` reconstruye la cadena | En una estructura puramente inmutable, el enlace previo solo puede actualizarse reconstruyendo el camino desde la cabeza hasta el nuevo nodo / In purely immutable linked cells, updating the previous link requires rebuilding the path from head |
| Ausencia de enlace nativa | Átomo `null` exclusivamente en `node(_, null)` | Representación elegida de enlace ausente; ninguna otra operación devuelve `null` / Explicit atom representing absent link |
| Indicador de fallo ante lista/pila/cola vacía o valor no encontrado | Fallo del predicado (`fail` / insatisfactorio) | Es el indicador natural de Prolog; evita centinelas numéricos o envoltorios adicionales / Natural Prolog indicator; avoids sentinel values or premature wrappers |
| `src/data_structures_basics.ext`, `test/data_structures_basics_test.ext`, `test/run_tests.ext` | `src/data_structures_basics.pl`, `test/data_structures_basics_tests.pl` | Convención del repositorio para suites de plunit; el ejecutable es `swipl` directamente / Monorepo convention for plunit suites; tests run directly with `swipl` |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `linked_list_get_head/2` | Lista vacía / Empty list | Fallo del predicado (`fail`) | `\+ linked_list_get_head(EmptyList, _)` |
| `linked_list_delete/3` | Valor ausente / Absent value | Fallo del predicado (`fail`) | `\+ linked_list_delete(List, 99, _)` |
| `stack_peek/2` | Pila vacía / Empty stack | Fallo del predicado (`fail`) | `\+ stack_peek(EmptyStack, _)` |
| `stack_pop/3` | Pila vacía / Empty stack | Fallo del predicado (`fail`) | `\+ stack_pop(EmptyStack, _, _)` |
| `queue_peek/2` | Cola vacía / Empty queue | Fallo del predicado (`fail`) | `\+ queue_peek(EmptyQueue, _)` |
| `queue_dequeue/3` | Cola vacía / Empty queue | Fallo del predicado (`fail`) | `\+ queue_dequeue(EmptyQueue, _, _)` |
| Inserciones (`insert_head`, `insert_tail`, `push`, `enqueue`) | Memoria disponible / Capacity | Sin fallo por límite / No capacity failure | No aplica / Not applicable |
| Entrada nula / Null input | Parámetros esperados / Arguments | No representable / Not representable | Los predicados esperan términos válidos del dominio; la especificación no define entradas nulas para este módulo |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Node: inicializar y observar valor/enlace / Initialize and observe value/link | Sí | `test/data_structures_basics_tests.pl:52-71` | Verificado en tests de `node_init`, `node_get_value`, `node_get_next`, `node_set_next` |
| Node: enlazar y recorrer / Initialize another node, link and traverse | Sí | `test/data_structures_basics_tests.pl:52-71` | Enlace y recorrido con `node_set_next` |
| LinkedList: estado vacío / Empty state | Sí | `test/data_structures_basics_tests.pl:73-129` | `is_empty` = true, `size` = 0, `get_head` falla |
| LinkedList: insertar por ambos extremos / Insert at both ends | Sí | `test/data_structures_basics_tests.pl:73-129` | Inserción en ambos extremos, tamaño 4, secuencia `5, 10, 20, 10` |
| LinkedList: eliminar primera aparición / Delete first occurrence | Sí | `test/data_structures_basics_tests.pl:73-129` | `delete(10)` tiene éxito, tamaño 3, nueva cabeza 5 |
| LinkedList: valor ausente / Absent value | Sí | `test/data_structures_basics_tests.pl:73-129` | `delete(99)` falla; tamaño y estructura sin cambio |
| LinkedList: vaciar / Empty the list | Sí | `test/data_structures_basics_tests.pl:73-129` | Eliminación sucesiva de 5, 20, 10; `is_empty` = true, `size` = 0, `get_head` falla |
| Stack: estado vacío y extracción fallida / Empty state and failed removal | Sí | `test/data_structures_basics_tests.pl:130-175` | `is_empty` = true, `size` = 0, `peek` y `pop` fallan |
| Stack: LIFO y `peek` no mutante / LIFO and non-mutating peek | Sí | `test/data_structures_basics_tests.pl:130-175` | `push` 10, 20, 30; `peek` devuelve 30 y conserva tamaño 3 |
| Stack: extracción y reutilización / Removal and reuse | Sí | `test/data_structures_basics_tests.pl:130-175` | `pop` (30), `push` (40), tres `pop` (40, 20, 10); queda vacía |
| Stack: vacío tras extracción / Empty after removal | Sí | `test/data_structures_basics_tests.pl:130-175` | `pop` sobre pila vacía falla; conserva `is_empty` |
| Queue: estado vacío y extracción fallida / Empty state and failed removal | Sí | `test/data_structures_basics_tests.pl:176-221` | `is_empty` = true, `size` = 0, `peek` y `dequeue` fallan |
| Queue: FIFO y `peek` no mutante / FIFO and non-mutating peek | Sí | `test/data_structures_basics_tests.pl:176-221` | `enqueue` 10, 20, 30; `peek` devuelve 10 y conserva tamaño 3 |
| Queue: extracción y reutilización / Removal and reuse | Sí | `test/data_structures_basics_tests.pl:176-221` | `dequeue` (10), `enqueue` (40), tres `dequeue` (20, 30, 40); queda vacía |
| Queue: vacío tras extracción / Empty after removal | Sí | `test/data_structures_basics_tests.pl:176-221` | `dequeue` sobre cola vacía falla; conserva `is_empty` |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Inserción al final (`linked_list_insert_tail/3` y `queue_enqueue/3`) en $O(n)$ en lugar de $O(1)$ | Degradación de complejidad en inserciones por la cola en colecciones extensas | Consecuencia intrínseca de los términos inmutables de Prolog sin variables libres compartidas; documentado en adaptaciones idiomáticas |
| Recursión de `dsb_append_node` no aprovecha LCO / TCO | Consumo de memoria proporcional a $n$ en llamadas anidadas para reconstruir la estructura | Se reconstruye a la vuelta de la recursión; suficiente para las estructuras académicas del módulo |
| Estructuras basadas en términos compuestos no unifican polimórficamente sin contrato formal | Cada estructura define sus propios predicados con nombres específicos de prefijo | No se introduce jerarquía ni traits prematuros en Fase 1, según la guía de abstracción |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Se comparte un único nodo (`node(Value, Next)`). Ningún ADT envuelve ni delega operaciones en `linked_list` ni en listas nativas de la biblioteca estándar de Prolog.
- **EN:** A single node representation (`node(Value, Next)`) is shared across all three structures. No ADT wraps or delegates operations to `linked_list` or standard Prolog lists.
- **ES:** Se respeta la pureza de términos inmutables en Prolog: las operaciones actualizan el estado unificando una nueva estructura en el argumento de salida.
- **EN:** Immutable term semantics are preserved: mutating operations unify a newly constructed term into the output argument.
- **ES:** El indicador de fallo natural es el fracaso lógico del predicado (`fail`), evaluable mediante negación por fallo (`\+ Goal`).
- **EN:** Natural failure is signaled through logical predicate failure (`fail`), easily verified via negation-as-failure (`\+ Goal`).
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
| Especificación / Specification | [`06_Data_Structures_Basics.md`](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics) |
| Módulo homologado del lenguaje / Homologated module | [`prolog/core/foundations/numbers/`](../../foundations/numbers/) |
| Módulo homologado de la misma fase / Homologated module in same phase | [`prolog/core/algorithms/naive_sort/`](../naive_sort/) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [SWI-Prolog — Documentation & PLUnit](https://www.swi-prolog.org/pldoc/doc_for?object=section(%27packages/plunit.html%27)) |
