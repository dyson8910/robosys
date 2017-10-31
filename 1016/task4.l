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
  (let (b1 b2)
    (setq b1 (make-cylinder 6 50))
    (setq b2 (make-cylinder 5 10))
    (send b2 :locate #f(0 0 40))
    (setq b1 (body- b1 b2))
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
  :super cascaded-link)
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

(defun make-sheet-parts
    (x y z c)
  (let (b1)
    (setq b1 (make-cube x y z))
    (send b1 :locate c)
    b1))

(defclass wiper-sheet
  :super cascaded-link)
(defmethod wiper-sheet
  (:init ()
	 (let (s1 s2 s3 s4 s5 l1 l2 l3 l4 l5)
	   (send-super :init)
	   (setq s1 (make-cube 32 102 1))
	   (setq s2 (make-sheet-parts 4 102 1 #f(-1.5 0 0)))
	   (setq s3 (make-sheet-parts 10 102 1 #f(-4.5 0 0)))
	   (setq s4 (make-sheet-parts 4 102 1 #f(1.5 0 0)))
	   (setq s5 (make-sheet-parts 10 102 1 #f(4.5 0 0)))

	   ;;set link
	   (setq l1 (instance bodyset-link :init (make-cascoords) :bodies (list s1)))
	   (setq l2 (instance bodyset-link :init (make-cascoords) :bodies (list s2)))
	   (setq l3 (instance bodyset-link :init (make-cascoords) :bodies (list s3)))
	   (setq l4 (instance bodyset-link :init (make-cascoords) :bodies (list s4)))
	   (setq l5 (instance bodyset-link :init (make-cascoords) :bodies (list s5)))
	   
	   ;;set assoc
	   (send self :assoc l1)
	   (send l1 :assoc l2)
	   (send l2 :assoc l3)
	   (send l1 :assoc l4)
	   (send l4 :assoc l5)
	   
	   ;;set location
	   (send l1 :locate #f(0 0 0.5))
	   (send l2 :locate #f(-15.5 0 0))
	   (send l3 :locate #f(-3 0 0))
	   (send l4 :locate #f(15.5 0 0))
	   (send l5 :locate #f(3 0 0))
	   
	   ;;set joint-list
	   (setq joint-list
		 (list
		  (instance rotational-joint
			    :init :parent-link l1 :child-link l2
			    :axis :y
			    :max 90
			    :min 0)
		  (instance rotational-joint
			    :init :parent-link l2 :child-link l3
			    :axis :y
			    :max 90
			    :min 0)
		  (instance rotational-joint
			    :init :parent-link l1 :child-link l4
			    :axis :y
			    :max 0
			    :min -90)
		  (instance rotational-joint
			    :init :parent-link l4 :child-link l5
			    :axis :y
			    :max 0
			    :min -90)
		  ))
	   (setq links (list l1 l2 l3 l4 l5))
	   (send self :init-ending)
	   )))

(setq r (instance quickle-wiper :init))
(setq s (instance wiper-sheet :init))
(send r :locate #f(0 0 10))

(objects (list r s))

(dotimes (i 90)
  (send r :locate (float-vector 0 0 -0.1))
  (send *irtviewer* :draw-objects))

(dotimes (i 90)
  (send s :angle-vector (float-vector i i (- 0 i) (- 0 i)))
  (send *irtviewer* :draw-objects))

(dotimes (i 45)
  (send r :angle-vector (float-vector i 0 0 0))
  (send *irtviewer* :draw-objects))

(send r :assoc s)

(dotimes (i 100)
  (send r :locate (float-vector -1 0 0))
  (send *irtviewer* :draw-objects))

(dotimes (i 45)
  (send r :angle-vector (float-vector 45 i  0 0))
  (send *irtviewer* :draw-objects))

(dotimes (i 10)
  (send r :angle-vector (float-vector 45 45 (* i -6) (* i -4)))
  (send *irtviewer* :draw-objects))

(dotimes (i 50)
  (send r :locate (float-vector 0 1 0))
  (send *irtviewer* :draw-objects))  


(dotimes (i 45)
  (send r :angle-vector (float-vector (- 45 i) (- 45 i)
				      -60 -40))
  (send s :angle-vector (float-vector (- 90 (* 2 i))
				      (- 90 (* 2 i))
				      (+ -90 (* 2 i))
				      (+ -90 (* 2 i))))
  (send *irtviewer* :draw-objects))
		   
(send r :dissoc s)


(dotimes (i 10)
  (send r :angle-vector (float-vector 0 0 (+ -60 (* i 6)) (+ -40 (* i 4))))
  (send r :locate #f(0 0 2))
  (send *irtviewer* :draw-objects))
