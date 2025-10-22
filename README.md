## Requisitos Previos

### Dependencias del Sistema

#### **Arch Linux**
```bash
# Herramientas básicas
sudo pacman -S git curl nodejs npm python python-pip ripgrep fd

# LaTeX (texlive completo)
sudo pacman -S texlive-most texlive-lang texlive-binextra

# Visualizador PDF
sudo pacman -S okular

# Herramientas opcionales
sudo pacman -S clang cmake
```

#### **Ubuntu/Debian**
```bash
# Herramientas básicas
sudo apt update
sudo apt install git curl nodejs npm python3 python3-pip ripgrep fd-find

# LaTeX (texlive completo)
sudo apt install texlive-full texlive-lang-spanish chktex

# Visualizador PDF
sudo apt install okular

# Herramientas opcionales
sudo apt install clang cmake
```

### Configuración de Neovim

1. **Instalar Language Servers** (desde Neovim)
   ```vim
   :Mason
   ```
   Selecciona e instala: `lua_ls`, `clangd`, `texlab`, `html`, `cssls`

### Verificación de LaTeX

Para verificar que LaTeX está correctamente configurado:
```bash
# Verificar texlive
latex --version

# Verificar ChkTeX
chktex --version

# Verificar texlab (después de instalar desde Mason)
~/.local/share/nvim/mason/bin/texlab --version
```

---

## Plugins

### Explorador de Archivos

#### **Neo-tree**
Explorador de archivos moderno con soporte para Git.

**Uso básico:**
- `Ctrl+n` - Abrir/cerrar Neo-tree
- `Enter` - Abrir archivo
- `O` - Abrir con selector de ventana
- `H` - Mostrar/ocultar archivos ocultos
- `F5` - Refrescar vista

**Gestión de archivos:**
- `a` - Crear nuevo archivo (termina con `/` para crear carpeta)
- `d` - Eliminar archivo/carpeta (pide confirmación)
- `r` - Renombrar archivo/carpeta
- `c` - Copiar archivo
- `m` - Mover/cortar archivo
- `p` - Pegar archivo copiado/cortado
- `y` - Copiar ruta al clipboard

**Ayuda:**
- `?` - Ver todos los comandos disponibles

---

### Búsqueda y Navegación

#### **Telescope**
Buscador fuzzy para archivos, texto y más.

**Uso básico:**
- `<leader>pf` - Buscar archivos en proyecto
- `Ctrl+p` - Buscar archivos de Git
- `<leader>ps` - Búsqueda de texto en vivo

**Búsquedas avanzadas (incluyen archivos ocultos):**
- `<leader>ff` - Live grep con todos los filtros
- `<leader>fg` - Live grep (incluye ocultos, simple)
- `<leader>gg` - Buscar palabra bajo cursor (simple)
- `<leader>gw` - Buscar palabra bajo cursor (con filtros)
- `<leader>fe` - Búsqueda avanzada con exclusiones interactivas

#### **Harpoon**
Navegación rápida entre archivos marcados.

**Uso:**
- `<leader>a` - Marcar archivo actual
- `Ctrl+e` - Menú de archivos marcados
- `<leader>1` a `<leader>6` - Saltar a archivo marcado

#### **FZF**
Integración de FZF para búsquedas rápidas.

**Uso:**
- `<leader>fz` - Comando :Files

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

### LaTeX

#### **VimTeX**

Editor LaTeX con compilación automática y visualización en Okular.

**Características:**

- Compilación continua con latexmk
- Archivos auxiliares en carpeta `build/`
- Sincronización bidireccional con Okular
- Detección automática de la raíz del proyecto

**Uso básico:**

**Compilación:**

- `<leader>ll` - Iniciar compilación continua
- `<leader>lk` - Detener compilación
- `<leader>lc` - Limpiar archivos auxiliares
- `<leader>lb` - Recompilar desde cero (elimina build/)

**Visualización:**

- `<leader>lv` - Abrir PDF en Okular (busca en build/)
- Click en PDF (Shift+Click) - Sincroniza Okular → Neovim

**Navegación:**

- `<leader>lt` - Tabla de contenidos
- `<leader>li` - Información de VimTeX
- `<leader>ls` - Estado de compilación
- `<leader>lw` - Contar palabras

**Navegación LSP (texlab):**

- `gd` - Ir a definición (comandos, labels, referencias)
- `gr` - Ver todas las referencias
- `K` - Documentación hover (info de comandos LaTeX)

**Diagnósticos (texlab + ChkTeX):**

- `<leader>le` - Ver diagnóstico flotante (línea actual)
- `<leader>lp` - Error anterior
- `<leader>ln` - Siguiente error
- `<leader>lq` - Lista de diagnósticos (location list)
- `<leader>ee` - Ver TODOS los errores (texlab + ChkTeX completo)

**Gestión de build/:**

- `<leader>ld` - Eliminar carpeta build/
- `<leader>lx` - Copiar PDF a raíz del proyecto

**Comandos:**

- `:LaTeXHelp` - Ayuda completa de comandos
- `:LaTeXDebug` - Ver información del proyecto (rutas, PDFs)
- `:LaTeXTemplate` - Insertar plantilla básica
- `:BuildClean` - Eliminar build/
- `:BuildRebuild` - Limpiar y recompilar
- `:PDFCopy` - Copiar PDF a raíz
- `:LaTeXChkTeX` - Ejecutar solo ChkTeX manualmente
- `:LaTeXErrors` - Ver análisis completo (texlab + ChkTeX)

