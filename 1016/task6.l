(load "models/room73b2-scene.l")
(load "models/h7-robot.l")
(setq *room* (room73b2))
(setq *robot* (h7))
(send *robot* :reset-pose)

(send *robot* :move-to (send *room* :spot "cook-spot") :world)
(send *robot* :locate #f(0 0 550))

(objects (list *robot* *room*))
(send *irtviewer* :look-all
      (geo::make-bounding-box
       (flatten (send-all (send *robot* :bodies) :vertices))))

(setq *kettle* (send *room* :object "room73b2-kettle"))
(if (send *kettle* :parent) (send (send *kettle* :parent) :dissoc *kettle*))

(setq *kettle-handle* (car (send *kettle* :handle)))
(send *kettle-handle* :rotate pi :z)

(send *robot* :rarm :inverse-kinematics *kettle-handle*
      :link-list (send *robot* :link-list (send *robot* :rarm :end-coords :parent))
      :move-target (send *robot* :rarm :end-coords)
      :rotation-axis t 
      :debug-view t ;;:p-limit 10 :r-limit 0.05
      :cog-null-space t)

(send *robot* :rarm :end-coords :assoc *kettle*)

(setq *original-location* (send *robot* :rarm :end-coords))

(setq *mug-cup* (send *room* :object "room73b2-mug-cup"))
(if (send *mug-cup* :parent) (send (send *mug-cup* :parent) :dissoc *mug-cup*))

(do-until-key
 (x::window-main-one)
 )

(setq g (make-cascoords :pos #f(500 1900 1200)))
(send g :rotate pi/2 :x)
(send g :rotate pi :z)

(send *robot* :rarm :inverse-kinematics g
      :link-list (send *robot* :link-list (send *robot* :rarm :end-coords :parent))
      :move-target (send *robot* :rarm :end-coords)
      :rotation-axis t
      :debug-view t ;;:p-limit 10 :r-limit 0.05
      :cog-null-space t)

(setq g2 (make-cascoords :pos #f(500 1900 1200)))
(send g2 :rotate pi/2 :x)
(send g2 :rotate pi :z)
(send g2 :rotate (deg2rad -15) :x)

(do-until-key
 (x::window-main-one))

(send *robot* :rarm :inverse-kinematics g2
      :link-list (send *robot* :link-list (send *robot* :rarm :end-coords :parent))
      :move-target (send *robot* :rarm :end-coords)
      :rotation-axis t
      :debug-view t ;;:p-limit 10 :r-limit 0.05
      :cog-null-space t)

(do-until-key
 (x::window-main-one))

(send *robot* :rarm :inverse-kinematics g
      :link-list (send *robot* :link-list (send *robot* :rarm :end-coords :parent))
      :move-target (send *robot* :rarm :end-coords)
      :rotation-axis t
      :debug-view t ;;:p-limit 10 :r-limit 0.05
      :cog-null-space t)
