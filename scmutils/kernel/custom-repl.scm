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

(declare (usual-integrations))

(define saved-repl-print (waiter-write))

;; set to 'expression' to suppress simplification.
;; Initialized at end of library.
(define *scmutils/repl-simplifier* (make-parameter (lambda (x) x)))

;; change 'simplify' to 'expression' to suppress simplification.
(define (scmutils/simplify object)
  (define (simplifiable object)
    (prepare-for-printing object (*scmutils/repl-simplifier*)
                          ;simplify ; automatic simplification
                          ;expression ; suppress simplification
                          ))
  (if (or (symbol? object)
          (list? object)
          (vector? object)
          (procedure? object))
      (begin
        (simplifiable object)
        ((*last-expression-printed*)))
      object))

(define (scmutils/repl-print val)
  (unless (eq? val (void))
      (pp (scmutils/simplify val) (console-output-port))
      ;;(newline)
      (flush-output-port (console-output-port))))

(define (pple) (pp ((*last-expression-printed*))))

(define (start-scmutils-print!)
  (waiter-write scmutils/repl-print))

(define (stop-scmutils-print!)
  (waiter-write saved-repl-print))

(define (display-expression)
  (if (or (undefined-value? ((*last-expression-printed*)))
	  (and (procedure? ((*last-expression-printed*)))
	       (not (operator? ((*last-expression-printed*))))))
      ((*last-expression-printed*))
      (internal-show-expression ((*last-expression-printed*)))))

(define de display-expression)
