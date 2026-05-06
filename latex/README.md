# Missouri S&T Academic Portfolio System

A comprehensive LaTeX-based portfolio system for organizing and presenting academic work from Missouri University of Science and Technology. This system creates professional, branded portfolios that showcase coursework, teaching materials, and academic achievements across multiple disciplines.

## 📚 Portfolio Types

The system generates four distinct portfolio formats, each serving a specific purpose:

### **Academic Notes** (`notes.tex`)
Course lecture notes, study materials, and reference documents organized by semester and subject. Perfect for comprehensive exam preparation or sharing knowledge with fellow students.

### **Academic Assignments** (`assignments.tex`)  
Homework submissions, projects, and laboratory reports that demonstrate problem-solving skills and technical competency across various disciplines.

### **Curated Portfolio** (`curated.tex`)
A carefully selected collection of exemplary work including teaching materials, significant projects, and standout assignments that best represent academic excellence.

### **Complete Portfolio** (`complete.tex`)
The comprehensive collection containing all academic work—ideal for graduate school applications or comprehensive academic records.

## 🏗️ System Architecture

### Core Components

| File | Purpose |
|------|---------|
| `mst.cls` | Custom LaTeX class defining the portfolio style and layout |
| `config.tex` | Personal information and customization settings |
| `makefile` | Build automation for generating PDFs |
| `assets/` | Missouri S&T logos and branding elements |

### Content Organization

```
latex/
├── assets/                 # University branding and images
├── cs*/                   # Computer Science courses
├── cpe*/                  # Computer Engineering courses  
├── math*/                 # Mathematics courses
├── phys*/                 # Physics courses
├── stat*/                 # Statistics courses
├── phil*/                 # Philosophy courses
├── psyc*/                 # Psychology courses
└── teach/                 # Teaching materials
```

Each course directory contains PDF files of completed work, organized with consistent naming conventions for easy navigation.

## 🚀 Getting Started

### Building Portfolios

```bash
# Build all portfolios at once
make

# Build individual portfolios
make notes        # Generate notes portfolio
make assignments  # Generate assignments portfolio  
make curated      # Generate curated portfolio
make complete     # Generate complete portfolio

# Maintenance commands
make clean        # Remove temporary build files
make distclean    # Remove all generated PDFs
```

### Adding Content

1. **Place your PDF** in the appropriate course directory
2. **Edit the portfolio file** where you want it to appear
3. **Add an entry** using the following format:

```latex
\coursesection{CS5400}{Artificial Intelligence}
\includeassignment{cs5400_artificial_intelligence/homework_1.pdf}{Homework 1}
\includeassignment{cs5400_artificial_intelligence/project.pdf}{Final Project}
```

## ⚙️ Personalization

Configure your portfolio by editing `config.tex`:

```latex
\renewcommand{\myname}{Your Name}
\renewcommand{\myemail}{your.email@mst.edu}
\renewcommand{\mydegree}{Bachelor of Science, Computer Science}
\renewcommand{\mygraduation}{May 2024}
\renewcommand{\myresearch}{Machine Learning, Data Science}
\renewcommand{\myadvisor}{Dr. Faculty Name}
\renewcommand{\mygpa}{3.85}
\renewcommand{\myteaching}{Teaching Assistant Experience}
\renewcommand{\mycourses}{CS1570, CS1510}
```

These settings automatically populate throughout your portfolios, ensuring consistency across all documents.

## 📋 Document Structure

Each portfolio follows a consistent structure:

1. **Title Page** - University branding with your name and portfolio type
2. **Preface** - Introduction and context for the portfolio
3. **Table of Contents** - Hyperlinked navigation to all sections
4. **Course Sections** - Content organized by department and course number
5. **Included PDFs** - Full documents with preserved formatting

## 🎨 Features

