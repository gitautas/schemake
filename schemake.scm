#!/usr/bin/env -S  guile --no-auto-compile --no-debug -e main -s
!#

;;; Schemake is a minimalistic ninja build generator intended for use for my own C/C++ projects.

;; Disable backtrace messages
;; (debug-disable 'backtrace)

;; Local includes
;; (include "./src/project.scm")
;; (include "./src/target.scm")
;;;; FOR DEBUGGING
(include "/home/gintautas/Projects/schemake/src/project.scm")
(include "/home/gintautas/Projects/schemake/src/target.scm")


;; Constants
(define schemake-version "0.1")

(define (main args)
  ;; Check for a build.scm file in the working directory
  (if (not (file-exists? "build.scm")) (error "cannot find build.scm in working directory"))
  ;; (include "./build.scm")
  (include "/home/gintautas/Projects/schemake/build.scm")
  (create-build-dir))
