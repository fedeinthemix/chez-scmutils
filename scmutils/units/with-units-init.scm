

(assign-operation 'type             u:type             with-units?)

(assign-operation 'arity            u:arity            with-units?)

(assign-operation 'zero-like        u:zero-like        with-units?)
(assign-operation 'one-like         u:one-like         with-units?)

(assign-operation 'zero?            u:zero?            with-units?)


(assign-operation 'negate           u:negate           with-units?)
(assign-operation 'invert           u:invert           with-units?)

(assign-operation 'sqrt             u:sqrt             with-units?)



(assign-operation '=          u:=            with-units? with-units?)
(assign-operation '<          u:<            with-units? with-units?)
(assign-operation '<=         u:<=           with-units? with-units?)
(assign-operation '>          u:>            with-units? with-units?)
(assign-operation '>=         u:>=           with-units? with-units?)
(assign-operation '+   u:+     with-units?             not-differential-or-compound?)
(assign-operation '+   u:+     not-differential-or-compound?  with-units?)

(assign-operation '-   u:-     with-units?             not-differential-or-compound?)
(assign-operation '-   u:-     not-differential-or-compound?  with-units?)

(assign-operation '*   u:*     with-units?             not-differential-or-compound?)
(assign-operation '*   u:*     not-differential-or-compound?  with-units?)

(assign-operation '*   u:*u    with-units?               units?)
(assign-operation '*   u:u*    units?                    with-units?)

(assign-operation '*   u:t*u    not-d-c-u?               units?)
(assign-operation '*   u:u*t    units?                   not-d-c-u?)


(assign-operation '/   u:/     with-units?              not-differential-or-compound?)
(assign-operation '/   u:/     not-differential-or-compound?  with-units?)

(assign-operation '/   u:/u    with-units?               units?)
(assign-operation '/   u:u/    units?                    with-units?)

(assign-operation '/   u:t/u    not-d-c-u?                units?)
(assign-operation '/   u:u/t    units?                    not-d-c-u?)


(assign-operation 'expt       u:expt         with-units?  not-differential-or-compound?)


(assign-operation 'make-rectangular    u:make-rectangular with-units? with-units?)
(assign-operation 'make-polar          u:make-polar       with-units? any?)
(assign-operation 'real-part           u:real-part        with-units?)
(assign-operation 'imag-part           u:imag-part        with-units?)
(assign-operation 'magnitude           u:magnitude        with-units?)
(assign-operation 'angle               u:angle            with-units?)

(assign-operation 'conjugate           u:conjugate        with-units?)

(assign-operation 'atan2               u:atan2            with-units? with-units?)
