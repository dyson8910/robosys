(defun make-piston nil
  (let ((b1 (make-cylinder 5 70))
	(b2 (make-cube 20 20 10)))
    (send b2 :locate (float-vector 0 0 75))
    (setq b1 (body+ b1 b2))
    (send b1 :set-color :gray20)
    b1))

(defun make-case nil
  (let ((b1 (make-cylinder 10 70))
	(b2 (make-cylinder 5.5 70)))
    (setq b1 (body- b1 b2))
    (send b1 :set-color :gray80)
    b1))


(setq h1 (instance bodyset-link :init (make-cascoords) :bodies (list (make-case))))
(setq s1 (instance bodyset-link :init (make-cascoords) :bodies (list (make-piston))))
(setq j1 (instance linear-joint  :init :parent-link h1 :child-link s1 :axis :z :max 45 :min 0))

(setq r (instance cascaded-link :init))
(send r :assoc h1)
(send h1 :assoc s1)
(setq (r . links) (list h1 s1))
(setq (r . joint-list) (list j1))
(send r :init-ending)

(objects (list r))
(setq i 0)
(do-until-key
 (send r :angle-vector (float-vector (* 20 (- 1 (cos (/ i 100.0))))))
 (send *irtviewer* :draw-objects)
 (x::window-main-one)
 (incf i))
