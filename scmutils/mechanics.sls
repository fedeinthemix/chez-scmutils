;;; Copyright © 2016 Federico Beffa
;;;
;;; This program is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code

#!chezscheme

(library (scmutils mechanics)
  (export
   ;;;./scmutils/mechanics/rotation.scm ; OK
   ;;rotate-x-matrix-2 rotate-x-matrix
   Rx-matrix
   ;;rotate-y-matrix-2 rotate-y-matrix
   Ry-matrix
   ;;rotate-z-matrix-2 rotate-z-matrix
   Rz-matrix
   angle&axis->rotation-matrix
   ;;rotate-x-tuple-2
   rotate-x-tuple
   ;;rotate-y-tuple-2
   rotate-y-tuple
   ;;rotate-z-tuple-2
   rotate-z-tuple
   ;;rotate-x-2
   rotate-x
   ;;rotate-y-2
   rotate-y
   ;;rotate-z-2
   rotate-z wcross->w

   ;;;./scmutils/mechanics/Lagrangian.scm
   coordinate-tuple velocity-tuple acceleration-tuple
   momentum-tuple ->local ->state ->L-state state->n-dof
   state->t state->q state->qdot state->qddot time coordinate
   velocity acceleration coordinates velocities accelerations Q
   Qdot Qdotdot literal-Lagrangian-state path->state-path Gamma
   make-Lagrangian Lagrange-equations Lagrangian->acceleration
   Lagrange-equations-1 local-state-derivative qv->local-path
   Lagrangian->state-derivative Lagrangian->energy
   Lagrangian->power-loss

   ;;;./scmutils/mechanics/action.scm ; OK
   Lagrangian-action
   make-path
   parametric-path-action
   find-path
   linear-interpolants

   ;;;./scmutils/mechanics/Lagrangian-evolution.scm ; OK

   ;;;./scmutils/mechanics/gamma-bar.scm ; OK
   Gamma-bar osculating-path Dt-procedure Dt
   Euler-Lagrange-operator trim-last-argument LE
   Lagrange-equations-operator clip-state clip generalized-LE

   ;;;./scmutils/mechanics/Lagrangian-transformations.scm ; OK
   F->C rectangular->polar r->p polar->rectangular
   p->r spherical->rectangular s->r rectangular->spherical r->s
   Rx Ry Rz

   ;;;./scmutils/mechanics/Noether.scm ; OK
   Noether-integral

   ;;;./scmutils/mechanics/rigid.scm ; OK
   m:antisymmetric? antisymmetric->column-matrix
   3vector-components->antisymmetric M-of-q->omega-of-t
   M-of-q->omega-body-of-t M->omega
   M->omega-body T-body L-body L-space Euler->M Euler->omega
   Euler->omega-body Euler-state->omega-body
   T-body-Euler T-rigid-body L-body-Euler Euler-state->L-body
   L-space-Euler Euler-state->L-space relative-error
   quaternion-state->omega-body quaternion-state->omega-space
   qw-state->L-body qw-state->L-space T-quaternion-state

   ;;;./scmutils/mechanics/Hamiltonian.scm
   ->H-state H-state? compatible-H-state? state->p momentum
   momenta P state->qp literal-Hamiltonian-state Lstate->Hstate
   Hstate->Lstate H-state->matrix matrix->H-state
   degrees-of-freedom make-Hamiltonian Hamilton-equations
   qp->H-state-path Hamiltonian->state-derivative D-phase-space
   Legendre-transform-procedure
   Lagrangian->Hamiltonian-procedure
   Hamiltonian->Lagrangian-procedure Poisson-bracket
   commutator anticommutator Lie-derivative flow-derivative

   ;;;./scmutils/mechanics/Routhian.scm
   Lagrangian->Routhian Routh-equations Routh-equations-bad
   Routhian->acceleration-bad Routhian->acceleration
   Routhian->state-derivative Lagrangian-state->Routhian-state
   Routhian-state->Lagrangian-state

   ;;;./scmutils/mechanics/Hamiltonian-evolution.scm ; OK

   ;;;./scmutils/mechanics/qualitative.scm
   unstable-manifold
   fixed-point-eigen
   radially-mapping-points
   find-invariant-curve
   which-way?

   ;;;./scmutils/mechanics/point-transformation.scm
   F->CH F->CT F->K

   ;;;./scmutils/mechanics/canonical.scm
   canonical? compositional-canonical? J-func T-func canonical-H?
   canonical-K? linear-function->multiplier Phi Phi*
   time-independent-canonical? polar-canonical
   polar-canonical-inverse two-particle-center-of-mass
   two-particle-center-of-mass-canonical
   multiplicative-transpose transpose-function

   ;;;./scmutils/mechanics/symplectic.scm
   symplectic-two-form canonical-transform? J-matrix symplectic?
   symplectic-transform? qp-submatrix symplectic-matrix?
   symplectic-unit

   ;;;./scmutils/mechanics/generating-functions.scm ; OK

   ;;;./scmutils/mechanics/time-evolution.scm
   shift-t C->Cp H->Hp

   ;;;./scmutils/mechanics/Lie-transform.scm
   Lie-transform flow-transform

   ;;;./scmutils/mechanics/pendulum.scm
   Hpendulum pendulum-sysder pendulum-Hamiltonian
   pendulum-oscillating-frequency pendulum-oscillating-angle
   pendulum-oscillating-angular-momentum
   pendulum-oscillating-action pendulum-oscillating-action-to-E
   pendulum-oscillating-phase pendulum-oscillating-dt
   pendulum-oscillating-aa-state-to-state
   pendulum-oscillating-state-to-aa-state
   pendulum-circulating-frequency pendulum-circulating-angle
   pendulum-circulating-angular-momentum
   pendulum-circulating-action pendulum-circulating-action-to-E
   pendulum-circulating-phase pendulum-circulating-dt
   pendulum-circulating-aa-state-to-state
   pendulum-circulating-state-to-aa-state pendulum-f pendulum-g
   pendulum-inverse-f pendulum-inverse-g
   pendulum-separatrix-angle
   pendulum-separatrix-angular-momentum gudermannian
   inverse-gudermannian pendulum-separatrix-action
   pendulum-advance pendulum-integration pendulum-frequency
   pendulum-state-to-global-aa-state
   pendulum-global-aa-state-to-state
   
   )
  (import (except (rnrs base) error assert
                  inexact? zero? sqrt exp log sin cos tan
                  asin acos abs = < <= > >= + - * / expt gcd make-rectangular
                  make-polar real-part imag-part magnitude angle
                  atan apply)
          (rename (only (rnrs base) string<?) (string<? string:<?))
          (rnrs eval)
          (rnrs mutable-pairs)
          (rnrs io simple)
          (rnrs io ports)
          (rnrs r5rs)
          (rnrs conditions)
          (rnrs control)
          (rnrs syntax-case)
          (rename (except (rnrs lists) filter) (remq delq) (remv delv))
          (except (mit core) assert) ; assert is defined in general/logic-utils.scm
          (except (mit arithmetic) conjugate)
          (mit list)
          (except (mit vector) flo:subvector) ; flo:subvector in
                                              ; numerics/signal/cph-dsp/flovec.scm
          (mit curry)
          (except (mit arity) procedure-arity) ; use version in apply-hook
          (mit apply-hook)
          (mit hash-tables)
          (mit environment)
          (mit streams)
          (only (srfi :1) reduce reduce-right delete any every lset-adjoin
                make-list append-map)
          (srfi :9)
          (srfi :14) ; char-set
          (rename (srfi :41) (stream-cons cons-stream)
                  (stream-fold stream-accumulate))
          (only (chezscheme) include import compile module eval-when
                last-pair environment? scheme-environment
                copy-environment interaction-environment
                make-parameter parameterize
                iota reverse! list-head random
                waiter-write console-output-port with-output-to-string
                void vector-copy)
          (scmutils base)
          (scmutils generic))

;;; **** mechanics **********************************

(include "./scmutils/mechanics/rotation.scm")

;;; Chapter 1

;;; FBE: we include this in '(scmutils generic)
;;(include "./scmutils/mechanics/universal.scm")
(include "./scmutils/mechanics/Lagrangian.scm")
(include "./scmutils/mechanics/action.scm")
(include "./scmutils/mechanics/Lagrangian-evolution.scm")
(include "./scmutils/mechanics/gamma-bar.scm")
(include "./scmutils/mechanics/Lagrangian-transformations.scm")
(include "./scmutils/mechanics/Noether.scm")

;;; Chapter 2

(include "./scmutils/mechanics/rigid.scm")

;;; Chapter 3

;; defines 'Lie-derivative'.  A more general definition is in calculus/Lie.scm
(include "./scmutils/mechanics/Hamiltonian.scm")
(include "./scmutils/mechanics/Routhian.scm")
(include "./scmutils/mechanics/Hamiltonian-evolution.scm")

;;; FBE: this is loaded into (scmutils base)
;;(include "./scmutils/mechanics/sections.scm" scmutils-base-environment)

;;; Chapter 4

(include "./scmutils/mechanics/qualitative.scm")

;;; Chapter 5

(include "./scmutils/mechanics/point-transformation.scm")
(include "./scmutils/mechanics/canonical.scm")
(include "./scmutils/mechanics/symplectic.scm")

(include "./scmutils/mechanics/time-varying.scm")

(include "./scmutils/mechanics/generating-functions.scm")
(include "./scmutils/mechanics/time-evolution.scm")
(include "./scmutils/mechanics/Lie-transform.scm")

;;; Chapter 6

(include "./scmutils/mechanics/pendulum.scm")

)
