;;Problem 1 ------------------------------------------------------------------------------------------------------------------------------------------------------
;; (byTwos n m) returns the list of every +2 up to m
;; Base Case: if n > m, return '()
;; Hypothesis: Assume (byTwos (+ n 2) m) return every n+2 up to m
;; Recursive step: (byTwos n m) returns (cons n (byTwos (+ n 2) m))
(define (byTwos n m) (if (> n m)
                         '()
                         (cons n (byTwos (+ n 2) m))
                         )
  )
;;Problem 2 ------------------------------------------------------------------------------------------------------------------------------------------------------
;;(compress L) returns the compressed list L without any nested lists
;; Base Case: L is the empty list
;; Hypothesis: Assume (car L) is a list, if so dive further, if not add to list and recursively add car L of cdr L
;;Recursive step: (compress L) returns (cons (car L) (compress (cdr L))
(define (compress L)
  (cond ((null? L) '())
        ((list? (car L)) (append (compress (car L)) (compress (cdr L))))
        (else (cons (car L) (compress (cdr L))))
        )
  )
;;Problem 3 ------------------------------------------------------------------------------------------------------------------------------------------------------
;;(rev-all L) returns a reversed list of nested lists
;;Base Case: L is the empty list
;;Hypothesis: Assume rev (cdr L) returns reversed list from last to first
;;Recursive step: (rev L result) returns (rev (cdr L) (cons (car L) result)
(define (rev-all L)
  (rev L '()))
;;Helper Function
(define (rev L result)
  (if (null? L) result
      (if (list? (car L))
          (rev (cdr L) (cons (rev(car L) '()) result))
          (rev (cdr L) (cons (car L) result))
          )
      )
  )
;;Problem 4 ------------------------------------------------------------------------------------------------------------------------------------------------------
;;(equalTo? x y) returns true or false if the contents of x and y are the same
;;Base case: list x and y is empty
;;Hypothesis: Assume (equalTo? x y) works for all values x and y, and also assume if x and y are empty and false hasnt been returned, the lists are the same
;;Recursive step: (equalTo? (cdr x) (cdr y)) recursively iterates through both lists
(define (equalTo? x y)
  (if (and (null? x) (null? y)) '#t
      (cond ((and (not(list? x)) (not (list? y))) (if (= x y) '#t '#f)) ;;if just atoms just compare
            ((or (and (null? x) (not (null? y))) (and (null? y) (not (null? x)))) '#f) ;;Check to make sure lists are same size or not
            ((eq? (car x) (car y)) (equalTo? (cdr x) (cdr y)))
            (else '#f))
      )
  )
;;Problem 5 -----------------------------------------------------------------------------------------------------------------------------------------------------
;;(equalFns? fn1 fn2 domain) returns true if both functions return the same value when applied to the same element of the list domain
;;Base case: list domain is the empty list
;;Hypothesis: Assume (equaltFns? fn1 fn2 domain) keeps iterating until it finds a discrepancy in the results of the two functions
;;Recursive step (equalFns? fn1 fn2 (cdr domain)) where cdr is the rest of the list to iterate through
(define (equalFns? fn1 fn2 domain)
  (if (null? domain) '#t
      (if (equalTo? (fn1 (car domain)) (fn2 (car domain)))
          (equalFns? fn1 fn2 (cdr domain))
          '#f)
      )
  )
;;Problem 6 ------------------------------------------------------------------------------------------------------------------------------------------------------
;;same-vals fn1 fn2 domain returns the list if the values of the returned fn1 and fn2 are the same
;;Base Case: list domain is the empty list
;;Hypothesis: Assume (= (fn1 (car domain)) (fn2 (car domain))) returns whether each element of the list is the same
;;Recursive step: Function either returns the list with the added element or returns the next element to check with (same-vals fn1 fn2 (cdr domain))
(define (same-vals fn1 fn2 domain)
  (if (null? domain) '()
      (if (= (fn1 (car domain)) (fn2 (car domain)))
          (cons (car domain) (same-vals fn1 fn2 (cdr domain)))
          (same-vals fn1 fn2 (cdr domain))
          )
      )
  )
;;Problem 7 ------------------------------------------------------------------------------------------------------------------------------------------------------
;; (split x L) returns two lists split by upper x and lower x
;;Base Case: List L is the empty list, return 2 lists
;;Hypothesis: Assume (split x L) works for any list L smaller than L
;;Recursive step: (sub-split x (cdr L) L1 L2) is called each time the list is not null and there is more to split on. It splits the list from the first and rest of the list
(define (split x L)
  (letrec ((sub-split (lambda (x L L1 L2)
                        (if (null? L) (list L1 L2)
                            (if (>= x (car L))
                                (sub-split x (cdr L) (cons (car L) L1) L2)
                                (sub-split x (cdr L) L1 (cons (car L) L2)) )))
                      )
           )
    (sub-split x L '() '() )
    )
  )
;;Problem 8 ------------------------------------------------------------------------------------------------------------------------------------------------------
;;(psort L) returns a sorted list given a list L
;; Base Case: List l is the empty list, return '()
;; Hypothesis: Assume (psort L) works on any given split list L
;; Recursive Step: (psort (car partition)) and (psort (cadr partition)) Call the psort on each halves of the lists
(define (psort L)
  (if (null? L) '()
      (let ((partition (split (car L) (cdr L))))
        (append
         (psort(car partition))
         (list (car L))
         (psort(cadr partition))
         )
        )
      )
  )
;;Problem 9 ------------------------------------------------------------------------------------------------------------------------------------------------------
;;(applyToList f) returns a function which takes a list that then gets function f applied to each element
(define (applyToList f)
  (lambda (L) (map f L)))
;;Problem 10 ------------------------------------------------------------------------------------------------------------------------------------------------------
(define (newApplyToList f)
  (lambda (L) (letrec ((mymap (lambda (f L)
                                (cond ((null? L) '())
                                      (else (cons (f (car L)) (mymap f (cdr L))))))))
                (mymap f L)
                )
    )
  )