/-
  QSqrt2Sqrt5.lean — Exact arithmetic in Q(√2, √5)

  The biquadratic field Q(√2, √5) = {a + b√2 + c√5 + d√10 | a,b,c,d ∈ ℚ}.
  Needed for V_cb which involves division by √2.

  Multiplication rules: √2·√2=2, √5·√5=5, √2·√5=√10,
  √2·√10=2√5, √5·√10=5√2, √10·√10=10.

  DecidableEq: compare four rational components.
-/
import Mathlib.Data.Rat.Defs

/-- Elements of Q(√2, √5): represents a + b√2 + c√5 + d√10 -/
structure QSqrt2Sqrt5 where
  a : ℚ  -- rational part
  b : ℚ  -- coefficient of √2
  c : ℚ  -- coefficient of √5
  d : ℚ  -- coefficient of √10
  deriving Repr, DecidableEq

namespace QSqrt2Sqrt5

protected def add (x y : QSqrt2Sqrt5) : QSqrt2Sqrt5 :=
  ⟨x.a + y.a, x.b + y.b, x.c + y.c, x.d + y.d⟩

protected def neg (x : QSqrt2Sqrt5) : QSqrt2Sqrt5 :=
  ⟨-x.a, -x.b, -x.c, -x.d⟩

protected def sub (x y : QSqrt2Sqrt5) : QSqrt2Sqrt5 :=
  ⟨x.a - y.a, x.b - y.b, x.c - y.c, x.d - y.d⟩

/-- Multiplication using √2²=2, √5²=5, √2·√5=√10, √2·√10=2√5, √5·√10=5√2 -/
protected def mul (x y : QSqrt2Sqrt5) : QSqrt2Sqrt5 :=
  ⟨x.a*y.a + 2*x.b*y.b + 5*x.c*y.c + 10*x.d*y.d,
   x.a*y.b + x.b*y.a + 5*x.c*y.d + 5*x.d*y.c,
   x.a*y.c + 2*x.b*y.d + x.c*y.a + 2*x.d*y.b,
   x.a*y.d + x.b*y.c + x.c*y.b + x.d*y.a⟩

instance : Add QSqrt2Sqrt5 := ⟨QSqrt2Sqrt5.add⟩
instance : Neg QSqrt2Sqrt5 := ⟨QSqrt2Sqrt5.neg⟩
instance : Sub QSqrt2Sqrt5 := ⟨QSqrt2Sqrt5.sub⟩
instance : Mul QSqrt2Sqrt5 := ⟨QSqrt2Sqrt5.mul⟩
instance : Zero QSqrt2Sqrt5 := ⟨⟨0, 0, 0, 0⟩⟩
instance : One QSqrt2Sqrt5 := ⟨⟨1, 0, 0, 0⟩⟩

def ofRat (q : ℚ) : QSqrt2Sqrt5 := ⟨q, 0, 0, 0⟩
def ofNat' (n : ℕ) : QSqrt2Sqrt5 := ⟨↑n, 0, 0, 0⟩
instance (n : ℕ) : OfNat QSqrt2Sqrt5 n := ⟨ofNat' n⟩

def smul (q : ℚ) (x : QSqrt2Sqrt5) : QSqrt2Sqrt5 := ⟨q*x.a, q*x.b, q*x.c, q*x.d⟩
def sdiv (x : QSqrt2Sqrt5) (q : ℚ) : QSqrt2Sqrt5 := ⟨x.a/q, x.b/q, x.c/q, x.d/q⟩

def npow (x : QSqrt2Sqrt5) : ℕ → QSqrt2Sqrt5
  | 0 => 1
  | n + 1 => x * npow x n

instance : HPow QSqrt2Sqrt5 ℕ QSqrt2Sqrt5 := ⟨npow⟩

/-- √2 as an element -/
def sqrt2 : QSqrt2Sqrt5 := ⟨0, 1, 0, 0⟩
/-- √5 as an element -/
def sqrt5 : QSqrt2Sqrt5 := ⟨0, 0, 1, 0⟩
/-- 1/√2 = √2/2 -/
def inv_sqrt2 : QSqrt2Sqrt5 := ⟨0, 1/2, 0, 0⟩
/-- φ = (1+√5)/2 -/
def phi : QSqrt2Sqrt5 := ⟨1/2, 0, 1/2, 0⟩
/-- φ⁻¹ = (√5-1)/2 -/
def phi_inv : QSqrt2Sqrt5 := ⟨-1/2, 0, 1/2, 0⟩

/-- √2 · √2 = 2 -/
theorem sqrt2_sq : sqrt2 * sqrt2 = (⟨2, 0, 0, 0⟩ : QSqrt2Sqrt5) := by native_decide

/-- (1/√2)² = 1/2 -/
theorem inv_sqrt2_sq : inv_sqrt2 * inv_sqrt2 = ofRat (1/2) := by native_decide

end QSqrt2Sqrt5
