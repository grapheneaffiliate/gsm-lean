/-
  NeutrinoMass.lean — Neutrino mass sum from E₈/H₄ geometry

  Σm_ν = m_e · φ⁻³⁴(1 + εφ³)

  The full formula involves the electron mass m_e (an absolute mass scale).
  Here we verify the φ-dependent factor: φ⁻³⁴(1 + εφ³).
  GSM: 59.24 meV, Experiment: ~59 meV (0.40%)
-/
import GSMLean.QSqrt5
import GSMLean.E8Constants

open QSqrt5

/-- The φ-dependent factor in Σm_ν: φ⁻³⁴(1 + εφ³)
    where ε = 28/248 is the torsion ratio.
    The full Σm_ν = m_e × this factor. -/
def neutrino_factor : QSqrt5 :=
  npow phi_inv 34 * ((1 : QSqrt5) + QSqrt5.smul torsion_ratio (npow phi 3))

theorem neutrino_factor_exact :
    neutrino_factor = (⟨769554223/124, -344155111/124⟩ : QSqrt5) := by native_decide

#eval s!"ν factor = {neutrino_factor.toFloat} (× m_e gives ~59 meV)"
