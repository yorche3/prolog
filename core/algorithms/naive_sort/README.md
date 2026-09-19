# Naive Sort — Prolog

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Prolog**, con **SWI-Prolog** como intérprete y **plunit** (biblioteca estándar de SWI) como framework de pruebas unitarias.

Tres algoritmos de ordenación con coste $O(n^2)$: **selection sort**, **bubble sort** e **insertion sort**, todos ordenando de forma ascendente la lista recibida, sin bibliotecas de ordenamiento ni estructuras auxiliares.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/naive_sort.pl`](src/naive_sort.pl) | Base de conocimiento: 3 predicados del contrato + 4 helpers. |
| [`test/naive_sort_tests.pl`](test/naive_sort_tests.pl) | Suite única: 3 tests (7 casos cada uno). |
| [`.gitignore`](.gitignore) | Ignora los ficheros compilados por `qcompile/1` (`*.qlf`). |

**Estructura de directorios esperada:**

```text
naive_sort/
├── .gitignore                           # Ignora *.qlf
├── src/
│   └── naive_sort.pl                    # 3 predicados + 4 helpers
└── test/
    └── naive_sort_tests.pl              # 3 tests, 7 casos cada uno
```

**ES:** No hay fichero de ejecución aparte: la suite termina con `:- initialization(run_tests(naive_sort_tests), main).`, que es el runner, igual que en `numbers/`.

**EN:** There is no separate launcher file: the suite ends with `:- initialization(run_tests(naive_sort_tests), main).`, which is the runner, exactly as in `numbers/`.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Sigue el mismo patrón que [`numbers`](../../foundations/numbers/) y [`calculator`](../../foundations/unit_test/calculator/): base de conocimiento en `src/` y su suite plunit en `test/`, con el resultado como último argumento de cada predicado. El módulo no tiene predicados auxiliares expuestos al usuario: los helpers (`pick_min/3`, `smallest/3`, `remove_first/3`, `bubble_pass/3`, `insert/3`) quedan como predicados internos del fichero.

**EN:** Follows the same pattern as [`numbers`](../../foundations/numbers/) and [`calculator`](../../foundations/unit_test/calculator/): a knowledge base in `src/` and its plunit suite in `test/`, with the result as the last argument of each predicate. The module exposes no auxiliary predicates to the user: the helpers (`pick_min/3`, `smallest/3`, `remove_first/3`, `bubble_pass/3`, `insert/3`) stay as internal predicates of the file.

**Combinación aplicada:** algoritmo no recursivo en el pseudocódigo, implementado de forma recursiva sobre listas (Prolog no tiene bucles ni mutación) → **1 suite × 3 tests = 3 tests (21 casos)**.

**Applied combination:** non-recursive algorithm in the pseudocode, implemented recursively over lists (Prolog has no loops or mutation) → **1 suite × 3 tests = 3 tests (21 cases)**.

### Inicialización / Initialization

**ES:** La estructura de este lenguaje es manual (✍️ `mkdir -p src test` en la guía de inicialización): no hay comando de andamiaje que ejecutar, y el módulo se compone a mano igual que `numbers/`.

**EN:** This language's structure is manual (✍️ `mkdir -p src test` in the initialization guide): there is no scaffolding command to run, and the module is assembled by hand just like `numbers/`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/naive_sort.pl` — Implementación

**ES:** Cada algoritmo tiene su propia estrategia y su propio helper. Extracto de `selection_sort`, que es el único que usa `pick_min/3`:

**EN:** Each algorithm has its own strategy and its own helper. Excerpt from `selection_sort`, the only one that uses `pick_min/3`:

```prolog
selection_sort([], []).
selection_sort(Arr, [Min|SortedRest]) :-
    pick_min(Arr, Min, Rest),
    selection_sort(Rest, SortedRest).

% pick_min(+Arr, -Min, -Rest): Min es el menor elemento de Arr y Rest es Arr sin
% su primera aparición, conservando el orden original.
pick_min([X|Xs], Min, Rest) :-
    smallest(Xs, X, Min),
    remove_first(Min, [X|Xs], Rest).
```

**ES:** `bubble_sort/2` usa `bubble_pass/3`, que devuelve además la bandera de intercambio:

**EN:** `bubble_sort/2` uses `bubble_pass/3`, which also returns the swap flag:

```prolog
bubble_sort(Arr, Sorted) :-
    ( bubble_pass(Arr, Passed, true) ->
        bubble_sort(Passed, Sorted)
    ;
        Sorted = Arr
    ).
```

Y `insertion_sort/2` usa `insert/3`:

