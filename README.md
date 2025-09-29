## Plugins

### Explorador de Archivos

#### **Neo-tree**
Explorador de archivos moderno con soporte para Git.

**Uso:**
- `Ctrl+n` - Abrir/cerrar Neo-tree
- `H` (dentro de Neo-tree) - Mostrar/ocultar archivos ocultos
- `Enter` - Abrir archivo
- `O` - Abrir con selector de ventana
- `F5` - Refrescar vista

---

### Búsqueda y Navegación

#### **Telescope**
Buscador fuzzy para archivos, texto y más.

**Uso:**
- `<leader>pf` - Buscar archivos en proyecto
- `Ctrl+p` - Buscar archivos de Git
- `<leader>ps` - Búsqueda de texto en vivo
- `<leader>ff` - Buscar archivos (incluye ocultos)
- `<leader>fg` - Grep en vivo (incluye ocultos)
- `<leader>gg` - Buscar palabra bajo cursor
- `<leader>gw` - Buscar palabra exacta
- `<leader>fe` - Búsqueda avanzada con exclusiones

#### **Harpoon**
Navegación rápida entre archivos marcados.

**Uso:**
- `<leader>a` - Marcar archivo actual
- `Ctrl+e` - Menú de archivos marcados
- `<leader>1` a `<leader>6` - Saltar a archivo marcado

#### **FZF**
Integración de FZF para búsquedas rápidas.

**Uso:**
- `<leader>ff` - Comando :Files

---

### LSP y Autocompletado

#### **Mason + LSP Config**
Gestión de Language Servers (Lua, C/C++, CMake, CSS, HTML).

**Uso:**
- `K` - Documentación (hover)
- `gd` - Ir a definición
- `gr` - Mostrar referencias

#### **nvim-cmp**
Motor de autocompletado inteligente.

**Uso:**
- `Ctrl+p/n` - Navegar sugerencias
- `Tab` - Siguiente sugerencia
- `Shift+Tab` - Sugerencia anterior
- `Enter` - Confirmar selección
- `Ctrl+Space` - Forzar autocompletado
- `Ctrl+e` - Cerrar menú

#### **CoC (Conquer of Completion)**
Motor LSP alternativo con clangd.

**Uso:**
- `Tab/Shift+Tab` - Navegar autocompletado
- `Enter` - Confirmar
- `gd` - Ir a definición
- `K` - Documentación

---

### Edición de Código

#### **Comment.nvim**
Comentar/descomentar código fácilmente.

**Uso:**
- `gc` - Toggle comentario (modo normal/visual)
- `gcc` - Comentar línea actual

#### **Conform**
Formateo automático de código (clang-format para C/C++).

**Uso:**
- `<leader>kk` - Formatear archivo o selección
- `:Format` - Comando manual

#### **Better Whitespace**
Resalta y elimina espacios en blanco.

**Características:**
- Limpieza automática al guardar
- Resalta espacios al final de líneas

#### **Treesitter**
Resaltado de sintaxis avanzado.

**Lenguajes soportados:**
- Python, Lua, C, JavaScript, CMake, YAML

---

### Python

#### **nvim-ufo**
Plegado avanzado de docstrings de Python.

**Uso:**
- `<leader>dt` - Toggle docstring actual
- `<leader>df` - Plegar todos los docstrings
- `<leader>du` - Desplegar todos los docstrings
- `<leader>da` - Alternar plegar/desplegar todos
- `<leader>dn` - Siguiente docstring
- `<leader>dp` - Docstring anterior
- `:PythonDocHelp` - Ayuda completa

**Teclas nativas de folding:**
- `zo/zc` - Abrir/cerrar fold actual
- `zR/zM` - Abrir/cerrar todos los folds

---

### Git

#### **Vim Fugitive**
Herramienta Git integrada.

**Uso:**
- `<leader>gs` - Git status
- `<leader>gb` - Ver ramas

#### **LazyGit**
Interfaz gráfica de Git.

**Uso:**
- `<leader>gg` - Abrir LazyGit
- `<leader>gl` - Abrir LazyGit (alternativo)

#### **Git Blame**
Muestra información de Git inline.

**Características:**
- Se activa automáticamente
- Muestra autor, fecha y resumen

---

### Apariencia

#### **Barbar**
Barra de pestañas para buffers.

**Uso:**
- `Tab + número (1-9)` - Saltar a buffer
- `Tab+0` - Último buffer
- `Tab+Tab` - Siguiente buffer
- `Shift+Tab` - Buffer anterior
- `<leader>c` - Cerrar buffer

