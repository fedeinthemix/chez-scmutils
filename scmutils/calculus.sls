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

(library (scmutils calculus)
  (export
   ;;;./scmutils/calculus/dgutils.scm
   diffop-name s:sigma/r s:sigma/r/l s:sigma s:sigma/l
   simplify-numerical-expression with-incremental-simplifier

   ;;;./scmutils/calculus/indexed.scm
   argument-types has-argument-types? declare-argument-types!
   index-types has-index-types? declare-index-types!
   typed->indexed indexed->typed
   i:outer-product count-occurrences i:contract
   list-with-inserted-coord typed->structure
   structure->typed
   maybe-simplify-coeff-functions simplify-coeff-function
   simplify-coeff-functions? zero-manifold-function?
   one-manifold-function? manifold-function-cofunction?

   ;;;./scmutils/calculus/manifold.scm
   manifold-point 
   make-manifold-point transfer-point get-coordinate-rep
   get-coordinates my-manifold-point? c:generate c:lookup
   specify-manifold patch attach-patch
   coordinate-system coordinate-system-at make-manifold
   attach-coordinate-system
   coordinate-system-dimension frame?
   chart point typical-point typical-coords
   corresponding-velocities install-coordinates
   *saved-environment-values* R^n R^n-type R1
   R1-rect the-real-line R2 R2-rect R2-polar R3 R3-rect R3-cyl
   R4 R4-rect R4-cyl spacetime spacetime-rect spacetime-sphere
   S^2-type S^2-coordinates
   S2 S^n-type S^n-coordinates
   S1 S1-circular S1-tilted S2p S2p-spherical S2p-tilted S3
   S3-spherical S3-tilted S^n-stereographic
   S2p-stereographic S2p-Riemann S^n-gnomic S1-gnomic
   S2p-gnomic S3-gnomic S3-stereographic SO3-type SO3
   Euler-angles alternate-angles literal-scalar-field
   zero-coordinate-function literal-manifold-function
   zero-manifold-function one-manifold-function
   constant-manifold-function S2-Riemann
   
  ;;;./scmutils/calculus/vector-fields.scm
   vector-field? procedure->vector-field vector-field-procedure
   components->vector-field vector-field->components vf:zero
   vf:zero-like vf:zero? literal-vector-field
   coordinate-basis-vector-field-procedure
   coordinate-basis-vector-field
   coordinate-system->vector-basis
   basis-components->vector-field
   vector-field->basis-components coordinatize evolution

  ;;;./scmutils/calculus/form-fields.scm
   form-field? 1form-field? procedure->1form-field ff:zero
   ff:zero-like ff:zero? 1form-field-procedure
   components->1form-field 1form-field->components
   literal-1form-field coordinate-basis-1form-field-procedure
   coordinate-basis-1form-field
   coordinate-system->1form-basis basis-components->1form-field
   1form-field->basis-components function->1form-field
   differential-of-function

  ;;;./scmutils/calculus/basis.scm
   coordinate-basis? coordinate-system->basis basis->coordinate-system basis?
   make-basis basis->vector-basis basis->1form-basis
   basis->dimension contract vector-basis->dual
   make-constant-vector-field Jacobian

  ;;;./scmutils/calculus/wedge.scm ; OK
   wedge get-rank rank->arity procedure->nform-field Alt

  ;;;./scmutils/calculus/exterior-derivative.scm
   exterior-derivative-procedure d

  ;;;./scmutils/calculus/Lie.scm ; OK
   Lie-derivative

  ;;;./scmutils/calculus/interior-product.scm ; OK
   interior-product

  ;;;./scmutils/calculus/ode.scm
   Lie-D

  ;;;./scmutils/calculus/maps.scm ; OK
   pullback-function pushforward-function differential-of-map
   differential pushforward-vector literal-manifold-map
   vector-field->vector-field-over-map
   form-field->form-field-over-map
   basis->basis-over-map
   pullback-form pullback-vector-field pullback

  ;;;./scmutils/calculus/covariant-derivative.scm ; OK
   covariant-derivative covariant-derivative-ordinary
   covariant-derivative-function
   covariant-derivative-vector
   covariant-derivative-form
   covariant-derivative-argument-types
   covariant-differential Cartan->Christoffel
   Christoffel->Cartan Cartan-transform symmetrize-Christoffel
   symmetrize-Cartan make-Cartan Cartan? Cartan->forms
   Cartan->basis make-Christoffel Christoffel?
   Christoffel->symbols Christoffel->basis
   Cartan->Cartan-over-map
   geodesic-equation parallel-transport-equation

  ;;;./scmutils/calculus/curvature.scm ; OK
   Riemann-curvature Riemann Ricci
   torsion-vector torsion curvature-components

  ;;;./scmutils/calculus/metric.scm ; OK
   coordinate-system->metric-components
   embedding-map->metric-components coordinate-system->metric
   coordinate-system->inverse-metric
   make-metric literal-metric
   components->metric metric->components
   metric->inverse-components metric:invert
   metric-over-map lower
   vector-field->1form-field drop1 raise
   1form-field->vector-field raise1 drop2 raise2
   trace2down trace2up sharpen S2-metric

  ;;;./scmutils/calculus/connection.scm
   make-Christoffel-1 metric->Christoffel-1 metric->Christoffel-2
   literal-Christoffel-names literal-Christoffel-1
   literal-Christoffel-2 literal-Cartan structure-constant
   metric->connection-1 metric->connection-2

  ;;;./scmutils/calculus/gram-schmidt.scm ; OK
   Gram-Schmidt completely-antisymmetric

  ;;;./scmutils/calculus/hodge-star.scm ; OK
   Hodge-star orthonormalize

  ;;;./scmutils/calculus/tensors.scm ; OK
   tensor-test literal-field

  ;;;./scmutils/calculus/vector-calculus.scm
   gradient curl divergence Laplacian
   coordinate-system->Lame-coefficients
   coordinate-system->orthonormal-vector-basis

  ;;;./scmutils/calculus/SR-boost.scm ; OK
   make-4tuple 4tuple->ct 4tuple->space proper-time-interval
   proper-space-interval general-boost general-boost2
   extended-rotation

  ;;;./scmutils/calculus/SR-frames.scm ; OK
   make-SR-coordinates SR-coordinates? SR-name coordinates->event
   event->coordinates boost-direction v/c
   coordinate-origin make-SR-frame base-frame-point base-frame-chart
   the-ether add-v/cs add-velocities
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
          (scmutils generic)
          (except (scmutils mechanics) Lie-derivative))

;;; FBE: used in calculus/manifold.scm
(define user-generic-environment (interaction-environment))

;;; FBE: from mechanics
;;(include "./scmutils/mechanics/rotation.scm")

;;; **** calculus **********************************

(include "./scmutils/calculus/dgutils.scm")

(include "./scmutils/calculus/indexed.scm") 

(include "./scmutils/calculus/manifold.scm")
(include "./scmutils/calculus/vector-fields.scm")
(include "./scmutils/calculus/form-fields.scm")
(include "./scmutils/calculus/basis.scm")

(include "./scmutils/calculus/wedge.scm")
(include "./scmutils/calculus/exterior-derivative.scm")
(include "./scmutils/calculus/Lie.scm")
(include "./scmutils/calculus/interior-product.scm")
(include "./scmutils/calculus/ode.scm")

(include "./scmutils/calculus/maps.scm")

(include "./scmutils/calculus/covariant-derivative.scm")
(include "./scmutils/calculus/curvature.scm")
(include "./scmutils/calculus/metric.scm")
;; Connection derived from metric
(include "./scmutils/calculus/connection.scm")

;; Hodge star depends on metric
(include "./scmutils/calculus/gram-schmidt.scm")
;; gram-schmidt runs very slowly!
(include "./scmutils/calculus/hodge-star.scm")

(include "./scmutils/calculus/tensors.scm")

(include "./scmutils/calculus/vector-calculus.scm")

;;(include "./scmutils/calculus/so3" SO3-environment) ; FBE

;; special relativity
;;; FBE in '(scmutils base)
;;(include "./scmutils/calculus/frame-maker" scmutils-base-environment)

(include "./scmutils/calculus/SR-boost.scm")
(include "./scmutils/calculus/SR-frames.scm")

)
