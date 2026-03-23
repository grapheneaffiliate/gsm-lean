-- GSMLean: Formally verified derivations of fundamental physical constants
-- from E₈ → H₄ geometry using computational verification in Q(√5).
--
-- Each file is a self-verifying computation. If it compiles with no `sorry`,
-- the derivation is machine-verified.

-- Foundation
import GSMLean.QSqrt5
import GSMLean.QSqrt2Sqrt5
import GSMLean.GoldenRatio
import GSMLean.E8Constants

-- E₈ root system and projection
import GSMLean.E8Data
import GSMLean.H4Projection

-- Electromagnetic sector
import GSMLean.Alpha
import GSMLean.WeakMixing
import GSMLean.StrongCoupling

-- Electroweak sector
import GSMLean.Electroweak

-- Fermion masses
import GSMLean.LeptonMasses
import GSMLean.QuarkMasses

-- Mixing matrices
import GSMLean.CKMMatrix
import GSMLean.PMNSMatrix

-- Neutrino sector
import GSMLean.NeutrinoMass

-- Cosmology
import GSMLean.Cosmology
import GSMLean.ExtendedConstants

-- Composite and QCD
import GSMLean.CompositeQCD
import GSMLean.ProtonMass

-- Predictions and hierarchy
import GSMLean.BellBound
import GSMLean.Predictions
import GSMLean.Hierarchy
