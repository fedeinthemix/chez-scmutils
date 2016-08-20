(import (mit core)
        (mit curry)
        (scmutils base)
        (scmutils generic)
        (scmutils mechanics)
        (scmutils calculus)
        (fbe gnuplot))

;;; **** UNIVARIATE MINIMIZATION ****

(define foo (Lagrange-interpolation-function '(2 1 2) '(2 3 4)))

;;(brent-min foo 0 5 1e-2)
(minimize foo 0 5)
;; => (3.0 1.0 5) ; [x-min (f x-min) n-iterations]

(golden-section-min foo 0 5
    (lambda (lowx minx highx flowx fminx fhighx count)
      (< (abs (- highx lowx)) .001)))
;; => (3.0001322139227034 1.0000000174805213 17)

(define bar (Lagrange-interpolation-function '(2 1 2 0 3) '(2 3 4 5 6)))

(local-minima bar -10 10 15 .0000001)
;; => ((5.303446964995252 -0.32916549541536916 18)
;;     (2.5312725379910592 0.4258326399952621 18)

(local-maxima bar -10 10 15 .0000001)
;; => ((3.8192274368217713 2.067961961032311 17)
;;     (10 680 31)
;;     (-10 19735 29))

;;; **** MULTIVARIATE MINIMIZATION ****

(define (baz v)
  (* (foo (ref v 0)) (bar (ref v 1))))

(multidimensional-minimize baz '(4 3))
;; => (2.9999927603607803 2.5311967755369285)

(nelder-mead baz '#(4 3) 1 .00001 100)
;; => (ok ((up 2.9955235887900926 2.5310866303625517)
;;          .
;;          0.42584120140775594)
;;        21)

(dfp baz (compose down->vector (D baz)) '#(4 3) .4 .00001 100)
;; => (ok ((up 2.999971756396209 2.5312137271309987)
;;          .
;;          0.4258326204265247)
;;        4)

;;; **** QUADRATURE ****

(define witch
  (lambda (x)
    (/ 4.0 (+ 1.0 (* x x)))))

(define integrator (make-definite-integrator))

;;(integrator 'set-method! 'romberg)
(integrator 'set-error! 1e-12)
(integrator 'set-integrand! witch)
(integrator 'set-lower-limit! 0.0)
(integrator 'set-upper-limit! 1.0)
(integrator 'integral)
;; => 3.141592653589803

(define (foo n)
  ((make-definite-integrator
    (lambda (x) (expt (log (/ 1 x)) n))
    0.0 1.0
    1e-12 'open-closed)
   'integral))

(foo 3)
;; => 5.99999999999799

;;; **** ODE ****

;; (set-ode-integration-method! 'qcrk4)
;; (set-ode-integration-method! 'bulirsch-stoer)
;; (set-ode-integration-method! 'qcctrap2)
;; (set-ode-integration-method! 'explicit-gear)

(define* ((ellipse-sysder a b) state)
  (let ((t (ref state 0))
        (x (ref state 1))
        (y (ref state 2)))
    (up 1                               ; dt/dt
        (* -1 a y)                      ; dx/dt
        (* b x))))                      ; dy/dt

;; this kind of monitor is very slow with the 'gnuplot' interface.
(define* ((monitor-xy win) state)
  (win 'plot-points (list (ref state 1)) (list (ref state 2))))

(define* (monitor-xy-txt . ignored) write-line)

(define win (make-gplotter))
(win 'hold #t)

((evolve ellipse-sysder 0.5 2.)
 (up 0. .5 .5)                          ; initial state
 (monitor-xy-txt)                       ; the monitor
 0.01                                   ; plotting step
 10.)                                   ; final value of t

((state-advancer ellipse-sysder 0.5 2.0) (up 0. .5 .5) 3.0 1e-10)

;; We should define a nice interface to accumulate results
(define xy-results
  (let ((t-end 10)
        (dt 0.01))
    (list (make-vector (+ 1 (exact (round (/ t-end dt)))) +nan.0)
          (make-vector (+ 1 (exact (round (/ t-end dt)))) +nan.0))))

(define* ((monitor-xy-v xy-vectors t-end dt) state)
  (define (index t) (exact (round (/ t dt))))
  (let ((t (ref state 0))
        (x (ref state 1))
        (y (ref state 2)))
    (vector-set! (car xy-vectors) (index t) x)
    (vector-set! (cadr xy-vectors) (index t) y)))

(let ((t-end 10.0)
      (dt 0.01))
 ((evolve ellipse-sysder 0.5 2.)
  (up 0. .5 .5)                         ; initial state
  (monitor-xy-v xy-results t-end dt)    ; the monitor
  dt                                    ; plotting step
  t-end))                               ; final value of t

(define win2 (make-gplotter))
(win2 'plot-points xy-results)
(win2 'grid)
(win2 'xrange -1.3 1.3)
(win2 'yrange -1.3 1.3)

;;; mechanics example

(define* ((harmonic-sysder m k) state)
  (let ((q (coordinate state)) (p (momentum state)))
    (let ((x (ref q 0)) (y (ref q 1))
          (px (ref p 0)) (py (ref p 1)))
      (up 1                             ;dt/dt
          (up (/ px m) (/ py m))        ;dq/dt
          (down (* -1 k x) (* -1 k y))  ;dp/dt
          ))))

(define* ((H m k) state)
  (+ (/ (square (momentum state))
        (* 2 m))
     (* 1/2 k
        (square (coordinate state)))))

(let ((m 0.5) (k 2.0))
  ((evolve harmonic-sysder m k)
   (up 0.                               ; initial state
       (up .5 .5)
       (down 0.1 0.0))
   (lambda (state)                      ; the monitor
     (write-line
      (list (time state) ((H m k) state))))
   1.0                                  ; output step
   10.))
