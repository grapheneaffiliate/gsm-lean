#!/usr/bin/env python3
"""
verify_values.py — Compute exact Q(√5) values for all GSM Lean theorems.

This script performs the same computations that Lean's kernel will verify,
using Python's exact rational arithmetic (fractions.Fraction).
Use this to generate/verify the ⟨a, b⟩ values in Lean theorem statements.
"""

from fractions import Fraction as F
import math

# Q(√5) arithmetic: elements are (a, b) representing a + b√5
def mul(x, y):
    return (x[0]*y[0] + 5*x[1]*y[1], x[0]*y[1] + x[1]*y[0])

def add(x, y):
    return (x[0]+y[0], x[1]+y[1])

def neg(x):
    return (-x[0], -x[1])

def sub(x, y):
    return add(x, neg(y))

def smul(q, x):
    return (q*x[0], q*x[1])

def sdiv(x, q):
    return (x[0]/q, x[1]/q)

def npow(x, n):
    result = (F(1), F(0))
    for _ in range(n):
        result = mul(result, x)
    return result

def approx(x):
    return float(x[0]) + float(x[1]) * math.sqrt(5)

def lean_literal(x):
    """Format as Lean QSqrt5 literal."""
    return f"⟨{x[0]}, {x[1]}⟩"

# Fundamental constants
phi = (F(1,2), F(1,2))
phi_inv = (F(-1,2), F(1,2))
zero = (F(0), F(0))
one = (F(1), F(0))

print("=" * 70)
print("EXACT Q(√5) VALUES FOR LEAN THEOREMS")
print("=" * 70)

# Golden ratio identities
print("\n--- Golden Ratio ---")
print(f"φ² = {lean_literal(mul(phi, phi))}")
print(f"φ·φ⁻¹ = {lean_literal(mul(phi, phi_inv))}")
print(f"φ+φ⁻¹ = {lean_literal(add(phi, phi_inv))}")

# Powers of φ⁻¹
print("\n--- Powers of φ⁻¹ ---")
for n in [7, 8, 14, 16, 26]:
    p = npow(phi_inv, n)
    print(f"φ⁻{n:2d} = {lean_literal(p):40s} ≈ {approx(p):.10f}")

# Alpha derivation
print("\n--- Fine-Structure Constant α⁻¹ ---")
anchor = (F(137), F(0))
t_ferm = npow(phi_inv, 7)
t_bos = npow(phi_inv, 14)
t_rank = npow(phi_inv, 16)
t_tors = sdiv(npow(phi_inv, 8), F(-248))
t_cox = smul(F(248,240), npow(phi_inv, 26))

terms = [
    ("anchor (137)", anchor),
    ("φ⁻⁷ (fermionic)", t_ferm),
    ("φ⁻¹⁴ (bosonic)", t_bos),
    ("φ⁻¹⁶ (rank tower)", t_rank),
    ("-φ⁻⁸/248 (torsion)", t_tors),
    ("(248/240)φ⁻²⁶ (Coxeter)", t_cox),
]

total = zero
for name, term in terms:
    total = add(total, term)
    print(f"  {name:30s} = {lean_literal(term):40s} ≈ {approx(term):+.10f}")

print(f"\n  α⁻¹ = {lean_literal(total)}")
print(f"  α⁻¹ ≈ {approx(total):.12f}")
print(f"  CODATA 2022: 137.035999177")
print(f"  Deviation: {abs(approx(total) - 137.035999177):.3e}")

# Weak mixing angle
print("\n--- Weak Mixing Angle ---")
s2tw = add((F(3,13), F(0)), npow(phi_inv, 16))
print(f"  sin²θ_W = {lean_literal(s2tw)} ≈ {approx(s2tw):.10f}")

# Lepton mass ratios
print("\n--- Lepton Masses ---")
mer = add(add(add(npow(phi, 11), npow(phi, 4)), one),
          add(neg(npow(phi_inv, 5)), neg(npow(phi_inv, 15))))
print(f"  m_μ/m_e = {lean_literal(mer)} ≈ {approx(mer):.10f}")

tmr = add(add(sub(npow(phi, 6), npow(phi_inv, 4)), neg(one)),
          npow(phi_inv, 8))
print(f"  m_τ/m_μ = {lean_literal(tmr)} ≈ {approx(tmr):.10f}")

# Quark mass ratios
print("\n--- Quark Masses ---")
L3 = add(npow(phi, 3), npow(phi_inv, 3))
L3sq = mul(L3, L3)
print(f"  L₃² = m_s/m_d = {lean_literal(L3sq)} ≈ {approx(L3sq):.10f}")

# Bottom/charm
bc = add(npow(phi, 2), npow(phi_inv, 3))
print(f"  m_b/m_c = {lean_literal(bc)} ≈ {approx(bc):.10f}")

# Cosmology
print("\n--- Cosmology ---")
ns = sub(one, npow(phi_inv, 7))
print(f"  n_s = {lean_literal(ns)} ≈ {approx(ns):.10f}")

zcmb = add(npow(phi, 14), (F(246), F(0)))
print(f"  z_CMB = {lean_literal(zcmb)} ≈ {approx(zcmb):.6f}")

print("\n" + "=" * 70)
print("All values computed with exact rational arithmetic.")
print("These should match the Lean native_decide verifications.")
