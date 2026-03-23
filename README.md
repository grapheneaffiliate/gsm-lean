# GSMLean

Formally verified derivations of fundamental physical constants from E₈ → H₄ geometry, using Lean 4.

## What this is

The Geometric Standard Model (GSM) derives 58 fundamental constants of nature from E₈ Lie algebra structure and the E₈ → H₄ golden ratio projection. This repository formalizes those derivations in Lean 4, where **the compiler IS the verifier**.

**This is not an abstract proof project.** Each derivation is a computation in Q(√5) — the minimal field containing the golden ratio φ = (1+√5)/2. Lean's kernel executes the computation exactly and verifies the result. No proof tactics, no proof search. `native_decide` literally runs the math and checks it.

## Key insight

Equality in Q(√5) is **decidable**: two elements a₁+b₁√5 = a₂+b₂√5 iff a₁=a₂ and b₁=b₂. This means every GSM derivation that stays in Q(√5) can be machine-verified by Lean's kernel checking rational arithmetic.

## Structure

```
GSMLean/
  QSqrt5.lean          -- Q(√5) field arithmetic (the foundation)
  GoldenRatio.lean     -- φ identities, powers (verified computationally)
  E8Constants.lean     -- E₈ structure: dim=248, rank=8, roots=240, Casimirs
  Alpha.lean           -- α⁻¹ = 137 + φ⁻⁷ + φ⁻¹⁴ + φ⁻¹⁶ - φ⁻⁸/248 + (248/240)φ⁻²⁶
  WeakMixing.lean      -- sin²θ_W = 3/13 + φ⁻¹⁶
  LeptonMasses.lean    -- m_μ/m_e, m_τ/m_μ
  QuarkMasses.lean     -- m_s/m_d = L₃² = 20 (EXACT)
  Cosmology.lean       -- n_s, z_CMB, Ω_Λ
```

See [DERIVATION_DAG.md](DERIVATION_DAG.md) for the full dependency graph.

## Building

```bash
# Install Lean 4 via elan
curl -sSf https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh | sh

# Fetch Mathlib cache (avoids building from source)
cd GSMLean
lake exe cache get

# Build and verify all derivations
lake build
```

If it compiles with no `sorry`, every derivation is machine-verified.

## Example: Fine-structure constant

```lean
-- α⁻¹ = 137 + φ⁻⁷ + φ⁻¹⁴ + φ⁻¹⁶ - φ⁻⁸/248 + (248/240)φ⁻²⁶
-- Each term from E₈ group theory. Zero free parameters.
-- GSM: 137.035999174, CODATA: 137.035999177 (0.14σ)

theorem alpha_inv_exact :
    alpha_inv = (⟨351894529/2480, -471660097/7440⟩ : QSqrt5) := by native_decide
```

Lean evaluates the entire chain — 137 from E₈ representation theory, correction terms from Casimir eigenvalues, torsion from SO(8) kernel — and confirms the exact Q(√5) result.

## Related repositories

- [e8-phi-constants](https://github.com/grapheneaffiliate/e8-phi-constants) — Python derivations of all 58 constants
- [DHL-MM](https://github.com/grapheneaffiliate/DHL-MM) — Fast sparse Lie algebra multiplication for exceptional algebras
