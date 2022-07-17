(use-modules (oop goops))

(define-class <project> ()
  (name #:init-value "my-project" #:getter get-name #:setter set-name)
  (languages #:init-value (list 'c) #:getter get-langs #:setter set-langs)
  )
