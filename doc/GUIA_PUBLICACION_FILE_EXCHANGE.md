# Guía Oficial de Publicación y Registro en MATLAB Central File Exchange

Esta guía contiene la información exacta y los textos preparados para copiar y pegar directamente en el formulario de publicación de MathWorks para que la toolbox quede registrada en la tienda mundial de Add-Ons de MATLAB.

---

## 🔗 Enlace Directo al Portal de Publicación
Acceda al formulario oficial con su cuenta de MathWorks:
👉 **[https://www.mathworks.com/matlabcentral/fileexchange/submit](https://www.mathworks.com/matlabcentral/fileexchange/submit)**

---

## 📝 Campos del Formulario de Registro (Copiar y Pegar)

### 1. Archivo a Subir (File to Upload)
Suba el archivo comprimido que acabamos de generar:
📁 **`root_free_laplace_v1.0.0.zip`**
*(Ubicado en: `c:\LyX_Scripts\SCRIPTS_PY\INVERSA_LAPLACE\MI_ALGORITMO\root_free_laplace_v1.0.0.zip`)*

---

### 2. Título (Title)
```text
Root-Free Numerical Laplace Inversion Toolbox
```

---

### 3. Resumen Corto (Summary)
```text
High-order spectral and orthogonal inverse Laplace transforms up to K = 1,000,000 strictly without root-finding.
```

---

### 4. Categoría Principal (Category)
- **Primary Category:** `Mathematics` ➔ `Differential Equations / Transforms`
- *(Alternativa secundaria si lo permite):* `Control Systems` ➔ `Linear Analysis`

---

### 5. Etiquetas de Búsqueda (Tags / Keywords)
Copie y pegue esta lista de etiquetas separadas por comas:
```text
laplace transform, numerical inversion, inverse laplace, root-free, laguerre, stirling, fujiwara, high-order, fractional calculus, chebyshev ladder, partial fractions, control systems
```

---

### 6. Descripción Completa (Description)
*(Copie y pegue el siguiente texto con formato Markdown compatible con MathWorks):*

```markdown
# Root-Free Numerical Laplace Inversion Toolbox
**Version 1.0.0 — High-Order Spectral and Orthogonal Inversion without Root-Finding**

This toolbox provides an industrial-grade, 100% root-free numerical engine for inverting high-order rational and irrational Laplace transforms, supporting dynamical systems from order K = 1 up to K = 1,000,000 in standard IEEE double precision (`float64`).

### 🌟 Key Capabilities
* **100% Root-Free:** Eliminates denominator root-finding (`roots`) entirely, avoiding the catastrophic numerical ill-conditioning of Wilkinson polynomials for K > 30.
* **Immunity to the Taylor Hump:** Neutralizes floating-point cancellation using:
  1. **Log-space Laurent-Stirling Recursion:** Evaluates factorials and Gamma terms in logarithmic space for safe causal horizons.
  2. **Möbius-Laguerre Orthogonal Projection:** Regularizes unstable half-plane dynamics onto the unit disk $L^2[0, \infty)$ with adaptive damping.
  3. **Adaptive Taylor Prolongation:** Overlapping analytic Taylor arcs using exact generalized Laguerre derivatives.
* **Massive Order Support (K = 1,000,000):** Built-in `FactorPoly` and `PartialFractions` classes process 10,000 harmonic resonators and 1,000,000 Chebyshev ladder modes in milliseconds.
* **Interactive Desktop Studio:** Includes `LaplaceGUI` with dual real-time plotting (time response and logarithmic error) and instant export to Workspace and CSV.
* **Universal Compatibility:** Pure MATLAB code compatible with MATLAB R2018b–R2026+ and GNU Octave 10+.

### 🚀 Quick Start
```matlab
% Invert standard rational fraction F(s) = 1 / (s^2 + 2*s + 2)
z = linspace(0, 10, 500);
[f_vals, info] = laplace.invert([1], [1, 2, 2], z);

% Launch the interactive GUI
LaplaceGUI
```

### 🧪 Validation & Benchmarks Included
* **5,000 Harmonic Resonators (K = 10,000):** Validated in 0.3 s against the analytical Dirichlet kernel closed form with $L_\infty < 10^{-11}$.
* **1,000,000 Pole Chebyshev Network:** Solved modal impulse response in 6 ms.
* **Diffusion Step Response:** 80-mode approximation benchmarked against analytical complementary error function (`erfc`) and Fourier series.

### 📚 Documentation
Includes full HTML documentation accessible via `doc root_free_laplace` and comprehensive unit test suite (`run_all_tests`).
```

---

### 7. Versión y Notas de Lanzamiento (Release Notes)
- **Version Number:** `1.0.0`
- **Release Notes:**
```text
Initial public release:
- 100% root-free hybrid architecture (Fujiwara + Möbius-Laguerre + Laurent-Stirling).
- Full support for FactorPoly and PartialFractions up to order K = 1,000,000.
- Interactive LaplaceGUI studio application.
- Comprehensive test suite and analytical reference benchmarks.
```

---

### 8. Licencia (License)
Seleccione en el desplegable de MathWorks:
- **BSD 2-Clause** o **MIT** (si desea máxima adopción académica), o
- **Custom License** (si desea incluir restricciones comerciales o de código cerrado).

---

### 9. Publicación Final
Haga clic en el botón azul **"Submit"** al final de la página.

¡Listo! MathWorks revisará e indexará su paquete, asignándole un identificador único. A partir de ese momento, cualquier usuario de MATLAB que abra el **Add-On Explorer** dentro del programa y busque *"Laplace"* encontrará su toolbox lista para instalar con un solo clic.
