(define R2-rect-chi (chart R2-rect))
(define R2-rect-chi-inverse (point R2-rect))
(define R2-polar-chi (chart R2-polar))
(define R2-polar-chi-inverse (point R2-polar))

(define R2-rect-point (R2-rect-chi-inverse (up 'x0 'y0)))
(define R2-polar-point (R2-polar-chi-inverse (up 'r0 'theta0)))

((compose R2-polar-chi R2-rect-chi-inverse)
 (up 'x0 'y0))

(define-coordinates (up x y) R2-rect)
(define-coordinates (up r theta) R2-polar)

(x R2-rect-point)
(r R2-polar-point)
(theta R2-rect-point)

(coordinate-system->vector-basis R2-rect)

(define R2->R (-> (UP Real Real) Real))
;; (define v
;;   (components->vector-field
;;    (up (literal-function 'b^0 R2->R)
;;        (literal-function 'b^1 R2->R))
;;    R2-rect))
(define v (literal-vector-field 'b R2-rect))
(define omega (literal-1form-field 'a R2-rect))

((v (literal-manifold-function 'f-rect R2-rect)) R2-rect-point)

(((coordinatize v R2-rect) (literal-function 'f-rect R2->R))
 (up 'x0 'y0))

((v (chart R2-rect)) R2-rect-point)
((d/dx (square r)) R2-rect-point)

(define circular (- (* x d/dy) (* y d/dx)))

(series:for-each print-expression
                 (((exp (* 't circular)) (chart R2-rect))
                  ((point R2-rect) (up 1 0)))
                 6)

(g:apply
 ((d (literal-manifold-function 'f-rect R2-rect))
  (coordinate-system->vector-basis R2-rect))
 (list R2-rect-point))

;;; Try to implement 'use-value' -> fails :-(

;; (define (inapplicable-object-condition? c)
;;   (if (and (assertion-violation? c)
;;            (string=? "attempt to apply non-procedure ~s"
;;                      (condition-message c))
;;            (continuation-condition? c))
;;       (condition-continuation c)
;;       #f))

;; ;; missing a way to get to the arguments.
;; (guard (c
;;         ((inapplicable-object-condition? c)
;;          ((condition-continuation c)
;;           (lambda args (g:apply (car (condition-irritants c)) args))))
;;         (else (raise c)))
;;   (((d (literal-manifold-function 'f-rect R2-rect))
;;     (coordinate-system->vector-basis R2-rect))
;;    R2-rect-point))
