/-
  Electroweak.lean — Electroweak sector constants from E₈/H₄ geometry

  Top Yukawa coupling, Higgs-to-vev ratio, W and Z boson mass ratios.
  All pure Q(√5) — verified by native_decide.
-/
import GSMLean.QSqrt5
import GSMLean.E8Constants

open QSqrt5

/-- Top Yukawa coupling y_t = 1 - φ⁻¹⁰
    GSM: 0.99187, Experiment: 0.9919 (0.003%) -/
def top_yukawa : QSqrt5 := (1 : QSqrt5) - npow phi_inv 10

theorem top_yukawa_exact :
    top_yukawa = (⟨-121/2, 55/2⟩ : QSqrt5) := by native_decide

/-- Higgs-to-vev ratio m_H/v = 1/2 + φ⁻⁵/10
    GSM: 0.5090, Experiment: 0.5087 (0.06%) -/
def higgs_vev_ratio : QSqrt5 :=
  QSqrt5.ofRat (1/2) + QSqrt5.sdiv (npow phi_inv 5) 10

theorem higgs_vev_exact :
    higgs_vev_ratio = (⟨-1/20, 1/4⟩ : QSqrt5) := by native_decide

/-- W boson mass ratio m_W/v = (1 - φ⁻⁸)/3
    GSM: 0.3262, Experiment: 0.3264 (0.05%) -/
def w_vev_ratio : QSqrt5 :=
  QSqrt5.sdiv ((1 : QSqrt5) - npow phi_inv 8) 3

theorem w_vev_exact :
    w_vev_ratio = (⟨-15/2, 7/2⟩ : QSqrt5) := by native_decide

/-- Top mass ratio m_t/v = 52/48 - φ⁻²
    GSM: 0.7014, Experiment: 0.7014 (0.005%) -/
def top_vev_ratio : QSqrt5 :=
  QSqrt5.ofRat (52/48) - npow phi_inv 2

theorem top_vev_exact :
    top_vev_ratio = (⟨-5/12, 1/2⟩ : QSqrt5) := by native_decide

/-- Z boson mass ratio m_Z/v = 78/248 + φ⁻⁶
    GSM: 0.3702, Experiment: 0.3702 (0.012%) -/
def z_vev_ratio : QSqrt5 :=
  QSqrt5.ofRat (78/248) + npow phi_inv 6

theorem z_vev_exact :
    z_vev_ratio = (⟨1155/124, -4⟩ : QSqrt5) := by native_decide

#eval s!"y_t    = {top_yukawa.toFloat} (exp: 0.9919)"
#eval s!"m_H/v  = {higgs_vev_ratio.toFloat} (exp: 0.5087)"
#eval s!"m_W/v  = {w_vev_ratio.toFloat} (exp: 0.3264)"
#eval s!"m_t/v  = {top_vev_ratio.toFloat} (exp: 0.7014)"
#eval s!"m_Z/v  = {z_vev_ratio.toFloat} (exp: 0.3702)"
