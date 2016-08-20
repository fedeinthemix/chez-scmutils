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

(library (scmutils generic)
  (export
   Sigma

   ;;;./scmutils/kernel/genenv.scm ; OK
   type type-predicate arity inexact? zero-like
   one-like identity-like zero? one? identity? negate invert
   square cube sqrt exp log exp2 exp10 log2 log10 sin cos tan
   cot sec csc asin acos sinh cosh tanh sech csch asinh acosh
   atanh abs determinant trace transpose dimension solve-linear
   derivative = < <= > >= + - * / dot-product cross-product
   outer-product expt gcd make-rectangular make-polar real-part
   imag-part magnitude angle conjugate atan partial-derivative
   partial apply arg-scale arg-shift sigma ref size compose

   ;;;./scmutils/poly/interp-generic ; OK
   Lagrange-interpolation-function

   ;;;./scmutils/poly/lagrange ; OK
   lagrange
   triangle-iterate
   make-linear-interpolator
   vector->vector-constructor

   ;;;./scmutils/units/hms-dms-radians
   degrees->radians radians->degrees xms->x x->xms dms->d d->dms dms->radians
   radians->dms hours->radians radians->hours hms->h h->hms
   hms->radians radians->hms

   ;;;./scmutils/units/convert.scm
   unit-convert

   ;;;./scmutils/mechanics/universal.scm ; OK
   D I D-as-matrix Taylor-series-coefficients

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
          (scmutils base))

(include "./scmutils/kernel/fbe2-genenv.scm")

(include "./scmutils/poly/interp-generic.scm")

(include "./scmutils/poly/lagrange.scm")

(include "./scmutils/units/hms-dms-radians.scm")

(include "./scmutils/units/convert.scm")

;;; **************************************

(include "./scmutils/mechanics/universal.scm")

(define (Sigma a b proc)
  (g:sigma proc a b))

)
