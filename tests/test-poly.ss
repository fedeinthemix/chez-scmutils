(define x-1 (poly/make-from-dense 1 '(1 -1)))
(define x+1 (poly/make-from-dense 1 '(1 1)))

(define p1 (poly/mul (poly/mul x-1 x-1) x+1))
(define p2 (poly/mul (poly/mul x+1 x+1) x-1))

(poly/gcd-euclid p1 p2)
;; => (*dense* 1 1 0 -1)

(pcf:->expression
 (poly/gcd-euclid p1 p2)
 '(x))
;; => (+ -1 (expt x 2))

(poly->roots (poly/mul (poly/mul x-1 x-1) x+1))
;; => (-1.0 1.0 1.0)

