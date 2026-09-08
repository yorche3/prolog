# 🚀 Fundamentos / Foundations — Prolog

Implementación de los ejercicios de la sección [Fundamentos / Foundations](https://yorche3.github.io/programming_languages/core/foundations/) del repositorio principal en **Prolog (SWI-Prolog)**.

---

## 📖 Descripción / Description

**ES:** Esta sección reúne los conceptos esenciales para empezar a trabajar con **Prolog**. Cubre desde los programas más básicos (`Hello, World!` y `Hello, User!`) hasta la implementación de una calculadora con pruebas unitarias y algoritmos numéricos en tres enfoques progresivos (recursivo directo, recursivo con acumulador e iterativo).

**EN:** This section brings together the essential concepts to start working with **Prolog**. It covers everything from the most basic programs (`Hello, World!` and `Hello, User!`) to the implementation of a calculator with unit tests and numerical algorithms in three progressive approaches (direct recursion, accumulator recursion, and iterative).

---

## 📁 Estructura / Structure

```text
prolog/
└── core/
    └── foundations/
        ├── README.md              # Este archivo / This file
        ├── helloworld/            # 01_Hello_World — Primer programa
        │   ├── helloworld.pl
        │   └── README.md
        ├── hellouser/             # 02_Hello_User — Entrada y salida
        │   ├── hellouser.pl
        │   └── README.md
        ├── unit_test/
        │   └── calculator/        # 03_Unit_Test_Calculator — Pruebas unitarias
        │       ├── src/
        │       │   └── calculator.pl
        │       ├── test/
        │       │   └── calculator_test.pl
        │       └── README.md
        └── numbers/               # 04_Numbers — Algoritmos numéricos
            ├── src/
            │   └── numbers.pl
            ├── test/
            │   ├── recursive_tests.pl
            │   ├── recursive_with_acc_tests.pl
            │   └── iterative_tests.pl
            └── README.md
```

---

## 🔢 Progresión / Progression

| Especificación | Proyecto | Conceptos | Tests | Dependencias externas |
| -------------- | -------- | --------- | :---: | :-------------------: |
| [`01_Hello_World`](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | Regla `hello/0`, `format/2`, consulta de goals | — | ❌ Solo stdlib |
| [`02_Hello_User`](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | `write`, `read_line_to_string/2`, unificación | — | ❌ Solo stdlib |
| [`03_Unit_Test_Calculator`](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | plunit, `begin_tests`/`end_tests`, `assertion`, bucles deterministas | 5 | ❌ Solo stdlib |
| [`04_Numbers`](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | Recursión, acumuladores, combinadores iterativos, LCO | 15 | ❌ Solo stdlib |

---

## 🛠️ Enfoque general / General Approach

**ES:** Los proyectos en esta sección siguen un patrón progresivo:

1. **Hello World** y **Hello User**: Programas de un solo archivo con una regla, ejecutados consultando un objetivo (`swipl -g <goal>`). Usan exclusivamente la biblioteca estándar.
2. **Calculator**: Primer proyecto con suite de pruebas (**plunit**, incluido con SWI-Prolog). Introduce la separación `src/` + `test/` y el runner de plunit (`initialization(run_tests(...), main)`).
3. **Numbers**: Expande el patrón de Calculator a tres suites de prueba (una por enfoque). Prolog **sí garantiza TCO** mediante **LCO** (last-call optimization), por lo que los tres enfoques (`_rec`, `_acc`, `_ite`) tienen pruebas directas: 15 tests (33 casos).

**EN:** The projects in this section follow a progressive pattern:

1. **Hello World** and **Hello User**: Single-file programs with one rule, run by querying a goal (`swipl -g <goal>`). Use only the standard library.
2. **Calculator**: First project with a test suite (**plunit**, bundled with SWI-Prolog). Introduces the `src/` + `test/` separation and plunit's runner (`initialization(run_tests(...), main)`).
3. **Numbers**: Expands the Calculator pattern to three test suites (one per approach). Prolog **does guarantee TCO** through **LCO** (last-call optimization), so all three approaches (`_rec`, `_acc`, `_ite`) have direct tests: 15 tests (33 cases).

---

## 🚀 Ejecución rápida / Quick Start

### Hello World

```bash
cd prolog/core/foundations/helloworld
swipl -q -g hello -t halt helloworld.pl
```

### Hello User

```bash
cd prolog/core/foundations/hellouser
swipl -q -g hellouser -t halt hellouser.pl
```

### Calculator (pruebas)

```bash
cd prolog/core/foundations/unit_test/calculator/test
swipl -q -f calculator_test.pl -t halt
```

### Numbers (pruebas)

```bash
cd prolog/core/foundations/numbers/test
swipl -q -f recursive_tests.pl -t halt
swipl -q -f recursive_with_acc_tests.pl -t halt
swipl -q -f iterative_tests.pl -t halt
```

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
