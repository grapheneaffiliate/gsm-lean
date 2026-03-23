/-
  PMNSMatrix.lean — PMNS neutrino mixing angles

  Each angle is defined as arctan or arcsin of a Q(√5) argument.
  The Q(√5) arguments are verified by native_decide.
  The angle definitions use Mathlib's Real.arctan/Real.arcsin.
  Key identity: tan(arctan(x)) = x (by Real.tan_arctan).
-/
import GSMLean.QSqrt5
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse

open QSqrt5

/-! ### Q(√5) arguments (verified computationally) -/

/-- Argument of arctan for θ₁₂: φ⁻¹ + 2φ⁻⁸ -/
def theta12_arg : QSqrt5 := npow phi_inv 1 + QSqrt5.smul 2 (npow phi_inv 8)

theorem theta12_arg_exact :
    theta12_arg = (⟨93/2, -41/2⟩ : QSqrt5) := by native_decide

/-- Argument of arcsin² for θ₂₃: (1+φ⁻⁴)/2 -/
def theta23_arg : QSqrt5 := QSqrt5.sdiv ((1 : QSqrt5) + npow phi_inv 4) 2

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

/-! ### Real-valued angle definitions using Mathlib

  These are noncomputable (they use classical choice via arctan/arcsin)
  but they are mathematically precise definitions. -/

/-- Evaluate a QSqrt5 element as a real number -/
noncomputable def QSqrt5.toReal (x : QSqrt5) : ℝ :=
  (x.a : ℝ) + (x.b : ℝ) * Real.sqrt 5

/-- θ₁₂ = arctan(φ⁻¹ + 2φ⁻⁸) ≈ 33.449° -/
noncomputable def theta12 : ℝ := Real.arctan (theta12_arg.toReal)

/-- θ₂₃ = arcsin(√((1+φ⁻⁴)/2)) ≈ 49.195° -/
noncomputable def theta23 : ℝ := Real.arcsin (Real.sqrt (theta23_arg.toReal))

/-- θ₁₃ = arcsin(φ⁻⁴ + φ⁻¹²) ≈ 8.569° -/
noncomputable def theta13 : ℝ := Real.arcsin (theta13_arg.toReal)

/-- δ_CP = π + arctan(φ⁻² - φ⁻⁵) ≈ 196.27° (= 180° + 16.27°) -/
noncomputable def delta_cp : ℝ := Real.pi + Real.arctan (delta_cp_arg.toReal)

/-! ### Fundamental identities

  These follow directly from the definitions of arctan and arcsin. -/

/-- tan(θ₁₂) = φ⁻¹ + 2φ⁻⁸ (by definition of arctan) -/
theorem tan_theta12 : Real.tan theta12 = theta12_arg.toReal :=
  Real.tan_arctan _

/-- sin(θ₁₃) = φ⁻⁴ + φ⁻¹² (requires argument in [-1, 1]) -/
theorem sin_theta13 (h1 : -1 ≤ theta13_arg.toReal) (h2 : theta13_arg.toReal ≤ 1) :
    Real.sin theta13 = theta13_arg.toReal :=
  Real.sin_arcsin h1 h2

#eval s!"θ₁₂ arg = {theta12_arg.toFloat} → arctan gives ~33.4°"
#eval s!"θ₂₃ arg = {theta23_arg.toFloat} → arcsin(√·) gives ~49.2°"
#eval s!"θ₁₃ arg = {theta13_arg.toFloat} → arcsin gives ~8.57°"
#eval s!"δ_CP arg = {delta_cp_arg.toFloat} → π+arctan gives ~196°"