```prolog
insertion_sort([], []).
insertion_sort([X|Xs], Sorted) :-
    insertion_sort(Xs, SortedXs),
    insert(X, SortedXs, Sorted).
```

### Suites de pruebas — plunit

**ES:** Una única suite con un `test(...)` por predicado. Los 7 casos viven en una lista de hechos compartida (`case/3`) y un único helper los recorre para cualquier algoritmo:

**EN:** A single suite with one `test(...)` per predicate. The 7 cases live in a shared set of facts (`case/3`) and a single helper walks them for any algorithm:

```prolog
assert_sorts_all_cases(Sort, Algorithm) :-
    forall(case(Description, Input, Expected),
           assert_sorts_case(Sort, Algorithm, Description, Input, Expected)).

assert_sorts_case(Sort, Algorithm, Description, Input, Expected) :-
    Goal =.. [Sort, Input, Actual],
    call(Goal),
    assertion(should_sort(Algorithm, Description, Actual, Expected)).
```

**ES:** El helper recibe el nombre del predicado y construye el goal con `=..`, de forma que sirve para los tres algoritmos sin repetir las aserciones.

**EN:** The helper receives the predicate's name and builds the goal with `=..`, so it serves all three algorithms without repeating the assertions.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener SWI-Prolog instalado

```bash
# Verificar instalación
swipl --version
```

### Verificación estática / Static check

**ES:** Prolog no compila a un artefacto previo, así que la comprobación estática es **consultar** el fichero: `swipl` analiza la sintaxis y avisa de variables singulares o cláusulas mal formadas al cargarlo.

**EN:** Prolog does not compile to a prior artifact, so the static check is **consulting** the file: `swipl` analyses the syntax and warns about singleton variables or malformed clauses when loading it.

```bash
cd prolog/core/algorithms/naive_sort
swipl -q -g "consult('src/naive_sort.pl'), halt"
```

### Ejecutar las pruebas unitarias / Run tests

```bash
cd prolog/core/algorithms/naive_sort/test
swipl -q -f naive_sort_tests.pl -t halt
```

### Salida esperada / Expected output

```text
% [1/3] naive_sort_tests:selection_sort ............. passed (0.003 sec)
% [2/3] naive_sort_tests:bubble_sort ................ passed (0.000 sec)
% [3/3] naive_sort_tests:insertion_sort ............. passed (0.000 sec)
```

> **ES:** 3 tests en total (uno por algoritmo); los 21 casos viven como `assertion` dentro de ellos (7 por algoritmo), todos pasando.
> **EN:** 3 tests in total (one per algorithm); the 21 cases live as `assertion`s within them (7 per algorithm), all passing.

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Algoritmo | Predicado | Helper | Entrada ordenada | Entrada invertida |
|-----------|-----------|--------|:----------------:|:-----------------:|
| Selection sort | `selection_sort/2` | `pick_min/3` | $O(n^2)$ | $O(n^2)$ |
| Bubble sort | `bubble_sort/2` | `bubble_pass/3` | $O(n)$ (salida temprana) | $O(n^2)$ |
| Insertion sort | `insertion_sort/2` | `insert/3` | $O(n)$ | $O(n^2)$ |

**ES:** Cada algoritmo tiene su propia estrategia: `selection_sort` busca el mínimo y lo retira, `bubble_sort` arrastra el mayor con pasadas sucesivas e `insertion_sort` inserta cada elemento en su sitio. No comparten helper.

**EN:** Each algorithm has its own strategy: `selection_sort` finds the minimum and removes it, `bubble_sort` pushes the maximum along with successive passes, and `insertion_sort` inserts every element into place. They share no helper.

### Casos cubiertos / Covered cases

| # | Entrada | Salida esperada |
|:-:|---------|-----------------|
| 1 | `[5, 2, 9, 1, 5, 6]` | `[1, 2, 5, 5, 6, 9]` |
| 2 | `[1, 2, 3, 4, 5]` | `[1, 2, 3, 4, 5]` |
| 3 | `[5, 4, 3, 2, 1]` | `[1, 2, 3, 4, 5]` |
| 4 | `[7, 7, 7, 7]` | `[7, 7, 7, 7]` |
| 5 | `[3, -1, 4, -5, 0]` | `[-5, -1, 0, 3, 4]` |
| 6 | `[42]` | `[42]` |
| 7 | `[]` | `[]` |

**ES:** Son los 7 casos obligatorios de la especificación. El **caso nulo se omite** (ver la nota correspondiente).

**EN:** These are the 7 mandatory cases from the specification. The **null case is omitted** (see the corresponding note).

