#!/usr/bin/env -S  guile --no-auto-compile --no-debug -e main -s
!#

;;;; Schemake is a minimalistic ninja build generator intended for use for my own C/C++ projects.

;; Dependencies
(load "src/project.scm")

;; Disable backtrace messages
(debug-disable 'backtrace)

(define (main args)
  ;; Check for a build.scm file in the working directory
  (if (not (file-exists? "build.scm")) (error "cannot find build.scm in working directory"))

  )
