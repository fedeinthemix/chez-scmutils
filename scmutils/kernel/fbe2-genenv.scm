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

(define *environment* 'generic-environment)

;; Unary operators from generic.scm

(define type g:type)
(define type-predicate g:type-predicate)
(define arity g:arity)

(define inexact? g:inexact?)

(define zero-like g:zero-like)
(define one-like g:one-like)
(define identity-like g:identity-like)

(define zero? g:zero?)
(define one? g:one?)
(define identity? g:identity?)

(define negate g:negate)
(define invert g:invert)

(define square g:square)
(define cube   g:cube)

(define sqrt g:sqrt)

(define exp g:exp)
(define log g:log)

(define exp2  g:exp2)
(define exp10 g:exp10)
(define log2  g:log2)
(define log10 g:log10)

(define sin g:sin)
(define cos g:cos)
(define tan g:tan)
(define cot g:cot)
(define sec g:sec)
(define csc g:csc)

(define asin g:asin)
(define acos g:acos)

(define sinh g:sinh)
(define cosh g:cosh)
(define tanh g:tanh)
(define sech g:sech)
(define csch g:csch)

(define asinh g:asinh)
(define acosh g:acosh)
(define atanh g:atanh)

(define abs g:abs)

(define determinant g:determinant)
(define trace g:trace)
(define transpose g:transpose)
(define dimension g:dimension)

(define solve-linear g:solve-linear)

(define derivative g:derivative)

;; Binary (and nary) operators from generic.scm

(define = g:=)
(define < g:<)
(define <= g:<=)
(define > g:>)
(define >= g:>=)

(define + g:+)
(define - g:-)
(define * g:*)
(define / g:/)

(define dot-product g:dot-product)
(define cross-product g:cross-product)

(define outer-product g:outer-product)

(define expt g:expt)
(define gcd g:gcd)


;; Complex operators from generic.scm

(define make-rectangular g:make-rectangular)
(define make-polar g:make-polar)

(define real-part g:real-part)
(define imag-part g:imag-part)
(define magnitude g:magnitude)
(define angle g:angle)

(define conjugate g:conjugate)


;; Wierd operators from generic.scm

(define atan g:atan)

(define partial-derivative g:partial-derivative)
(define partial g:partial)

(define apply g:apply)


;; Compound operators from mathutil.scm

(define arg-scale g:arg-scale)
(define arg-shift g:arg-shift)

(define sigma g:sigma)

(define ref   g:ref)
(define size  g:size)

(define compose g:compose)

;; (define generic-environment
;;   (generic-environment-maker))

;;; FBE: this is used in (scmutils base)
;; (define generic-numerical-operators
;;   '(	
;; 	zero-like
;; 	one-like
;; 	identity-like

;; 	negate
;; 	invert

;; 	square
;; 	cube

;; 	sqrt

;; 	exp
;; 	log

;; 	exp2
;; 	exp10
;; 	log2
;; 	log10

;; 	sin
;; 	cos
;; 	tan
;; 	sec
;; 	csc

;; 	asin
;; 	acos

;; 	sinh
;; 	cosh
;; 	tanh
;; 	sech
;; 	csch

;; 	abs

;; 	+
;; 	-
;; 	*
;; 	/

;; 	expt
;; 	gcd

;; 	make-rectangular
;; 	make-polar

;; 	real-part
;; 	imag-part
;; 	magnitude
;; 	angle

;; 	conjugate

;; 	atan))

#|
(let ((numerical-environment
       (extend-top-level-environment generic-environment)))
  (environment-define scmutils-base-environment
		      'numerical-environment
		      numerical-environment)
  (environment-define numerical-environment
		      '*environment*
		      'numerical-environment))
|#


;; FBE
;; (let ((numerical-environment
;;        (extend-top-level-environment scmutils-base-environment)
;;        ;;(extend-top-level-environment scmutils-base-environment '(numerical)) ; guile
;;        ))
;;   (environment-define scmutils-base-environment
;; 		      'numerical-environment
;; 		      numerical-environment)
;;   (environment-define numerical-environment
;; 		      '*environment*
;; 		      'numerical-environment))
