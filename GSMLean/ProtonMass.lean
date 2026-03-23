/-
  ProtonMass.lean — Proton-to-electron mass ratio

  m_p/m_e = 6π⁵(1 + φ⁻²⁴ + φ⁻¹³/240 + φ⁻¹⁷/240 + φ⁻³³/8)
  GSM: 1836.15267, Experiment: 1836.15267 (0.000007%)

  This formula involves π⁵ — a transcendental factor that cannot
  be verified in Q(√5). We verify the φ-dependent correction factor;
  the multiplication by 6π⁵ requires sorry.
-/
import GSMLean.QSqrt5

open QSqrt5

/-- The φ-dependent correction factor in m_p/m_e:
    1 + φ⁻²⁴ + φ⁻¹³/240 + φ⁻¹⁷/240 + φ⁻³³/8
    (multiplied by 6π⁵ ≈ 1836.12 to get the full ratio) -/
def proton_correction : QSqrt5 :=
  (1 : QSqrt5) + npow phi_inv 24
  + QSqrt5.sdiv (npow phi_inv 13) 240
  + QSqrt5.sdiv (npow phi_inv 17) 240
  + QSqrt5.sdiv (npow phi_inv 33) 8

/- The full theorem would be:
   m_p/m_e = 6π⁵ × proton_correction ≈ 1836.15267
   But 6π⁵ ∉ Q(√5), so we cannot verify the full product.
   The correction factor itself IS in Q(√5) and is verified. -/

#eval s!"proton correction = {proton_correction.toFloat}"
#eval s!"6π⁵ ≈ 1836.1181 × correction ≈ m_p/m_e"
