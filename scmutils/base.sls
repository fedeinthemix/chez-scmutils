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

#!chezscheme

(library (scmutils base)
  (export
   ;; base.sls
   derivative-symbol
   with-si-units->expression
   
   ;; ./scmutils/general/weak.scm
   weak-pair? weak-cons weak-car weak-cdr weak-pair/car?
   list->weak-list weak-set-cdr! get-weak-member weak-find
   weak-length weak-finder weak-find-equal?
   weak-find-eqv? weak-find-eq? purge-list clean-weak-list
   clean-weak-alist clean-subtable-alist clean-expression-table
   clean-alist
   
   ;;./scmutils/general/memoize.scm ; OK
   *memoizers* *auditing-memoizers* show-memoizer-statistics
   function-expression clear-memoizer-tables
   linear-memoize-1arg linear-memoize same-args?
   equal-args? eqv-args? eq-args?
   weak-find-equal-args? weak-find-eqv-args? weak-find-eq-args?
   *not-seen* hash-memoize-1arg hash-memoize memoize-procedure!
   unmemoize-procedure!

   ;;./scmutils/general/hashcons.scm ; OK
   cons-unique hash-cons pair-eqv? pair-eqv-hash-mod
   the-cons-table canonical-copy map-unique

   ;;./scmutils/general/resource-limit.scm
   *time-upper-limit* with-limited-time

   ;;./scmutils/general/stack-queue.scm
   stack&queue-empty? stack&queued? push! add-to-end! pop!

   ;;./scmutils/general/logic-utils.scm
   true? assert *assumption-tolerance-multiplier* assume!
   add-assumption! &or *or &and
   *and conjunction disjunction negation implication

   ;;./scmutils/general/list-utils.scm
   variable<? safe-map count-elements find-first countsymbols
   butlast last list-transpose list-index-of delete-nth
   list:elementwise map-distinct-pairs distinct-pairs
   for-each-distinct-pair fringe-smaller-than? split-list
   find-infimum subst delq-once substitute-multiple
   map&reduce
   ;;%append %reverse! %reverse

   ;;./scmutils/general/table.scm
   make-table
   *no-value* no-value? get getter
   put! putter! get-with-default getter-with-default
   get-with-check getter-with-check add-to-list!
   adjoin-to-list! store! lookup rlookup rassq rassoc disassoc
   default-lookup table-of lookup

   ;;./scmutils/general/sets.scm
   make-sets-package empty-set
   empty-set? singleton-set singleton-set? adjoin-set
   remove-set element-set? intersect-sets union-sets
   difference-sets subset-sets? list->set set->list symbols
   real-numbers <numbers numbers list-adjoin list-union
   list-intersection list-difference duplications?
   remove-duplicates subset? same-set? eq-set/remove
   eq-set/union eq-set/intersection
   eq-set/difference eq-set/subset? eq-set/equal?
   multi-set/intersection multi-set/difference

   ;;./scmutils/general/permute.scm
   permutations combinations list-interchanges split-permutations
   permutation-interchanges permute sort-and-permute subpermute
   int:factorial number-of-permutations number-of-combinations
   permutation-parity

   ;;./scmutils/general/eq-properties.scm
   eq-properties eq-put! eq-get eq-rem! eq-adjoin! eq-plist
   eq-clone! eq-label! eq-path

   ;;./scmutils/general/gjs-cselim.scm
   gjs/cselim make-let-expression make-canonical-lets
   make-expression-recorder record-expression! expressions-seen
   variable->expression occurs-in?

   ;;./scmutils/kernel/numeric.scm ; OK
   zero one -one two three pi -pi pi/6 -pi/6 pi/4
   -pi/4 pi/3 -pi/3 pi/2 -pi/2 2pi -2pi
   :zero :one :-one :two :three :pi :+pi :-pi :pi/6 :+pi/6
   :-pi/6 :pi/4 :+pi/4 :-pi/4 :pi/3 :+pi/3 :-pi/3 :pi/2 :+pi/2
   :-pi/2 :2pi :+2pi :-2pi *machine-epsilon* *sqrt-machine-epsilon*
   :euler :phi
   exact-zero? exact-one? :ln2 :ln10
   ;; log10 log2 exp10 exp2
   :minlog safelog principal-value
   principal-value-minus-pi-to-pi principal-value-zero-to-2pi
   principal-range
   ;; one? square cube negate invert cot sec csc
   ;; sinh cosh tanh sech csch
   factorial exact-quotient binomial-coefficient stirling-first-kind
   stirling-second-kind close-enuf?
   ;; sigma
   gcd-rational
   round-complex gcd-complex exact-complex? scheme-number-gcd
   *no-rationals-in-divide* scheme-number-divide sgn quadratic
   cubic
 
   ;;./scmutils/kernel/utils.scm
   do-up do-down sign defer-application all-equal?
   left-circular-shift right-circular-shift
   *at-least-zero* *exactly-zero* *at-least-one* *exactly-one*
   *at-least-two* *exactly-two* *at-least-three*
   *exactly-three* *one-or-two* exactly-n? any-number?
   ;; compose compose-n identity compose-2 compose-bin
   any? none?
   constant joint-arity a-reduce filter make-map bracket
   apply-to-all nary-combine binary-combine unary-combine
   iterated iterate-until-stable make-function-of-vector
   make-function-of-arguments alphaless?
   concatenate-names-maker concatenate-names the-null-symbol
   concatenate-names print-depth print-breadth wallp-pp pp-it
   watch-it cpp ;*taking-notes* *showing-notes* *notes*
   note-that! clear-notes! display-note show-notes

   ;;./scmutils/kernel/iterat.scm
   generate-list list:generate list-with-substituted-coord
   generate-vector vector-elementwise vector-forall
   vector-exists vector-accumulate
   vector-with-substituted-coord array-ref array-set!
   generate-array array-elementwise array-copy num-rows
   num-cols nth-row nth-col array-with-substituted-row
   array-with-substituted-col array-by-rows array-by-cols
   transpose-array

   ;;./scmutils/kernel/express.scm
   operator operands first-operand second-operand rest-operands
   substitute has-property? get-property add-property!
   make-numerical-literal make-real-literal make-literal
   make-combination expression-of down-maker? up-maker?
   vector-maker? quaternion-maker? matrix-by-rows-maker?
   matrix-by-columns-maker? matrix-maker?
   compound-data-constructor? expression
   up-constructor-name down-constructor-name object-name
   procedure-expression generate-list-of-symbols variables-in
   pair-up expression-walker expr:< expr:=

   ;;./scmutils/kernel/ghelper.scm
   make-generic-operator identity
   get-operator-record set-operator-record!
   make-operator-record operator-record-arity
   operator-record-finder set-operator-record-finder!
   operator-record-tree set-operator-record-tree!
   generic-operator-arity acceptable-arglist? assign-operation
   defhandler bind-in-tree no-way-known dwim get-handler

   ;;./scmutils/kernel/generic.scm
   g:type g:type-predicate g:arity g:inexact? g:zero-like g:one-like
   g:identity-like
   g:zero? generic:one? g:one?
   g:identity? g:negate g:invert g:square g:sqrt g:exp g:log
   g:sin g:cos g:asin g:acos g:sinh g:cosh g:abs g:determinant
   g:trace
   g:transpose
   ;;; We should put these in a separate file and include it here and
   ;;; in 'calculus/manifold.scm'.  We don't export them as they
   ;;; belong in '(scmutils generic).
   ;;coordinate-system coordinate-system-dimension
   g:dimension g:solve-linear 
   make-operator generic:partial-derivative
   g:derivative g:partial-derivative g:partial generic:=
   g:=:bin generic:< g:<:bin generic:<= g:<=:bin generic:>
   g:>:bin generic:>= g:>=:bin generic:+ g:+:bin generic:-
   g:-:bin generic:* g:*:bin generic:/ g:/:bin generic:expt
   g:expt g:gcd:bin g:dot-product g:cross-product
   g:outer-product g:make-rectangular g:make-polar g:real-part
   g:imag-part g:magnitude g:angle g:conjugate g:atan g:atan1
   g:atan2 generic:apply g:apply applicable-literal?
   g:= g:=:n g:< g:<:n g:<= g:<=:n g:> g:>:n g:>= g:>=:n g:+
   g:+:n g:* g:*:n g:- g:-:n g:/ g:/:n g:gcd g:gcd:n

   ;;./scmutils/kernel/mathutil.scm
   ratnum? g:cube g:log10 g:log2 g:exp10 g:exp2 g:tan g:cot
   g:sec g:csc g:tanh g:sech g:csch g:asinh g:acosh g:atanh
   g:arg-shift g:arg-scale g:sigma g:ref component
   ref-internal adjust-index adjust-end g:size g:compose
   g:identity g:compose-2 g:compose-bin

   ;;./scmutils/kernel/strutl.scm ; OK
   stream:for-each print-stream combiner-padded-streams stream-of-iterates
   infinite-stream-of stream-evaluate stream-apply map-stream
   map-streams merge-streams shorten-stream stream:+ stream:-
   stream:* stream:/ zero-stream one-stream integers-starting-from
   natural-number-stream factorial-stream stream-of-powers stream:inflate
   stream:list-append

   ;;./scmutils/kernel/fbe-extapply.scm
   *enable-literal-apply*
   with-literal-apply-enabled
   with-literal-reconstruction-enabled

   ;;./scmutils/kernel/types.scm
   make-type type-tag abstract-type-tag quantity-predicate
   concrete-predicate abstract-predicate quaternion-type-tag
   operator-type-tag abstract-quantity? abstract-number?
   literal-number? literal-real? numerical-quantity?
   with-units? units? compound-type-tag? not-compound? scalar?
   abstract-vector? vector-quantity? quaternion?
   quaternion-quantity? up? abstract-up? up-quantity? down?
   abstract-down? down-quantity? structure? abstract-structure?
   matrix? matrix-quantity? abstract-matrix? square-matrix?
   square-abstract-matrix? operator? not-operator?
   function-quantity? function? cofunction? abstract-function?
   typed-function? typed-or-abstract-function? differential?
   not-differential? series? not-series?
   not-differential-or-compound? not-d-c-u?

   ;;./scmutils/kernel/modarith.scm
   modular-type-tag modint? mod:make mod:make-internal
   mod:residue mod:modulus mod:reduce mod:unary-combine
   modint:invert mod:invert mod:binary-combine
   modint:+ modint:- modint:* modint:/ modint:expt
   mod:+ mod:- mod:* mod:/ mod:expt mod:= mod:chinese-remainder
   modint:chinese-remainder

   ;;./scmutils/kernel/diff.scm
   make-differential-quantity differential-term-list
   differential->terms terms->differential
   make-differential-term differential-tags
   differential-coefficient differential-of diff:arity
   diff:apply same-differential-tags? <differential-tags? <dts
   differential-tag-count <dt =dt union-differential-tags
   intersect-differential-tags dtl:+ dtl:* tdtl:* d:+ d:*
   diff:unary-op finite-part infinitesimal-part
   terms->differential-collapse diff:binary-op
   max-order-tag without-tag with-tag diff:atan2 diff:abs
   diff:conjugate diff:real-part diff:imag-part diff:magnitude
   diff:angle diff:type diff:type-predicate diff:zero-like
   diff:one-like diff:zero? diff:one? diff:binary-comparator
   diff:derivative
   simple-derivative-internal make-x+dx differential-object
   extract-dx-part hide-tag-in-object
   hide-tag-in-procedure wrap-procedure-differential-tags
   replace-differential-tag remove-differential-tag
   insert-differential-tag

   ;;./scmutils/kernel/deriv.scm ; OK
   deriv:euclidean-structure
   deriv:multivariate-derivative

   ;;./scmutils/kernel/operator.scm
   o:type o:type-predicate o:arity make-op operator-procedure
   operator-subtype operator-name operator-arity
   operator-optionals simple-operator? set-operator-optionals!
   operator-merge-subtypes operator-merge-arities
   operator-merge-optionals o:zero-like o:one-like o:+ o:-
   o:o+f o:f+o o:o-f o:f-o o:negate o:* o:f*o o:o*f o:o/n
   o:expt o:exp o:cos o:sin expn

   ;;./scmutils/kernel/function.scm
   f:type f:type-predicate f:unary f:binary coerce-to-function
   f:arity f:zero-like f:one-like f:identity-like f:transpose

   ;;./scmutils/kernel/numbers.scm
   n:type n:type-predicate *numbers-are-constant-functions*
   n:arity n:self n:deriv n:inexact? n:zero-like n:one-like
   n:zero? n:one? n:negate n:invert n:sqrt n:exp n:log n:sin
   n:cos n:tan n:sec n:csc n:asin n:acos n:atan n:sinh n:cosh
   n:tanh n:sech n:csch n:abs n:= n:< n:<= n:> n:>= n:+ n:- n:*
   n:/ n:expt n:gcd n:make-rectangular n:make-polar n:real-part
   n:imag-part n:magnitude n:angle n:conjugate n:log10 n:log2
   n:exp10 n:exp2 n:square n:cube n:sigma literal-number
   make-numerical-combination an:zero-like an:one-like an:=
   an:zero? an:one? abn:= abn:zero? abn:one? *known-reals*
   known-real? declare-known-reals declare-unknown-reals
   with-known-reals

   ;;./scmutils/kernel/vectors.scm ; OK
   v:type v:type-predicate v:generate vector:generate v:dimension
   v:elementwise vector:elementwise
   v:zero? v:make-zero v:zero-like literal-vector
   v:make-basis-unit v:basis-unit? vector=vector vector+vector
   vector-vector v:negate v:scale scalar*vector vector*scalar
   vector/scalar v:inner-product v:dot-product v:square v:cube
   euclidean-norm complex-norm maxnorm v:make-unit v:unit?
   v:conjugate v:cross-product general-inner-product v:apply
   v:arity v:partial-derivative v:inexact? abstract-vector
   av:arity av:zero-like make-vector-combination

   ;;./scmutils/kernel/structs.scm
   s:type sc:type-predicate sr:type-predicate vector->up
   vector->down literal-up literal-down s:structure up->vector
   down->vector s:->vector up down s:opposite s:same s:length
   s:ref s:with-substituted-coord s:subst s:subst-internal
   s:generate s:forall s:select s:map-chain s:fringe
   s:foreach s:map/r s:map/r/l s:map s:map/l s:elementwise
   structure:elementwise rexists s:arity s:inexact? s:zero?
   s:unary s:zero-like s:negate s:magnitude s:abs s:conjugate
   structure=structure s:binary structure+structure
   structure-structure s:multiply
   *allowing-incompatible-multiplication*
   s:compatible-for-contraction? s:compatible-elements?
   s:outer-product structure:expt scalar*structure
   structure*scalar structure/scalar s:square s:dot-product
   s:partial-derivative s:apply abstract-up abstract-down
   as:arity ac:zero-like ar:zero-like make-up-combination
   make-down-combination list->up-structure matrix->structure
   submatrix up-structure->list s:transpose s:transpose1
   s:inverse s:inverse1 A_mn->Mnm Mnm->A_mn A^mn->Mmn Mmn->A^mn
   A^m_n->Mmn Mmn->A^m_n A_m^n->Mnm Mnm->A_m^n \x32;-down?
   \x32;-up? up-of-downs? down-of-ups? \x32;-tensor?
   single-layer-down? single-layer-up? structure->matrix
   s:invert scalar/tensor solve-linear-left solve-linear-right
   s:divide-by-structure s:determinant s:trace flip-indices
   flip-outer-index typical-object structure->access-chains
   structure->prototype compatible-zero dual-zero
   compatible-shape s:transpose-outer s:contract ultra-flatten
   s:dimension ultra-unflatten *careful-conversion* s->m m->s
   as-matrix

   ;;./scmutils/kernel/matrices.scm
   m:type m:type-predicate tag-matrix m:num-rows m:num-cols
   matrix->array array->matrix m:dimension matrix-size
   column-matrix? row-matrix? vector->row-matrix
   vector->column-matrix row-matrix
   column-matrix column-matrix->vector row-matrix->vector
   m:nth-row m:nth-col m:diagonal literal-matrix
   literal-column-matrix literal-row-matrix up->column-matrix
   column-matrix->up down->row-matrix row-matrix->down
   matrix-by-rows matrix-by-row-list matrix-by-cols
   matrix-by-col-list matrix-with-substituted-row matrix-ref
   m:ref m:generate matrix:generate m:transpose m:elementwise
   matrix:elementwise m:submatrix m:minor m:zero? m:make-zero
   m:zero-like m:make-identity m:identity? m:one-like
   m:identity-like m:make-diagonal diagonal? matrix=matrix
   matrix-binary-componentwise matrix+matrix matrix-matrix
   matrix*matrix m:square m:expt matrix*scalar scalar*matrix
   m:scale m:outer-product m:inner-product matrix/matrix
   matrix*up down*matrix matrix*vector vector*matrix
   matrix/scalar scalar/matrix matrix=scalar scalar=matrix
   matrix+scalar scalar+matrix matrix-scalar scalar-matrix
   m:trace m:conjugate m:negate m:dot-product-row
   m:dot-product-column m:cross-product-row
   m:cross-product-column m:exp m:sin m:cos general-determinant
   Cramers-rule classical-adjoint-formula
   easy-zero? numerical? m:invert m:solve m:determinant
   m:rsolve m:solve-linear set-numerical! m:apply m:arity
   m:partial-derivative m:inexact? abstract-matrix am:arity
   am:zero-like am:one-like am:id-like make-matrix-combination

   ;;./scmutils/kernel/quaternion.scm ; OK
   q:type q:type-predicate make-quaternion q:make quaternion
   quaternion->vector q:->vector quaternion-ref q:ref
   real&3vector->quaternion q:real&3vector->
   quaternion->3vector q:3vector quaternion->real-part
   q:real-part quaternion+quaternion q:+ quaternion-quaternion
   q:- quaternion*quaternion q:* q:conjugate q:negate
   scalar*quaternion quaternion*scalar quaternion/scalar
   q:invert quaternion/quaternion q:/ q:magnitude q:make-unit
   q:unit? q:exp q:log q:zero-like q:zero? q:= q:inexact?
   q:apply q:arity q:partial-derivative
   q:1 q:i q:j q:k s:1 s:i s:j s:k
   quaternion->4x4 q:->4x4 4x4->quaternion q:4x4->
   angle-axis->quaternion q:angle-axis-> quaternion->angle-axis
   q:->angle-axis q:rotate
   rotation-matrix->quaternion q:rotation-matrix->
   quaternion->rotation-matrix q:->rotation-matrix

   ;;./scmutils/kernel/pseries.scm ; OK
   series:type series:type-predicate make-series series:arity
   series:promote-arity series->stream series:same-arity
   series-wrapper series:generate series:for-each
   series:elementwise series:print series:ref series
   power-series series:zero series:one series:identity constant-series
   coefficient+series series+coefficient coefficient-series
   series-coefficient coefficient*series series*coefficient
   series/coefficient coefficient/series add-series series:add
   sub-series series:sub negate-stream series:negate stream:c*s
   stream:s/c mul-series series:mul invert-series series:invert
   series:div integrate-helper *integrate-series integral-series-tail
   partial-sums partial-sums-stream series:sum series:value
   series:->function series:inflate series:zero-like
   series:one-like binomial-series
   cos-series sin-series exp-series cosh-series sinh-series
   tan-series atan-series

   ;;./scmutils/kernel/numsymb.scm ; OK
   enable-constructor-simplifications?
   enable-constructor-simplifications incremental-simplifier
   symbolic-operator-table make-numsymb-expression
   addto-symbolic-operator-table heuristic-number-canonicalizer
   numerical-expression-canonicalizer numerical-expression
   make-rectangular? symb:make-rectangular make-polar?
   symb:make-polar real-part? symb:real-part imag-part?
   symb:imag-part magnitude? symb:magnitude symb:magexpr angle?
   symb:angle symb:anglexpr conjugate? symb:conjugate
   *conjugate-transparent-operators* symb:&
   equality? symb:=:bin symb:= symb:zero? symb:one? sum?
   symb:addends symb:+ symb:add symb:add:n symb:sum product?
   symb:multiplicands symb:* symb:mul symb:mul:n symb:product
   difference? symb:minuend symb:subtrahend symb:- symb:dif
   symb:dif:n symb:difference quotient? symb:numerator
   symb:denominator symb:dividend symb:divisor symb:/ symb:quo
   symb:quo:n symb:quotient allow-nary-difference-quotient abs?
   symb:abs expt? symb:expt square? symb:square cube? symb:cube
   negate? symb:negate invert? symb:invert sqrt? symb:sqrt exp?
   symb:exp log? symb:log heuristic-sin-cos-simplify
   relative-integer-tolerance absolute-integer-tolerance n:pi/4
   n:pi n:2pi n:pi/2 n:pi/3 n:pi/6 almost-integer?
   n:zero-mod-pi? symb:zero-mod-pi? n:pi/2-mod-2pi?
   symb:pi/2-mod-2pi? n:-pi/2-mod-2pi? symb:-pi/2-mod-2pi?
   n:pi/2-mod-pi? symb:pi/2-mod-pi? n:zero-mod-2pi?
   symb:zero-mod-2pi? n:pi-mod-2pi? symb:pi-mod-2pi?
   n:pi/4-mod-pi? symb:pi/4-mod-pi? n:-pi/4-mod-pi?
   symb:-pi/4-mod-pi? sin? symb:sin cos? symb:cos tan? symb:tan
   csc? symb:csc sec? symb:sec atan? symb:atan asin? symb:asin
   acos? symb:acos cosh? symb:cosh sinh? symb:sinh max?
   symb:max min? symb:min derivative? symb:derivative
   ederivative? symb1:+ addup-args symb1:*
   mulup-args symb1:- symb1:/
   symb:elementary-access?

   ;;./scmutils/kernel/heuristic.scm
   heuristic-rounding-tolerance heuristic-rounding-denominator
   heuristic-one-part-insignificant heuristic-rounding-tiny
   heuristic-symbolize? heuristic-canonicalize-real
   heuristic-round-real h-c-r heuristic-canonicalize-complex
   heuristic-round-complex h-c-c

   ;;./scmutils/kernel/fbe-genenv.scm

   ;;./scmutils/kernel/chez-custom-repl.scm ; OK
   saved-repl-print
   *scmutils/repl-simplifier*
   scmutils/simplify
   scmutils/repl-print
   pple
   start-scmutils-print! stop-scmutils-print!
   display-expression de

   ;;./scmutils/simplify/pcf.scm ; OK
   poly/make-identity poly/make-constant poly/make-c*x^n
   poly/identity? poly/monic? poly/negative? poly/equal?
   poly/extend poly/contract poly/contractable? poly/make-vars
   poly/check-same-arity poly/add poly/sub poly/negate poly/mul
   poly/scale-1 poly/scale poly/square poly/expt
   poly/div poly/quotient poly/not-divisible? map-poly-terms
   poly/normalize poly/pseudo-remainder poly/content-maker
   poly/primitive-part-maker
   poly/gcd/euclid euclid-wallp? poly/gcd-euclid
   ;; poly/gcd-collins collins-wallp?
   gcd-memoizer *gcd-memoizer-enabled* *gcd-hit* *gcd-miss*
   unordered-pair-equal? unordered-poly-hash n-random-primes
   skip-initial-primes prime-numbers-vector hash-args-vector
   poly/derivative-partial
   poly/partial-derivative poly/derivative-principal
   poly/horner-univariate poly/horner poly/horner-helper
   poly/hh poly/arg-scale poly/arg-shift poly/abs
   poly/leading-base-coefficient poly/horner-with-error
   pcf? explicit-pcf? poly/type poly/arity poly/termlist
   poly/sparse? poly/make-from-sparse poly/dense?
   poly/make-from-dense poly/make poly/degree
   poly/leading-coefficient poly/except-leading-term
   *dense-break-even* poly/adjoin poly/coefficient
   poly/coefficients poly/base-coefficients
   poly/principal-reverse poly/->dense poly/->sparse
   poly/lowest-order poly/trailing-coefficient poly/sparse/zero
   poly/sparse/zero? poly/sparse/one poly/sparse/identity
   poly/sparse/degree
   poly/sparse/leading-coefficient
   poly/sparse/except-leading-term poly/sparse/adjoin
   poly/sparse/coefficients poly/sparse/coefficient
   poly/sparse/principal-reverse poly/sparse/lowest-order
   poly/sparse/trailing-coefficient poly/dense/zero
   poly/dense/zero? poly/dense/one poly/dense/identity
   poly/dense/degree
   poly/dense/leading-coefficient
   poly/dense/except-leading-term poly/dense/adjoin
   poly/dense/coefficients poly/dense/coefficient
   poly/dense/principal-reverse poly/dense/lowest-order
   poly/dense/trailing-coefficient dense->sparse sparse->dense
   poly/identity poly:arity poly:degree poly:zero? poly:one?
   poly:negate poly:square poly:derivative poly:= poly:+ poly:-
   poly:* poly:expt poly:divide poly:pseudo-remainder
   poly:quotient poly:partial-derivative poly:arg-shift
   poly:arg-scale poly:apply poly:zero poly:one poly:identity
   poly:horners-rule-with-error poly:value poly:principal-value
   poly:principal-reverse poly:scale poly:normalize-by
   poly:lowest-order poly:trailing-coefficient
   poly:leading-coefficient poly:except-leading-term
   poly:leading-base-coefficient poly:extend poly:contract
   poly:contractable? poly:new-variables poly:dense->
   poly:->dense pcf:->expression pcf:expression->
   poly:->lambda +$poly -$poly pcf:operator-table pcf:operators-known

   ;;./scmutils/simplify/rcf.scm ; OK
   rcf-tag ratform? make-ratform ratform-numerator
   ratform-denominator rcf:zero rcf:one rcf:zero? rcf:one?
   rcf:arity make-rcf rcf:rcf? rcf:pcf? rcf:=
   rcf:+ rcf:- rcf:negate rcf:* rcf:square rcf:/ rcf:invert
   rcf:gcd rcf:binary-operator rcf:numerator rcf:denominator
   rcf:expt rcf:arg-scale rcf:arg-shift rcf:value
   rcf:compose
   ;; rcf:derivative
   assoc-accumulation
   +$rcf *$rcf assoc-inverse-accumulation
   -$rcf /$rcf
   rcf:->expression rcf:expression->
   rcf:operator-table rcf:operators-known

   ;;./scmutils/simplify/fpf.scm ; OK
   fpf:coeff? fpf:coeff-zero? fpf:coeff-add fpf:coeff-sub
   fpf:coeff-mul fpf:coeff-div fpf:coeff-negate fpf:coeff-expt
   fpf:coeff-divide fpf? explicit-fpf? fpf:arity
   fpf:number-of-vars fpf:make fpf:terms fpf:make-term
   fpf:exponents fpf:coefficient fpf:constant-term? all-zeros?
   fpf:make-constant fpf:zero fpf:one fpf:-one fpf:identity
   fpf:new-variables fpf:same-exponents? fpf:>exponents?
   fpf:graded> fpf:lexicographical> fpf:map-coefficients
   fpf:binary-combine fpf:+ fpf:add-terms fpf:add-terms-general
   fpf:- fpf:scale fpf:scale-terms fpf:scale-terms-general
   fpf:negate fpf:negate-terms fpf:negate-terms-general fpf:*
   fpf:mul-terms fpf:mul-terms-general fpf:term*terms-general
   fpf:combine-exponents fpf:square fpf:expt
   fpf:divide fpf:divide-terms fpf:divide-terms-general
   fpf:horner-eval fpf:horner-eval-terms
   fpf:horner-eval-general fpf:->expression fpf:expression->
   +$fpf -$fpf *$fpf fpf:operator-table fpf:operators-known

   ;;./scmutils/simplify/simplify.scm ; OK
   *inhibit-expt-simplify* make-analyzer
   default-simplifier expression-simplifier initializer
   priority-setter expression-analyzer
   auxiliary-variable-fetcher fpf:analyzer pcf:analyzer
   pcf:simplify rcf:analyzer rcf:simplify

   ;;./scmutils/simplify/split-poly.scm ; OK
   gcd-Dp split-polynomial actual-factors
   split-polynomial->expression factor-polynomial-expression
   pcf:->factors poly:factor-analyzer poly:factor
   root-out-squares

   ;;./scmutils/simplify/fbe2-syntax.scm

   ;;./scmutils/simplify/rule-syntax.scm ; OK
   rule:compile rule:pattern rule:predicate rule:skeleton
   rule:consequent pattern:compile pattern:vars
   match:element? match:segment?
   match:variable-name match:restricted? match:restriction
   match:reverse-segment? predicate:compile none skel:compile
   skel:constant? skel:element? skel:element-expression
   skel:segment? skel:segment-expression

   ;;./scmutils/simplify/matcher.scm ; OK
   match:predicate match:equal match:eqv
   match:element match:segment
   match:make-segment match:segment-beginning
   match:segment-end match:list
   match:reverse-segment datum=?
   match:bind match:lookup match:value match:->combinators

   ;;./scmutils/simplify/rule-simplifier.scm ; OK
   rule-simplifier try-rules
   rule:make match:extract-segment

   ;;./scmutils/simplify/rules.scm ; OK
   log-exp-simplify? sqrt-expt-simplify? sqrt-factor-simplify?
   aggressive-atan-simplify? inverse-simplify?
   sin-cos-simplify? half-angle-simplify? ignore-zero?
   commute-partials? divide-numbers-through-simplify?
   trig-product-to-sum-simplify? log-exp-simplify
   sqrt-expt-simplify sqrt-factor-simplify
   aggressive-atan-simplify inverse-simplify sin-cos-simplify
   half-angle-simplify ignore-zero-simplify
   commute-partials-simplify divide-numbers-through-simplify
   trig-product-to-sum-simplify negative-number?
   complex-number? imaginary-number? imaginary-integer?
   non-integer? even-integer? odd-integer? universal-reductions
   logexp magsimp 
   miscsimp simsqrt non-negative-factors sqrt-expand sqrt-contract
   specfun->logexp logexp->specfun log-contract log-expand
   list< reals? canonicalize-partials trig->sincos sincos->trig triginv
   zero-mod-pi?
   pi/2-mod-2pi? -pi/2-mod-2pi? pi/2-mod-pi? zero-mod-2pi?
   pi-mod-2pi? pi/4-mod-pi? -pi/4-mod-pi? special-trig
   angular-parity exact-integer>3? expand-multiangle
   trig-sum-to-product trig-product-to-sum contract-expt-trig
   sin-half-angle-formula cos-half-angle-formula half-angle
   at-least-two? sin^2->cos^2 cos^2->sin^2 
   sincos-flush-ones more-than-two? split-high-degree-cosines
   split-high-degree-sines flush-obvious-ones sincos-random
   sincos->exp1 sincos->exp2 exp->sincos exp-contract
   exp-expand complex-rules divide-numbers-through
   simplify-until-stable
   simplify-and-canonicalize simplify-and-flatten
   only-if ->poisson-form trigexpand
   trigcontract full-simplify oe-simplify easy-simplify
   clear-square-roots-of-perfect-squares new-simplify

   ;;./scmutils/simplify/default.scm ; OK
   default-simplify g:simplify simplify-units simplify-procedure
   simplify-abstract-function simplify-operator
   simplify-quaternion simplify-matrix simplify-differential
   simplify-down simplify-up simplify-literal-number

   ;;./scmutils/simplify/sparse.scm ; OK
   sparse-exponents sparse-coefficient sparse-term
   sparse-constant-term? sparse-univariate? sparse-constant?
   sparse-one-term? sparse-one? sparse-zero? sparse-zero-term?
   sparse-constant-term sparse-one sparse-identity-term
   sparse-linear sparse-term-> sparse:>exponents?
   sparse-normalize sparse-scale sparse-negate-term sparse-add
   sparse-multiply sparse-multiply-term sparse-abs
   sparse-divide sparse-divisible? fpf:->sparse
   sparse-evaluate sparse-evaluate> sparse-evaluate<
   sparse-combine-like-terms sparse-merge-adjacent-terms

   ;;./scmutils/simplify/sparse-interpolate.scm
   sparse-interpolate *interpolate-skeleton-using-vandermonde*
   interpolate-skeleton expand-poly univariate-interpolate
   univariate-interpolate-values *interpolate-size*
   interpolate-random

   ;;./scmutils/simplify/sparse-gcd.scm ; OK
   poly/gcd-sparse poly/gcd/sparse sparse-gcd
   *heuristic-sparse-gcd-enabled* sparse-gcd-wrapper
   sparse-monomial-gcd sparse-content
   *heuristic-sparse-gcd-trials* *heuristic-sparse-gcd-win*
   *heuristic-sparse-gcd-lose*
   *heuristic-sparse-gcd-bad-decision* sparse-heuristic-gcd
   sparse-multivariate-gcd *sgcd-restart-limit*
   *sgcd-stage-limit* *sgcd-wallp* *sgcd-tuning*
   sparse-multivariate-gcd-helper *interpolate-primes-stream*
   reset-interpolation-args! make-interpolation-args
   sparse-univariate-gcd *ugcd-wallp* *ugcd-testing*
   sparse-base-content sparse-univariate-primitive-part
   sparse-univariate-pseudo-remainder
   sparse-univariate-constant sparse-univariate-one sparse-univariate-scale
   sparse-univariate-normalize

   ;;./scmutils/simplify/pcf-fpf.scm
   poly:gcd-dispatch *gcd-cut-losses* poly/gcd-classical
   *euclid-breakpoint-arity* poly:gcd gcd-check-same-arity
   gcd-target-type poly->sparse sparse->poly fpf->pcf pcf->fpf
   pcf->sparse sparse->pcf

   ;;./scmutils/display/print.scm
   *divide-out-terms* *heuristic-numbers* canonicalize-numbers
   ham:simplify divide-out-terms-simplify eqn:simplify
   flush-derivative flush-literal-function-constructors
   *factoring* simplify careful-simplify *only-printing*
   *last-expression-printed* prepare-for-printing
   unsimplifiable? show-expression print-expression pe se
   print-expression-comment pec

   ;;./scmutils/display/fbe-exdisplay.scm
   internal-show-expression
   2d-show-expression
   expression->tex-string
   display-tex-string
   last-tex-string-generated
   enable-tex-display

   ;;./scmutils/display/suppress-args.scm
   *suppressed-argument-list*
   *suppressed-argument-list-counter*
   suppress-arguments
   arg-suppressor

   ;;./scmutils/enclose/comcon.scm
   lambdafy make-bound-variables letify definify

   ;;./scmutils/enclose/fbe-magic.scm
   compile-procedure

   ;;./scmutils/enclose/fbe-jinx-cselim.scm
   text/cselim

   ;;./scmutils/enclose/enclose.scm
   lambda->numerical-procedure
   lambda->interpreted-generic-procedure
   abstract-to-function

   ;;./scmutils/numerics/signals/cph-dsp/flovec.scm
   flonum-vector->vector flonum-vector->list vector->flonum-vector
   list->flonum-vector flo:make-vector
   flo:make-initialized-vector flo:subvector flo:vector-grow
   flo:subvector-move! flo:vector-map flo:vector-map!
   flo:vector-for-each flo:subvector-for-each flo:vector-fill!
   flo:subvector-fill! ->flonum

   ;;./scmutils/numerics/quadrature/rational.scm
   extrapolate-function-to-zero build-tableau-f
   rational-function-interpolation build-tableau-lists
   sum-list-flo rational-interpolation zd-wallp? sigma-flo
   rat-square make-bs-intervals extrapolate-streams-to-zero
   build-tableau-streams *quadrature-neighborhood-width*
   from-neighborhood *INTEGRATE-N* integrate-closed-closed
   integrate-closed-closed-1 integrate-open-closed
   integrate-open-closed-1 integrate-closed-open
   integrate-closed-open-1 integrate-open-open
   integrate-open-open-1 integrate-open *roundoff-cutoff*
   integrate-roundoff-wallp? integrate-closed-finite
   integrate-open-finite trapezoid-stream rat-trapezoid
   trapezoid-using-previous-sum second-euler-maclaurin

   ;;./scmutils/numerics/quadrature/quadrature.scm ; OK
   :-infinity :+infinity *infinities* make-definite-integrator
   evaluate-definite-integral *improper-integral-breakpoint*
   evaluate-improper-integral bulirsch-stoer-quadrature

   ;;./scmutils/numerics/quadrature/defint.scm
   *compile-integrand? *definite-integral-allowable-error*
   definite-integral-with-tolerance definite-integral-numerical
   definite-integral choose-interior-point

   ;;./scmutils/numerics/extrapolate/re.scm ; OK
   make-zeno-sequence accelerate-zeno-sequence make-zeno-tableau
   first-terms-of-zeno-tableau richardson-sequence stream-limit
   richardson-limit ord-estimate-stream
   guess-integer-convergent guess-ord-inc-etc
   guess-ord-and-inc richardson-derivative richardson-second-derivative
   romberg-quadrature polynomial-extrapolation rational-extrapolation

   ;;./scmutils/numerics/optimize/unimin.scm ; OK
   extremal-arg extremal-value golden-section-min
   golden-section-max gsmin gsmax
   brent-min brent-max bracket-min
   bracket-max local-maxima local-minima
   estimate-global-max estimate-global-min

   ;;./scmutils/numerics/optimize/multimin.scm ; OK
   simplex-size simplex-vertex simplex-value simplex-entry
   simplex-highest simplex-but-highest simplex-next-highest
   simplex-lowest simplex-add-entry simplex-adjoin simplex-sort
   simplex-centroid
   extender make-simplex stationary? nelder-wallp? nelder-mead
   generate-gradient-procedure line-min-davidon
   line-min-brent
   fletcher-powell-wallp? fletcher-powell dfp dfp-brent
   bfgs-wallp? bfgs

   ;;./scmutils/numerics/optimize/optimize.scm ; OK
   minimize brent-error nelder-start-step nelder-epsilon nelder-maxiter
   multidimensional-minimize parameters->vector
   vector->parameters

   ;;./scmutils/numerics/linear/singular.scm
   barf-on-zero-pivot
   allow-zero-pivot
   singular-matrix-error
   with-singular-matrix-handler
   handle-singularity-errors-with

   ;;./scmutils/numerics/linear/full-pivot.scm
   full-pivot-solve-linear-system
   full-pivot-solve
   full-pivot-solve-internal
   full-pivot-find
   *minimum-allowable-full-pivot*

   ;;./scmutils/numerics/linear/gauss-jordan.scm
   gauss-jordan-solve-linear-system
   gauss-jordan-solve
   gauss-jordan-invert-and-solve
   *minimum-allowable-gj-pivot*
   destructive-gauss-jordan-solve-linear-system

   ;;./scmutils/numerics/linear/lu.scm ; OK
   lu-solve-linear-system lu-solve lu-determinant lu-invert
   lu-decompose lu-backsubstitute
   lu-solve-linear-system-internal lu-solve-internal
   lu-invert-internal lu-determinant-internal
   lu-decompose-internal tiny-pivot-bugger-factor bad-pivot?
   lu-find-best-pivot
   better-pivot? lu-upper-eqn lu-lower-eqn lu-row-swap
   lu-backsubstitute-internal lu-null-space
   lu-null-vector-internal heuristically-zero?
   heuristic-zero-vector? hilbert upper-matrix lower-matrix
   lower*upper checklu

   ;;./scmutils/numerics/linear/svd.scm
   svd svd-least-squares
   svd-solve-linear-system
   svd-invert
   ;;svd-internal

   ;;./scmutils/numerics/linear/vandermonde.scm
   solve-vandermonde-system
   solve-vandermonde-t-system
   solve-vandermonde-td-system
   roots->poly-value

   ;;./scmutils/numerics/linear/eigen.scm
   matrix->eigenvalues
   real-matrix->eigenvalues-eigenvectors
   matrix->eigenvalues-eigenvectors

   ;;./scmutils/numerics/ode/advance.scm ; OK
   advance-generator advance-wallp? min-step-size
   *independent-variable-tolerance* stream-of-states
   vector-fixed-point-with-failure
   *vector-fixed-point-iteration-loss*
   *vector-fixed-point-ridiculously-large*
   *fixed-point-wallpaper* vector-metric
   *norm-breakpoint* lp-norm max-norm parse-error-measure
   vector-clipper vector-padder J-dimension integrator-table
   add-integrator!

   ;;./scmutils/numerics/ode/qc.scm ; OK
   quality-control *qc-trigger-point*
   *qc-halfstep-reduction-factor* *qc-2halfsteps-reduction-factor*
   *qc-fullstep-reduction-factor* qc-wallp? qc-damping
   qc-zero-protect rk4 pc-wallp?
   c-trapezoid n-trapezoid

   ;;./scmutils/numerics/ode/bulirsch-stoer.scm ; OK
   for less-than
   *max-tableau-depth* *max-tableau-width*
   bulirsch-stoer-steps bulirsch-stoer-magic-vectors
   bulirsch-stoer-setup
   vector-Gragg
   lisptran-derivative->floating-lisptran-derivative
   error-measure->floating-error-measure
   bulirsch-stoer-lisptran bulirsch-stoer-floating-lisptran
   bulirsch-stoer-magic-multiplier bulirsch-stoer-magic-base
   bulirsch-stoer-error-wallp bulirsch-stoer-state-wallp
   system-derivative->lisptran-derivative
   lisptran-derivative->system-derivative

   ;;./scmutils/numerics/ode/be.scm ; OK
   c-euler

   ;;./scmutils/numerics/ode/gear.scm ; OK
   gear-advance-generator gear-stepper-generator
   gear-integrator
   update-table gear-predict-maker
   gear-solve-maker gear-control
   spice-expand spice-contract gear-wallp? *gear-max-order*
   *gear-min-order*
   *gear-dead-zone-low* *gear-dead-zone-high*
   *gear-error-too-big* *gear-step-refractory-period*
   *gear-order-refractory-period* *gear-decrease-order*
   *contract-order* *gear-damping* *gear-max-step-increase*
   *gear-protect* *gear-fixed-point-margin*
   *gear-fixed-point-failure-contraction* *spice-order-too-big*
   *spice-step-too-big* *spice-good-step*
   *spice-step-too-small* *spice-order-too-small*
   *spice-step-reduction* *spice-step-expansion* gc1 gc2 gc3
   gc4 gear-correctors  gear-corrector-errors
   gear-error extrap1 lag1 extrap2 lag2 extrap3 lag3
   extrap4 lag4 extrap5 lag5
   lagrange-extrapolators

   ;;./scmutils/numerics/ode/ode-advancer.scm
   *ode-integration-method* *first-step-scale* *corrector-convergence-margin*
   *progress-monitor* ode-advancer set-ode-integration-method!
   advance-monitor final-step-monitor bs-advancer
   qcrk4-advancer qc-ctrap-advancer qc-ceuler-advancer
   gear-advancer gear?

   ;;./scmutils/numerics/ode/interface.scm ; OK
   evolve *time-tolerance*
   *default-advancer-tolerance* state-advancer
   advance-beyond free-run-state-advancer
   make-parametric-flat-sysder *compiling-sysder?
   *max-compiled-sysder-table-size*
   *compiled-sysder-table-size* *compiled-sysder-table*
   compile-parametric-memoized
   *compiler-simplifier* compile-parametric flush-column

   ;;./scmutils/numerics/statistics/cluster.scm
   cluster multiset-difference remove-one merge-2-clusters
   make-a-cluster cluster-elements cluster-diameter
   cluster-subclusters make-singleton-cluster set-separation

   ;;./scmutils/numerics/statistics/gauss.scm ; OK
   uniform-random nonzero-uniform-random
   gaussian-random-pair gaussian-random
   gaussian-random-list
   gaussian-random-pairs
   gaussian-random-tuples
   add-noise

   ;;./scmutils/numerics/statistics/moments.scm ; OK
   v:mean ;v:variance-helper
   v:variance v:sample-variance
   v:standard-deviation v:sample-standard-deviation
   v:average-deviation mean variance
   standard-deviation sample-variance sample-standard-deviation
   skewness kurtosis average-deviation running-mean

   ;;./scmutils/numerics/functions/bessel.scm
   2/pi 3pi/4 round-to-even poly-by-coeffs->value
   bessj0 bessj1 bessj bessy0 bessy1 bessy bessh

   ;;;./scmutils/numerics/functions/elliptic.scm ; OK
   ;;Carlson-elliptic-1 Carlson-elliptic-1-simple Carlson-elliptic-2 ; internal
   elliptic-integral-F complete-elliptic-integral-K
   elliptic-integral-E complete-elliptic-integral-E
   elliptic-integrals first-elliptic-integral
   second-elliptic-integral first-elliptic-integral&derivative
   Jacobi-elliptic-functions

   ;;./scmutils/numerics/roots/bisect.scm ; OK
   bisect-2 bisect-fp *bisect-break* *bisect-wallp* bisect
   find-a-root search-for-roots

   ;;./scmutils/numerics/roots/zbrent.scm
   zbrent

   ;;./scmutils/numerics/roots/zeros.scm
   false-position-search
   newton-with-false-position-search

   ;;./scmutils/numerics/roots/newton-kahan.scm ; OK
   newton-search
   newton-kahan-search

   ;;./scmutils/numerics/roots/multidimensional.scm ; OK
   multidimensional-root

   ;;./scmutils/numerics/signals/cph-dsp/fft.scm ; OK
   flo:real-fft ;flo:real-fft!
   flo:real-inverse-fft ;flo:real-inverse-fft!
   flo:complex-fft ;flo:complex-fft!
   flo:complex-inverse-fft
   ;; flo:complex-inverse-fft! fix:ceiling-lg
   ;; flo:bit-reverse-vector! flo:inverse-fft-reverse!
   compute-wn-vectors
   ;; do-butterflies!
   fft-results->magnitude-squared! magnitude-squared->log-magnitude!
   fft-results->angle! fft-results->complex

   ;;./scmutils/numerics/signals/cph-dsp/white.scm
   make-noise-vector make-uniform-noise-vector
   make-gaussian-noise-vector:polar-method
   marsaglia-maclaren-method mm-algorithm-L mm-worst-case
   mm-tables mm-large-table mm-sj mm-pj mm-pj+3h mm-pj+6h
   mm-abj mm-dj mm-*pj mm-qj mm-fj+6h simpsons-rule
   one-sided-unit-gaussian-pdf-limits
   
   ;;./scmutils/poly/polyroot.scm ; OK
   leading-coefficient lowest-order trailing-coefficient
   identity-poly horners-rule-with-error complex-random
   horners-rule roots->poly poly->roots ensure-real
   bring-to-real rescale-poly-roots obviously-complex?
   clean-up-root deflate-poly identify-multiple-roots
   expand-multiplicities root-searcher root-polisher
   poly-newton-method poly-laguerre-method
   root-wallp minimum-magnitude
   obviousity-factor imaginary-part-tolerance on-axis-tolerance
   rationalization-tolerance
   max-scale clustering minimum-denominator *kahan-threshold*
   root-searcher-method root-searcher-x0 root-searcher-max-iter
   root-searcher-max-shrink root-searcher-jiggle
   root-searcher-shrink-factor root-searcher-value-to-noise
   root-searcher-minimum-progress root-polisher-method
   root-polisher-value-to-noise root-polisher-minimum-progress

   ;;./scmutils/poly/interp.scm ; OK
   lagrange-interpolation-function

   ;;./scmutils/poly/polyinterp.scm ; OK
   poly-domain->canonical poly-domain->general make-interp-poly
   get-poly-and-errors polynomial-function

   ;;./scmutils/poly/legendre.scm
   legendre-polynomial

   ;;./scmutils/poly/hermite.scm ; OK
   make-cubic-interpolant
   make-quintic-interpolant
   make-hermite-interpolator

   ;;./scmutils/poly/nchebpoly.scm ; OK
   add-lists scale-list chebyshev-polynomial
   scaled-chebyshev-expansions chebyshev-expansions
   poly->cheb-exp
   cheb-exp->poly trim-cheb-exp cheb-econ cheb-root-list
   first-n-cheb-values cheb-exp-value generate-cheb-exp
   generate-approx-poly

   ;;./scmutils/poly/ppa.scm ;OK
   make-ppa ppa-value ppa-memo make-smooth-ppa
   smooth-ppa-memo ppa-make-from-poly ppa-adjoin ppa-low-bound
   ppa-high-bound ppa-body ppa-terminal? ppa-poly ppa-split?
   ppa-split ppa-low-side ppa-high-side

   ;;./scmutils/kernel/litfun.scm
   Real X UP DOWN ^ starify X* UP* DOWN* -> Any
   default-function-type permissive-function-type Lagrangian
   Hamiltonian type->domain type->range-type type->domain-types
   type->arity length->exact-arity type-expression->predicate
   all-satisfied type-expression->type-tag df-range-type
   f:domain-types f:range-type *literal-reconstruction*
   f:expression typed-function literal-function?
   literal-function litfun literal-apply litderiv make-partials
   ;;fd

   ;;./scmutils/solve/solve.scm ; OK
   solve-simplifier residual-equations residual-variables
   substitutions hopeless-variables solve-incremental
   fewer-variables? flush-tautologies next-equations
   next-substitutions isolate-var occurs? isolatable?
   positive-power? var-in-product var-in-sum
   backsubstitute-substitution backsubstitute-equation
   substs->equations subst->equation apply-substitutions
   apply-substitutions-to-equation make-substitution
   substitution-variable substitution-expression
   substitution-justifications make-equation
   equation-expression equation-justifications
   equation-variables *solve:contradiction-wallp*
   contradictory-eqn? eqn-contradiction? *zero-threshold*
   differential-operator? D? Dn? standardize-equation
   simple-solve

   ;;./scmutils/units/units.scm
   &unitless unitless? the-empty-vector make-unit unit-system
   unit-exponents unit-scale same-dimensions? same-units?
   <-units? <=-units? >-units? >=-units? *units invert-units
   /units expt-units

   ;;./scmutils/units/fbe-system.scm ; OK
   define-unit-system
   unit-system? unit-system-name base-units derived-units alternate-units
   define-derived-unit define-derived-unit!
   define-additional-unit define-additional-unit!
   *multiplier-names* define-multiplier
   *numerical-constants* define-constant
   ;; numerical-constants symbolic-constants
   get-constant-data &
   *unit-constructor* express-in-given-units
   with-units->expression make-unit-description
   find-unit-description find-unit-name unit-expresson

   ;;./scmutils/units/with-units.scm
   *permissive-units* without-units? unitless-quantity? u:arity
   u:value u:units units:= angular? with-units has-units?
   u:type u:zero-like u:one-like u:zero? u:one? u:= u:< u:<=
   u:> u:>= u:negate u:invert u:sqrt u:sin u:cos u:exp u:+ u:-
   u:* u:/ u:*u u:u* u:t*u u:u*t u:/u u:u/ u:t/u u:u/t u:expt
   u:make-rectangular u:make-polar u:real-part u:imag-part
   u:magnitude u:angle u:conjugate u:atan2 non-unit?

   ;;./scmutils/units/fbe-SI-units.scm ; OK
   SI
   &meter &kilogram &second &ampere &kelvin &mole &candela
   &angular &radian &steradian &newton &joule &coulomb &watt
   &volt &ohm &siemens &farad &weber &henry &hertz &tesla &pascal
   &exa &peta &tera &giga &mega &kilo &hecto &deka &deci &centi
   &milli &micro &nano &pico &femto &atto
   &E &P &T &G &M &k &h &da &d &c &m &u &n &p &f &a
   &lumen &lux &katal &becquerel &gray &sievert &degree &gram &inch
   &centimeter &pound &slug &foot &mile &dyne &calorie &minute
   &hour &day &year &sidereal-year &AU &arcsec &pc &ly &esu &ev
   

   ;;./scmutils/units/fbe2-constants.scm ;OK
   :gamma :c :G :e :h :N_A :m_e :m_p :m_n :m_u :mu_e :mu_p :gamma_p
   :R_H :R :k :h-bar :F :mu_0 :epsilon_0 :Z0 :alpha :R_infinity
   :r_e :lambda_C :a_0 :Phi_0 :h/2m_e :e/m_e :mu_B :mu_e/mu_B
   :mu_N :sigma :sigma_T background-temperature water-freezing-temperature
   room-temperature water-boiling-temperature earth-orbital-velocity
   earth-mass earth-radius earth-surface-area earth-escape-velocity
   earth-gravitational-acceleration :g earth-mean-density
   earth-incident-sunlight vol@stp sound-speed@stp pressure@stp
   earth-surface-temperature sun-mass :m_sun sun-radius :r_sun
   sun-luminosity :l_sun sun-surface-temperature sun-rotation-period
   GMsun

   ;;./scmutils/calculus/fbe-coord.scm ; OK
   define-coordinates using-coordinates

   ;;./scmutils/calculus/frame-maker.scm ;OK
   frame-maker
   event->coords coords->event ancestor-frame
   make-event event?
   frame-owner claim! frame-params frame-name

   ;;;./scmutils/mechanics/sections.scm ; OK
   ;;explore-map default-monitor ; require 'plot-point'
   default-collector
   ;;pointer-coordinates display-map; require graphics capabilities
   iterated-map standard-map
   standard-map-inverse flo:pv

   )
  (import (except (rnrs base) error assert)
          (prefix (only (rnrs base) error) rnrs:)
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
          (mit arithmetic)
          (mit list)
          (except (mit vector) flo:subvector) ; flo:subvector in
                                              ; numerics/signal/cph-dsp/flovec.scm
          (mit curry)
          (except (mit arity) procedure-arity) ; use version in apply-hook
          (mit apply-hook)
          (mit hash-tables)
          (mit environment)
          (mit streams)
          (only (srfi :1) reduce delete any every lset-adjoin make-list append-map)
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
                void vector-copy))

