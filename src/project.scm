(use-modules (srfi srfi-9))

(define (get-user-name) (passwd:name (getpwuid (geteuid))))

(define current-project (make-undefined-variable))

(define-record-type <project>
  (make-project name author languages version sm-version)
  project?
  (name       project-name)
  (author     project-author)
  (languages  project-languages)
  (version    project-version)
  (sm-version project-sm-version))

(define* (project #:key
                  name
                  (author (get-user-name))
                  languages
                  (version "v1.0")
                  (sm-version schemake-version))
  (variable-set! current-project (make-project name author languages version sm-version)))
