# GSM Derivation Dependency Graph

## Architecture

All GSM constants derive from E₈ geometry through Q(√5) arithmetic.
The dependency DAG determines which constants can be verified in parallel.

```
QSqrt5.lean (Q(√5) field arithmetic)
├── GoldenRatio.lean (φ identities, powers, Lucas numbers)
│   ├── Alpha.lean (α⁻¹)
│   ├── WeakMixing.lean (sin²θ_W)
│   ├── StrongCoupling.lean (α_s)
│   ├── Electroweak.lean (y_t, m_H/v, m_W/v, m_t/v, m_Z/v)
│   ├── LeptonMasses.lean (m_μ/m_e, m_τ/m_μ)
│   ├── QuarkMasses.lean (m_s/m_d, m_c/m_s, m_b/m_c)
│   ├── CKMMatrix.lean (sin θ_C, J_CKM, V_ub)
│   ├── PMNSMatrix.lean (θ₁₂, θ₂₃, θ₁₃, δ_CP arguments)
│   ├── NeutrinoMass.lean (Σm_ν factor)
│   ├── Cosmology.lean (Ω_Λ, z_CMB, n_s)
│   ├── ExtendedConstants.lean (Ω_b, N_eff, Ω_DM, T_CMB, (mn-mp)/me, η_B)
│   ├── CompositeQCD.lean (B_d/m_p, σ₈)
│   ├── ProtonMass.lean (m_p/m_e correction factor)
│   ├── BellBound.lean (S_CHSH = 4-φ)
│   ├── Predictions.lean (Δm² ratio, r, m_π/m_e)
│   └── Hierarchy.lean (exponent derivation)
└── E8Constants.lean (248, 240, 28, Casimir degrees, ε)
    ├── E8Data.lean (240 root vectors, count + norm verification)
    └── H4Projection.lean (Elser-Sloane matrix, coefficients)
```

## Status

| File | Constants | Theorems | Status |
|------|-----------|----------|--------|
| QSqrt5.lean | Q(√5) field | DecidableEq | Done |
| GoldenRatio.lean | φ identities | 10 theorems | Done |
| E8Constants.lean | Structure constants | 5 theorems | Done |
| E8Data.lean | 240 root vectors | count=240, all norms=2 | Done |
| H4Projection.lean | Elser-Sloane matrix | 5 coefficient identities | Done |
| Alpha.lean | α⁻¹ | 7 theorems (each term + master) | Done |
| WeakMixing.lean | sin²θ_W | 1 theorem | Done |
| StrongCoupling.lean | α_s(M_Z) | 1 theorem | Done |
| Electroweak.lean | y_t, m_H/v, m_W/v, m_t/v, m_Z/v | 5 theorems | Done |
| LeptonMasses.lean | m_μ/m_e, m_τ/m_μ | 1 theorem | Done |
| QuarkMasses.lean | m_s/m_d, m_c/m_s, m_b/m_c | 2 theorems | Done |
| CKMMatrix.lean | sin θ_C, J_CKM, V_ub | 3 theorems | Done |
| PMNSMatrix.lean | θ₁₂, θ₂₃, θ₁₃, δ_CP (arguments) | 4 theorems | Done |
| NeutrinoMass.lean | Σm_ν factor | 1 theorem | Done |
| Cosmology.lean | n_s, z_CMB, Ω_Λ | 1 theorem | Done |
| ExtendedConstants.lean | Ω_b, N_eff, Ω_DM, T_CMB, (mn-mp)/me, η_B | 5 theorems | Done |
| CompositeQCD.lean | B_d/m_p, σ₈ | 2 theorems | Done |
| ProtonMass.lean | m_p/m_e correction | (needs π for full) | Done |
| BellBound.lean | S_CHSH = 4-φ | 3 theorems | Done |
| Predictions.lean | Δm² ratio, r, m_π/m_e | 3 theorems | Done |
| Hierarchy.lean | Hierarchy exponent | 2 theorems | Done |

**Total: 21 Lean files, 810 build jobs, 0 sorry, 0 errors.**

## Notes on limitations

- **V_cb** involves √2 (not in Q(√5)) — omitted from CKMMatrix.lean
- **M_Pl/v = φ^(80-ε)** has non-integer exponent — not in Q(√5), verified structurally only
- **m_p/m_e = 6π⁵(...)** involves π — correction factor verified, full product requires real analysis
- **PMNS angles** involve arctan/arcsin — Q(√5) arguments verified, transcendental evaluation not formalized
