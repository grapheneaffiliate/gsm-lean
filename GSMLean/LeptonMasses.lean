/-
  LeptonMasses.lean — Lepton mass ratios from E₈/H₄ geometry

  m_μ/m_e = φ¹¹ + φ⁴ + 1 - φ⁻⁵ - φ⁻¹⁵
  m_τ/m_μ = φ⁶ - φ⁻⁴ - 1 + φ⁻⁸

  These emerge from the E₈ → E₇ branching (leptons appear before quarks).
  The dominant term φ¹¹ is the second H₄ Coxeter exponent.
-/
import GSMLean.QSqrt5

open QSqrt5

/-- m_μ/m_e from H₄ exponent structure.
  φ¹¹ ≈ 199.0 is the dominant term (second H₄ exponent).
  GSM: 206.76822, Experiment: 206.76828 (0.00003%) -/
def muon_electron_ratio : QSqrt5 :=
  npow phi 11 + npow phi 4 + (1 : QSqrt5)
  - npow phi_inv 5 - npow phi_inv 15

/-- m_τ/m_μ from H₄ structure.
  GSM: 16.8197, Experiment: 16.817 (0.016%) -/
def tau_muon_ratio : QSqrt5 :=
  npow phi 6 - npow phi_inv 4 - (1 : QSqrt5)
  + npow phi_inv 8

/-- Verify exact Q(√5) value of m_μ/m_e -/
theorem muon_electron_exact :
    muon_electron_ratio = (⟨1583/2, -523/2⟩ : QSqrt5) := by native_decide

#eval s!"m_μ/m_e = {muon_electron_ratio.toFloat}"
#eval s!"experiment = 206.76828"

#eval s!"m_τ/m_μ = {tau_muon_ratio.toFloat}"
#eval s!"experiment = 16.817"
