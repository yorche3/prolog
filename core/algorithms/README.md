# Algorithms Pure — Prolog

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Prolog**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre **listas**, que en Prolog **son inmutables**, **se recorren recursivamente** y **no admiten `null`**.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `swipl -q -f` + plunit | 3 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                      # 05_Naive_Sort
    ├── .gitignore                   # Ignora *.qlf
    ├── src/
    │   └── naive_sort.pl            # 3 predicados del contrato + 4 helpers
    ├── test/
    │   └── naive_sort_tests.pl      # 3 tests × 7 casos
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | SWI-Prolog 10.x (intérprete, sin paso de compilación) |
| **CLI** | `swipl -q -f test/{modulo}_tests.pl -t halt` |
| **Andamiaje** | Manual: ✍️ `mkdir -p src test`; no hay comando de inicialización |
| **Framework de tests** | plunit, de la biblioteca estándar de SWI (`library(plunit)`) |
| **Runner** | La directiva `:- initialization(run_tests(unidad), main).` al final de la suite; no hay fichero aparte |
| **Separación** | `src/{modulo}.pl` (base de conocimiento) ↔ `test/` (suites `*_tests.pl`) |
| **Acceso al módulo** | `:- consult('../src/{modulo}.pl').` al inicio de la suite; SWI resuelve la ruta relativa al fichero que la carga |
| **Iteración** | Recursión; Prolog no tiene bucles ni asignación |
| **Indexación** | No aplica: se trabaja con listas y recursión, no con índices |
| **API** | Predicados con el resultado como último argumento: `predicado(+Arr, -Sorted)` |
| **Inmutabilidad** | Las listas no se pueden mutar, así que se devuelve una lista nueva; los tests no necesitan copiar el fixture |
| **Naming** | `snake_case` para predicados (`selection_sort`), igual que la especificación, con el array como `Arr` (el `arr` de la documentación) |
| **Nulabilidad** | Una lista no admite `null`; el caso nulo no es representable y se omite |
| **Mensajes de aserción** | plunit no admite mensaje en `assertion/1`, así que el contrato viaja como el goal `should_sort/4` que plunit imprime al fallar |
| **Determinismo** | `!` **después** de la guarda, para no dejar choicepoints (`Test succeeded with choicepoint`) |
| **Verificación estática** | `swipl -q -g "consult('src/{modulo}.pl'), halt"`, que avisa de variables singulares y cláusulas mal formadas |
| **Artefactos** | `*.qlf` (compilación con `qcompile/1`) — ignorados por el `.gitignore` del módulo |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort/test
swipl -q -f naive_sort_tests.pl -t halt
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
