#| -*-Scheme-*-

Copyright (C) 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994,
    1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
    2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013 Massachusetts
    Institute of Technology

This file is part of MIT/GNU Scheme.

MIT/GNU Scheme is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or (at
your option) any later version.

MIT/GNU Scheme is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with MIT/GNU Scheme; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301,
USA.

|#

;;;; Symbolic environment for simplification

(declare (usual-integrations))

(module symbolic-module
  (zero? one? negate invert square cube sqrt exp log
   sin cos tan sec csc asin acos sinh cosh abs expt
   make-rectangular make-polar real-part imag-part
   magnitude angle conjugate atan = + * - /)

(define (symbolic-operator operator-symbol)
  (let ((v (hash-table/get symbolic-operator-table operator-symbol #f)))
    (if v
        v
        (error "Undefined symbolic operator" operator-symbol))))

(define *environment* 'symbolic-environment)

;; Unary operators from generic.scm
#|
(define 'type (symbolic-operator 'type))
(define 'type-predicate (symbolic-operator 'type-predicate))
(define 'arity (symbolic-operator 'arity))

(define 'inexact? (symbolic-operator 'inexact?))

(define 'zero-like (symbolic-operator 'zero-like))
(define 'one-like (symbolic-operator 'one-like))
(define 'identity-like (symbolic-operator 'identity-like))
|#
(define zero? (symbolic-operator 'zero?))
(define one? (symbolic-operator 'one?))
;;	(define 'identity? (symbolic-operator 'identity?))

(define negate (symbolic-operator 'negate))
(define invert (symbolic-operator 'invert))

(define square (symbolic-operator 'square))
(define cube   (symbolic-operator 'cube))

(define sqrt (symbolic-operator 'sqrt))

(define exp (symbolic-operator 'exp))
(define log (symbolic-operator 'log))
#|
(define 'exp2  (symbolic-operator 'exp2))
(define 'exp10 (symbolic-operator 'exp10))
(define 'log2  (symbolic-operator 'log2))
(define 'log10 (symbolic-operator 'log10))
|#
(define sin (symbolic-operator 'sin))
(define cos (symbolic-operator 'cos))
(define tan (symbolic-operator 'tan))
(define sec (symbolic-operator 'sec))
(define csc (symbolic-operator 'csc))

(define asin (symbolic-operator 'asin))
(define acos (symbolic-operator 'acos))

(define sinh (symbolic-operator 'sinh))
(define cosh (symbolic-operator 'cosh))
#|
(define 'tanh (symbolic-operator 'tanh))
(define 'sech (symbolic-operator 'sech))
(define 'csch (symbolic-operator 'csch))
|#
(define abs (symbolic-operator 'abs))

;; (define 'derivative (symbolic-operator 'derivative))

;; Binary (and nary) operators from generic.scm

(define expt (symbolic-operator 'expt))
;; (define 'gcd (symbolic-operator 'gcd))


;; Complex operators from generic.scm

(define make-rectangular (symbolic-operator 'make-rectangular))
(define make-polar (symbolic-operator 'make-polar))

(define real-part (symbolic-operator 'real-part))
(define imag-part (symbolic-operator 'imag-part))
(define magnitude (symbolic-operator 'magnitude))
(define angle (symbolic-operator 'angle))

(define conjugate (symbolic-operator 'conjugate))

(define atan (symbolic-operator 'atan))

(define = (symbolic-operator '=))

(define + (symbolic-operator '+))

(define * (symbolic-operator '*))

(define - (symbolic-operator '-))

(define / (symbolic-operator '/))

;;(include "./scmutils/kernel/numsymb-defs.scm")
;;(include "./scmutils/kernel/numsymb-init.scm")

)
