# Hello, World! — Prolog

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Prolog**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`helloworld.pl`](helloworld.pl) | Código fuente: define la regla `hello/0` que imprime `"Hello, World! from Prolog"`. |

**Estructura de directorios esperada:**

```text
helloworld/
├── helloworld.pl   # Código fuente
└── README.md       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. Un único archivo `.pl` con una regla es suficiente: Prolog es declarativo, por lo que el "programa" es una base de conocimiento y la ejecución consiste en lanzar una consulta (`goal`) contra ella.

**EN:** The project was created manually, without scaffolding tools. A single `.pl` file with one rule is enough: Prolog is declarative, so the "program" is a knowledge base and execution consists of launching a query (goal) against it.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p prolog/core/foundations/helloworld
   ```

2. Escribir el archivo `helloworld.pl` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `swipl` (SWI-Prolog).

```prolog
hello :- format('Hello, World! from Prolog~n').
```

| Elemento | Propósito |
|----------|-----------|
| `hello` | Cabeza de la regla: un predicado `hello/0` (sin argumentos) que se cumple cuando su cuerpo se cumple. |
| `:-` | Operador de implicación inversa: "si se cumple el cuerpo, se cumple la cabeza". |
| `format('...~n')` | Imprime en la salida estándar; `~n` es el salto de línea en el formato de Prolog. |

> **ES:** `format/2` es análogo a `printf` en C: el primer argumento es la plantilla y `~n` produce un salto de línea (`~w` escribe un término, `~s` una cadena).
> **EN:** `format/2` is analogous to C's `printf`: the first argument is the template and `~n` produces a newline (`~w` writes a term, `~s` a string).

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener SWI-Prolog instalado

```bash
# Verificar instalación
swipl --version
```

### Ejecutar con un goal / Run with a goal

```bash
cd prolog/core/foundations/helloworld
swipl -q -g hello -t halt helloworld.pl
```

### Alternativa equivalente / Equivalent alternative

```bash
swipl -q -f helloworld.pl -g "hello, halt"
```

### Ejecutar interactivamente / Run interactively

```bash
cd prolog/core/foundations/helloworld
swipl helloworld.pl
```

```prolog
?- hello.
Hello, World! from Prolog
true.
```

### Salida esperada / Expected output

```text
Hello, World! from Prolog
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Prolog no tiene una función `main`: la ejecución es la consulta de un objetivo (`-g hello`) que se resuelve contra las reglas del archivo.
- **EN:** Prolog has no `main` function: execution is the query of a goal (`-g hello`) resolved against the file's rules.
- **ES:** El `true.` de la salida interactiva indica que la consulta se cumplió (la regla tiene éxito).
- **EN:** The interactive `true.` indicates the query succeeded (the rule succeeds).

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
