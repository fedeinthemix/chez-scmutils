;;; ***

(define R2-rect-point ((point R2-rect) (up 'x0 'y0)))
(define R3-rect-point ((point R3-rect) (up 'x0 'y0 'z0)))

(define-coordinates (up x y z) R3-rect)
(define u (+ (* 'u^0 d/dx) (* 'u^1 d/dy)))
(define v (+ (* 'v^0 d/dx) (* 'v^1 d/dy)))

(((wedge dx dy) u v) R3-rect-point)
;; => (+ (* v^1 u^0) (* -1 u^1 v^0))

;;; ***

(define R3-cyl-point ((point R3-cyl) (up 'r0 'theta0 'z0)))

(define-coordinates (up r theta z) R3-cyl)

(define a (+ (* 'a^0 d/dr) (* 'a^1 d/dtheta)))
(define b (+ (* 'b^0 d/dr) (* 'b^1 d/dtheta)))

(((wedge dr dtheta) a b) R3-cyl-point)
;; => (+ (* b^1 a^0) (* -1 a^1 b^0))

;;; ***

(define u (+ (* 'u^0 d/dx) (* 'u^1 d/dy) (* 'u^2 d/dz)))
(define v (+ (* 'v^0 d/dx) (* 'v^1 d/dy) (* 'v^2 d/dz)))
(define w (+ (* 'w^0 d/dx) (* 'w^1 d/dy) (* 'w^2 d/dz)))

(- (((wedge dx dy dz) u v w) R3-rect-point)
   (determinant
    (matrix-by-rows (list 'u^0 'u^1 'u^2)
                    (list 'v^0 'v^1 'v^2)
                    (list 'w^0 'w^1 'w^2))))
;; => 0

;;; ***

(define a (literal-manifold-function 'alpha R3-rect))
(define b (literal-manifold-function 'beta R3-rect))
(define c (literal-manifold-function 'gamma R3-rect))

(define theta (+ (* a dx) (* b dy) (* c dz)))

(define X (literal-vector-field 'X-rect R3-rect))
(define Y (literal-vector-field 'Y-rect R3-rect))

(((- (d theta)
     (+ (wedge (d a) dx)
        (wedge (d b) dy)
        (wedge (d c) dz)))
  X Y)
 R3-rect-point)
;; => 0

;;; ***

(define mu (literal-manifold-map 'MU R2-rect R3-rect))

(define f (literal-manifold-function 'f-rect R3-rect))
(define X (literal-vector-field 'X-rect R2-rect))

(define theta (literal-1form-field 'THETA R3-rect))
(define Y (literal-vector-field 'Y-rect R2-rect))

(((- ((pullback mu) (d theta)) (d ((pullback mu) theta))) X Y)
 R2-rect-point)
;; => 0

;;; ***

(define a (literal-manifold-function 'alpha R3-rect))
(define b (literal-manifold-function 'beta R3-rect))
(define c (literal-manifold-function 'gamma R3-rect))

(define-coordinates (up x y z) R3-rect)

(define theta (+ (* a dx) (* b dy) (* c dz)))

(define omega
  (+ (* a (wedge dy dz))
     (* b (wedge dz dx))
     (* c (wedge dx dy))))

(define X (literal-vector-field 'X-rect R3-rect))
(define Y (literal-vector-field 'Y-rect R3-rect))
(define Z (literal-vector-field 'Z-rect R3-rect))
(define V (literal-vector-field 'V-rect R3-rect))
(define R3-rect-point ((point R3-rect) (up 'x0 'y0 'z0)))

(((- ((Lie-derivative V) (d theta))
     (d ((Lie-derivative V) theta)))
  X Y)
 R3-rect-point)
;; => 0

(((- ((Lie-derivative V) (d omega))
     (d ((Lie-derivative V) omega)))
  X Y Z)
 R3-rect-point)
;; => 0

((((- (commutator (Lie-derivative X) (Lie-derivative Y))
      (Lie-derivative (commutator X Y)))
   theta)
  Z)
 R3-rect-point)
;; => 0

((((- (commutator (Lie-derivative X) (Lie-derivative Y))
      (Lie-derivative (commutator X Y)))
   omega)
  Z V)
 R3-rect-point)
;; => 0
