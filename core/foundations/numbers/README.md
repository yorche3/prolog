# Numbers — Prolog

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Prolog**, usando **plunit** (SWI-Prolog) como framework de pruebas unitarias.

Tres enfoques de implementación para los mismos 5 algoritmos: **recursivo directo** (`_rec`), **recursivo con acumulador** (`_acc`) e **iterativo** (`_ite`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/numbers.pl`](src/numbers.pl) | Base de conocimiento: 15 predicados (3 enfoques × 5 algoritmos) + 4 helpers `_help`. |
| [`test/recursive_tests.pl`](test/recursive_tests.pl) | Suite recursiva: 5 tests (11 casos). |
| [`test/recursive_with_acc_tests.pl`](test/recursive_with_acc_tests.pl) | Suite con acumulador: 5 tests (11 casos). |
| [`test/iterative_tests.pl`](test/iterative_tests.pl) | Suite iterativa: 5 tests (11 casos). |

**Estructura de directorios esperada:**

```text
numbers/
├── src/
│   └── numbers.pl                       # 15 predicados + 4 helpers _help
└── test/
    ├── recursive_tests.pl               # Tests recursivos (5 tests, 11 casos)
    ├── recursive_with_acc_tests.pl      # Tests con acumulador (5 tests, 11 casos)
    └── iterative_tests.pl               # Tests iterativos (5 tests, 11 casos)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Sigue el mismo patrón que [`calculator`](../unit_test/calculator/): base de conocimiento en `src/`, suites plunit en `test/` con `subtest`-equivalente (un `test(...)` por función, con sus casos dentro). Los 15 predicados se organizan en 3 grupos por enfoque:

| Enfoque | Sufijo | Ejemplo | ¿Tiene tests directos? |
| ------- | ------ | ------- | :---------------------: |
| Recursivo directo | `_rec` | `fibonacci_rec(N, R)` | ✅ Sí |
| Recursivo con acumulador | `_acc` | `fibonacci_acc(N, R)` | ✅ Sí (ver nota TCO) |
| Iterativo | `_ite` | `fibonacci_ite(N, R)` | ✅ Sí |

**EN:** Follows the same pattern as [`calculator`](../unit_test/calculator/): a knowledge base in `src/`, plunit suites in `test/` (one `test(...)` per function, with its cases inside). The 15 predicates are organized into 3 groups by approach:

| Approach | Suffix | Example | Direct tests? |
| -------- | ------ | ------- | :-----------: |
| Direct recursion | `_rec` | `fibonacci_rec(N, R)` | ✅ Yes |
| Accumulator recursion | `_acc` | `fibonacci_acc(N, R)` | ✅ Yes (see TCO note) |
| Iterative | `_ite` | `fibonacci_ite(N, R)` | ✅ Yes |

**Combinación aplicada:** TCO ✅ + iteración ✅ → `_rec` + `_acc` + `_ite` = **3 suites × 5 tests = 15 tests (33 casos)**.

**Applied combination:** TCO ✅ + iteration ✅ → `_rec` + `_acc` + `_ite` = **3 suites × 5 tests = 15 tests (33 cases)**.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build: las suites se ejecutan directamente con `swipl`.

### `src/numbers.pl` — Implementación

**ES:** Cada algoritmo tiene 3 implementaciones en un único archivo. Los helpers del enfoque con acumulador llevan el sufijo `_help` (privados por convención). Por ejemplo, `fibonacci`:

**EN:** Each algorithm has 3 implementations in a single file. The accumulator helpers carry the `_help` suffix (private by convention). For example, `fibonacci`:

```prolog
% Enfoque recursivo directo / Direct recursion
fibonacci_rec(N, Result) :-
    N =< 1, !,
    Result = N.
fibonacci_rec(N, Result) :-
    N1 is N - 1,
    N2 is N - 2,
    fibonacci_rec(N1, F1),
    fibonacci_rec(N2, F2),
    Result is F1 + F2.

% Enfoque con acumulador / Accumulator recursion
fibonacci_acc(N, Result) :-
    fibonacci_acc_help(N, 0, 1, Result), !.

fibonacci_acc_help(N, Acc2, _, Result) :-
    N =< 0, !,
    Result is Acc2.
fibonacci_acc_help(N, Acc2, Acc1, Result) :-
    N =< 2, !,
    Result is Acc1 + Acc2.
fibonacci_acc_help(N, Acc2, Acc1, Result) :-
    N1 is N - 1,
    fibonacci_acc_help(N1, Acc1, Acc1 + Acc2, Result), !.

% Enfoque iterativo / Iterative
fibonacci_ite(N, Result) :-
    (   N =< 1
    ->  Result = N
    ;   N1 is N - 1,
        numlist(1, N1, Steps),
        foldl(fibonacci_step, Steps, (0, 1), (_, Result))
    ).

fibonacci_step(_, (Acc2, Acc1), (Acc1, Result)) :-
    Result is Acc1 + Acc2.
```

| Algoritmo | `_rec` | `_acc` | `_ite` |
| --------- | ------ | ------ | ------ |
| `sum_of_first_n` | `N + sum_rec(N-1)` | helper con `Acc + N` (expresión) | `numlist` + `sum_list` |
| `factorial` | `N * fact_rec(N-1)` | helper con `Acc * N` (expresión) | `numlist` + `foldl` |
| `fibonacci` | `fib_rec(N-1) + fib_rec(N-2)` | helper con `Acc1 + Acc2` (expresión) | `foldl` con par de estado |
| `greatest_common_divisor` | Euclides (cláusulas + `!`) | helper (Euclides) | bucle `repeat` con `nb_setarg` |
| `least_common_multiple` | `(A/Gcd) * B` | `(A/Gcd) * B` | `(A/Gcd) * B` |

### Suites de pruebas — plunit

**ES:** Tres suites, una por enfoque. Cada suite agrupa un `test(...)` por función (5 por suite); los 11 casos del pseudocódigo viven como `assertion` dentro de ellos (33 en total).

**EN:** Three suites, one per approach. Each suite groups one `test(...)` per function (5 per suite); the specification pseudocode's 11 cases live as `assertion`s within them (33 in total).

```prolog
test(fibonacci_rec) :-
    fibonacci_rec(0, R1),
    assertion(R1 == 0),
    fibonacci_rec(1, R2),
    assertion(R2 == 1),
    fibonacci_rec(6, R3),
    assertion(R3 == 8).
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener SWI-Prolog instalado

```bash
# Verificar instalación
swipl --version
```

### Ejecutar las pruebas unitarias / Run tests

```bash
cd prolog/core/foundations/numbers/test
swipl -q -f recursive_tests.pl -t halt
swipl -q -f recursive_with_acc_tests.pl -t halt
swipl -q -f iterative_tests.pl -t halt
```

### Salida esperada / Expected output

```text
% Start unit: recursive_tests
% [1/5] recursive_tests:sum_of_first_n_rec ......... passed (0.003 sec)
% [2/5] recursive_tests:factorial_rec .............. passed (0.000 sec)
% [3/5] recursive_tests:fibonacci_rec .............. passed (0.000 sec)
% [4/5] recursive_tests:greatest_common_divisor_rec  passed (0.000 sec)
% [5/5] recursive_tests:least_common_multiple_rec .. passed (0.000 sec)
% End unit recursive_tests: passed (0.005 sec CPU)
% All 5 tests passed
```

> **ES:** 15 tests en total (5 por suite); los 33 casos viven como `assertion` dentro de ellos, todos pasando.
> **EN:** 15 tests in total (5 per suite); the 33 cases live as `assertion`s within them, all passing.

---

## 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO)

**ES:**
Tail recursion ocurre cuando la llamada recursiva es la última acción que ejecuta un predicado; después de la llamada no hay más instrucciones. La recursión con acumulador consigue esto pasando el estado previo como parámetro, sin dejar trabajo pendiente en la pila.

En Prolog, **sí se garantiza TCO** mediante **last-call optimization (LCO)**: la recursión de cola determinista se compila a un bucle con pila constante. De hecho, en Prolog la recursión de cola ES el mecanismo idiomático de iteración. Por eso **sí se desarrollan pruebas unitarias específicas para los predicados `_acc`** (5 tests, 11 casos).

**EN:**
Tail recursion occurs when the recursive call is the last action executed by a predicate; after the call there are no more instructions. Accumulator recursion achieves this by passing the previous state as a parameter, leaving no pending work on the stack.

In Prolog, **TCO is guaranteed** through **last-call optimization (LCO)**: deterministic tail recursion compiles to a loop with constant stack. In fact, in Prolog tail recursion IS the idiomatic iteration mechanism. This is why **dedicated unit tests are written for the `_acc` predicates** (5 tests, 11 cases).

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El proyecto no usa un `main`: el "punto de entrada" es el propio runner de plunit (`:- initialization(run_tests(...), main)` en cada suite). Por eso no se necesita el `run_tests` del pseudocódigo (la especificación lo pide solo si el framework no lo incluye).
- **EN:** The project has no `main`: the "entry point" is plunit's runner itself (`:- initialization(run_tests(...), main)` in each suite). That's why the pseudocode's `run_tests` is not needed (the specification asks for it only if the framework doesn't include one).
- **ES:** El enfoque `_ite` usa los combinadores iterativos nativos de SWI: `numlist/3`, `sum_list/2` (library(lists)) y `foldl/4` (library(apply)); el MCD traduce el `while` del pseudocódigo a un bucle `repeat` + `nb_setarg` (asignación no deshecha por backtracking).
- **EN:** The `_ite` approach uses SWI's native iterative combinators: `numlist/3`, `sum_list/2` (library(lists)) and `foldl/4` (library(apply)); GCD translates the pseudocode's `while` into a `repeat` + `nb_setarg` loop (assignment not undone by backtracking).
- **ES:** Los helpers `_acc` pasan el acumulador como **expresión sin evaluar** (`Acc + N`, `Acc * N`, `Acc1 + Acc2`), que se evalúa con `is` en la cláusula base — el patrón idiomático de Prolog.
- **EN:** The `_acc` helpers pass the accumulator as an **unevaluated expression** (`Acc + N`, `Acc * N`, `Acc1 + Acc2`), evaluated with `is` in the base clause — the idiomatic Prolog pattern.
- **ES:** El MCM usa `(A / Gcd) * B`; `/` produce flotante, pero `==` (igualdad aritmética en SWI) compara enteros y flotantes por valor.
- **EN:** LCM uses `(A / Gcd) * B`; `/` produces a float, but `==` (arithmetic equality in SWI) compares integers and floats by value.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
