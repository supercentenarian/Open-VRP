;;; Sun Jul 3, 2011
;;; Interface to read in testcases from files
;;; (Solomon style: http://neo.lcc.uma.es/radi-aeb/WebVRP/index.html?/Problem_Instances/CVRPTWInstances.html)
;;; ---
(in-package :open-vrp)

(defun couple-lists (list1 list2)
  "Given a list of x and y-coords, return a list of pairs usable for the program (*node-coords*)."
  (labels ((iter (rest-x rest-y ans)
	     (if (null rest-x) (nreverse ans)
		 (iter (cdr rest-x)
		       (cdr rest-y)
		       (cons (cons (car rest-x) (car rest-y)) ans)))))
    (iter list1 list2 nil)))
		       
(defun load-testcase-Solomon (file)
  "Load testcase from file, which should be Solomon style."
  (with-open-file (in file)
    (let ((name (read in))
	  (fleet-size (progn (dotimes (n 3) (read in)) (read in)))
	  (capacities (read in)))
      (dotimes (n 12) (read in))
      (loop
	 while (read in nil)
	 collect (read in) into x-coords
	 collect (read in) into y-coords
	 collect (read in) into demands
	 collect (read in) into min-times
	 collect (read in) into max-times
	 collect (read in) into service-duration
	 finally
	   (return (define-problem name (couple-lists x-coords y-coords) fleet-size (concatenate 'string "plots/" (string name) ".png") demands capacities (couple-lists min-times max-times) service-duration))))))      
	   
	   
	   
	   
	   