/-
  GoldenRatio.lean — Golden ratio identities, verified computationally

  Every theorem here is proved by `native_decide`: Lean's kernel computes
  both sides in Q(√5) exact arithmetic and confirms equality.
  No proof tactics, no proof search. The compiler IS the verifier.
-/
import GSMLean.QSqrt5

open QSqrt5

/-! ### Fundamental golden ratio identities -/

/-- φ² = φ + 1 (the defining identity of the golden ratio) -/
theorem phi_squared : phi * phi = phi + (1 : QSqrt5) := by native_decide

/-- φ · φ⁻¹ = 1 -/
theorem phi_times_phi_inv : phi * phi_inv = (1 : QSqrt5) := by native_decide

/-- φ + φ⁻¹ = √5 -/
theorem phi_plus_phi_inv : phi + phi_inv = sqrt5 := by native_decide

/-- φ - φ⁻¹ = 1 -/
theorem phi_minus_phi_inv : phi - phi_inv = (1 : QSqrt5) := by native_decide

/-- φ⁻¹ = φ - 1 -/
theorem phi_inv_eq : phi_inv = phi - (1 : QSqrt5) := by native_decide

/-! ### Powers of φ⁻¹ (used in GSM formulas)

  These verify the exact Q(√5) values of each power.
  The pattern follows Fibonacci numbers:
    φ⁻ⁿ = (-1)ⁿ(Fₙ₊₁ - Fₙφ) in Q(φ)
    φ⁻ⁿ = ⟨(-1)ⁿ(2Fₙ₊₁ - Fₙ)/2, (-1)ⁿ⁺¹Fₙ/2⟩ in Q(√5)
-/

/-- φ⁻⁷ = -29/2 + (13/2)√5 -/
theorem phi_inv_pow_7 :
    npow phi_inv 7 = (⟨-29/2, 13/2⟩ : QSqrt5) := by native_decide

/-- φ⁻⁸ = 47/2 - (21/2)√5 -/
theorem phi_inv_pow_8 :
    npow phi_inv 8 = (⟨47/2, -21/2⟩ : QSqrt5) := by native_decide

/-- φ⁻¹⁴ = 843/2 - (377/2)√5 -/
theorem phi_inv_pow_14 :
    npow phi_inv 14 = (⟨843/2, -377/2⟩ : QSqrt5) := by native_decide

/-- φ⁻¹⁶ = 2207/2 - (987/2)√5 -/
theorem phi_inv_pow_16 :
    npow phi_inv 16 = (⟨2207/2, -987/2⟩ : QSqrt5) := by native_decide

/-- φ⁻²⁶ = 271443/2 - (121393/2)√5 -/
theorem phi_inv_pow_26 :
    npow phi_inv 26 = (⟨271443/2, -121393/2⟩ : QSqrt5) := by native_decide

/-! ### Lucas number identities

  The φ-Lucas numbers L_n = φⁿ + φ⁻ⁿ are always rational.
  In Q(√5), this means the b-component cancels.
-/

/-- L₃² = (φ³ + φ⁻³)² = 20 exactly (used for m_s/m_d) -/
theorem lucas3_squared :
    let L3 := npow phi 3 + npow phi_inv 3
    L3 * L3 = (⟨20, 0⟩ : QSqrt5) := by native_decide
