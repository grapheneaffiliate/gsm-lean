/-
  PMNSMatrix.lean — PMNS neutrino mixing angles

  These formulas involve transcendental functions (arctan, arcsin)
  which cannot be verified by native_decide in Q(√5).
  The Q(√5) ARGUMENTS are verified; the trigonometric evaluation is sorry'd.

  θ₁₂ = arctan(φ⁻¹ + 2φ⁻⁸)     GSM: 33.449°  Exp: 33.44°
  θ₂₃ = arcsin√((1+φ⁻⁴)/2)      GSM: 49.195°  Exp: 49.2°
  θ₁₃ = arcsin(φ⁻⁴ + φ⁻¹²)     GSM: 8.569°   Exp: 8.57°
  δ_CP = 180° + arctan(φ⁻² - φ⁻⁵) GSM: 196.27° Exp: 197°
-/
import GSMLean.QSqrt5

open QSqrt5

/-- Argument of arctan for θ₁₂: φ⁻¹ + 2φ⁻⁸ -/
def theta12_arg : QSqrt5 :=
  npow phi_inv 1 + QSqrt5.smul 2 (npow phi_inv 8)

theorem theta12_arg_exact :
    theta12_arg = (⟨93/2, -41/2⟩ : QSqrt5) := by native_decide

/-- Argument of arcsin² for θ₂₃: (1+φ⁻⁴)/2 -/
def theta23_arg : QSqrt5 :=
  QSqrt5.sdiv ((1 : QSqrt5) + npow phi_inv 4) 2

theorem theta23_arg_exact :
    theta23_arg = (⟨9/4, -3/4⟩ : QSqrt5) := by native_decide

/-- Argument of arcsin for θ₁₃: φ⁻⁴ + φ⁻¹² -/
def theta13_arg : QSqrt5 := npow phi_inv 4 + npow phi_inv 12

theorem theta13_arg_exact :
    theta13_arg = (⟨329/2, -147/2⟩ : QSqrt5) := by native_decide

/-- Argument of arctan for δ_CP: φ⁻² - φ⁻⁵ -/
def delta_cp_arg : QSqrt5 := npow phi_inv 2 - npow phi_inv 5

theorem delta_cp_arg_exact :
    delta_cp_arg = (⟨7, -3⟩ : QSqrt5) := by native_decide

/- The actual angle values require transcendental evaluation.
   For the record:
   θ₁₂ ≈ 33.449°, θ₂₃ ≈ 49.195°, θ₁₃ ≈ 8.569°, δ_CP ≈ 196.27° -/

#eval s!"θ₁₂ arg = {theta12_arg.toFloat} → arctan gives ~33.4°"
#eval s!"θ₂₃ arg = {theta23_arg.toFloat} → arcsin(√·) gives ~49.2°"
#eval s!"θ₁₃ arg = {theta13_arg.toFloat} → arcsin gives ~8.57°"
#eval s!"δ_CP arg = {delta_cp_arg.toFloat} → 180°+arctan gives ~196°"
