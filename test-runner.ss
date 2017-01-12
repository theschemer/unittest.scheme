#!/usr/bin/env scheme-program

(import (chezscheme)
        (unittest))

(define (tag-string? str)
  (and (> (string-length str) 2)
       (string-ci=? (substring str 0 2) "--")))

(define (string->tag str)
   (string->symbol (substring str 2 (string-length str))))

(let-values (((tagnames filenames) (partition tag-string? (cdr (command-line)))))
            (if (null? filenames)
                (error 'unittest "no unit test files specified")
                (begin
                  (set-active-tags! (map string->tag tagnames))
                  (for-each load filenames))))

(print-test-report)