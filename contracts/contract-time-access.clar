;; Duplicate definitions removed

;; Duplicate definitions removed

;; Only callable once, by contract deployer, to set owner
;; (define-public (initialize-owner) ...) -- duplicate removed

;; Only contract owner can set the access window
;; (define-public (set-access-window (start uint) (end uint))) -- duplicate removed

;; Public function that users can call to access content (just simulated here)
;; (define-public (access-content) ...) -- duplicate removed

;; Duplicate definition removed

;; View function to check if a user can access right now
;; (define-read-only (can-access) ...) -- duplicate removed
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-NOT-IN-TIME (err u101))
(define-constant ERR-INVALID-WINDOW (err u102))

(define-data-var access-start uint u0)
(define-data-var access-end uint u0)
(define-data-var owner principal 'SP000000000000000000002Q6VF78) ;; placeholder, set by initialize-owner

;; Only callable once, by contract deployer, to set owner
(define-public (initialize-owner)
  (begin
    (if (is-eq (var-get owner) 'SP000000000000000000002Q6VF78)
        (begin
          (var-set owner tx-sender)
          (ok true)
        )
        (err u103) ;; Already initialized
    )
  )
)

;; Only contract owner can set the access window
(define-public (set-access-window (start uint) (end uint))
  (begin
    (if (is-eq tx-sender (var-get owner))
        (if (<= start end)
            (begin
              (var-set access-start start)
              (var-set access-end end)
              (ok true)
            )
            ERR-INVALID-WINDOW
        )
        ERR-NOT-AUTHORIZED
    )
  )
)

;; Public function that users can call to access content (just simulated here)
(define-public (access-content)
  (let (
        (current-block stacks-block-height)
        (start (var-get access-start))
        (end (var-get access-end))
      )
    (if (and (>= current-block start) (<= current-block end))
        (ok "Access granted!")
        ERR-NOT-IN-TIME
    )
  )
)

;; View function to check access window
(define-read-only (get-access-window)
  {
    start: (var-get access-start),
    end: (var-get access-end)
  }
)

;; View function to check if a user can access right now
(define-read-only (can-access)
  (let (
        (current-block stacks-block-height)
        (start (var-get access-start))
        (end (var-get access-end))
      )
    (ok (and (>= current-block start) (<= current-block end)))
  )
)
