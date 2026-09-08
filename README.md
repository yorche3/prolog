# Prolog

Proyectos en **Prolog (SWI-Prolog)**, con programas simples ejecutados consultando objetivos con `swipl` y proyectos con pruebas unitarias usando **plunit** (incluido con SWI-Prolog).

---

## 📂 Módulos / Modules

| Módulo | Descripción |
| ------ | ----------- |
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `unit_test/calculator`, `numbers` |

---

## ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
swipl -q -g hello -t halt helloworld.pl

# Hello, User!
cd core/foundations/hellouser
swipl -q -g hellouser -t halt hellouser.pl

# Calculator Tests
cd core/foundations/unit_test/calculator/test
swipl -q -f calculator_test.pl -t halt

# Numbers Tests
cd core/foundations/numbers/test
swipl -q -f recursive_tests.pl -t halt
swipl -q -f recursive_with_acc_tests.pl -t halt
swipl -q -f iterative_tests.pl -t halt
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
| ----------- | ----------- |
| [SWI-Prolog](https://www.swi-prolog.org/) | `sudo apt install swi-prolog` (Linux) / [Descargar](https://www.swi-prolog.org/Download.html) |

```bash
# Verificar instalación
swipl --version
```

> **ES:** `plunit` viene incluido con SWI-Prolog; no hay dependencias externas.
> **EN:** `plunit` ships with SWI-Prolog; there are no external dependencies.

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Programa simple (consulta de un objetivo)

**ES:** Un único archivo fuente con una base de conocimiento (hechos y reglas), ejecutado consultando un objetivo con `swipl -g <goal> -t halt`. Ideal para `helloworld` y `hellouser`.

**EN:** A single source file with a knowledge base (facts and rules), run by querying a goal with `swipl -g <goal> -t halt`. Ideal for `helloworld` and `hellouser`.

```bash
swipl -q -g <goal> -t halt <File>.pl   # ejecutar y salir
swipl <File>.pl                        # modo interactivo (consulta ?- <goal>.)
```

### 2. Proyecto con pruebas unitarias (plunit)

**ES:** Para proyectos que requieren pruebas unitarias, se usa **plunit** (`begin_tests`/`end_tests`, `test(...)`, `assertion`) con el runner integrado (`:- initialization(run_tests(...), main)`). El código fuente se organiza en `src/` y las pruebas en `test/`.

**EN:** For projects that require unit tests, **plunit** (`begin_tests`/`end_tests`, `test(...)`, `assertion`) is used with its built-in runner (`:- initialization(run_tests(...), main)`). Source code goes in `src/` and tests in `test/`.

```bash
swipl -q -f <suite>.pl -t halt        # ejecutar una suite
```

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*