---

## 📝 Notas de implementación / Implementation Notes

### 🧬 Listas inmutables: se devuelve una lista nueva / Immutable lists: a new list is returned

**ES:** La especificación pide el ordenamiento *in-place*, pero las listas de Prolog son **inmutables** y el lenguaje no tiene asignación, así que ningún algoritmo puede reordenar la lista recibida. La especificación admite explícitamente la alternativa («de forma in-place o retornando una copia ordenada según el paradigma del lenguaje»), de modo que los tres predicados construyen y devuelven una **lista nueva** y la de entrada queda intacta. Por eso los tests **no necesitan copiar** el fixture: es imposible que un caso contamine al siguiente.

**EN:** The specification asks for an *in-place* sort, but Prolog lists are **immutable** and the language has no assignment, so no algorithm can reorder the received list. The specification explicitly allows the alternative ("in-place or returning a sorted copy depending on the language paradigm"), so all three predicates build and return a **new list** and the input one is left untouched. That is why the tests **need no copy** of the fixture: a case cannot contaminate the next one.

### 🚫 Caso nulo omitido / Null case omitted

**ES:** La especificación pide devolver un indicador de fallo si la entrada es nula o inválida. En Prolog el array es una **lista** y una lista no admite `null` ni una entrada nula, así que el caso no es representable en la firma. La representación alternativa que menciona la especificación (`Option`/`Maybe` vacío o `Result` de error) queda fuera de alcance porque esta fase todavía no introduce ese tipo. Se conservan los 7 casos obligatorios, y el array vacío se prueba como caso 7.

**EN:** The specification asks for a failure indicator when the input is null or invalid. In Prolog the array is a **list** and a list admits neither `null` nor a null input, so the case is not representable in the signature. The alternative representation the specification mentions (empty `Option`/`Maybe` or error `Result`) is out of scope because this phase does not introduce that type yet. The 7 mandatory cases are kept, and the empty array is tested as case 7.

### 🎯 `pick_min/3`: búsqueda explícita del mínimo / explicit minimum search

**ES:** El pseudocódigo de `selection_sort` recorre el tramo no ordenado buscando el mínimo (`min_idx`) y lo intercambia con el primero. Sobre listas inmutables no hay intercambio posible, así que la adaptación idiomática es **retirar** el mínimo y ponerlo al frente: `smallest/3` recorre la lista comparando con el mejor candidato, y `remove_first/3` retira su primera aparición conservando el orden del resto. La estrategia observable es la misma del pseudocódigo —mínimo al inicio, recursión sobre el resto— y el coste se mantiene $O(n^2)$.

**EN:** The pseudocode of `selection_sort` walks the unsorted part looking for the minimum (`min_idx`) and swaps it with the first element. Over immutable lists no swap is possible, so the idiomatic adaptation is to **remove** the minimum and put it in front: `smallest/3` walks the list comparing against the best candidate, and `remove_first/3` removes its first occurrence while preserving the order of the rest. The observable strategy is the pseudocode's — minimum first, recursion over the rest — and the cost stays $O(n^2)$.

### 🔁 `bubble_pass/3` y la bandera de intercambio / `bubble_pass/3` and the swap flag

**ES:** `bubble_sort` mantiene la optimización de salida temprana que exige la especificación, pero en lugar de una variable `swapped` la bandera viaja como **tercer argumento** del helper: `bubble_pass/3` compara pares adyacentes, arrastra el mayor al final de la lista y devuelve `true` si la pasada intercambió algo. El bucle exterior solo vuelve a iterar si la bandera es `true`, que es el `if not swapped then break` del pseudocódigo. Verificado de forma aislada: `bubble_pass([1,2,3,4,5], _, Flag)` da `Flag = false`, así que una lista ya ordenada se resuelve en una sola pasada y el mejor caso es $O(n)$.

**EN:** `bubble_sort` keeps the early-exit optimisation the specification requires, but instead of a `swapped` variable the flag travels as the helper's **third argument**: `bubble_pass/3` compares adjacent pairs, pushes the maximum to the end of the list and returns `true` if the pass swapped anything. The outer loop only iterates again when the flag is `true`, which is the pseudocode's `if not swapped then break`. Verified in isolation: `bubble_pass([1,2,3,4,5], _, Flag)` gives `Flag = false`, so an already sorted list is solved in a single pass and the best case is $O(n)$.

### ✂️ Cortes después de la guarda / Cuts after the guard

