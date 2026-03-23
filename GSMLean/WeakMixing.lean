/-
  WeakMixing.lean — Weinberg angle sin²θ_W

  Formula: sin²θ_W = 3/13 + φ⁻¹⁶

  - 3/13: from E₈ → E₆ × SU(3) branching rule
  - φ⁻¹⁶: rank tower correction (2 × rank(E₈) = 16)

  GSM value:  0.231222
  Experiment: 0.23121 (0.005%)
-/
import GSMLean.QSqrt5

open QSqrt5

/-- sin²θ_W = 3/13 + φ⁻¹⁶ -/
def sin2_theta_W : QSqrt5 :=
  QSqrt5.ofRat (3/13) + npow phi_inv 16

/-- Exact Q(√5) value of sin²θ_W -/
theorem sin2_theta_W_exact :
    sin2_theta_W = (⟨28697/26, -987/2⟩ : QSqrt5) := by native_decide

#eval s!"sin²θ_W = {sin2_theta_W.toFloat}"
#eval s!"experiment = 0.23121"