---

### Utilidades

#### **Translate.nvim**
Traducción de texto con Google Translate.

**Uso:**
- `<leader>te` - Traducir a español (flotante)
- `<leader>ti` - Traducir a inglés
- `<leader>tw` - Traducir palabra bajo cursor (español)
- `<leader>twi` - Traducir palabra (inglés)
- `<leader>tc` - Traducir comentario (español)
- `<leader>tci` - Traducir comentario (inglés)
- `<leader>tei` - Traducir e insertar (español)
- `<leader>ter` - Traducir y reemplazar (español)
- `<leader>ts` - Traducir en ventana dividida
- `:TranslateHelp` - Ayuda completa
- `:TranslateEngine {motor}` - Cambiar motor

#### **Markdown Preview**
Vista previa de Markdown en navegador.

**Uso:**
- `Ctrl+k` - Alternar vista previa (solo en .md)
- Se abre en http://127.0.0.1:8888

#### **Window Picker**
Selector visual de ventanas.

**Uso:**
- `<leader>w` - Activar selector

#### **Duck**
Emojis animados en pantalla (diversión).

**Uso:**
- `<leader>da` - 30 🍺
- `<leader>ds` - 30 🤬
- `<leader>dd` - 30 💜
- `<leader>dk` - Eliminar todos

---

## Atajos de Teclado

### Navegación

| Atajo | Acción |
|-------|--------|
| `Ctrl+n` | Abrir/cerrar Neo-tree |
| `<leader>pf` | Buscar archivos |
| `<leader>a` | Marcar en Harpoon |
| `Ctrl+e` | Menú Harpoon |
| `<leader>1-6` | Saltar a archivo marcado |
| `Ctrl+Arrow` | Moverse entre ventanas |
| `Alt+Arrow` | Intercambiar ventanas |
| `Ctrl+Shift+Arrow` | Redimensionar ventanas |

### Edición

| Atajo | Acción |
|-------|--------|
| `gc` | Comentar/descomentar |
| `<leader>kk` | Formatear código |
| `Ctrl+s` | Guardar (con limpieza) |
| `Ctrl+c` | Copiar (visual) |
| `Ctrl+v` | Pegar |
| `<leader>ya` | Copiar todo el archivo |

### Buffers

| Atajo | Acción |
|-------|--------|
| `Tab+número` | Ir a buffer N |
| `Tab+Tab` | Siguiente buffer |
| `Shift+Tab` | Buffer anterior |
| `<leader>c` | Cerrar buffer |
| `<leader>bd` | Cerrar buffer (alternativo) |

### Terminal

| Atajo | Acción |
|-------|--------|
| `<leader>t` | Abrir terminal |
| `<leader>q` | Cerrar ventana |
| `Ctrl+w` (en terminal) | Cambiar ventana |

### Git

| Atajo | Acción |
|-------|--------|
| `<leader>gg` | LazyGit |
| `<leader>gs` | Git status |
| `<leader>gb` | Ver ramas |

### Traducción

| Atajo | Acción |
|-------|--------|
| `<leader>te` | Traducir a español |
| `<leader>ti` | Traducir a inglés |
| `<leader>tw` | Traducir palabra (ES) |
| `<leader>tc` | Traducir comentario |

### Python

| Atajo | Acción |
|-------|--------|
| `<leader>dt` | Toggle docstring |
| `<leader>df` | Plegar docstrings |
| `<leader>du` | Desplegar docstrings |
| `<leader>da` | Alternar todos |
| `<leader>dn` | Siguiente docstring |
| `<leader>dp` | Docstring anterior |

### LSP

| Atajo | Acción |
|-------|--------|
| `K` | Documentación |
| `gd` | Ir a definición |
| `gr` | Ver referencias |
| `Tab` | Siguiente sugerencia |
| `Shift+Tab` | Sugerencia anterior |
| `Enter` | Confirmar |

---

## Comandos Útiles

### Generales
```vim
:Lazy                 " Gestor de plugins
:Mason                " Gestor de LSP
:TranslateHelp        " Ayuda de traducción
:PythonDocHelp        " Ayuda de docstrings
```

### Git
```vim
:Git                  " Fugitive
:LazyGit              " LazyGit
```

### Formateo
```vim
:Format               " Formatear código
:StripWhitespace      " Limpiar espacios
```