**ES:** Los predicados auxiliares usan `!` para ser deterministas y evitar que plunit avise de «Test succeeded with choicepoint». El corte va **siempre después** de la guarda (`X > Y, !, …`): ponerlo antes compromete la cláusula antes de comprobar la condición y el predicado ya no puede recaer en la cláusula siguiente.

**EN:** The auxiliary predicates use `!` to be deterministic and avoid plunit's "Test succeeded with choicepoint" warning. The cut always comes **after** the guard (`X > Y, !, …`): putting it before commits the clause before checking the condition, and the predicate can no longer fall through to the next clause.

### 🔀 Estabilidad de `insertion_sort` / `insertion_sort` stability

**ES:** `insert/3` coloca el elemento delante del primer mayor o igual (`X =< Y`), de modo que los elementos iguales conservan su orden relativo y `insertion_sort` es estable. El caso 1 (`[5, 2, 9, 1, 5, 6]`, con dos cincos) se beneficia de ello, aunque la comparación de los tests se hace sobre valores y no sobre identidad.

**EN:** `insert/3` places the element before the first greater-or-equal one (`X =< Y`), so equal elements keep their relative order and `insertion_sort` is stable. Case 1 (`[5, 2, 9, 1, 5, 6]`, with two fives) benefits from it, although the tests compare values rather than identity.

### 🏷️ Naming y visibilidad / Naming and visibility

**ES:** Los predicados usan `snake_case` (`selection_sort`), que es a la vez la convención de Prolog y el nombre que emplea la especificación, así que la API coincide con el contrato sin traducciones. Todos los predicados del fichero son públicos a nivel de módulo, pero la suite solo usa los tres del contrato; los helpers son detalles internos. No hay `main()`: el punto de entrada es la directiva `initialization/2` que llama a `run_tests/1`.

**EN:** Predicates use `snake_case` (`selection_sort`), which is both Prolog's convention and the name used by the specification, so the API matches the contract with no translation. Every predicate in the file is public at module level, but the suite only uses the three contract ones; the helpers are internal details. There is no `main()`: the entry point is the `initialization/2` directive that calls `run_tests/1`.

### 🧪 Estructura de los tests / Test structure

**ES:** Una única suite con 3 `test(...)`. Dos detalles importantes: (1) plunit **no admite un mensaje** en `assertion/1` (en SWI 10.0.2 no existen `assertion/2` ni `assertion/3`), así que el mensaje del contrato viaja como el propio *goal* de la aserción: `assertion(should_sort(Algorithm, Description, Actual, Expected))`, y al fallar plunit imprime `Assertion: user:should_sort(selection_sort,an_unsorted_array,[9,6,5,5,2,1],[1,2,5,5,6,9])`; (2) plunit informa de **todas** las aserciones fallidas de un test, no solo de la primera, lo que hace visible de una vez qué casos se rompen.

**EN:** A single suite with 3 `test(...)`. Two important details: (1) plunit **takes no message** in `assertion/1` (SWI 10.0.2 has neither `assertion/2` nor `assertion/3`), so the contract message travels as the assertion's own *goal*: `assertion(should_sort(Algorithm, Description, Actual, Expected))`, and on failure plunit prints `Assertion: user:should_sort(selection_sort,an_unsorted_array,[9,6,5,5,2,1],[1,2,5,5,6,9])`; (2) plunit reports **every** failed assertion of a test, not just the first, which makes all broken cases visible at once.

```prolog
:- begin_tests(naive_sort_tests).

test(selection_sort) :-
    assert_sorts_all_cases(selection_sort, selection_sort).

test(bubble_sort) :-
    assert_sorts_all_cases(bubble_sort, bubble_sort).

test(insertion_sort) :-
    assert_sorts_all_cases(insertion_sort, insertion_sort).

:- end_tests(naive_sort_tests).
```

### 📍 Desviaciones respecto a la ubicación esperada / Deviations from the expected location

| Especificación | Implementación | Motivo |
|----------------|----------------|--------|
| `src/naive_sort.ext` | `src/naive_sort.pl` | El nombre coincide exactamente; solo cambia la extensión. |
| `test/naive_sort_test.ext` | `test/naive_sort_tests.pl` | La convención de `numbers/` para las suites es el sufijo plural `_tests.pl` (`recursive_tests.pl`, `iterative_tests.pl`). |
| `test/run_tests.ext` | *(no existe)* | La suite se ejecuta a sí misma con `:- initialization(run_tests(naive_sort_tests), main).`, que es el runner. Ni `numbers/` ni `calculator/` incluyen un fichero aparte. |

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

*[← Volver a Algoritmos Puros](../README.md) · [↑ Volver a Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
