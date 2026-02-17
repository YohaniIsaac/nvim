# Neovim Configuration

> `<leader>nh` → Notification history (historial de notificaciones)

## Índice

- [Requisitos Previos](#requisitos-previos)
  - [Dependencias del Sistema](#dependencias-del-sistema)
  - [Configuración de Neovim](#configuración-de-neovim)
  - [Verificación de LaTeX](#verificación-de-latex)
- [Plugins](#plugins)
  - [Explorador de Archivos](#explorador-de-archivos)
    - [Neo-tree](#neo-tree)
  - [Búsqueda y Navegación](#búsqueda-y-navegación)
    - [Telescope](#telescope)
    - [Harpoon](#harpoon)
    - [Marks.nvim](#marksnvim---marcas-visuales)
    - [FZF](#fzf)
  - [LSP y Autocompletado](#lsp-y-autocompletado)
    - [Mason + LSP Config](#mason--lsp-config)
    - [nvim-cmp](#nvim-cmp)
    - [CoC](#coc-conquer-of-completion)
  - [Edición de Código](#edición-de-código)
    - [Búsqueda y Reemplazo](#búsqueda-y-reemplazo)
    - [Comment.nvim](#commentnvim)
    - [Conform](#conform)
    - [Better Whitespace](#better-whitespace)
    - [Treesitter](#treesitter)
  - [Python](#python)
    - [nvim-ufo](#nvim-ufo)
  - [LaTeX](#latex)
    - [VimTeX](#vimtex)
    - [texlab + ChkTeX](#texlab--chktex-lsp-integrado)
  - [Git](#git)
    - [Vim Fugitive](#vim-fugitive)
    - [LazyGit](#lazygit)
    - [Git Blame](#git-blame)
  - [Apariencia](#apariencia)
    - [Barbar](#barbar)
  - [Utilidades](#utilidades)
    - [Translate.nvim](#translatenvim)
    - [Code Checker](#code-checker-oxycontroller)
    - [Markdown Preview](#markdown-preview)
    - [Snacks.nvim](#snacksnvim)
    - [Window Picker](#window-picker)
    - [Duck](#duck)
- [Atajos de Teclado](#atajos-de-teclado)
  - [Navegación](#navegación)
  - [Marks](#marks)
  - [Edición](#edición)
  - [Buffers](#buffers)
  - [Terminal](#terminal)
  - [Git (atajos)](#git-1)
  - [Traducción](#traducción)
  - [Python (atajos)](#python-1)
  - [LSP (atajos)](#lsp)
  - [Markdown](#markdown)
  - [Utilidades (atajos)](#utilidades-1)
  - [Snacks.nvim (atajos)](#snacksnvim-1)
- [Comandos Útiles](#comandos-útiles)

---

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

#### **Marks.nvim - Marcas visuales**
Sistema de marcas mejorado con indicadores visuales en la columna izquierda.

**Crear marcas:**
- `m{a-z}` - Crear marca local (solo en el archivo actual)
- `m{A-Z}` - Crear marca global (entre archivos)
- `m;` - Toggle marca automática (usa siguiente letra disponible)

**Saltar a marcas:**
- `'{marca}` - Saltar a la línea de la marca
- `` `{marca} `` - Saltar a la posición exacta (línea y columna)
- `m]` - Siguiente marca
- `m[` - Marca anterior
- `''` - Volver a la posición anterior al último salto

**Gestionar marcas:**
- `dm` - Eliminar marca bajo el cursor
- `dm-` - Eliminar todas las marcas del buffer
- `dm=` - Eliminar todas las marcas en la línea actual
- `<leader>dma` - Eliminar todas las marcas locales (a-z) del buffer
- `<leader>dmA` - Eliminar TODAS las marcas (locales + globales)
- `m:` - Preview de la marca (ventana flotante)
- `<leader>m` - Navegador visual de marcas (snacks.nvim)

**Bookmarks especiales:**
- `m0` - Set bookmark (marcador con símbolo ⚑)
- `dm0` - Eliminar bookmark
- `m0]` / `m0[` - Navegar entre bookmarks

**Características visuales:**
- Las marcas se muestran en la columna izquierda con sus letras
- Diferentes colores para marcas locales (a-z) y globales (A-Z)
- Actualización automática cada 250ms

**Ejemplos de uso:**
- `ma` - Marca la línea actual como 'a' (aparece "a" en la columna izquierda)
- `'a` - Salta a la línea de la marca 'a'
- `m]` - Salta a la siguiente marca en el buffer
- `m;` - Marca rápida (usa siguiente letra disponible)
- `m0` - Crea un bookmark con símbolo ⚑

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

#### **Búsqueda y Reemplazo**
Buscar y reemplazar palabras con confirmación interactiva.

**Uso:**
- `<leader>p` - Buscar y reemplazar palabra bajo cursor
  - Coloca el cursor sobre una palabra
  - Presiona `<leader>p` (espacio + p)
  - Escribe el texto de reemplazo
  - Presiona Enter
  - Para cada ocurrencia te preguntará:
    - `y` - reemplazar esta ocurrencia
    - `n` - saltar esta ocurrencia
    - `a` - reemplazar todas las restantes
    - `q` o `Esc` - cancelar

**Ejemplo:**
1. Coloca el cursor sobre la palabra `foo`
2. Presiona `<leader>p`
3. Escribe `bar`
4. Presiona Enter
5. Confirma cada reemplazo con `y` o `n`

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

- `<leader>ll` - Iniciar compilación continua (latexmk detecta cambios automáticamente)
- `<leader>lk` - Detener compilación
- `<leader>lc` - Limpiar archivos auxiliares
- `<leader>lb` - Recompilar desde cero (elimina build/)

**Cómo funciona la compilación continua:**
1. Presiona `<leader>ll` para iniciar
2. latexmk se queda escuchando cambios en todos los archivos `.tex` del proyecto
3. Cada vez que guardas (`Ctrl+s`), latexmk detecta el cambio y recompila automáticamente
4. El PDF se actualiza automáticamente en Okular sin necesidad de reabrir
5. Usa `<leader>lk` para detener la compilación continua cuando termines

**Visualización:**

- `<leader>lv` - Abrir PDF en Okular (busca automáticamente en build/)
  - Detecta el archivo principal del proyecto automáticamente
  - Funciona desde archivos secundarios (no necesitas estar en el main.tex)
  - Si no encuentra el PDF específico, busca cualquier PDF en build/ como fallback
  - **Tip:** Para proyectos multi-archivo, agrega `% !TEX root = main.tex` al inicio de archivos secundarios
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

Los siguientes snippets personalizados están configurados con alta prioridad:

- `fig` + Tab → Figure completo con center, includegraphics, caption y label
  ```latex
  \begin{figure}
      \begin{center}
          \includegraphics[width=0.95\textwidth]{figures/|cursor|}
      \end{center}
      \caption{}
      \label{fig:}
  \end{figure}
  ```

- `eq` + Tab → Entorno equation
  ```latex
  \begin{equation}
      |cursor|
  \end{equation}
  ```

- `sec` + Tab → Section con label
  ```latex
  \section{Título}
  \label{sec:etiqueta}
  ```

- `beg` + Tab → Entorno genérico begin/end
  ```latex
  \begin{environment}
      |cursor|
  \end{environment}
  ```

**Tip:** Escribe el trigger y presiona Tab para expandir el snippet. Usa Tab para saltar entre los campos editables.

**Agregar más snippets:** Edita `lua/plugins/latex.lua` en la sección "CUSTOM LATEX SNIPPETS".

**Nota sobre proyectos multi-archivo:**

VimTeX detecta automáticamente la raíz del proyecto y el archivo principal, por lo que puedes trabajar en archivos dentro de subcarpetas y siempre compilará el documento principal.

**Para proyectos con estructura multi-archivo:**
- VimTeX intenta detectar automáticamente cuál es el archivo principal (el que tiene `\documentclass`)
- Si la detección automática falla, agrega este comentario al inicio de tus archivos secundarios:
  ```latex
  % !TEX root = main.tex
  % O si está en un subdirectorio:
  % !TEX root = ../main.tex
  ```
- Después de agregar el comentario, recarga con `:VimtexReload` o `<leader>rr`
- Una vez configurado, todos los comandos (`<leader>ll`, `<leader>lv`, etc.) funcionarán correctamente desde cualquier archivo del proyecto

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

#### **Code Checker (Oxycontroller)**

Ejecuta el script `./scripts/checker` en el proyecto oxycontroller.

**Uso:**
- `<leader>cc` - Ejecutar checker sobre archivo actual (ventana flotante)
  - Solo funciona dentro del proyecto oxycontroller
  - Muestra resultados en ventana flotante (80% del tamaño de pantalla)
  - Presiona `q` o `Esc` para cerrar
  - Ejecuta: `./scripts/checker -k <archivo_actual>`

#### **Markdown Preview**
Vista previa de Markdown en navegador con actualización en vivo.

**Características:**
- Vista previa en tiempo real mientras editas
- Se actualiza automáticamente al guardar
- Soporta sintaxis de GitHub-flavored Markdown
- Se abre en http://127.0.0.1:8888

**Uso (solo en archivos .md):**
- `<leader>lv` - Abrir vista previa en navegador
- `<leader>lk` - Detener vista previa
- `<leader>lt` - Alternar vista previa (toggle)

**Comandos alternativos:**
- `:MarkdownPreview` - Abrir vista previa
- `:MarkdownPreviewStop` - Detener vista previa
- `:MarkdownPreviewToggle` - Alternar vista previa

**Nota:** Los atajos `<leader>l*` funcionan igual que LaTeX para facilitar la memorización. El atajo se adapta automáticamente según el tipo de archivo (.tex o .md).

#### **Snacks.nvim**
Colección de plugins de calidad de vida (40+ módulos).

**Características principales:**

**Marks visuales:**
- Indicadores de marcas en la columna izquierda
- `<leader>m` - Navegador de marcas

**Notificaciones:**
- Sistema de notificaciones mejorado
- `<leader>nh` - Historial de notificaciones
- `<leader>nd` - Descartar notificaciones

**Scratch buffers (buffers temporales):**
- `<leader>.` - Abre/cierra un buffer temporal para notas o pruebas
  - Se guarda automáticamente en disco
  - Persiste entre sesiones de Neovim
  - Útil para código de prueba, notas rápidas, snippets temporales
- `<leader>S` - Selecciona entre múltiples scratch buffers
  - Puedes tener varios scratch buffers para diferentes propósitos

**Buffer delete mejorado:**
- `<leader>bd` - Cierra el buffer actual sin romper el layout de ventanas
  - Problema normal: `:bdelete` cierra ventanas si ese buffer está abierto múltiples veces
  - Con snacks: Cierra el buffer pero mantiene todas las ventanas abiertas

**Funcionalidades automáticas:**
- Smooth scrolling automático
- Indent guides visuales
- LSP word references (resalta referencias automáticamente)
- Bigfile handling (optimiza archivos grandes >1MB)

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
| `Alt+Arrow` | Intercambiar ventanas (swap) |
| `Ctrl+Shift+Arrow` | Redimensionar ventanas |
| `<leader>w` | Selector visual de ventanas |

### Marks

| Atajo | Acción |
|-------|--------|
| `m{a-z}` | Crear marca local |
| `m{A-Z}` | Crear marca global |
| `m;` | Marca automática |
| `'{marca}` | Saltar a marca |
| `m]` / `m[` | Siguiente/anterior marca |
| `dm` | Eliminar marca bajo cursor |
| `dm-` | Eliminar todas las marcas |
| `<leader>dma` | Eliminar marcas locales (a-z) |
| `<leader>dmA` | Eliminar TODAS las marcas |
| `m:` | Preview marca |
| `<leader>m` | Navegador de marcas |
| `m0` | Bookmark especial |

### Edición

| Atajo | Acción |
|-------|--------|
| `gc` | Comentar/descomentar |
| `<leader>kk` | Formatear código |
| `<leader>p` | Buscar y reemplazar palabra bajo cursor |
| `Ctrl+s` | Guardar (con limpieza) |
| `Ctrl+c` | Copiar (visual) |
| `Ctrl+v` | Pegar |
| `<leader>ya` | Copiar todo el archivo |
| `Ctrl+j` (insert) | Scroll documento hacia abajo |
| `Ctrl+k` (insert) | Scroll documento hacia arriba |

### Buffers

| Atajo | Acción |
|-------|--------|
| `Tab+número` | Ir a buffer N |
| `Tab+Tab` | Siguiente buffer |
| `Shift+Tab` | Buffer anterior |
| `<leader>c` | Cerrar buffer |
| `<leader>bd` | Cerrar buffer (alternativo) |
| `<leader>bn` | Cerrar buffer y abrir siguiente |

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

### Markdown

| Atajo | Acción |
|-------|--------|
| `<leader>lv` | Abrir vista previa en navegador |
| `<leader>lk` | Detener vista previa |
| `<leader>lt` | Alternar vista previa |

**Nota:** Los atajos `<leader>l*` son compartidos con LaTeX para facilitar la memorización:
- En archivos `.tex` → `<leader>lv` abre el PDF en Okular
- En archivos `.md` → `<leader>lv` abre la vista previa en el navegador

### Utilidades

| Atajo | Acción |
|-------|--------|
| `<leader>rr` | Recargar configuración completa de Neovim |
| `<leader>cc` | Code checker (oxycontroller) |
| `<leader>fz` | FZF Files |

### Snacks.nvim

| Atajo | Acción |
|-------|--------|
| `<leader>m` | Navegador de marcas |
| `<leader>nh` | Historial notificaciones |
| `<leader>nd` | Descartar notificaciones |
| `<leader>.` | Scratch buffer temporal |
| `<leader>S` | Seleccionar scratch buffer |
| `<leader>bd` | Delete buffer (mejorado) |

---

## Comandos Útiles

### Generales
```vim
:Lazy                 " Gestor de plugins
:Mason                " Gestor de LSP
:TranslateHelp        " Ayuda de traducción
:PythonDocHelp        " Ayuda de docstrings
```

### Recargar Configuración

**Opción 1: Atajo rápido (recomendado)**
```vim
<leader>rr            " Recarga completa (limpia cache + reinicia LSP)
```

**Opción 2: Manual paso a paso**
```vim
" 1. Recargar init.lua
:source $MYVIMRC

" 2. Recargar archivo Lua específico (si estás editando uno)
:luafile %

" 3. Reiniciar LSP servers
:LspRestart

" 4. Recargar plugin específico (con Lazy)
:Lazy reload <nombre-plugin>
:Lazy reload latex.lua

" 5. Limpiar cache de módulos Lua (en línea de comandos Lua)
:lua for k,_ in pairs(package.loaded) do if k:match("^lua") or k:match("^config") or k:match("^plugins") then package.loaded[k] = nil end end
:source $MYVIMRC
```

**Tip:** Después de modificar snippets o configuración de LaTeX, usa `<leader>rr` para aplicar los cambios sin cerrar Neovim.

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
