(use-modules (srfi srfi-9))

(define (get-user-name) (passwd:gecos (getpwuid (geteuid))))

(define current-project (make-undefined-variable))

(define-record-type <project>
  (make-project name author languages version sm-version build-dir targets)
  project?
  (name       project-name)
  (author     project-author)
  (languages  project-languages)
  (version    project-version)
  (sm-version project-sm-version)
  (build-dir  project-build-dir)
  (targets    project-targets set-project-targets!))

(define* (project #:key
                  (name "awesome-project")
                  (author (get-user-name))
                  (languages '())
                  (version "v1.0")
                  (sm-version schemake-version)
                  (build-dir "build")
                  (targets '()))
  (set! current-project (make-project name author languages version sm-version build-dir targets)))

(define (create-build-dir)
  ;; Check if build dir exists and create one if it doesn't
  (if (not (file-exists? (string-append (project-build-dir current-project) "/")))
      (mkdir (project-build-dir current-project))))
