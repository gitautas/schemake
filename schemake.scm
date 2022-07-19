#!/usr/bin/env -S  guile --no-auto-compile --no-debug -e main -s
!#

;;;; Schemake is a minimalistic ninja build generator intended for use for my own C/C++ projects.

;; Disable backtrace messages
(debug-disable 'backtrace)

;; Local modules
(use-modules (src project))

;; Constants
(define sm-version "0.1")

(define (main args)
  (let ((proj (make-project "a" get-user-name '('c 'cpp) "v0.1" sm-version)))
    (display proj)
    (newline))
  ;; Check for a build.scm file in the working directory
  (if (not (file-exists? "build.scm")) (error "cannot find build.scm in working directory")))
