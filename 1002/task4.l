(defclass rat
  :super propertied-object
  :slots (numer denom))
(defmethod rat
  (:init (&optional n d) (send self :make-rat n d))
  (:make-rat (n d)
	     (setq numer n)
	     (setq denom d)
	     (format t "~A/~A~%" numer denom))
  (:numer () numer)
  (:denom () denom)
  (:add-rat (a b)
	    (send self :make-rat (+ (* (send a :numer) (send b :denom))
				    (* (send a :denom) (send b :numer)))
		  (* (send a :denom) (send b :denom)))))
