(defun period-iter (x)
  (do ((i 0 (+ i 1)))
      ((>= i x))
      (format t ".")))
      

(defun period-rec (x)
  (if (< x 1)
      nil
    (progn (format t ".")
	   (period-rec (- x 1)))))

(defun symbol-iter (x)
  (do ((counter 0))
      ((null x) counter)
      (progn (if (eql 'a (car x))
		 (setq counter (+ counter 1)))
	     (setq x (cdr x)))))

	   
(defun symbol-rec (x)
  (if (null x)
      0
    (if (eql 'a (car x))
	(+ 1 (symbol-rec (cdr x)))
      (symbol-rec (cdr x)))))


