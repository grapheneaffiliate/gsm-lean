/-
  CompositeQCD.lean — Composite hadron and QCD constants

  Deuteron binding energy ratio, clustering amplitude σ₈.
-/
import GSMLean.QSqrt5
import GSMLean.E8Constants

open QSqrt5

/-- Deuteron binding energy ratio B_d/m_p = φ⁻⁷(1+φ⁻⁷)/30
    GSM: 0.001188, Experiment: 0.001188 (0.03%) -/
def deuteron_binding : QSqrt5 :=
  QSqrt5.sdiv (npow phi_inv 7 * ((1 : QSqrt5) + npow phi_inv 7)) 30

theorem deuteron_binding_exact :
    deuteron_binding = (⟨407/30, -91/15⟩ : QSqrt5) := by native_decide

/-- Clustering amplitude σ₈ = 78/(8·12) - ε·φ⁻⁹
    GSM: 0.8110, Experiment: 0.8111 (0.01%) -/
def sigma_8 : QSqrt5 :=
  QSqrt5.ofRat (78/96) - QSqrt5.smul torsion_ratio (npow phi_inv 9)

theorem sigma_8_exact :
    sigma_8 = (⟨2531/496, -119/62⟩ : QSqrt5) := by native_decide

#eval s!"B_d/m_p = {deuteron_binding.toFloat} (exp: 0.001188)"
#eval s!"σ₈ = {sigma_8.toFloat} (exp: 0.8111)"