**Snippets disponibles:**

- `eq` - Entorno equation
- `fig` - Entorno figure con includegraphics
- `sec` - Section con label

**Nota:** VimTeX detecta automáticamente la raíz del proyecto, por lo que puedes trabajar en archivos dentro de subcarpetas y siempre compilará el documento principal.

**Control de concealment (ocultamiento de comandos):**

VimTeX oculta ciertos comandos LaTeX (como `\vspace{}`, `\hspace{}`, etc.) para mejorar la legibilidad. Para controlar esto:

- `:set conceallevel=0` - Mostrar todo (sin ocultamiento)
- `:set conceallevel=1` - Ocultar parcialmente
- `:set conceallevel=2` - Ocultar completamente (por defecto en muchos setups)

#### **texlab + ChkTeX (LSP integrado)**

**¿Qué es?**

texlab es el Language Server oficial para LaTeX que proporciona:
- Autocompletado inteligente de comandos, entornos y referencias
- Navegación por el código (ir a definición, ver referencias)
- Análisis de errores en tiempo real mediante ChkTeX integrado

**Diagnósticos en tiempo real:**

texlab ejecuta ChkTeX automáticamente mientras editas (con 500ms de delay) y muestra:
- **Errores de ChkTeX**: uso incorrecto de comandos, problemas de estilo
- **Warnings de texlab**: referencias indefinidas, comandos desconocidos
- **Hints**: sugerencias de mejora

Los diagnósticos aparecen como:
- Símbolos en la columna lateral (, , , )
- Subrayados en el código
- Virtual text al final de la línea
- Ventanas flotantes con `<leader>le` o `<leader>ee`

**Diferencias entre comandos de errores:**
- `<leader>le` → Muestra solo el error de la **línea actual** (rápido)
- `<leader>ee` → Ejecuta ChkTeX completo y muestra **todos los errores** del archivo (detallado)
- `<leader>lp` / `<leader>ln` → Navega entre errores detectados

**Configuración:**
- ChkTeX se configura en `~/.chktexrc` (para silenciar warnings molestos)
- texlab se configura en `lua/plugins/lsp-config.lua`
- Documentación completa: `docs/LATEX_SETUP.md`

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
- `<leader>fw` - Abrir LazyGit
- `<leader>gl` - Abrir LazyGit (alternativo)

#### **Git Blame**
Muestra información de Git blame inline y en ventana flotante.

**Características:**
- **Desactivado por defecto** (para activar: `:GitBlameToggle`)
- Blame inline: muestra autor, fecha y resumen al final de cada línea
- Blame flotante: selecciona código en modo visual y usa `<leader>gv` para ver historial completo con diffs

**Uso:**
- `:GitBlameToggle` - Activar/desactivar blame inline
- `:GitBlameEnable` - Activar blame inline
- `:GitBlameDisable` - Desactivar blame inline
- `<leader>gv` (modo visual) - Ver git log -L de selección en ventana flotante
  - Muestra: commit hash, autor, fecha, mensaje, diff completo con syntax highlighting
- Ventana flotante: presiona `q` o `Esc` para cerrar

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
**Traducción básica:**
- `<leader>te` - Traducir a español (flotante)
- `<leader>ti` - Traducir a inglés (flotante)
- `<leader>tw` - Traducir palabra bajo cursor (español)
- `<leader>twi` - Traducir palabra bajo cursor (inglés)

**Traducción con inserción:**
- `<leader>tei` - Traducir e insertar (español)
- `<leader>tii` - Traducir e insertar (inglés)

**Traducción con reemplazo:**
- `<leader>ter` - Traducir y reemplazar (español)
- `<leader>tir` - Traducir y reemplazar (inglés)

**Comentarios:**
- `<leader>tc` - Traducir comentario (español)
- `<leader>tci` - Traducir comentario (inglés)

**Ventana dividida:**
- `<leader>ts` - Traducir en ventana dividida

**Comandos:**
- `:TranslateHelp` - Ayuda completa
- `:TranslateEngine {motor}` - Cambiar motor de traducción

#### **checker en oxycontroller**

- `<leader>cc` - Usar script de chequeo, abre una ventana flotante (no genera contexto de compilación)

#### **Markdown Preview**
Vista previa de Markdown en navegador.

**Uso:**
- `Ctrl+k` - Alternar vista previa (solo en .md)
- `:MarkdownPreview` - Vista previa (solo en .md)
- `:MarkdownPreviewStop` - Detener vista previa (solo en .md)
- `:MarkdownPreviewToggle` - Alternar vista vista previa (solo en .md)
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
| `<leader>fw` | LazyGit |
| `<leader>gs` | Git status |
| `<leader>gb` | Ver ramas |
| `<leader>gv` (visual) | Git blame flotante |

### Traducción

| Atajo | Acción |
|-------|--------|
| `<leader>te` | Traducir a español |
| `<leader>ti` | Traducir a inglés |
| `<leader>tw` | Traducir palabra (ES) |
| `<leader>twi` | Traducir palabra (EN) |
| `<leader>tc` | Traducir comentario (ES) |
| `<leader>tci` | Traducir comentario (EN) |
| `<leader>tei` | Traducir e insertar (ES) |
| `<leader>ter` | Traducir y reemplazar (ES) |
| `<leader>ts` | Traducir en split |

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
