/-
  QuarkMasses.lean — Quark mass ratios from E₈/H₄ geometry

  The key result: m_s/m_d = L₃² = (φ³ + φ⁻³)² = 20 EXACTLY.
  This is the φ-Lucas number L₃ squared, a pure consequence of
  the golden ratio arithmetic underlying H₄.
-/
import GSMLean.QSqrt5
import GSMLean.E8Constants

open QSqrt5

/-! ### Strange-to-down quark mass ratio -/

/-- φ-Lucas number L₃ = φ³ + φ⁻³ -/
def lucas_3 : QSqrt5 := npow phi 3 + npow phi_inv 3

/-- m_s/m_d = L₃² = 20 exactly.
    This is a pure algebraic identity, not a fit. -/
def strange_down_ratio : QSqrt5 := lucas_3 * lucas_3

/-- L₃² = 20 in Q(√5). The √5 components cancel exactly. -/
theorem strange_down_exact :
    strange_down_ratio = (⟨20, 0⟩ : QSqrt5) := by native_decide

/-- L₃² is purely rational (no irrational part) -/
theorem strange_down_rational :
    strange_down_ratio.b = 0 := by native_decide

/-! ### Charm-to-strange quark mass ratio -/

/-- m_c/m_s = (φ⁵ + φ⁻³)(1 + 28/(240φ²))
    GSM: 11.831, Experiment: 11.83 (0.008%) -/
def charm_strange_ratio : QSqrt5 :=
  (npow phi 5 + npow phi_inv 3) *
  ((1 : QSqrt5) + QSqrt5.sdiv (QSqrt5.ofNat' dim_SO8) (roots_E8 : ℚ) *
    QSqrt5.inv (npow phi 2))

/-! ### Bottom-to-charm quark mass ratio -/

/-- m_b/m_c = φ² + φ⁻³
    GSM: 2.854, Experiment: 2.86 (0.21%) -/
def bottom_charm_ratio : QSqrt5 :=
  npow phi 2 + npow phi_inv 3

#eval s!"m_s/m_d = {strange_down_ratio.toFloat} (should be 20.0)"
#eval s!"m_c/m_s = {charm_strange_ratio.toFloat} (exp: 11.83)"
#eval s!"m_b/m_c = {bottom_charm_ratio.toFloat} (exp: 2.86)"
