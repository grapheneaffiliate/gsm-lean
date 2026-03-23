/-
  StrongCoupling.lean — Strong coupling constant from E₈/H₄ geometry

  α_s(M_Z) = 1/[2φ³(1+φ⁻¹⁴)(1+8φ⁻⁵/14400)]
  GSM: 0.11789, Experiment: 0.1180 (0.09%)
-/
import GSMLean.QSqrt5

open QSqrt5

/-- Strong coupling denominator: 2φ³(1+φ⁻¹⁴)(1+8φ⁻⁵/14400) -/
def alpha_s_denom : QSqrt5 :=
  QSqrt5.smul 2 (npow phi 3) *
  ((1 : QSqrt5) + npow phi_inv 14) *
  ((1 : QSqrt5) + QSqrt5.sdiv (QSqrt5.smul 8 (npow phi_inv 5)) 14400)

/-- Strong coupling α_s(M_Z) = 1/denominator
    GSM: 0.11789, Experiment: 0.1180 (0.09%) -/
def alpha_s : QSqrt5 := QSqrt5.inv alpha_s_denom

theorem alpha_s_exact :
    alpha_s = (⟨2414700/41862587, 1127160/41862587⟩ : QSqrt5) := by native_decide

#eval s!"α_s(M_Z) = {alpha_s.toFloat} (exp: 0.1180)"
