(defun period-iter (x)
  (do ((i x (- i 1)))
       ((< i 2) '.)
       (format t ".")))

(defun period-rec (x)
  (if (< x 2)
      '.
    (progn (format t ".")
	   (period-rec (- x 1)))))

(defun symbol-iter (x)
  (do ((counter 0))
      ((null x) counter)
      (progn (if (eql 'a (car x))
		 (progn (setq counter (+ counter 1))
			(setq x (cdr x)))
	       (setq x (cdr x))))))

	   
(defun symbol (x count)
  (if (null x)
      count
    (if (eql 'a (car x))
	(symbol (cdr x) (+ count 1))
      (symbol (cdr x) count))))

(defun symbol-rec (x)
  (symbol x 0))

