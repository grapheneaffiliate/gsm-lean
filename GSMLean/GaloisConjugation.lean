/-
  GaloisConjugation.lean — The Galois Conjugation Theorem for E₈ → H₄

  THEOREM: For every E₈ root v, the squared norms of its projections
  onto the H₄ and H₄' subspaces are Galois conjugates in Q(√5):

    ‖proj_H4(v)‖² = conj(‖proj_H4'(v)‖²)

  i.e. if ‖proj_H4(v)‖² = a + b√5, then ‖proj_H4'(v)‖² = a - b√5.

  Discovered computationally (March 2026) and formalized here.
  Proof method: native_decide over all 240 E₈ roots.

  This means the E₈ theta function decomposes as a single Hilbert
  theta function over Z[φ], with the two H₄ copies arithmetically
  locked by the Galois group of Q(√5).
-/
import GSMLean.QSqrt5
import GSMLean.E8Data
import GSMLean.H4Projection

open QSqrt5

/-! ### Conjugate projection: H₄' = σ(H₄) -/

/-- The conjugate projection matrix: apply Galois conjugation σ(√5 → -√5)
    to each entry of the Elser-Sloane matrix. -/
def projMatrixConj : Fin 4 → Fin 8 → QSqrt5 :=
  fun i j => QSqrt5.conj (projMatrix i j)

/-- Project to H₄' (conjugate subspace) -/
def projectConj (v : Fin 8 → ℚ) : Fin 4 → QSqrt5 :=
  fun i =>
    projMatrixConj i 0 * QSqrt5.ofRat (v 0) + projMatrixConj i 1 * QSqrt5.ofRat (v 1) +
    projMatrixConj i 2 * QSqrt5.ofRat (v 2) + projMatrixConj i 3 * QSqrt5.ofRat (v 3) +
    projMatrixConj i 4 * QSqrt5.ofRat (v 4) + projMatrixConj i 5 * QSqrt5.ofRat (v 5) +
    projMatrixConj i 6 * QSqrt5.ofRat (v 6) + projMatrixConj i 7 * QSqrt5.ofRat (v 7)

/-- projectConj(v) = conj(project(v)) component-wise -/
theorem projectConj_eq_conj (v : Fin 8 → ℚ) (i : Fin 4) :
    projectConj v i = QSqrt5.conj (project v i) := by
  simp [projectConj, project, projMatrixConj]
  -- This follows from conj being a ring homomorphism:
  -- conj(a*r + b*r + ...) = conj(a)*r + conj(b)*r + ...
  -- where r is rational (so conj(r) = r)
  sorry -- TODO: prove via conj distributivity lemmas

/-! ### Squared norm in Q(√5) -/

/-- Squared norm of a 4D Q(√5) vector: ‖w‖² = Σᵢ wᵢ² -/
def normSq4 (w : Fin 4 → QSqrt5) : QSqrt5 :=
  w 0 * w 0 + w 1 * w 1 + w 2 * w 2 + w 3 * w 3

/-- H₄ squared norm of an E₈ root -/
def h4NormSq (v : Fin 8 → ℚ) : QSqrt5 := normSq4 (project v)

/-- H₄' squared norm of an E₈ root -/
def h4BarNormSq (v : Fin 8 → ℚ) : QSqrt5 := normSq4 (projectConj v)

/-! ### The Galois Conjugation Theorem -/

/-- Helper: check the theorem for a single root -/
def galoisConjHolds (v : Root8) : Bool :=
  h4BarNormSq v == QSqrt5.conj (h4NormSq v)

/-- Check the theorem for all 240 roots -/
def allRootsGaloisConj : Bool :=
  e8Roots.all galoisConjHolds

/--
  **The Galois Conjugation Theorem (computational verification)**

  For every E₈ root v:
    ‖proj_H4'(v)‖² = σ(‖proj_H4(v)‖²)

  where σ is the Galois conjugation √5 ↦ -√5.

  This is verified by checking all 240 roots via `native_decide`.
-/
theorem galois_conjugation_all_roots : allRootsGaloisConj = true := by
  native_decide

/-! ### Consequences -/

/-- The total norm is rational (lies in Q, not Q(√5)).
    This follows because ‖v‖² = ‖proj_H4(v)‖² + ‖proj_H4'(v)‖²
    = (a+b√5) + (a-b√5) = 2a ∈ Q. -/
def totalNormRational (v : Root8) : Bool :=
  let total := h4NormSq v + h4BarNormSq v
  total.b == 0

/-- Total norm is rational for all 240 roots -/
theorem total_norm_rational_all : e8Roots.all totalNormRational = true := by
  native_decide

/-- The norm product (algebraic norm) is rational.
    N(‖proj_H4(v)‖²) = ‖proj_H4(v)‖² × ‖proj_H4'(v)‖² = a²-5b² ∈ Q. -/
def normProductRational (v : Root8) : Bool :=
  let prod := h4NormSq v * h4BarNormSq v
  prod.b == 0

/-- Norm product is rational for all 240 roots -/
theorem norm_product_rational_all : e8Roots.all normProductRational = true := by
  native_decide

/-! ### Distinct H₄ norm orbits -/

/-- Count distinct H₄ norms among the 240 roots.
    We expect 5 orbits (sizes 24, 24, 144, 24, 24). -/
def distinctH4Norms : List QSqrt5 :=
  (e8Roots.map h4NormSq).eraseDups

/-- There are exactly 23 distinct H₄ norm values under Elser-Sloane projection -/
theorem norm_orbit_count : distinctH4Norms.length = 23 := by
  native_decide

/-! ### Orbit structure -/

/-- Count roots with a given H₄ norm -/
def orbitSize (n : QSqrt5) : Nat :=
  (e8Roots.filter (fun v => h4NormSq v == n)).length

/-- The 23 orbit sizes, sorted -/
def orbitSizes : List Nat :=
  (distinctH4Norms.map orbitSize).mergeSort (· ≤ ·)

/-- Orbit sizes sum to 240 -/
theorem orbit_sizes_sum : orbitSizes.foldl (· + ·) 0 = 240 := by
  native_decide

/-- Orbit sizes under Elser-Sloane projection -/
theorem orbit_sizes_correct :
    orbitSizes = [2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 4, 4, 4, 8, 8, 12, 12, 16, 16, 18, 20, 34, 56] := by
  native_decide

#eval s!"Galois conjugation holds for all roots: {allRootsGaloisConj}"
#eval s!"Distinct H4 norms: {distinctH4Norms.length}"
#eval s!"Orbit sizes: {orbitSizes}"
