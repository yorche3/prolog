# Hello, User! — Prolog

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Prolog**, con un enfoque manual y minimalista.

Lee un nombre desde la entrada estándar y saluda al usuario.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hellouser.pl`](hellouser.pl) | Código fuente: define la regla `hellouser/0` que solicita un nombre y saluda. |

**Estructura de directorios esperada:**

```text
hellouser/
├── hellouser.pl    # Código fuente
└── README.md       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce tres conceptos nuevos respecto a `helloworld`:

1. **Escritura sin salto de línea** — `write` imprime el prompt dejando el cursor en la misma línea.
2. **Entrada de usuario** — `read_line_to_string/2` lee una línea desde la entrada estándar y la unifica con una variable.
3. **Unificación y formato** — `Name` es una variable lógica que se unifica con la línea leída, y `format/2` la escribe con `~w`.

**EN:** This program introduces three new concepts compared to `helloworld`:

1. **Writing without newline** — `write` prints the prompt leaving the cursor on the same line.
2. **User input** — `read_line_to_string/2` reads a line from standard input and unifies it with a variable.
3. **Unification and formatting** — `Name` is a logical variable unified with the read line, and `format/2` writes it with `~w`.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p prolog/core/foundations/hellouser
   ```

2. Escribir el archivo `hellouser.pl` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `swipl` (SWI-Prolog).

**ES:** El flujo del programa es:

1. Imprimir `"Enter your name: "` con `write` (sin salto de línea).
2. Leer una línea desde `stdin` con `read_line_to_string/2`, unificándola con `Name`.
3. Imprimir `"Hello, <nombre>!"` con `format/2` usando `~w`.

**EN:** Program flow:

1. Print `"Enter your name: "` with `write` (no newline).
2. Read a line from `stdin` with `read_line_to_string/2`, unifying it with `Name`.
3. Print `"Hello, <name>!"` with `format/2` using `~w`.

```prolog
hellouser :-
    write('Enter your name: '),
    read_line_to_string(current_input, Name),

    format('Hello, ~w!~n', [Name]).
```

| Elemento | Propósito |
|----------|-----------|
| `write('...')` | Imprime en la salida estándar **sin** salto de línea al final (el cursor permanece junto al prompt). |
| `read_line_to_string(current_input, Name)` | Lee una línea desde la entrada estándar y unifica la variable `Name` con ella (sin el salto de línea final). |
| `Name` | Variable lógica: se instancia con la línea leída; las variables en Prolog empiezan con mayúscula. |
| `format('Hello, ~w!~n', [Name])` | Imprime con formato: `~w` escribe el término (aquí la cadena `Name`) y `~n` añade el salto de línea. |

> **ES:** En Prolog no hay "asignación": `read_line_to_string/2` unifica `Name` con el valor leído. Una variable unificada no puede reasignarse.
> **EN:** In Prolog there is no "assignment": `read_line_to_string/2` unifies `Name` with the read value. A unified variable cannot be reassigned.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener SWI-Prolog instalado

```bash
# Verificar instalación
swipl --version
```

### Ejecutar con un goal / Run with a goal

```bash
cd prolog/core/foundations/hellouser
swipl -q -g hellouser -t halt hellouser.pl
```

### Ejecutar interactivamente / Run interactively

```bash
cd prolog/core/foundations/hellouser
swipl hellouser.pl
```

```prolog
?- hellouser.
Enter your name: Ada
Hello, Ada!
true.
```

### Salida esperada / Expected output

```text
Enter your name: Ada
Hello, Ada!
```

> **ES:** El programa espera a que el usuario escriba su nombre y presione Enter antes de mostrar el saludo.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Prolog no tiene una función `main`: la ejecución es la consulta de un objetivo (`-g hellouser`) contra la base de conocimiento.
- **EN:** Prolog has no `main` function: execution is the query of a goal (`-g hellouser`) against the knowledge base.
- **ES:** SWI-Prolog vacía el buffer de salida antes de leer de la entrada estándar, por lo que el prompt aparece correctamente.
- **EN:** SWI-Prolog flushes the output buffer before reading from standard input, so the prompt appears correctly.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
