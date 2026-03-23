/-
  E8Data.lean — E₈ root system: 240 roots in ℚ⁸

  The 240 roots come in two types:
  - Type D₈: 112 roots — all permutations of (±1, ±1, 0, 0, 0, 0, 0, 0)
  - Half-integer: 128 roots — (±1/2)⁸ with even number of minus signs

  We construct both sets computationally and verify the total count.
-/
import GSMLean.QSqrt5
import GSMLean.E8Constants

/-- A root in 8 dimensions -/
abbrev Root8 := Fin 8 → ℚ

/-- Generate Type D₈ roots: all vectors with exactly two nonzero entries ±1.
    Count: C(8,2) × 4 = 28 × 4 = 112 -/
def typeD8Roots : List Root8 := Id.run do
  let mut roots : List Root8 := []
  for i in List.range 8 do
    for j in List.range 8 do
      if i < j then
        for si in [1, -1] do
          for sj in [1, -1] do
            roots := roots ++ [fun k =>
              if k.val == i then si
              else if k.val == j then sj
              else 0]
  return roots

/-- Generate half-integer roots: (±1/2)⁸ with even parity.
    Count: 2⁸/2 = 128 -/
def halfIntRoots : List Root8 := Id.run do
  let mut roots : List Root8 := []
  -- Iterate over all 256 sign patterns via binary encoding
  for bits in List.range 256 do
    -- Count number of minus signs (bits set)
    let mut minusCount := 0
    for b in List.range 8 do
      if bits / (2^b) % 2 == 1 then
        minusCount := minusCount + 1
    -- Keep only even parity
    if minusCount % 2 == 0 then
      roots := roots ++ [fun k =>
        if bits / (2^k.val) % 2 == 1 then -1/2 else 1/2]
  return roots

/-- All 240 E₈ roots -/
def e8Roots : List Root8 := typeD8Roots ++ halfIntRoots

/-- Type D₈ contributes 112 roots -/
theorem typeD8_count : typeD8Roots.length = 112 := by native_decide

/-- Half-integer type contributes 128 roots -/
theorem halfInt_count : halfIntRoots.length = 128 := by native_decide

/-- Total E₈ root count = 240 -/
theorem e8_root_count : e8Roots.length = 240 := by native_decide

/-- The norm² of each root should be 2. Verify for all 240 roots. -/
def normSq (v : Root8) : ℚ :=
  v 0 * v 0 + v 1 * v 1 + v 2 * v 2 + v 3 * v 3 +
  v 4 * v 4 + v 5 * v 5 + v 6 * v 6 + v 7 * v 7

theorem all_roots_norm2 : e8Roots.all (fun r => normSq r == 2) = true := by native_decide

#eval s!"Type D₈ roots: {typeD8Roots.length}"
#eval s!"Half-integer roots: {halfIntRoots.length}"
#eval s!"Total E₈ roots: {e8Roots.length}"
