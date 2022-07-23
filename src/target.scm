(use-modules (srfi srfi-9))

(define-record-type <target>
  (make-target name sources dependencies)
  target?
  (name         target-name)
  (sources      target-sources)
  (dependencies target-deps))


(define* (executable name sources
                    #:key dependencies)
  ;; Create the target and append it to our project targets
  (set-project-targets! current-project
                       (append (project-targets current-project) (make-target name sources dependencies))))
