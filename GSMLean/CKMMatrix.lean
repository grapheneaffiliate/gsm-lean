/-
  CKMMatrix.lean — CKM quark mixing matrix elements from E₈/H₄ geometry

  The Cabibbo angle, Jarlskog invariant, V_ub, and V_cb.
  V_cb requires Q(√2, √5) since it involves division by √2.
-/
import GSMLean.QSqrt5
import GSMLean.QSqrt2Sqrt5
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

/-! ### V_cb in Q(√2, √5)

  V_cb = (φ⁻⁸ + φ⁻¹⁵)φ²/√2 × (1 + 1/240)

  This element lives in Q(√2, √5) since it involves division by √2.
  We verify it using QSqrt2Sqrt5 with DecidableEq on 4 rational components.
-/

open QSqrt2Sqrt5 in
/-- V_cb = (φ⁻⁸ + φ⁻¹⁵)φ² · (1 + 1/240) · (1/√2)
    GSM: 0.04093, Experiment: 0.0410 (0.16%) -/
def v_cb : QSqrt2Sqrt5 :=
  (QSqrt2Sqrt5.npow QSqrt2Sqrt5.phi_inv 8 + QSqrt2Sqrt5.npow QSqrt2Sqrt5.phi_inv 15) *
  QSqrt2Sqrt5.npow QSqrt2Sqrt5.phi 2 *
  ((1 : QSqrt2Sqrt5) + QSqrt2Sqrt5.ofRat (1/240)) *
  QSqrt2Sqrt5.inv_sqrt2

open QSqrt2Sqrt5 in
/-- Exact Q(√2, √5) value of V_cb -/
theorem v_cb_exact :
    v_cb = (⟨0, -121223/960, 0, 3615/64⟩ : QSqrt2Sqrt5) := by native_decide

/-! ### V_cb² in Q(√5) (cross-check)

  V_cb² = [(φ⁻⁸ + φ⁻¹⁵)φ²(1 + 1/240)]² / 2
  Since squaring eliminates √2, this lives in Q(√5). -/

/-- The pre-√2 factor X = (φ⁻⁸ + φ⁻¹⁵)φ²(1 + 1/240) in Q(√5) -/
def v_cb_pre : QSqrt5 :=
  (npow phi_inv 8 + npow phi_inv 15) * npow phi 2 *
  ((1 : QSqrt5) + QSqrt5.ofRat (1/240))

/-- V_cb² = X²/2 in Q(√5) -/
def v_cb_squared : QSqrt5 := QSqrt5.sdiv (v_cb_pre * v_cb_pre) 2

theorem v_cb_squared_exact :
    v_cb_squared = (⟨14698384427/230400, -29214743/1024⟩ : QSqrt5) := by native_decide

#eval s!"sin θ_C = {sin_cabibbo.toFloat} (exp: 0.2250)"
#eval s!"J_CKM   = {jarlskog.toFloat} (exp: 3.08e-5)"
#eval s!"V_ub    = {v_ub.toFloat} (exp: 0.00361)"
#eval s!"V_cb²   = {v_cb_squared.toFloat} → V_cb = √· ≈ 0.04093 (exp: 0.0410)"
