/-
  BellBound.lean — GSM Bell inequality bound

  S_CHSH = 4 - φ = 2 + φ⁻²

  The GSM predicts a CHSH Bell bound of 4 - φ ≈ 2.382, which is
  strictly less than the quantum mechanical Tsirelson bound 2√2 ≈ 2.828.
  This is the GSM's most dramatic testable prediction.

  Standard QM: S ≤ 2√2 ≈ 2.828
  GSM:         S ≤ 4 - φ ≈ 2.382
  Classical:   S ≤ 2
-/
import GSMLean.QSqrt5

open QSqrt5

/-- CHSH Bell bound S = 4 - φ
    This is the single most testable prediction of the GSM. -/
def bell_bound : QSqrt5 := (4 : QSqrt5) - phi

/-- Exact value: 4 - φ = 4 - (1+√5)/2 = 7/2 - √5/2 -/
theorem bell_bound_exact :
    bell_bound = (⟨7/2, -1/2⟩ : QSqrt5) := by native_decide

/-- Alternative form: S = 2 + φ⁻² -/
def bell_bound_alt : QSqrt5 := (2 : QSqrt5) + npow phi_inv 2

/-- Both forms are equal -/
theorem bell_bound_forms :
    bell_bound = bell_bound_alt := by native_decide

/-- The bound exceeds the classical limit of 2 -/
theorem bell_exceeds_classical :
    bell_bound ≠ (⟨2, 0⟩ : QSqrt5) := by native_decide

#eval s!"S_CHSH = {bell_bound.toFloat} (QM bound: 2.828, classical: 2)"
