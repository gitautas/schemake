(use-modules (srfi srfi-9))

(define (get-user-name) (passwd:name (getpwuid geteuid)))

(define-record-type <project>
  (make-project name author languages version sm-version)
  project?
  (name       project-name)
  (author     project-author)
  (languages  project-languages)
  (version    project-version)
  (sm-version project-sm-version))

(define-module (src project)
  #:export (<project> get-user-name))
