/-
  H4Projection.lean — Elser-Sloane projection E₈ → H₄

  The 4×8 projection matrix P maps 8D E₈ roots to 4D H₄ roots.
  Its entries involve φ/2 and 1/(2φ), living in Q(√5).

  Under this projection, 240 E₈ roots map to 120 H₄ roots (with multiplicity 2).
  The H₄ roots form the vertices of the 600-cell.
-/
import GSMLean.QSqrt5
import GSMLean.E8Constants

open QSqrt5

/-- The four projection coefficients from the Elser-Sloane matrix.
    c1 = 1/(2φ) = (√5-1)/4, c2 = φ/2 = (1+√5)/4, c3 = 1/2 -/

def c1 : QSqrt5 := QSqrt5.sdiv phi_inv 2  -- 1/(2φ) = φ⁻¹/2
def c2 : QSqrt5 := QSqrt5.sdiv phi 2      -- φ/2
def c3 : QSqrt5 := QSqrt5.ofRat (1/2)     -- 1/2

/-- c1 = (√5-1)/4 -/
theorem c1_exact : c1 = (⟨-1/4, 1/4⟩ : QSqrt5) := by native_decide

/-- c2 = (1+√5)/4 -/
theorem c2_exact : c2 = (⟨1/4, 1/4⟩ : QSqrt5) := by native_decide

/-- Key identity: c1² + c2² = 3/4 -/
theorem c1_sq_plus_c2_sq :
    c1 * c1 + c2 * c2 = QSqrt5.ofRat (3/4) := by native_decide

/-- Key identity: c1 + c2 = √5/2 -/
theorem c1_plus_c2 :
    c1 + c2 = QSqrt5.sdiv sqrt5 2 := by native_decide

/-- Key identity: c2 - c1 = 1/2 -/
theorem c2_minus_c1 :
    c2 - c1 = QSqrt5.ofRat (1/2) := by native_decide

/-- Key identity: c1 × c2 = 1/4 (product of conjugate pair) -/
theorem c1_times_c2 :
    c1 * c2 = QSqrt5.ofRat (1/4) := by native_decide

/-- The Elser-Sloane projection matrix (4 rows × 8 columns).
    Each row is a function Fin 8 → QSqrt5. -/
def projMatrix : Fin 4 → Fin 8 → QSqrt5
  | 0 => fun j => match j with
    | 0 => c2 | 1 => c1 | 2 => 0 | 3 => c3
    | 4 => c1 | 5 => QSqrt5.neg c2 | 6 => c3 | 7 => 0
  | 1 => fun j => match j with
    | 0 => c1 | 1 => QSqrt5.neg c2 | 2 => c3 | 3 => 0
    | 4 => QSqrt5.neg c2 | 5 => QSqrt5.neg c1 | 6 => 0 | 7 => c3
  | 2 => fun j => match j with
    | 0 => 0 | 1 => c3 | 2 => c2 | 3 => c1
    | 4 => c3 | 5 => 0 | 6 => c1 | 7 => QSqrt5.neg c2
  | 3 => fun j => match j with
    | 0 => c3 | 1 => 0 | 2 => c1 | 3 => QSqrt5.neg c2
    | 4 => 0 | 5 => c3 | 6 => QSqrt5.neg c2 | 7 => QSqrt5.neg c1

/-- Project an 8D rational vector to 4D Q(√5) -/
def project (v : Fin 8 → ℚ) : Fin 4 → QSqrt5 :=
  fun i =>
    projMatrix i 0 * QSqrt5.ofRat (v 0) + projMatrix i 1 * QSqrt5.ofRat (v 1) +
    projMatrix i 2 * QSqrt5.ofRat (v 2) + projMatrix i 3 * QSqrt5.ofRat (v 3) +
    projMatrix i 4 * QSqrt5.ofRat (v 4) + projMatrix i 5 * QSqrt5.ofRat (v 5) +
    projMatrix i 6 * QSqrt5.ofRat (v 6) + projMatrix i 7 * QSqrt5.ofRat (v 7)

#eval s!"c1 = {c1.toFloat} (= 1/(2φ) ≈ 0.309)"
#eval s!"c2 = {c2.toFloat} (= φ/2 ≈ 0.809)"
