(defun summit (lst)
  (setq x (remove nil lst))
  (apply #'+ x))
