# AI in Professional Practice of a Mathematics Teacher

This repository contains the source materials (Markdown) and build configuration for the course _AI in Professional Practice of a Mathematics Teacher_

The project is built using a Markdown → PDF / DOCX workflow powered by Pandoc and LaTeX.

---

## 📦 Project Structure

- `docs/` — main course materials (syllabus + modules in Markdown)
- `assets/` — images and static resources
- `templates/` — LaTeX and Word reference templates
- `scripts/` — helper scripts (e.g., sanitize)
- `Makefile` — build automation
- `build/` — generated output (PDF/DOCX)

---

## 🛠 Required Tools

You need the following tools installed:

### 1. Pandoc (3.x recommended)

Used for converting Markdown to PDF and DOCX.

Check installation:

```
pandoc --version
```

### 2. LaTeX (XeLaTeX recommended)

Required for PDF generation.

Test:

```
xelatex --version
```

Recommended: TeX Live or MacTeX.

### 3. Python 3

Used for text sanitation script.

Test:

```
python3 --version
```

---

## 🚀 Build Commands

All commands are run from the repository root.

### Build everything (PDF + DOCX)

```
make
```

### Build only PDF

```
make pdf
```

### Build only DOCX

```
make docx
```

### Clean generated files

```
make clean
```

### Run text sanitation (replace problematic Unicode, etc.)

```
make sanitize
```

---

## 🧩 Notes

- PDF output uses the custom LaTeX template in `templates/academic.tex`.
- Word formatting is controlled by `templates/reference.docx`.
- Images must be placed inside the `assets/` directory.
- Generated files are placed in `build/`.

---

## 📄 License

- Educational content is licensed under **CC BY 4.0** (see `LICENSE`).
- Code and build tooling are licensed under the **MIT License** (see `LICENSE-CODE`).
