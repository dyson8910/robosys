(if (not (boundp '*irtviewer*)) (make-irtviewer))
(setq sun (make-gdome (make-gdome (make-icosahedron 100)))) ;;make sun
(send sun :set-color :red) ;;set color of sun
(setq earth (make-gdome (make-gdome (make-icosahedron 30)))) ;;make earth 
(send earth :set-color :blue) ;;set color of earth
(setq moon (make-gdome (make-gdome (make-icosahedron 15)))) ;;make moon
(send moon :set-color :gray20) ;;set color of moon
(send sun :assoc earth)
(send earth :assoc moon)
(send earth :locate #f(1000 0 0))
(send moon :locate #f(80 0 0))

(objects (list sun earth moon))

(setq period-sun-rot (deg2rad (/ 360 27)))
(setq period-earth-rev (deg2rad (/ 360 365.25)))
(setq period-earth-rot (deg2rad (/ 360 0.997)))
(setq period-moon-rev (deg2rad (/ 360 27)))
(setq period-moon-rot (deg2rad (/ 360 27)))

(do-until-key
 (send sun :rotate period-earth-rev :z)
 (send sun :dissoc earth)
 (send sun :rotate (- period-sun-rot period-earth-rev) :z)
 (send sun :assoc earth)
 (send earth :rotate period-moon-rev :z)
 (send earth :dissoc moon)
 (send earth :rotate (- 0 period-moon-rev) :z)
 (send earth :rotate (- period-earth-rot period-earth-rev) :z)
 (send earth :assoc moon)
 (send moon :rotate (- period-moon-rot period-moon-rev) :z)
 (send *irtviewer* :draw-objects)
 (x::window-main-one);;process window event
 )
