# GSM Derivation Dependency Graph

## Architecture

All 58 GSM constants derive from E₈ geometry through Q(√5) arithmetic.
The dependency DAG determines which constants can be verified in parallel.

```
QSqrt5.lean (Q(√5) field arithmetic)
├── GoldenRatio.lean (φ identities, powers)
│   ├── Alpha.lean (α⁻¹) ← also depends on E8Constants
│   ├── WeakMixing.lean (sin²θ_W)
│   ├── LeptonMasses.lean (m_μ/m_e, m_τ/m_μ)
│   ├── QuarkMasses.lean (m_s/m_d, m_c/m_s, m_b/m_c) ← also depends on E8Constants
│   ├── Cosmology.lean (Ω_Λ, z_CMB, n_s) ← also depends on E8Constants
│   ├── CKMMatrix.lean (V_us, V_cb, V_ub, J_CKM) [TODO]
│   ├── PMNSMatrix.lean (θ₁₂, θ₂₃, θ₁₃) [TODO — requires transcendentals]
│   ├── NeutrinoMass.lean (Σm_ν) [TODO]
│   ├── ProtonMass.lean (m_p/m_e) [TODO — requires π]
│   ├── Hierarchy.lean (M_Pl/v) [TODO]
│   └── BellBound.lean (S_CHSH = 4-φ) [TODO]
└── E8Constants.lean (248, 240, 28, Casimir degrees)
    └── E8Data.lean (240 root vectors) [TODO]
        └── H4Projection.lean (Elser-Sloane matrix) [TODO]
```

## Parallel verification groups

Constants in independent branches compile independently.
`lake build` parallelizes automatically.

### Group A: Pure Q(√5) (no transcendentals)
- α⁻¹, sin²θ_W, m_μ/m_e, m_τ/m_μ, m_s/m_d, m_c/m_s, m_b/m_c
- n_s, z_CMB, Ω_Λ, S_CHSH, m_t/v, Ω_b, N_eff, m_Z/v, Ω_DM, T_CMB

### Group B: Requires π (transcendental)
- m_p/m_e = 6π⁵(1+...) — cannot be `native_decide`, needs `sorry` or norm_num

### Group C: Requires arctan/arcsin (transcendental)
- PMNS angles θ₁₂, θ₂₃, θ₁₃, δ_CP — flag with `sorry`

## Status

| File | Constants | Status |
|------|-----------|--------|
| QSqrt5.lean | (foundation) | ✅ Complete |
| GoldenRatio.lean | φ identities | ✅ Complete |
| E8Constants.lean | Structure constants | ✅ Complete |
| Alpha.lean | α⁻¹ | ✅ Complete |
| WeakMixing.lean | sin²θ_W | ✅ Complete |
| LeptonMasses.lean | m_μ/m_e, m_τ/m_μ | ✅ Complete |
| QuarkMasses.lean | m_s/m_d, m_c/m_s, m_b/m_c | ✅ Complete |
| Cosmology.lean | n_s, z_CMB, Ω_Λ | ✅ Complete |
| CKMMatrix.lean | V_us, V_cb, V_ub, J | ⬚ TODO |
| PMNSMatrix.lean | θ₁₂, θ₂₃, θ₁₃, δ_CP | ⬚ TODO (transcendental) |
| NeutrinoMass.lean | Σm_ν | ⬚ TODO |
| ProtonMass.lean | m_p/m_e | ⬚ TODO (needs π) |
| Hierarchy.lean | M_Pl/v | ⬚ TODO |
| BellBound.lean | S_CHSH = 4-φ | ⬚ TODO |
| E8Data.lean | 240 roots | ⬚ TODO |
| H4Projection.lean | Elser-Sloane | ⬚ TODO |
