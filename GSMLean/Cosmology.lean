/-
  Cosmology.lean — Cosmological constants from E₈/H₄ geometry

  Dark energy fraction, CMB redshift, Hubble constant, spectral index.
-/
import GSMLean.QSqrt5
import GSMLean.E8Constants

open QSqrt5

/-- Spectral index n_s = 1 - φ⁻⁷
    GSM: 0.9656, Experiment: 0.9649 (0.07%) -/
def spectral_index : QSqrt5 :=
  (1 : QSqrt5) - npow phi_inv 7

/-- CMB redshift z_CMB = φ¹⁴ + 246
    GSM: 1089.0, Experiment: 1089.80 (0.074%)
    The 246 = dim(E₈) - 2 = 248 - 2. -/
def z_cmb : QSqrt5 :=
  npow phi 14 + QSqrt5.ofNat' 246

/-- z_CMB exact value -/
theorem z_cmb_exact :
    z_cmb = (⟨1335/2, 377/2⟩ : QSqrt5) := by native_decide

/-- Dark energy density Ω_Λ = φ⁻¹ + φ⁻⁶ + φ⁻⁹ - φ⁻¹³ + φ⁻²⁸ + ε·φ⁻⁷
    GSM: 0.68889, Experiment: 0.6889 (0.002%) -/
def dark_energy : QSqrt5 :=
  npow phi_inv 1 + npow phi_inv 6 + npow phi_inv 9
  - npow phi_inv 13 + npow phi_inv 28
  + QSqrt5.smul torsion_ratio (npow phi_inv 7)

#eval s!"n_s    = {spectral_index.toFloat} (exp: 0.9649)"
#eval s!"z_CMB  = {z_cmb.toFloat} (exp: 1089.80)"
#eval s!"Ω_Λ    = {dark_energy.toFloat} (exp: 0.6889)"
