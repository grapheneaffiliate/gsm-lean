/-
  ExtendedConstants.lean — Extended GSM constants (baryon density, N_eff,
  dark matter, CMB temperature, neutron-proton mass difference, baryon asymmetry)

  All pure Q(√5). Many involve the torsion ratio ε = 28/248.
-/
import GSMLean.QSqrt5
import GSMLean.E8Constants

open QSqrt5

/-- Baryon density Ω_b = 1/12 - φ⁻⁷
    GSM: 0.04889, Experiment: 0.0489 (0.017%) -/
def omega_b : QSqrt5 :=
  QSqrt5.ofRat (1/12) - npow phi_inv 7

theorem omega_b_exact :
    omega_b = (⟨175/12, -13/2⟩ : QSqrt5) := by native_decide

/-- Effective number of neutrino species N_eff = 240/78 - φ⁻⁷ + ε·φ⁻⁹
    GSM: 3.0440, Experiment: 3.044 (0.001%) -/
def n_eff : QSqrt5 :=
  QSqrt5.ofRat (240/78) - npow phi_inv 7
  + QSqrt5.smul torsion_ratio (npow phi_inv 9)

theorem n_eff_exact :
    n_eff = (⟨10709/806, -142/31⟩ : QSqrt5) := by native_decide

/-- Dark matter density Ω_DM = 1/8 + φ⁻⁴ - ε·φ⁻⁵
    GSM: 0.2607, Experiment: 0.2607 (0.007%) -/
def omega_dm : QSqrt5 :=
  QSqrt5.ofRat (1/8) + npow phi_inv 4
  - QSqrt5.smul torsion_ratio (npow phi_inv 5)

theorem omega_dm_exact :
    omega_dm = (⟨1053/248, -221/124⟩ : QSqrt5) := by native_decide

/-- CMB temperature T_CMB = 78/30 + φ⁻⁶ + ε·φ⁻¹
    GSM: 2.7255 K, Experiment: 2.7255 K (0.0002%) -/
def t_cmb : QSqrt5 :=
  QSqrt5.ofRat (78/30) + npow phi_inv 6
  + QSqrt5.smul torsion_ratio (npow phi_inv 1)

theorem t_cmb_exact :
    t_cmb = (⟨7157/620, -489/124⟩ : QSqrt5) := by native_decide

/-- Neutron-proton mass difference ratio (m_n-m_p)/m_e = 8/3 - φ⁻⁴ + ε·φ⁻⁵
    GSM: 2.5309, Experiment: 2.5309 (0.002%) -/
def neutron_proton_diff : QSqrt5 :=
  QSqrt5.ofRat (8/3) - npow phi_inv 4
  + QSqrt5.smul torsion_ratio (npow phi_inv 5)

theorem neutron_proton_exact :
    neutron_proton_diff = (⟨-541/372, 221/124⟩ : QSqrt5) := by native_decide

/-- Baryon asymmetry η_B = (3/13)·φ⁻³⁴·φ⁻⁷·(1-φ⁻⁸)
    = (3/13)·φ⁻⁴¹·(1-φ⁻⁸)
    GSM: 6.10×10⁻¹⁰, Experiment: 6.1×10⁻¹⁰ (0.002%) -/
def baryon_asymmetry : QSqrt5 :=
  QSqrt5.smul (3/13) (npow phi_inv 34) *
  npow phi_inv 7 *
  ((1 : QSqrt5) - npow phi_inv 8)

#eval s!"Ω_b        = {omega_b.toFloat} (exp: 0.0489)"
#eval s!"N_eff      = {n_eff.toFloat} (exp: 3.044)"
#eval s!"Ω_DM       = {omega_dm.toFloat} (exp: 0.2607)"
#eval s!"T_CMB      = {t_cmb.toFloat} (exp: 2.7255 K)"
#eval s!"(mn-mp)/me = {neutron_proton_diff.toFloat} (exp: 2.5309)"
