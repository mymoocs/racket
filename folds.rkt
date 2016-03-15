#lang racket

(define nil '())

(define curry2 (lambda (x)
                 (lambda (y)
                   (+ x y))))

(define incr (lambda (x) (+ x 1)))
(define map (lambda (f ls)
              (if (null? ls) '()
              (cons (f (car ls)) (map f (cdr ls))))))



(define my-foldl-curry (lambda (f)
  (lambda (z)
    (lambda (ls)
        (if (null? ls) z
        (((my-foldl-curry f) (f z (car ls))) (cdr ls)))))
    ))

(define my-foldl (lambda (f z ls)
        (if (null? ls) z
        (my-foldl f (f z (car ls)) (cdr ls)))))
    
(define reverse
  (lambda (ls)
     (my-foldl (lambda (ls x) (cons x ls)) '() ls)))

(define length
  (lambda (ls)
      (my-foldl (lambda (ls x) (+ 1 ls)) 0 ls)))

(define product
  (lambda (ls)
      (my-foldl * 1 ls)))

(define sum
  (lambda (ls)
      (my-foldl + 0 ls)))


(define my-foldr (lambda (f z ls)
                   (if (null? ls) z
                   (f (car ls) (my-foldr f z (cdr ls))))))   
(define my-append (lambda (xs ys)
  (my-foldr cons ys xs)))
