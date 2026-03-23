/-
  CKMMatrix.lean — CKM quark mixing matrix elements from E₈/H₄ geometry

  The Cabibbo angle, Jarlskog invariant, and V_ub element.
  Note: V_cb requires √2 (not in Q(√5)) and is omitted.
-/
import GSMLean.QSqrt5
import GSMLean.E8Constants

open QSqrt5

/-- Cabibbo angle sin θ_C = (φ⁻¹ + φ⁻⁶)/3 × (1 + 8φ⁻⁶/248)
    GSM: 0.22499, Experiment: 0.2250 (0.004%) -/
def sin_cabibbo : QSqrt5 :=
  QSqrt5.sdiv (npow phi_inv 1 + npow phi_inv 6) 3 *
  ((1 : QSqrt5) + QSqrt5.sdiv (QSqrt5.smul 8 (npow phi_inv 6)) 248)

theorem sin_cabibbo_exact :
    sin_cabibbo = (⟨410/93, -58/31⟩ : QSqrt5) := by native_decide

/-- Jarlskog invariant J_CKM = φ⁻¹⁰/264
    GSM: 3.08×10⁻⁵, Experiment: 3.08×10⁻⁵ (0.007%) -/
def jarlskog : QSqrt5 :=
  QSqrt5.sdiv (npow phi_inv 10) 264

theorem jarlskog_exact :
    jarlskog = (⟨41/176, -5/48⟩ : QSqrt5) := by native_decide

/-- V_ub = 2φ⁻⁷/19
    GSM: 0.00363, Experiment: 0.00361 (0.43%) -/
def v_ub : QSqrt5 :=
  QSqrt5.sdiv (QSqrt5.smul 2 (npow phi_inv 7)) 19

theorem v_ub_exact :
    v_ub = (⟨-29/19, 13/19⟩ : QSqrt5) := by native_decide

/- Note: V_cb = (φ⁻⁸+φ⁻¹⁵)φ²/√2·(1+1/240) involves √2,
   which is NOT in Q(√5). This element requires the larger field
   Q(√2, √5) and cannot be verified by native_decide on QSqrt5. -/

#eval s!"sin θ_C = {sin_cabibbo.toFloat} (exp: 0.2250)"
#eval s!"J_CKM   = {jarlskog.toFloat} (exp: 3.08e-5)"
#eval s!"V_ub    = {v_ub.toFloat} (exp: 0.00361)"
