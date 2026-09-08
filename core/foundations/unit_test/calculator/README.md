# Calculator — Prolog

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Prolog**, usando **plunit** (SWI-Prolog) como framework de pruebas unitarias.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/calculator.pl`](src/calculator.pl) | Base de conocimiento con las 5 operaciones aritméticas como predicados `X/3`. |
| [`test/calculator_test.pl`](test/calculator_test.pl) | Suite plunit con 5 `test(...)` y runner integrado (`initialization(..., main)`). |

**Estructura de directorios esperada:**

```text
calculator/
├── src/
│   └── calculator.pl            # 5 predicados aritméticos
└── test/
    └── calculator_test.pl       # 5 tests con plunit
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **plunit**, la librería de pruebas unitarias incluida con SWI-Prolog:

1. Cada operación es un predicado de aridad 3 (`operación(A, B, Resultado)`), la forma idiomática de "devolver" valores en Prolog (vía unificación).
2. Cada prueba es un `test(nombre)` dentro de `begin_tests/end_tests` y verifica con `assertion`.
3. El runner es el propio plunit: `:- initialization(run_tests(calculator_test), main)` ejecuta la suite al cargar el archivo; no se necesita un `run_tests` propio (la especificación lo pide solo si el framework no lo incluye).
4. `multiplication`, `division` y `modulus` se implementan con las estrategias educativas de la especificación (sin usar los operadores `*`, `/` ni `mod` respectivamente).

**EN:** This project uses **plunit**, the unit testing library bundled with SWI-Prolog:

1. Each operation is an arity-3 predicate (`operation(A, B, Result)`), the idiomatic way of "returning" values in Prolog (via unification).
2. Each test is a `test(name)` inside `begin_tests/end_tests` and verifies with `assertion`.
3. The runner is plunit itself: `:- initialization(run_tests(calculator_test), main)` runs the suite when the file is loaded; no custom `run_tests` is needed (the specification asks for it only if the framework doesn't include one).
4. `multiplication`, `division` and `modulus` are implemented with the educational strategies from the specification (without using the `*`, `/` or `mod` operators respectively).

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build: la suite se ejecuta directamente con `swipl`.

### `src/calculator.pl` — Módulo principal

| Operación | Implementación educativa |
| --------- | ------------------------ |
| `addition(A, B, R)` | Suma directa (`is` con `+`). |
| `subtraction(A, B, R)` | Resta directa (`is` con `-`). |
| `multiplication(A, B, R)` | Suma repetitiva: acumula `A`, `B` veces (no usa `*`). |
| `division(A, B, R)` | Resta repetitiva: resta `B` de `A` mientras `A >= B` (no usa `/`). |
| `modulus(A, B, R)` | Construida sobre `division` y `multiplication` (no usa `mod`). |

```prolog
addition(A, B, Result) :- Result is A + B.

subtraction(A, B, Result) :- Result is A - B.

multiplication(A, B, Result) :-
    multiplication_loop(B, 0, A, Result).

multiplication_loop(N, Acc, A, Result) :-
    (   N =< 0
    ->  Result = Acc
    ;   N1 is N - 1,
        addition(Acc, A, Acc1),
        multiplication_loop(N1, Acc1, A, Result)
    ).

division(A, B, Quotient) :-
    division_loop(A, B, 0, Quotient).

division_loop(A, B, Acc, Quotient) :-
    (   A < B
    ->  Quotient = Acc
    ;   subtraction(A, B, A1),
        addition(Acc, 1, Acc1),
        division_loop(A1, B, Acc1, Quotient)
    ).

modulus(A, B, Result) :-
    division(A, B, Q),
    multiplication(Q, B, P),
    subtraction(A, P, Result).
```

### `test/calculator_test.pl` — Pruebas unitarias (plunit)

**ES:** Un `test` por operación, con los mismos casos del pseudocódigo de la especificación.

**EN:** One `test` per operation, with the same cases as the specification pseudocode.

```prolog
:- use_module(library(plunit)).
:- consult('../src/calculator.pl').

:- begin_tests(calculator_test).

test(addition) :-
    addition(2, 3, Result),
    assertion(Result == 5).

test(subtraction) :-
    subtraction(5, 2, Result),
    assertion(Result == 3).

test(multiplication) :-
    multiplication(3, 4, Result),
    assertion(Result == 12).

test(division) :-
    division(10, 3, Result),
    assertion(Result == 3).

test(modulus) :-
    modulus(10, 3, Result),
    assertion(Result == 1).

:- end_tests(calculator_test).

:- initialization(run_tests(calculator_test), main).
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
cd prolog/core/foundations/unit_test/calculator/test
swipl -q -f calculator_test.pl
```

### Salida esperada / Expected output

```text
% Start unit: calculator_test
% [1/5] calculator_test:addition .................... passed (0.003 sec)
% [2/5] calculator_test:subtraction ................. passed (0.000 sec)
% [3/5] calculator_test:multiplication .............. passed (0.000 sec)
% [4/5] calculator_test:division .................... passed (0.000 sec)
% [5/5] calculator_test:modulus ..................... passed (0.000 sec)
% End unit calculator_test: passed (0.005 sec CPU)
% All 5 tests passed in 0.007 seconds (0.007 cpu)
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** En Prolog no hay funciones con retorno: los resultados "se devuelven" unificando el último argumento de cada predicado.
- **EN:** In Prolog there are no return values: results are "returned" by unifying the last argument of each predicate.
- **ES:** Los bucles recursivos usan if-then-else (`-> ;`) para ser deterministas; así plunit no reporta choicepoints pendientes.
- **EN:** The recursive loops use if-then-else (`-> ;`) to be deterministic; that way plunit reports no pending choicepoints.
- **ES:** `division` no valida `B == 0` (fuera del alcance de este ejemplo, como indica la especificación). `==` en SWI-Prolog es igualdad aritmética.
- **EN:** `division` does not validate `B == 0` (out of scope for this example, as the specification states). `==` in SWI-Prolog is arithmetic equality.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
