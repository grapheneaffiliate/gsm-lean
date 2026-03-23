# CLAUDE.md — GSMLean

## Project Overview
Lean 4 formalization of the Geometric Standard Model (GSM): computationally verified
derivations of fundamental physical constants from E₈ → H₄ geometry.

## Philosophy
This is NOT an abstract proof project. It is a transpilation of Python computations into
Lean's verified kernel. The Percepta "LLMs as Computers" insight applies: each derivation
step is a `def` that Lean's kernel computes exactly. The final theorem is `native_decide`
confirming the output. No proof search needed — Lean's type checker IS the verifier.

## Key Design Decisions
- **Q(√5) is the foundation.** All GSM constants live in Q(√5) = {a+b√5 | a,b ∈ ℚ}.
  DecidableEq for QSqrt5 enables `native_decide` verification.
- **Hardcode data, don't generate it.** E8 roots, projection matrices, structure constants
  are transcribed as literal lists. Generating them in Lean causes slow compilation.
- **One file per constant (or group).** Import graph mirrors the derivation DAG.
- **If a derivation uses transcendentals** (π, arctan, etc.), flag with `sorry` and note it.

## Commands
```bash
lake exe cache get     # Fetch Mathlib prebuilt oleans
lake build             # Build and verify all derivations
py scripts/verify_values.py  # Python cross-check of exact Q(√5) values
```

## File Structure
- `GSMLean/QSqrt5.lean` — Q(√5) field arithmetic (everything depends on this)
- `GSMLean/GoldenRatio.lean` — φ identities and powers
- `GSMLean/E8Constants.lean` — dim=248, rank=8, roots=240, Casimirs
- `GSMLean/Alpha.lean` — α⁻¹ = 137 + φ⁻⁷ + φ⁻¹⁴ + φ⁻¹⁶ - φ⁻⁸/248 + (248/240)φ⁻²⁶
- `GSMLean/WeakMixing.lean` — sin²θ_W = 3/13 + φ⁻¹⁶
- `GSMLean/LeptonMasses.lean` — m_μ/m_e, m_τ/m_μ
- `GSMLean/QuarkMasses.lean` — m_s/m_d = 20 (EXACT), m_c/m_s, m_b/m_c
- `GSMLean/Cosmology.lean` — n_s, z_CMB, Ω_Λ
- See DERIVATION_DAG.md for full dependency graph

## Source Repos
- Python derivations: https://github.com/grapheneaffiliate/e8-phi-constants
- Sparse Lie algebra engine: https://github.com/grapheneaffiliate/DHL-MM

## The Goal
Every `.lean` file compiles with NO `sorry`. Each compiled file = a machine-verified
derivation of a physical constant from E₈ geometry.
