(project #:name "schemake-test"
         #:author "LP"
         #:languages '('c 'cpp)
         #:version "0.1"
         #:sm-version ">= 0.1"
         #:build-dir "build")

(executable "schemake-test" '("test.c"))
