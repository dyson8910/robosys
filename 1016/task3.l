(defun make-handle (rin rout)
  (let (b1 b2)
    (setq b1 (make-cylinder rin 80))
    (setq b2 (make-cylinder rout 80))
    (setq b2 (body- b2 b1))
    (send b2 :set-color :gray20)
    b2))

(defun make-grip (r)
  (let (rout b1 b2)
    (setq rout (+ r 1))
    (setq b1 (make-cylinder rout 40))
    (setq b2 (make-cylinder r 20))
    (setq b1 (body- b1 b2))
    (send b1 :set-color :white)
    b1))

(defun make-wiper nil
  (let (b1 b2 b3)
    (setq b1 (make-cube 30 100 2))
    (setq b2 (make-cube 6 16 10))
    (setq b3 (make-cube 6 12 10))
    (setq b2 (body- b2 b3))
    (send b2 :locate #f(0 0 4))
    (setq b1 (body+ b1 b2))
    (send b1 :locate #f(0 0 -6))
    (send b1 :set-color :white)
    b1))

(defun make-joint nil
  (let (b1 b2 b3)
    (setq b1 (make-cylinder 6 50))
    (setq b2 (make-cylinder 5 10))
    (setq b3 (make-cube 5 15 20))
    (send b2 :locate #f(0 0 40))
    (setq b1 (body- b1 b2))
    (setq b1 (body- b1 b3))
    (send b1 :set-color :gray80)
    (send b1 :locate #f(0 0 -3))
    b1))

(defun make-joint2 nil
  (let (b1 b2 b3)
    (setq b1 (make-cube 4 10 20))
    (setq b2 (make-cylinder 1 12))
    (setq b3 (make-cylinder 1 20))
    (send b2 :locate #f(-6 0 7))
    (send b2 :rotate (deg2rad 90) :y)
    (send b3 :locate #f(0 10 -7))
    (send b3 :rotate (deg2rad 90) :x)
    (setq b1 (body+ b1 b2))
    (setq b1 (body+ b1 b3))
    (send b1 :set-color :white)
    (send b1 :locate #f(0 0 7))
    b1))
    
(defclass quickle-wiper
  :super cascaded-link
  )

(defmethod quickle-wiper
  (:init ()
	 (let (g1 h1 h2 h3 j1 j2 w1 l1 l2 l3 l4 l5)
	   (send-super :init)
	   (setq g1 (make-grip 3))
	   (setq h1 (make-handle 2 3))
	   (setq h2 (make-handle 3 4))
	   (setq h3 (make-handle 4 5))
	   (setq j1 (make-joint))
	   (setq j2 (make-joint2))
	   (setq w1 (make-wiper))
	   ;;set l5
	   (send h1 :assoc g1)
	   (send g1 :locate #f(0 0 60))
	   
	   ;;set l3
	   (send j1 :assoc h3)
	   (send h3 :locate #f(0 0 37))
	   
	   ;;set link
	   (setq l5 (instance bodyset-link :init (make-cascoords) :bodies (list h1 g1)))
	   (setq l4 (instance bodyset-link :init (make-cascoords) :bodies (list h2)))
	   (setq l3 (instance bodyset-link :init (make-cascoords) :bodies (list j1 h3)))
	   (setq l2 (instance bodyset-link :init (make-cascoords) :bodies (list j2)))
	   (setq l1 (instance bodyset-link :init (make-cascoords) :bodies (list w1)))

	   ;;set assoc
	   (send self :assoc l1)
	   (send l1 :assoc l2)
	   (send l2 :assoc l3)
	   (send l3 :assoc l4)
	   (send l4 :assoc l5)

	   ;;set location
	   (send l1 :locate #f(0 0 7))
	   (send l2 :locate #f(0 0 0))
	   (send l3 :locate #f(0 0 14))
	   (send l4 :locate #f(0 0 107))
	   (send l5 :locate #f(0 0 70))
	   	   
	   ;;set joint-list
	   (setq joint-list
		 (list
		  (instance rotational-joint
			    :init :parent-link l1 :child-link l2
			    :axis :y)
		  (instance rotational-joint
			    :init :parent-link l2 :child-link l3
			    :axis :x)
		  (instance linear-joint
			    :init :parent-link l3 :child-link l4
			    :axis :z
			    :max 5
			    :min -60)
		  (instance linear-joint
			    :init :parent-link l4 :child-link l5
			    :axis :z
			    :max 5
			    :min -40)
		  ))
	   ;;set links
	   (setq links (list l1 l2 l3 l4 l5))
	   (send self :init-ending)
	   )))

(setq r (instance quickle-wiper :init))
(objects (list r))
