(defun c:calculateangle ()
    (initget "Points Lines")
    (setq OPT (getkword "Calculate angle between points or lines? "))
    (if	(= OPT "Lines")
	(progn
	    (setq L1   (car (entsel "\nSelect the first line"))
		  L2   (car (entsel "\nSelect the second line"))
		  PT1  (cdr (assoc 10 (entget L1)))
		  PT2  (cdr (assoc 11 (entget L1)))
		  ANG1 (angle PT2 PT1)
		  PT3  (cdr (assoc 10 (entget L2)))
		  PT4  (cdr (assoc 11 (entget L2)))
		  ANG2 (angle PT4 PT3)
		  AR   (- ANG1 ANG2)
		  AL   (- (* 2 PI) AR)
	    )
	    (prompt
		(strcat
		    "\n\n\n\t\t\t\t\tThe angle left is: "
		    (angtos AL 1 6)
		    "\n\t\t\t\t\tThe angle right is: "
		    (angtos AR 1 6)
		)
	    )
	    (princ)
	)
	(progn
	    (setq PT1  (getpoint "\nSelect first point")
		  PT2  (getpoint PT1 "\nSelect second point")
		  ANG1 (angle PT1 PT2)
		  PT3  (getpoint PT2 "\nSelect third point")
		  ANG2 (angle PT2 PT3)
		  AR   (- (- ANG1 ANG2) PI)
		  AL   (- (* 2 PI) AR)
	    )
	    (prompt
		(strcat
		    "\n\n\n\t\t\t\t\tThe angle left is: "
		    (angtos AL 1 6)
		    "\n\t\t\t\t\tThe angle right is: "
		    (angtos AR 1 6)
		)
	    )
	    (princ)
	)
    )
)