- **Professional Formatting**: Custom LaTeX class with Missouri S&T branding
- **Hyperlinked Navigation**: Click through table of contents and cross-references
- **Modular Design**: Mix and match content across different portfolio types
- **Consistent Styling**: Automatic headers, footers, and page numbering
- **PDF Preservation**: Original documents included with full fidelity
- **Multi-Discipline Support**: Organized structure for CS, CPE, MATH, PHYS, and more

## 📂 Course Directory Structure

The repository contains extensive coursework across multiple disciplines:

### Computer Science (CS)
- **CS1001**: Data Structures Lab
- **CS1200**: Discrete Mathematics
- **CS1510**: Data Structures
- **CS2200**: Theory of Computer Science
- **CS2300**: Databases
- **CS2500**: Algorithms
- **CS3001**: Skills Development
- **CS3100**: Software Engineering I
- **CS3200**: Numerical Methods
- **CS3800**: Operating Systems
- **CS4096**: Software Systems Development
- **CS5200**: Analysis of Algorithms
- **CS5201**: Object-Oriented Numerical Modeling
- **CS5400**: Artificial Intelligence
- **CS5402**: Data Mining

### Computer Engineering (CPE)
- **CPE2210**: Introduction to Computer Engineering
- **CPE3150**: Micro Embedded Design

### Mathematics & Statistics
- **MATH1214**: Calculus I
- **MATH1215**: Calculus II
- **MATH2100**: Foundations of Mathematics
- **MATH2222**: Calculus III
- **MATH3304**: Differential Equations
- **STAT3117**: Statistics

### Physics & Other
- **PHYS1135**: Physics I
- **PHYS2135**: Physics II
- **PHYS2305**: Modern Physics
- **PHIL3225**: Business Ethics
- **PSYC1101**: Psychology 101

## 💡 Best Practices

- **File Naming**: Use lowercase with underscores (e.g., `homework_1.pdf`)
- **Organization**: Group related materials in course-specific directories
- **Titles**: Be descriptive but concise in your assignment titles
- **Regular Updates**: Add new work as you complete it throughout the semester
- **Version Control**: Track changes with Git for collaborative work

## 🛠️ Technical Details

- **LaTeX Engine**: pdfLaTeX with full font support
- **Package Dependencies**: pdfpages, hyperref, fancyhdr, geometry, graphicx
- **Build System**: GNU Make with dependency resolution
- **Compatibility**: Works on macOS, Linux, and Windows (with TeX distribution)
- **Document Class**: Custom `mst.cls` for consistent styling

## 📝 Example Workflow

```bash
# 1. Add a new assignment PDF
cp ~/Downloads/ai_project.pdf cs5400_artificial_intelligence/

# 2. Edit the assignments portfolio
vim assignments.tex

# 3. Add the entry under the appropriate course section
# \includeassignment{cs5400_artificial_intelligence/ai_project.pdf}{AI Final Project}

# 4. Rebuild the portfolio
make assignments

# 5. View the result
open assignments.pdf
```

## 🎓 Portfolio Contents

Aggregate PDFs (rebuild via `make`):

| Portfolio | Pages | Size | Description |
|-----------|------:|-----:|-------------|
| `notes.pdf` | 473 | 5.7M | Lecture notes and study materials |
| `assignments.pdf` | 498 | 17M | Homework, projects, and laboratory reports |
| `curated.pdf` | 258 | 7.9M | Selected best work + teaching materials |
| `complete.pdf` | **1,113** | 26M | Comprehensive collection of academic work |

This collection represents comprehensive academic work including:
- **Course Notes**: 473 pages across 30+ courses
- **Assignments**: Homework, projects, and laboratory reports across 17 courses
- **Teaching Materials**: Lab assignments, lecture presentations, and tutorials
- **Research Projects**: AI, data mining, and numerical modeling work
- **Capstone Projects**: Software systems development and engineering projects

---

*This portfolio system represents years of academic excellence at Missouri S&T, organized for maximum impact and professional presentation.*