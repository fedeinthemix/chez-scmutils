;;; Copyright © 2016 Federico Beffa <beffa@fbengineering.ch>
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

;;; Comments:
;;;
;;; This is a port to Guile of the equivalent macros found in the
;;; original MIT/GNU Scheme Scmutils library.

;; (define-values (v1 v2 v3 ...) values-expr)

(define-syntax define-values
  (lambda (stx)
    (syntax-case stx ()
      ((_ (name ...) v-expr)
       (with-syntax (((t ...) (generate-temporaries #'(name ...))))
         #`(begin
             (define name) ...
             (call-with-values
                 (lambda () v-expr)
               (lambda (t ...)
                 (set! name t) ...))))))))

;; Use:
;; (define-coordinates (up x y z (down p q) ...) coord-sys)

(define-syntax define-coordinates
  (lambda (stx)
    (syntax-case stx ()
      ((k coord-proto-symb coord-sys-expr)
       (identifier? #'coord-proto-symb)
       (with-syntax (((coord-sys) (generate-temporaries #'(coord-sys-expr)))
                     (coord-vector-sym
                      (datum->syntax #'k
                                     (symbol-append
                                      'd/d
                                      (syntax->datum #'coord-proto-symb))))
                     (coord-one-form-sym 
                      (datum->syntax #'k
                                     (symbol-append
                                      'd
                                      (syntax->datum #'coord-proto-symb)))))
         #'(begin
             (define-values (coord-proto-symb coord-vector-sym coord-one-form-sym)
               (let ((coord-sys coord-sys-expr))
                 ((coord-sys 'set-coordinate-prototype!) 'coord-proto-symb)
                 (let ((chart-functions
                        (list
                         (cadar (ultra-flatten
                                (coord-sys 'coordinate-function-specs)))
                         (cadar (ultra-flatten
                                (coord-sys 'coordinate-basis-vector-field-specs)))
                         (cadar (ultra-flatten
                                (coord-sys 'coordinate-basis-1form-field-specs))))))
                   (apply values chart-functions)))))))
      ((k (up/down coord-proto-symb ...) coord-sys-expr)
       (with-syntax (((coord-sys)
                      (generate-temporaries #'(coord-sys-expr)))
                     ((coord-vector-sym ...)
                      (map (lambda (cs)
                             (datum->syntax #'k
                                            (symbol-append
                                             'd/d
                                             (syntax->datum cs))))
                           #'(coord-proto-symb ...)))
                     ((coord-one-form-sym ...)
                      (map (lambda (cs)
                             (datum->syntax #'k
                                            (symbol-append
                                             'd
                                             (syntax->datum cs))))
                           #'(coord-proto-symb ...)))
                     )
         #'(begin
             (define-values (coord-proto-symb ...
                             coord-vector-sym ...
                             coord-one-form-sym ...)
               (let ((coord-sys coord-sys-expr))
                 ((coord-sys 'set-coordinate-prototype!)
                  (up/down 'coord-proto-symb ...))
                 (let ((chart-functions
                        (append
                         (map cadr
                              (ultra-flatten
                               (coord-sys 'coordinate-function-specs)))
                         (map cadr
                              (ultra-flatten
                               (coord-sys 'coordinate-basis-vector-field-specs)))
                         (map cadr
                              (ultra-flatten
                               (coord-sys 'coordinate-basis-1form-field-specs))))))
                   (apply values chart-functions))))))))))

;; (using-coordinates (up x y) R2-rect
;;   (pec (x ((R2-rect '->point) (up 'a 'b))))

(define-syntax using-coordinates
  (lambda (stx)
    (syntax-case stx ()
      ((_ (coord ...) coord-sys-expr body ...)
       #'(let ()
           (define-coordinates (coord ...) coord-sys-expr)
           body ...)))))

