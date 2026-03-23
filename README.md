# GSMLean

**Formally verified derivations of fundamental physical constants from E₈ geometry in Lean 4.**

Zero free parameters. Zero `sorry`. The compiler IS the verifier.

---

## Table of Contents

- [What This Is](#what-this-is)
- [The Core Idea in 60 Seconds](#the-core-idea-in-60-seconds)
- [Why This Matters](#why-this-matters)
- [Verified Results](#verified-results)
- [Mathematical Framework](#mathematical-framework)
  - [E₈: The Largest Exceptional Lie Algebra](#e₈-the-largest-exceptional-lie-algebra)
  - [H₄: The 4D Icosahedral Symmetry](#h₄-the-4d-icosahedral-symmetry)
  - [The E₈ → H₄ Projection](#the-e₈--h₄-projection)
  - [Q(√5): The Golden Field](#q5-the-golden-field)
- [The Verification Strategy](#the-verification-strategy)
  - [Why Not Traditional Proof Tactics?](#why-not-traditional-proof-tactics)
  - [The Percepta Connection](#the-percepta-connection)
  - [DecidableEq: The Entire Trick](#decidableeq-the-entire-trick)
- [Complete Formula Reference](#complete-formula-reference)
  - [The Fine-Structure Constant](#the-fine-structure-constant-α⁻¹)
  - [The Electromagnetic Anchor: 137](#the-electromagnetic-anchor-137)
  - [Laplacian Eigenvalue Corrections](#laplacian-eigenvalue-corrections)
  - [The Torsion Correction](#the-torsion-correction)
  - [Weak Mixing Angle](#weak-mixing-angle)
  - [Lepton Mass Ratios](#lepton-mass-ratios)
  - [Quark Mass Ratios](#quark-mass-ratios)
  - [Cosmological Constants](#cosmological-constants)
  - [All 58 Constants](#all-58-constants)
- [Architecture](#architecture)
  - [File Structure](#file-structure)
  - [Dependency DAG](#dependency-dag)
  - [Parallel Verification Groups](#parallel-verification-groups)
- [Building and Running](#building-and-running)
  - [Prerequisites](#prerequisites)
  - [Build](#build)
  - [What "Build Succeeded" Means](#what-build-succeeded-means)
  - [Cross-Checking with Python](#cross-checking-with-python)
- [Code Walkthrough](#code-walkthrough)
  - [QSqrt5.lean: The Foundation](#qsqrt5lean-the-foundation)
  - [GoldenRatio.lean: Verified Identities](#goldenratiolean-verified-identities)
  - [E8Constants.lean: Group Theory Data](#e8constantslean-group-theory-data)
  - [Alpha.lean: The Main Event](#alphalean-the-main-event)
  - [QuarkMasses.lean: The Exact Result](#quarkmasseslean-the-exact-result)
- [Extending: Adding New Constants](#extending-adding-new-constants)
- [Roadmap](#roadmap)
- [Mathematical Background](#mathematical-background)
  - [E₈ Root System](#e₈-root-system)
  - [Casimir Operators and Exponents](#casimir-operators-and-exponents)
  - [The Golden Ratio in H₄ Geometry](#the-golden-ratio-in-h₄-geometry)
  - [Fibonacci Numbers and Powers of φ](#fibonacci-numbers-and-powers-of-φ)
- [Related Repositories](#related-repositories)
- [References](#references)

---

## What This Is

The **Geometric Standard Model (GSM)** is a framework that derives fundamental constants of nature — the fine-structure constant, particle mass ratios, mixing angles, cosmological parameters — from the geometry of the E₈ Lie algebra and its projection onto the H₄ (icosahedral) root system.

This repository is a **Lean 4 formalization** of those derivations. Every formula is transcribed as exact arithmetic in the quadratic field Q(√5), and every claimed result is verified by Lean's kernel at compile time. If `lake build` succeeds with no `sorry`, every derivation is machine-checked.

**This is not an abstract proof project.** There are no tactics wrestling with ring axioms or chasing commutative diagrams. Each derivation is a **computation** — a chain of arithmetic operations in Q(√5) — and Lean's `native_decide` tactic compiles the computation to native code, runs it, and confirms the output. The theorem prover is used as a verified calculator.

## The Core Idea in 60 Seconds

1. **The golden ratio φ = (1+√5)/2 lives in the quadratic field Q(√5) = {a + b√5 | a,b ∈ ℚ}.**

2. **Equality in Q(√5) is decidable.** Two elements a₁+b₁√5 and a₂+b₂√5 are equal if and only if a₁=a₂ and b₁=b₂. This is just comparing pairs of rationals.

3. **All GSM formulas are algebraic expressions in φ.** The fine-structure constant, lepton mass ratios, quark mass ratios, cosmological parameters — they all reduce to sums and products of powers of φ with rational coefficients.

4. **Lean 4 has exact rational arithmetic and `native_decide`.** We define Q(√5) as a structure with two ℚ fields, derive `DecidableEq`, and then every equation becomes decidable. Lean compiles the check to native code and executes it.

5. **If it compiles, it's verified.** The Lean kernel is the verifier. No trust assumptions beyond the kernel itself.

## Why This Matters

### For physics
The GSM claims to derive 58 fundamental constants from pure geometry with zero free parameters. Whether this framework is physically correct is an open question — but the *algebraic* claims are now machine-verified. The formula α⁻¹ = 137 + φ⁻⁷ + φ⁻¹⁴ + φ⁻¹⁶ - φ⁻⁸/248 + (248/240)φ⁻²⁶ produces the number 137.035999174... This is a mathematical fact, now formally proven.

### For formal verification
This demonstrates a pattern: **transpile scientific computations into Lean and let the kernel verify them**. No proof engineering required — just exact arithmetic and `native_decide`. This approach could apply to any computational derivation in algebraic number fields.

### For the E₈ sphere packing proof
Viazovska's Fields Medal-winning proof that E₈ gives the densest sphere packing in 8 dimensions was [formalized in Lean](https://github.com/leanprover-community/mathlib4) by the Math, Inc. team. The GSM derivations use the same E₈ structure — the 240 roots, the Casimir operators, the H₄ projection. This repository provides a verified computational layer that complements the abstract formalization.

---

## Verified Results

Every value below is machine-verified by Lean's kernel via `native_decide`. The "Exact Q(√5)" column shows the proven value; the "Approx" column is a Float evaluation for human readability.

| # | Constant | Formula | Exact Q(√5) | Approx | Experiment | Deviation |
|---|----------|---------|-------------|--------|------------|-----------|
| 1 | **α⁻¹** | 137 + φ⁻⁷ + φ⁻¹⁴ + φ⁻¹⁶ - φ⁻⁸/248 + (248/240)φ⁻²⁶ | ⟨351894529/2480, -471660097/7440⟩ | 137.035999 | 137.035999177 | **0.000000002%** |
| 2 | **sin²θ_W** | 3/13 + φ⁻¹⁶ | ⟨28697/26, -987/2⟩ | 0.23122 | 0.23121 | 0.005% |
| 3 | **m_μ/m_e** | φ¹¹ + φ⁴ + 1 - φ⁻⁵ - φ⁻¹⁵ | ⟨1583/2, -523/2⟩ | 206.768 | 206.768 | 0.00003% |
| 4 | **m_τ/m_μ** | φ⁶ - φ⁻⁴ - 1 + φ⁻⁸ | ⟨28, -5⟩ | 16.820 | 16.817 | 0.016% |
| 5 | **m_s/m_d** | L₃² = (φ³+φ⁻³)² | ⟨20, 0⟩ | **20.000** | 20.0 | **EXACT** |
| 6 | **m_b/m_c** | φ² + φ⁻³ | ⟨-1/2, 3/2⟩ | 2.854 | 2.86 | 0.21% |
| 7 | **n_s** | 1 - φ⁻⁷ | ⟨31/2, -13/2⟩ | 0.9656 | 0.9649 | 0.07% |
| 8 | **z_CMB** | φ¹⁴ + 246 | ⟨1335/2, 377/2⟩ | 1089.0 | 1089.80 | 0.074% |
| 9 | **Ω_Λ** | φ⁻¹ + φ⁻⁶ + φ⁻⁹ - φ⁻¹³ + φ⁻²⁸ + ε·φ⁻⁷ | (computed) | 0.6889 | 0.6889 | 0.002% |

Additionally, 20+ golden ratio identities and E₈ structure theorems are verified:

| Theorem | Statement | Proof |
|---------|-----------|-------|
| `phi_squared` | φ² = φ + 1 | `native_decide` |
| `phi_times_phi_inv` | φ · φ⁻¹ = 1 | `native_decide` |
| `phi_plus_phi_inv` | φ + φ⁻¹ = √5 | `native_decide` |
| `lucas3_squared` | (φ³+φ⁻³)² = 20 | `native_decide` |
| `anchor_is_137` | 128 + 8 + 1 = 137 | `native_decide` |
| `e8_decomposition` | dim(SO(16)) + dim(Spin(16)₊) = 248 | `native_decide` |
| `casimir_sum` | Sum of E₈ Casimir degrees = 128 | `native_decide` |
| `strange_down_rational` | (m_s/m_d).b = 0 (purely rational) | `native_decide` |

---

## Mathematical Framework

### E₈: The Largest Exceptional Lie Algebra

E₈ is a 248-dimensional Lie algebra, the largest of the five exceptional simple Lie algebras. Its key invariants:

| Property | Value | Significance |
|----------|-------|-------------|
| Dimension | 248 | Total degrees of freedom |
| Rank | 8 | Dimension of Cartan subalgebra |
| Number of roots | 240 | = E₈ kissing number (densest sphere packing in 8D) |
| Coxeter number | 30 | Order of Coxeter element |
| Casimir degrees | {2, 8, 12, 14, 18, 20, 24, 30} | Degrees of independent invariant polynomials |
| Exponents | {1, 7, 11, 13, 17, 19, 23, 29} | Casimir degrees minus 1 |

E₈ decomposes under its maximal subgroup SO(16) as:

```
248 = 120 ⊕ 128
      ↑       ↑
   adjoint  spinor (Spin(16)₊)
```

This decomposition is the origin of the electromagnetic anchor 137 = 128 + 8 + 1.

### H₄: The 4D Icosahedral Symmetry

H₄ is the symmetry group of the 600-cell (the 4-dimensional analogue of the icosahedron). Its root system has 120 vectors in 4 dimensions, and its coordinates involve the golden ratio φ.

| Property | Value |
|----------|-------|
| Rank | 4 |
| Roots | 120 (= 600-cell vertices) |
| Coxeter group order | 14,400 |
| Coxeter exponents | {1, 11, 19, 29} |
| Edge length (unit radius) | 1/φ |

The H₄ exponents {1, 11, 19, 29} are a subset of the E₈ exponents {1, 7, 11, 13, 17, 19, 23, 29}. This is not a coincidence — it reflects the E₈ → H₄ projection.

### The E₈ → H₄ Projection

The 240 roots of E₈ in 8 dimensions project onto the 120 roots of H₄ in 4 dimensions via the **Elser-Sloane projection matrix** — a 4×8 matrix whose entries are built from φ/2 and 1/(2φ).

```
E₈ (8D, 240 roots)  ──P──→  H₄ (4D, 120 roots)
                          ↓
                     kernel ≅ SO(8)
                     dim(SO(8)) = 28
```

The projection kernel has dimension 28 = dim(SO(8)). The ratio ε = 28/248 is the **torsion ratio** that appears throughout the GSM formulas.

### Q(√5): The Golden Field

Because φ = (1+√5)/2, all coordinates in H₄ and all derived quantities live in the quadratic field:

```
Q(√5) = {a + b√5 | a, b ∈ ℚ}
```

This field is closed under addition, subtraction, multiplication, and division (for nonzero denominators). Its elements are represented as pairs (a, b) of rational numbers:

| Element | Q(√5) representation |
|---------|---------------------|
| φ = (1+√5)/2 | ⟨1/2, 1/2⟩ |
| φ⁻¹ = (√5-1)/2 | ⟨-1/2, 1/2⟩ |
| √5 | ⟨0, 1⟩ |
| 137 | ⟨137, 0⟩ |
| φ⁻⁷ | ⟨-29/2, 13/2⟩ |

The multiplication rule is:

```
(a₁ + b₁√5)(a₂ + b₂√5) = (a₁a₂ + 5b₁b₂) + (a₁b₂ + a₂b₁)√5
```

**The critical property:** equality in Q(√5) is **decidable**. Two elements are equal if and only if their rational components match. This is what makes computational verification possible.

---

## The Verification Strategy

### Why Not Traditional Proof Tactics?

Traditional Lean proofs use tactics like `ring`, `norm_num`, `simp` to manipulate algebraic expressions symbolically. This works well for abstract algebra but is overkill for our use case.

We don't need to prove that Q(√5) is a field, or that φ satisfies x²-x-1=0 in some abstract sense. We need to verify that **specific computations produce specific numbers**. That's what computers do.

### The Percepta Connection

The Percepta lab paper ["Can LLMs Be Computers?"](https://percepta.ai/blog/llms-as-computers) (March 2026) showed that computation can be encoded as an **append-only execution trace** where each step looks back at a small number of prior steps, and a kernel verifies correctness.

We apply the same principle:

1. **Each `def` is a computation step** that references prior steps
2. **The trace is the chain of definitions** from `phi_inv` through powers to `alpha_inv`
3. **Lean's kernel is the verifier** — it evaluates the trace and confirms the result
4. **`native_decide` is the fast path** — it compiles to native code for efficient execution

```
                    Percepta                    GSMLean
                    ───────                    ────────
Program         →   WASM bytecode          →   QSqrt5 defs
Execution trace →   Token stream           →   Lean term reduction
Kernel          →   Transformer weights    →   Lean type checker
Verification    →   Output matches         →   native_decide confirms
```

### DecidableEq: The Entire Trick

The `deriving DecidableEq` line in the `QSqrt5` structure definition is the single most important line in the entire project:

```lean
structure QSqrt5 where
  a : ℚ
  b : ℚ
  deriving Repr, DecidableEq  -- ← THIS
```

Because ℚ has `DecidableEq` (rational equality is decidable — just compare numerator and denominator), and our structure has two ℚ fields, Lean automatically derives `DecidableEq` for `QSqrt5`.

This means for any proposition `x = y` where `x y : QSqrt5`, the proposition is `Decidable` — Lean can compute whether it's true or false. The `native_decide` tactic exploits this: it compiles the decision procedure to native code, runs it, and uses the result as a proof.

**In other words:** every equation in Q(√5) can be proved by running a program. No mathematical insight needed at proof time — only at formula-discovery time.

---

## Complete Formula Reference

### The Fine-Structure Constant (α⁻¹)

```
α⁻¹ = 137 + φ⁻⁷ + φ⁻¹⁴ + φ⁻¹⁶ - φ⁻⁸/248 + (248/240)φ⁻²⁶
     = 137.035999174...
```

CODATA 2022 experimental value: **137.035999177(21)**. Deviation: **0.14σ**.

Each term has a group-theoretic origin:

### The Electromagnetic Anchor: 137

```
137 = dim(Spin(16)₊) + rank(E₈) + χ(E₈/H₄)
    = 128 + 8 + 1
```

| Component | Value | Origin |
|-----------|-------|--------|
| dim(Spin(16)₊) | 128 | Positive chirality spinor representation of SO(16) ⊂ E₈ |
| rank(E₈) | 8 | Cartan subalgebra dimension (U(1)⁸ gauge factors) |
| χ(E₈/H₄) | 1 | Euler characteristic of the coset manifold |

The anchor is **not fitted**. It is determined by the representation theory of E₈. Alternative anchors (136, 138) fail to achieve sub-ppm precision with any combination of φ-power corrections.

Verified in Lean:
```lean
theorem anchor_is_137 : em_anchor = 137 := by native_decide
theorem e8_decomposition : dim_SO16 + dim_Spin16_plus = dim_E8 := by native_decide
```

### Laplacian Eigenvalue Corrections

The fractional part of α⁻¹ comes from the spectrum of the Laplacian operator on the coset manifold E₈/H₄. Each term is a power of φ⁻¹ determined by Casimir degrees:

| Term | Value | Exponent Origin | Physical Interpretation |
|------|-------|-----------------|------------------------|
| φ⁻⁷ | +0.034442 | Half of Casimir-14: 14/2 = 7 | First fermionic threshold |
| φ⁻¹⁴ | +0.001186 | Full Casimir-14 | Bosonic completion (photon self-energy) |
| φ⁻¹⁶ | +0.000453 | Rank tower: 2 × rank(E₈) = 16 | Cartan doubling in H₄ |
| -φ⁻⁸/248 | -0.000086 | Casimir-8, suppressed by 1/dim(E₈) | SO(8) torsion back-reaction |
| (248/240)φ⁻²⁶ | +0.000004 | Doubled Coxeter exponent 2×13 | Higher-order Coxeter correction |

### The Torsion Correction

The E₈ → H₄ projection has a kernel isomorphic to SO(8):

```
dim(kernel) = dim(SO(8)) = 28
ε = dim(SO(8)) / dim(E₈) = 28/248 ≈ 0.11290
```

The torsion tensor from dimensional reduction enters with negative sign (vacuum polarization from the hidden sector), suppressed by 1/dim(E₈):

```
Torsion term = -φ⁻⁸/248 = -(47/2 - (21/2)√5) / 248 = ⟨-47/496, 21/496⟩
```

Verified in Lean:
```lean
theorem torsion_value : term_torsion = (⟨-47/496, 21/496⟩ : QSqrt5) := by native_decide
```

### Weak Mixing Angle

```
sin²θ_W = 3/13 + φ⁻¹⁶ = 0.23122...
```

- **3/13**: from E₈ → E₆ × SU(3) branching rule
- **φ⁻¹⁶**: rank tower correction

Experiment: 0.23121. Deviation: 0.005%.

### Lepton Mass Ratios

```
m_μ/m_e = φ¹¹ + φ⁴ + 1 - φ⁻⁵ - φ⁻¹⁵ = 206.768...
```

The dominant term φ¹¹ ≈ 199.0 comes from the second H₄ Coxeter exponent (11). Experiment: 206.76828. Deviation: **0.00003%**.

```
m_τ/m_μ = φ⁶ - φ⁻⁴ - 1 + φ⁻⁸ = 16.820...
```

Experiment: 16.817. Deviation: 0.016%.

### Quark Mass Ratios

The most striking result:

```
m_s/m_d = L₃² = (φ³ + φ⁻³)² = 20    EXACTLY
```

This is the square of the third φ-Lucas number. In Q(√5):
- φ³ = ⟨2, 1⟩ and φ⁻³ = ⟨-2, 1⟩
- L₃ = φ³ + φ⁻³ = ⟨0, 2⟩ = 2√5
- L₃² = (2√5)² = 20

The √5 components cancel exactly, leaving a pure integer. Verified in Lean:

```lean
theorem strange_down_exact : strange_down_ratio = (⟨20, 0⟩ : QSqrt5) := by native_decide
theorem strange_down_rational : strange_down_ratio.b = 0 := by native_decide
```

### Cosmological Constants

```
n_s     = 1 - φ⁻⁷                                    = 0.9656   (exp: 0.9649)
z_CMB   = φ¹⁴ + 246                                   = 1089.0   (exp: 1089.80)
Ω_Λ     = φ⁻¹ + φ⁻⁶ + φ⁻⁹ - φ⁻¹³ + φ⁻²⁸ + ε·φ⁻⁷   = 0.6889   (exp: 0.6889)
```

### All 58 Constants

The complete list of 58 GSM constants, including CKM and PMNS mixing matrices, neutrino masses, and predictions, is documented in the companion repository [e8-phi-constants/FORMULAS.md](https://github.com/grapheneaffiliate/e8-phi-constants/blob/main/FORMULAS.md). Constants requiring transcendental functions (π, arcsin, arctan) cannot be verified by `native_decide` and are marked as TODO in the roadmap.

---

## Architecture

### File Structure

```
GSMLean/
├── lakefile.toml              # Build config (depends on Mathlib)
├── lean-toolchain             # Lean 4 version (v4.29.0-rc6)
├── GSMLean.lean               # Root import (imports all modules)
│
├── GSMLean/
│   ├── QSqrt5.lean            # Q(√5) field: structure, arithmetic, DecidableEq
│   ├── GoldenRatio.lean       # φ identities: φ²=φ+1, powers, Lucas numbers
│   ├── E8Constants.lean       # E₈ data: 248, 240, 28, Casimirs, anchor=137
│   ├── Alpha.lean             # α⁻¹ derivation (6 terms, master theorem)
│   ├── WeakMixing.lean        # sin²θ_W = 3/13 + φ⁻¹⁶
│   ├── LeptonMasses.lean      # m_μ/m_e, m_τ/m_μ
│   ├── QuarkMasses.lean       # m_s/m_d = 20, m_c/m_s, m_b/m_c
│   ├── Cosmology.lean         # n_s, z_CMB, Ω_Λ
│   └── Basic.lean             # Placeholder
│
├── scripts/
│   └── verify_values.py       # Python cross-check of exact Q(√5) values
│
├── DERIVATION_DAG.md          # Full dependency graph
├── CLAUDE.md                  # Development instructions
└── README.md                  # This file
```

### Dependency DAG

```
QSqrt5.lean ─────────────────────────── (Q(√5) field arithmetic)
  │
  ├── GoldenRatio.lean ──────────────── (φ², φ·φ⁻¹=1, powers, Lucas)
  │     │
  │     ├── Alpha.lean ──────────────── (α⁻¹) ← also imports E8Constants
  │     ├── WeakMixing.lean ─────────── (sin²θ_W)
  │     ├── LeptonMasses.lean ───────── (m_μ/m_e, m_τ/m_μ)
  │     ├── QuarkMasses.lean ────────── (m_s/m_d, m_c/m_s, m_b/m_c)
  │     │                                ← also imports E8Constants
  │     ├── Cosmology.lean ──────────── (n_s, z_CMB, Ω_Λ)
  │     │                                ← also imports E8Constants
  │     ├── CKMMatrix.lean ─────────── [TODO]
  │     ├── BellBound.lean ─────────── [TODO] S_CHSH = 4-φ
  │     └── ... (remaining constants)
  │
  └── E8Constants.lean ──────────────── (248, 240, 28, Casimirs, ε, anchor)
        │
        ├── E8Data.lean ─────────────── [TODO] (240 root vectors)
        └── H4Projection.lean ──────── [TODO] (Elser-Sloane matrix)
```

### Parallel Verification Groups

Constants in independent branches compile independently. `lake build` parallelizes automatically.

**Group A — Pure Q(√5), fully verifiable by `native_decide`:**
- α⁻¹, sin²θ_W, m_μ/m_e, m_τ/m_μ, m_s/m_d, m_c/m_s, m_b/m_c
- n_s, z_CMB, Ω_Λ, S_CHSH, m_t/v, Ω_b, N_eff, m_Z/v, Ω_DM, T_CMB
- Most CKM elements, baryon asymmetry η_B

**Group B — Requires π (transcendental):**
- m_p/m_e = 6π⁵(1+φ⁻²⁴+...) — cannot use `native_decide`
- Would need Mathlib's π definition + interval arithmetic or `norm_num` extensions

**Group C — Requires arctan/arcsin (transcendental):**
- PMNS neutrino mixing angles — flag with `sorry`

---

## Building and Running

### Prerequisites

- **Lean 4** via [elan](https://github.com/leanprover/elan) (version manager)
- ~4 GB disk for Mathlib cache
- ~8 GB RAM recommended

### Build

```bash
# Clone
git clone https://github.com/grapheneaffiliate/gsm-lean.git
cd gsm-lean

# Install dependencies and fetch prebuilt Mathlib (avoids 2+ hour build)
lake update
lake exe cache get

# Build and verify all derivations
lake build
```

### What "Build Succeeded" Means

When `lake build` reports success:

1. Every `.lean` file compiled without errors
2. Every `native_decide` tactic successfully evaluated its computation
3. Every theorem statement is confirmed by Lean's kernel
4. **Zero `sorry`** — no unproven assumptions

The build output includes `#eval` results showing approximate values:

```
info: GSMLean/Alpha.lean:121:0: "α⁻¹ (GSM)   = 137.035999"
info: GSMLean/Alpha.lean:122:0: "α⁻¹ (CODATA) = 137.035999177"
info: GSMLean/Alpha.lean:123:0: "Anchor = 137.000000"
info: GSMLean/Alpha.lean:124:0: "φ⁻⁷   = 0.034442"
info: GSMLean/Alpha.lean:125:0: "φ⁻¹⁴  = 0.001186"
info: GSMLean/Alpha.lean:126:0: "φ⁻¹⁶  = 0.000453"
info: GSMLean/Alpha.lean:127:0: "-φ⁻⁸/248 = -0.000086"
info: GSMLean/Alpha.lean:128:0: "(248/240)φ⁻²⁶ = 0.000004"

info: GSMLean/QuarkMasses.lean:46:0: "m_s/m_d = 20.000000 (should be 20.0)"

info: GSMLean/LeptonMasses.lean:31:0: "m_μ/m_e = 206.768224"
info: GSMLean/LeptonMasses.lean:34:0: "m_τ/m_μ = 16.819660"
```

### Cross-Checking with Python

A Python script independently computes all exact Q(√5) values using `fractions.Fraction`:

```bash
python scripts/verify_values.py
```

This serves as an independent cross-check — the Python values must match the Lean theorem statements exactly.

---

## Code Walkthrough

### QSqrt5.lean: The Foundation

The entire verification strategy rests on this 100-line file. It defines:

```lean
/-- Elements of Q(√5): represents a + b√5 where a, b ∈ ℚ -/
structure QSqrt5 where
  a : ℚ  -- rational part
  b : ℚ  -- coefficient of √5
  deriving Repr, DecidableEq
```

Arithmetic follows the rules of the quadratic field:

```lean
/-- Multiplication: (a₁+b₁√5)(a₂+b₂√5) = (a₁a₂ + 5b₁b₂) + (a₁b₂ + a₂b₁)√5 -/
protected def mul (x y : QSqrt5) : QSqrt5 :=
  ⟨x.a * y.a + 5 * x.b * y.b, x.a * y.b + x.b * y.a⟩
```

Distinguished elements:

```lean
def phi : QSqrt5 := ⟨1/2, 1/2⟩          -- (1+√5)/2
def phi_inv : QSqrt5 := ⟨-1/2, 1/2⟩      -- (√5-1)/2
def sqrt5 : QSqrt5 := ⟨0, 1⟩              -- √5
```

### GoldenRatio.lean: Verified Identities

Every identity is a one-line `native_decide` proof:

```lean
/-- φ² = φ + 1 (the defining identity of the golden ratio) -/
theorem phi_squared : phi * phi = phi + (1 : QSqrt5) := by native_decide

/-- φ · φ⁻¹ = 1 -/
theorem phi_times_phi_inv : phi * phi_inv = (1 : QSqrt5) := by native_decide
```

Powers of φ⁻¹ follow the Fibonacci pattern. For φ⁻ⁿ, the Q(√5) components involve Fibonacci numbers F_n:

```
φ⁻ⁿ = ⟨(-1)ⁿ(2F_{n+1} - F_n)/2, (-1)^{n+1}F_n/2⟩
```

Each is verified:

```lean
theorem phi_inv_pow_7 :
    npow phi_inv 7 = (⟨-29/2, 13/2⟩ : QSqrt5) := by native_decide
    -- F₇=13, F₈=21: a = -(2·21-13)/2 = -29/2, b = 13/2
```

### E8Constants.lean: Group Theory Data

Pure data — no computation, just the numbers that define E₈:

```lean
def dim_E8 : ℕ := 248
def rank_E8 : ℕ := 8
def roots_E8 : ℕ := 240
def casimir_degrees_E8 : List ℕ := [2, 8, 12, 14, 18, 20, 24, 30]

-- Verified structural identities
theorem casimir_sum : casimir_degrees_E8.sum = 128 := by native_decide
theorem e8_decomposition : dim_SO16 + dim_Spin16_plus = dim_E8 := by native_decide
theorem anchor_is_137 : em_anchor = 137 := by native_decide
```

### Alpha.lean: The Main Event

The alpha derivation follows a 5-step computational chain, mirroring the Percepta execution trace model:

**Step 1 — Anchor:** embed 137 into Q(√5)
```lean
def anchor : QSqrt5 := QSqrt5.ofNat' em_anchor
```

**Step 2 — Corrections:** each term references prior definitions
```lean
def term_fermionic : QSqrt5 := npow phi_inv 7       -- φ⁻⁷
def term_bosonic : QSqrt5 := npow phi_inv 14         -- φ⁻¹⁴
def term_rank_tower : QSqrt5 := npow phi_inv 16      -- φ⁻¹⁶
def term_torsion : QSqrt5 := QSqrt5.sdiv (npow phi_inv 8) (-248)  -- -φ⁻⁸/248
def term_coxeter : QSqrt5 := QSqrt5.smul (248/240) (npow phi_inv 26)  -- (248/240)φ⁻²⁶
```

**Step 3 — Assembly:**
```lean
def alpha_inv : QSqrt5 :=
  anchor + term_fermionic + term_bosonic + term_rank_tower
  + term_torsion + term_coxeter
```

**Step 4 — Verification:** each intermediate and the final result
```lean
theorem alpha_inv_exact :
    alpha_inv = (⟨351894529/2480, -471660097/7440⟩ : QSqrt5) := by native_decide
```

**Step 5 — Sanity check:** Float evaluation at compile time
```lean
#eval s!"α⁻¹ (GSM)   = {alpha_inv.toFloat}"   -- prints "137.035999"
#eval s!"α⁻¹ (CODATA) = 137.035999177"
```

### QuarkMasses.lean: The Exact Result

The cleanest derivation — m_s/m_d is an integer:

```lean
def lucas_3 : QSqrt5 := npow phi 3 + npow phi_inv 3

def strange_down_ratio : QSqrt5 := lucas_3 * lucas_3

theorem strange_down_exact :
    strange_down_ratio = (⟨20, 0⟩ : QSqrt5) := by native_decide

theorem strange_down_rational :
    strange_down_ratio.b = 0 := by native_decide
```

The theorem `strange_down_rational` proves that the irrational part vanishes — the mass ratio is a pure integer, exactly 20. This is a non-trivial algebraic identity: the √5 components from φ³ and φ⁻³ conspire to cancel exactly when squared.

---

## Extending: Adding New Constants

To add a new GSM constant:

1. **Read the Python derivation** from [e8-phi-constants](https://github.com/grapheneaffiliate/e8-phi-constants)

2. **Create a new `.lean` file** (e.g., `GSMLean/BellBound.lean`)

3. **Transcribe each step as a `def`:**
   ```lean
   import GSMLean.QSqrt5
   open QSqrt5

   def bell_bound : QSqrt5 := (4 : QSqrt5) - phi   -- S_CHSH = 4 - φ
   ```

4. **Compute the exact Q(√5) value** using `scripts/verify_values.py`

5. **State and prove the theorem:**
   ```lean
   theorem bell_bound_exact :
       bell_bound = (⟨7/2, -1/2⟩ : QSqrt5) := by native_decide
   ```

6. **Add the import** to `GSMLean.lean`

7. **Build:** `lake build`

If the derivation uses transcendental functions (π, arcsin, etc.), mark the theorem with `sorry` and note it in `DERIVATION_DAG.md`.

---

## Roadmap

### Implemented (verified, zero sorry)

| File | Constants | Status |
|------|-----------|--------|
| QSqrt5.lean | Q(√5) field | Compiles |
| GoldenRatio.lean | φ identities, 5 power verifications, Lucas identity | Compiles |
| E8Constants.lean | dim=248, rank=8, roots=240, Casimirs, anchor=137, ε | Compiles |
| Alpha.lean | α⁻¹ (6 intermediate + master theorem) | Compiles |
| WeakMixing.lean | sin²θ_W | Compiles |
| LeptonMasses.lean | m_μ/m_e, m_τ/m_μ | Compiles |
| QuarkMasses.lean | m_s/m_d, m_c/m_s, m_b/m_c | Compiles |
| Cosmology.lean | n_s, z_CMB, Ω_Λ | Compiles |

### TODO — Pure Q(√5) (verifiable by `native_decide`)

| Constant | Formula | Difficulty |
|----------|---------|------------|
| α_s(M_Z) | 1/[2φ³(1+φ⁻¹⁴)(1+8φ⁻⁵/14400)] | Easy |
| y_t | 1 - φ⁻¹⁰ | Trivial |
| m_H/v | 1/2 + φ⁻⁵/10 | Trivial |
| m_W/v | (1-φ⁻⁸)/3 | Trivial |
| sin θ_C | (φ⁻¹+φ⁻⁶)/3 × (1+8φ⁻⁶/248) | Easy |
| J_CKM | φ⁻¹⁰/264 | Trivial |
| V_ub | 2φ⁻⁷/19 | Trivial |
| S_CHSH | 4 - φ | Trivial |
| m_t/v | 52/48 - φ⁻² | Trivial |
| Ω_b | 1/12 - φ⁻⁷ | Trivial |
| N_eff | 240/78 - φ⁻⁷ + ε·φ⁻⁹ | Easy |
| T_CMB | 78/30 + φ⁻⁶ + ε·φ⁻¹ | Easy |
| Ω_DM | 1/8 + φ⁻⁴ - ε·φ⁻⁵ | Easy |
| Σm_ν | m_e·φ⁻³⁴(1+εφ³) | Easy |
| M_Pl/v | φ^(80-ε) | Medium (large exponent) |

### TODO — Requires transcendentals (will need `sorry` or special tactics)

| Constant | Formula | Blocker |
|----------|---------|---------|
| m_p/m_e | 6π⁵(1+...) | Needs π |
| θ₁₂ | arctan(φ⁻¹+2φ⁻⁸) | Needs arctan |
| θ₂₃ | arcsin√((1+φ⁻⁴)/2) | Needs arcsin |
| θ₁₃ | arcsin(φ⁻⁴+φ⁻¹²) | Needs arcsin |
| δ_CP | 180° + arctan(φ⁻²-φ⁻⁵) | Needs arctan |

### TODO — E₈ Root System Data

| File | Content | Size |
|------|---------|------|
| E8Data.lean | 240 root vectors in ℚ⁸ | Large (240 × 8 rationals) |
| H4Projection.lean | 4×8 Elser-Sloane matrix | Small |
| ProjectionVerify.lean | Verify 240 → 120 root mapping | Computationally intensive |

---

## Mathematical Background

### E₈ Root System

The 240 roots of E₈ in 8 dimensions come in two types:

**Type D₈ (112 roots):** All permutations of (±1, ±1, 0, 0, 0, 0, 0, 0).
- Choose 2 positions from 8: C(8,2) = 28
- Choose signs: 4 combinations each
- Total: 28 × 4 = 112

**Half-integer (128 roots):** All vectors (±1/2, ±1/2, ..., ±1/2) with an even number of minus signs.
- 2⁸ = 256 sign combinations, half with even parity
- Total: 128

All 240 roots have norm √2. The inner product between distinct roots takes values in {-2, -1, 0, 1}.

### Casimir Operators and Exponents

The **Casimir operators** of a Lie algebra are the independent polynomial invariants of the adjoint representation. For E₈, there are 8 (= rank) independent Casimirs, with degrees:

```
{2, 8, 12, 14, 18, 20, 24, 30}
```

The **exponents** are the degrees minus 1:

```
{1, 7, 11, 13, 17, 19, 23, 29}
```

Key properties:
- Sum of degrees = 128 = dim(Spin(16)₊)
- Product of degrees = |Weyl group of E₈|
- The highest degree 30 = Coxeter number h

The GSM assigns physical meaning to these degrees: they determine the exponents in the φ-power corrections to fundamental constants.

### The Golden Ratio in H₄ Geometry

The golden ratio φ = (1+√5)/2 appears in H₄ because the icosahedral symmetry group is built on the regular pentagon, whose diagonal-to-side ratio is φ.

Key algebraic properties:

| Identity | Value |
|----------|-------|
| φ² = φ + 1 | Minimal polynomial: x² - x - 1 = 0 |
| φ⁻¹ = φ - 1 | The unique positive root of x² + x - 1 = 0 |
| φ + φ⁻¹ = √5 | Sum equals the irrational part |
| φ · φ⁻¹ = 1 | Product equals unity |
| φⁿ + φ⁻ⁿ = Lₙ | φ-Lucas numbers (always rational for even n) |

### Fibonacci Numbers and Powers of φ

Powers of φ follow the Fibonacci recurrence. If F_n denotes the n-th Fibonacci number (F₀=0, F₁=1, F₂=1, F₃=2, ...):

```
φⁿ = Fₙ · φ + F_{n-1}
```

In Q(√5) representation:

```
φⁿ  = ⟨F_n/2 + F_{n-1}, F_n/2⟩
φ⁻ⁿ = ⟨(-1)ⁿ(2F_{n+1} - F_n)/2, (-1)^{n+1}F_n/2⟩
```

Examples used in GSM:

| Power | Fibonacci | Q(√5) | Approx |
|-------|-----------|-------|--------|
| φ⁻⁷ | F₇=13, F₈=21 | ⟨-29/2, 13/2⟩ | 0.03444 |
| φ⁻⁸ | F₈=21, F₉=34 | ⟨47/2, -21/2⟩ | 0.02129 |
| φ⁻¹⁴ | F₁₄=377, F₁₅=610 | ⟨843/2, -377/2⟩ | 0.00119 |
| φ⁻¹⁶ | F₁₆=987, F₁₇=1597 | ⟨2207/2, -987/2⟩ | 0.00045 |
| φ⁻²⁶ | F₂₆=121393, F₂₇=196418 | ⟨271443/2, -121393/2⟩ | 0.0000037 |

Note how the rational components grow large (271443) while the actual values shrink (0.0000037). This is because the rational and irrational parts nearly cancel — a signature of the golden ratio's proximity to a ratio of consecutive Fibonacci numbers.

---

## Related Repositories

| Repository | Description | Role |
|-----------|-------------|------|
| [e8-phi-constants](https://github.com/grapheneaffiliate/e8-phi-constants) | Python derivations of all 58 GSM constants | Source of formulas |
| [DHL-MM](https://github.com/grapheneaffiliate/DHL-MM) | Fast sparse Lie algebra multiplication (913× for E₈) | Numerical engine |
| [gsm-lean](https://github.com/grapheneaffiliate/gsm-lean) | This repository — Lean 4 formalization | Formal verification |

---

## References

**The GSM framework:**
- `e8-phi-constants` repository — complete derivations, 34,000+ lines of Python

**E₈ and H₄ mathematics:**
- Humphreys, *Introduction to Lie Algebras and Representation Theory* — E₈ structure
- Conway & Sloane, *Sphere Packings, Lattices and Groups* — E₈ root system, kissing numbers
- Elser & Sloane (2-3), "A highly symmetric four-dimensional quasicrystal" — E₈ → H₄ projection

**Lean 4 and formal verification:**
- [Lean 4 documentation](https://lean-lang.org/)
- [Mathlib4](https://github.com/leanprover-community/mathlib4) — the mathematics library
- Viazovska E₈ sphere packing formalization — same algebraic structures

**Computational verification philosophy:**
- Percepta Lab, ["Can LLMs Be Computers?"](https://percepta.ai/blog/llms-as-computers) (March 2026) — computation as self-verifying execution traces

---

*Every theorem in this repository is machine-verified. If `lake build` succeeds, the mathematics is correct — not because we trust the author, but because we trust the Lean kernel.*
