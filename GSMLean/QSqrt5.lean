/-
  QSqrt5.lean — Exact arithmetic in Q(√5)

  The field Q(√5) = {a + b√5 | a, b ∈ ℚ} is the minimal field containing
  the golden ratio φ = (1+√5)/2. All GSM derivations live in this field.

  The key property: equality in Q(√5) is DECIDABLE. Two elements
  a₁ + b₁√5 = a₂ + b₂√5 iff a₁ = a₂ and b₁ = b₂ (since √5 is irrational).
  This means Lean's kernel can computationally verify any equation.
-/
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum

/-- Elements of Q(√5): represents a + b√5 where a, b ∈ ℚ -/
structure QSqrt5 where
  a : ℚ  -- rational part
  b : ℚ  -- coefficient of √5
  deriving Repr, DecidableEq

namespace QSqrt5

/-! ### Basic arithmetic operations -/

/-- Addition: (a₁+b₁√5) + (a₂+b₂√5) = (a₁+a₂) + (b₁+b₂)√5 -/
protected def add (x y : QSqrt5) : QSqrt5 := ⟨x.a + y.a, x.b + y.b⟩

/-- Negation: -(a+b√5) = (-a) + (-b)√5 -/
protected def neg (x : QSqrt5) : QSqrt5 := ⟨-x.a, -x.b⟩

/-- Subtraction -/
protected def sub (x y : QSqrt5) : QSqrt5 := ⟨x.a - y.a, x.b - y.b⟩

/-- Multiplication: (a₁+b₁√5)(a₂+b₂√5) = (a₁a₂ + 5b₁b₂) + (a₁b₂ + a₂b₁)√5 -/
protected def mul (x y : QSqrt5) : QSqrt5 :=
  ⟨x.a * y.a + 5 * x.b * y.b, x.a * y.b + x.b * y.a⟩

/-- Conjugation: conj(a+b√5) = a - b√5 -/
def conj (x : QSqrt5) : QSqrt5 := ⟨x.a, -x.b⟩

/-- Norm: N(a+b√5) = a² - 5b² (rational-valued) -/
def norm (x : QSqrt5) : ℚ := x.a * x.a - 5 * x.b * x.b

/-- Multiplicative inverse: 1/(a+b√5) = (a-b√5)/(a²-5b²) -/
protected def inv (x : QSqrt5) : QSqrt5 :=
  let d := x.norm
  ⟨x.a / d, -x.b / d⟩

instance : Add QSqrt5 := ⟨QSqrt5.add⟩
instance : Neg QSqrt5 := ⟨QSqrt5.neg⟩
instance : Sub QSqrt5 := ⟨QSqrt5.sub⟩
instance : Mul QSqrt5 := ⟨QSqrt5.mul⟩
instance : Inv QSqrt5 := ⟨QSqrt5.inv⟩
instance : Zero QSqrt5 := ⟨⟨0, 0⟩⟩
instance : One QSqrt5 := ⟨⟨1, 0⟩⟩

/-- Scalar multiplication by a rational -/
def smul (q : ℚ) (x : QSqrt5) : QSqrt5 := ⟨q * x.a, q * x.b⟩

/-- Scalar division by a rational -/
def sdiv (x : QSqrt5) (q : ℚ) : QSqrt5 := ⟨x.a / q, x.b / q⟩

/-- Embed a rational number -/
def ofRat (q : ℚ) : QSqrt5 := ⟨q, 0⟩

/-- Embed an integer -/
def ofInt (n : ℤ) : QSqrt5 := ⟨↑n, 0⟩

/-- Embed a natural number -/
def ofNat' (n : ℕ) : QSqrt5 := ⟨↑n, 0⟩

instance (n : ℕ) : OfNat QSqrt5 n := ⟨ofNat' n⟩

/-! ### Power function -/

/-- Natural number power by repeated multiplication -/
def npow (x : QSqrt5) : ℕ → QSqrt5
  | 0 => 1
  | n + 1 => x * npow x n

instance : HPow QSqrt5 ℕ QSqrt5 := ⟨npow⟩

/-! ### Approximate evaluation (for human-readable output) -/

/-- Evaluate to Float by substituting √5 ≈ 2.2360679774997896 -/
def toFloat (x : QSqrt5) : Float :=
  let a_f := x.a.num.natAbs.toFloat * (if x.a.num < 0 then -1.0 else 1.0) / x.a.den.toFloat
  let b_f := x.b.num.natAbs.toFloat * (if x.b.num < 0 then -1.0 else 1.0) / x.b.den.toFloat
  a_f + b_f * 2.2360679774997896

/-! ### Distinguished elements -/

/-- The golden ratio φ = (1+√5)/2 -/
def phi : QSqrt5 := ⟨1/2, 1/2⟩

/-- The inverse golden ratio φ⁻¹ = (√5-1)/2 -/
def phi_inv : QSqrt5 := ⟨-1/2, 1/2⟩

/-- √5 -/
def sqrt5 : QSqrt5 := ⟨0, 1⟩

end QSqrt5