(define scmutils-base-environment (environment '(scmutils base)))
;; used, e.g., in 'enclose/enclose.scm' by 'lambda->numerical-procedure'
(define numerical-environment (environment '(rnrs) '(scmutils base)))
(define generic-environment (environment '(scmutils generic)
                                         '(scmutils mechanics)
                                         '(scmutils calculus)))
(define user-generic-environment #f)

(define *unparser-list-depth-limit* #f)
(define *unparser-list-breadth-limit* #f)

(define derivative-symbol (string->symbol "D"))

;;; **** general **********************************
(include "./scmutils/general/weak.scm")
(include "./scmutils/general/memoize.scm")
(include "./scmutils/general/hashcons.scm")

(include "./scmutils/general/resource-limit.scm")

(include "./scmutils/general/stack-queue.scm")
;;(include "./scmutils/general/ambsch.scm")

(include "./scmutils/general/logic-utils.scm")

(include "./scmutils/general/list-utils.scm")

(include "./scmutils/general/table.scm")
(include "./scmutils/general/sets.scm")
(include "./scmutils/general/permute.scm")
;;(include "./scmutils/general/line-prefix.scm")

(include "./scmutils/general/eq-properties.scm")
(include "./scmutils/general/gjs-cselim.scm")
  
;;; **** kernel **********************************
(define +pi (* 4 (atan 1 1)))
(define +2pi (* 2 +pi))

(include "./scmutils/kernel/numeric.scm")
(include "./scmutils/kernel/utils.scm")
(include "./scmutils/kernel/iterat.scm")
(include "./scmutils/kernel/express.scm")

(include "./scmutils/kernel/ghelper.scm")
(include "./scmutils/kernel/generic.scm")
(include "./scmutils/kernel/mathutil.scm")
(include "./scmutils/kernel/strutl.scm")

(include "./scmutils/kernel/fbe-extapply.scm")

(include "./scmutils/kernel/types.scm")

(define (diff-memoize-1arg f) f)
(define (diff-memoize-2arg f) f)
(define (diff-memoize f) f)
;;;(define (diff-memoize-1arg f) (linear-memoize-1arg f))
;;;(define (diff-memoize-2arg f) (linear-memoize f))
;;;(define (diff-memoize f) (linear-memoize f))
;;;(define (diff-memoize f) (hash-memoize f))

(include "./scmutils/kernel/modarith.scm")
(include "./scmutils/kernel/diff.scm")
(include "./scmutils/kernel/deriv.scm")
(include "./scmutils/kernel/operator.scm")
(include "./scmutils/kernel/function.scm")

;; references symbolic-environment
(include "./scmutils/kernel/numbers.scm")
(include "./scmutils/kernel/vectors.scm")
(include "./scmutils/kernel/structs.scm")
(include "./scmutils/kernel/matrices.scm")
(include "./scmutils/kernel/quaternion.scm")
(include "./scmutils/kernel/pseries.scm")

(include "./scmutils/kernel/numsymb.scm")

(include "./scmutils/kernel/heuristic.scm")

(include "./scmutils/kernel/fbe-genenv.scm")

(include "./scmutils/kernel/custom-repl.scm")

;;;; **** Simplifier loader  **********************************

;;; Canonical simplifiers are based on Rational Canonical Form,
;;;  which is, in turn, based on Polynomial Canonical Form.

;;;The following two files must be loaded in the given order.
(include "./scmutils/simplify/pcf.scm")
(include "./scmutils/simplify/rcf.scm")

;;; We need flattened polynomials to support rule-based simplifiers.

(include "./scmutils/simplify/fpf.scm")

;;; Canonical simplifiers are glued together with SIMPLIFY.

(include "./scmutils/simplify/simplify.scm")

(include "./scmutils/simplify/split-poly.scm")

;;; Rule-based simplifiers

;;; FBE: Instead of the 'symbolic-environment' we create the
;;; 'symbolic-module'.  To reproduce the 'rule-environment' in
;;; 'syntax.scm' we work in the 'scmutils-base-environment' and import
;;; 'symbolic-module'.

;;(define rule-environment symbolic-environment)

(define (rule-memoize f) f)
;;; (define (rule-memoize f) (linear-memoize-1arg f))
;;; (define (rule-memoize f) (linear-memoize f))
;;; (define (rule-memoize f) (hash-memoize f))
;;; (define (rule-memoize f) (hash-memoize-1arg f))

;;(include "syntax" scmutils-base-environment)
(include "./scmutils/simplify/fbe-syntax.scm")
(include "./scmutils/simplify/rule-syntax.scm")
(include "./scmutils/simplify/matcher.scm")
(include "./scmutils/simplify/rule-simplifier.scm")

;;; FBE: tried to make this a module, but can't make it work. Try
;;; loading it directly into 'scmutils-base-environment'.
;;(load "rules" rule-environment)
(include "./scmutils/simplify/rules.scm")

#;
(define (default-simplify exp)
  (new-simplify (expression exp)))

(include "./scmutils/simplify/default.scm")

(include "./scmutils/simplify/sparse.scm")
(include "./scmutils/simplify/sparse-interpolate.scm")
(include "./scmutils/simplify/sparse-gcd.scm")

(include "./scmutils/simplify/pcf-fpf.scm")

(define symbolic-operators
  (hash-table/key-list symbolic-operator-table))

;; ;;;; **** Display  **********************************

(include "./scmutils/display/print.scm")

(include "./scmutils/display/fbe-exdisplay.scm")

(include "./scmutils/display/suppress-args.scm")

;;;; **** Enclose  **********************************

(include "./scmutils/enclose/comcon.scm")
(include "./scmutils/enclose/fbe-magic.scm")

;;; FBE: uses structures.
;; (include "./scmutils/enclose/jinx-utils.scm")
;; (include "./scmutils/enclose/jinx-cselim.scm")
(include "./scmutils/enclose/fbe-jinx-cselim.scm")

(include "./scmutils/enclose/enclose.scm")

;;(include "opaque" scmutils-base-environment)

;;;; **** Numerics  **********************************

;;; signals/cph-dsp
(include "./scmutils/numerics/signals/cph-dsp/flovec.scm")

;; ;;; quadrature
(include "./scmutils/numerics/quadrature/rational.scm")
(include "./scmutils/numerics/quadrature/quadrature.scm")
(include "./scmutils/numerics/quadrature/defint.scm")

;;; extrapolate
(include "./scmutils/numerics/extrapolate/re.scm") ; fundamental

;;; optimize
(include "./scmutils/numerics/optimize/unimin.scm") ; fundamental
(include "./scmutils/numerics/optimize/multimin.scm") ; fundamental
(include "./scmutils/numerics/optimize/optimize.scm") ; fundamental

;;; linear
(include "./scmutils/numerics/linear/singular.scm") ; fundamental

(include "./scmutils/numerics/linear/full-pivot.scm") ; fundamental
(include "./scmutils/numerics/linear/gauss-jordan.scm") ; fundamental
(include "./scmutils/numerics/linear/lu.scm") ; fundamental
(include "./scmutils/numerics/linear/svd.scm") ; fundamental
(include "./scmutils/numerics/linear/vandermonde.scm") ; fundamental

(include "./scmutils/numerics/linear/eigen.scm") ; fundamental

;;; ode
(include "./scmutils/numerics/ode/advance.scm")
(include "./scmutils/numerics/ode/qc.scm")
(include "./scmutils/numerics/ode/bulirsch-stoer.scm")
(include "./scmutils/numerics/ode/be.scm")
(include "./scmutils/numerics/ode/gear.scm")
(include "./scmutils/numerics/ode/ode-advancer.scm")
(include "./scmutils/numerics/ode/interface.scm")

;;; statistics
(include "./scmutils/numerics/statistics/cluster.scm") ; fundamental

(include "./scmutils/numerics/statistics/gauss.scm") ; fundamental

(include "./scmutils/numerics/statistics/moments.scm") ; fundamental

;;; functions

(include "./scmutils/numerics/functions/bessel.scm")
(include "./scmutils/numerics/functions/elliptic.scm")

;;; roots

(include "./scmutils/numerics/roots/bisect.scm")
(include "./scmutils/numerics/roots/zbrent.scm")
(include "./scmutils/numerics/roots/zeros.scm")
(include "./scmutils/numerics/roots/newton-kahan.scm")
(include "./scmutils/numerics/roots/multidimensional.scm")

;; ;;; signals/cph-dsp (rest)

;;; These are loaded in user-initial-environment
;; (include "./scmutils/numerics/signals/cph-dsp/mathutil.scm")
(include "./scmutils/numerics/signals/cph-dsp/fft.scm")
(include "./scmutils/numerics/signals/cph-dsp/white.scm")

;;;; **** Poly  **********************************

;;; Hairy polynomial rootfinder.  Not so good, but I tried (GJS)
(include "./scmutils/poly/polyroot.scm")

;;; The Polynomial Interpolator: generic code.
;;; export = (Lagrange-interpolation-function ys xs)
;; (parameterize ((case-sensitive #t))
;;  ;;with-case-preserved
;;     (lambda ()
;;       (load* "interp-generic" generic-environment)))

;;; A compiled Polynomial Interpolator: fast numerical code.
;;; export = (lagrange-interpolation-function ys xs)
(include "./scmutils/poly/interp.scm")


;;;     Halfant stuff
;;; Elegant constructor of custom Lagrange interpolator procedures
;; FBE: In '(scmutils generic)
;; (include "lagrange" generic-environment)

;;;     Actual polynomial codes (requires pcf)
;;; Shifts and scales polynomial domains, 
;;; makes interpolation polynomials, estimates errors.
(include "./scmutils/poly/polyinterp.scm")

;;; Legendre polynomials
(include "./scmutils/poly/legendre.scm")

;;; Hermite interpolators (splines)
(include "./scmutils/poly/hermite.scm")

;;; Chebyshev expansions, economization
(include "./scmutils/poly/nchebpoly.scm")

;;; Piecewise polynomial approximations; good function memoizers
(include "./scmutils/poly/ppa.scm")

;;;; **************************************

;;(start-preserving-case!)

;;;; **************************************

(include "./scmutils/kernel/litfun.scm")

;;;; **** Solve  **********************************

(include "./scmutils/solve/solve.scm")

;; ;;;; **** Units  **********************************

(include "./scmutils/units/units.scm")
;;(include "./scmutils/units/system.scm")
(include "./scmutils/units/fbe-system.scm")
(include "./scmutils/units/with-units.scm")

;;(include "SI-units"   generic-environment)
(include "./scmutils/units/fbe-SI-units.scm")

;; (include "hms-dms-radians" generic-environment)

;; (include "convert.scm"    generic-environment)

;;; For display/print
(define with-si-units->expression
  (lambda (x)
    (with-units->expression SI x)))

;;; In mechanics loader (load "constants"   generic-environment)
;; FBE: I load it here in scmutils-base-environment

;;; FBE: some constants like ':pi' are already defined and needed
;;; before this point -> commented out
(include "./scmutils/units/fbe-constants.scm") ; FBE

;;;; **************************************

(include "./scmutils/calculus/fbe-coord.scm")
(include "./scmutils/calculus/frame-maker.scm")

;;; FBE: Instead of creating 'symbolic-environment' we create the module
;;; 'symbolic-module' which we use in 'fbe-syntax'.
;;(include "symbenv" scmutils-base-environment)
(include "./scmutils/simplify/fbe-symbenv.scm")

;; ;; a couple of functions in 'scmutils-base-environment' which refer to
;; ;; the 'generic-environment'.
;; (include "./scmutils/units/system-generic-env.scm")

;; ;;;; **** Mechanics  **********************************

(include "./scmutils/mechanics/sections.scm")

;;;; **** Initialize library ************************************************

(*scmutils/repl-simplifier* simplify)
;;(start-scmutils-print!)

)
