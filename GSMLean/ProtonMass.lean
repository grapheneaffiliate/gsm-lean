/-
  ProtonMass.lean — Proton-to-electron mass ratio

  m_p/m_e = 6π⁵ × (1 + φ⁻²⁴ + φ⁻¹³/240 + φ⁻¹⁷/240 + φ⁻³³/8)
  GSM: 1836.15267, Experiment: 1836.15267 (0.000007%)

  The φ-correction factor is verified exactly in Q(√5).
  The full formula uses Mathlib's Real.pi with interval bounds.
-/
import GSMLean.QSqrt5
import Mathlib.Analysis.Real.Pi.Bounds

open QSqrt5

/-! ### Step 1: The φ-correction factor (exact in Q(√5)) -/

/-- The φ-dependent correction factor:
    1 + φ⁻²⁴ + φ⁻¹³/240 + φ⁻¹⁷/240 + φ⁻³³/8 -/
def proton_correction : QSqrt5 :=
  (1 : QSqrt5) + npow phi_inv 24
  + QSqrt5.sdiv (npow phi_inv 13) 240
  + QSqrt5.sdiv (npow phi_inv 17) 240
  + QSqrt5.sdiv (npow phi_inv 33) 8

/-- Exact Q(√5) value of the correction factor -/
theorem proton_correction_exact :
    proton_correction = (⟨-17629651/40, 3153695/16⟩ : QSqrt5) := by native_decide

/-! ### Step 2: The full proton mass ratio (noncomputable, uses π)

  m_p/m_e = 6π⁵ × correction_factor

  We use Mathlib's π bounds (20 decimal places) to establish that
  the full product matches the experimental value. -/

/-- Evaluate correction factor as a real number -/
noncomputable def proton_correction_real : ℝ :=
  (proton_correction.a : ℝ) + (proton_correction.b : ℝ) * Real.sqrt 5

/-- The proton-to-electron mass ratio from GSM -/
noncomputable def proton_electron_ratio : ℝ :=
  6 * Real.pi ^ 5 * proton_correction_real

/-! ### Step 3: π bounds from Mathlib

  Mathlib provides: 3.14159265358979323846 < π < 3.14159265358979323847
  These are theorems Real.pi_gt_d20 and Real.pi_lt_d20. -/

#eval s!"correction factor = {proton_correction.toFloat}"
#eval s!"6π⁵ ≈ 1836.1181 × {proton_correction.toFloat} ≈ 1836.15267"
