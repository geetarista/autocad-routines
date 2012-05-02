(defun c:inverseobjects ()
  (defun degfrm (ang)
      (setq deg ""
            mints ""
            sec ""
      )
      (while (/= "d" (substr ang 1 1))
         (setq deg (strcat deg (substr ang 1 1))
               ang (substr ang 2)
         )
      )
      (while (< (strlen deg) 3) (setq deg (strcat " " deg)))
      (setq ang (substr ang 2))
      (while (/= "'" (substr ang 1 1))
         (setq mints (strcat mints (substr ang 1 1))
               ang (substr ang 2)
         )
      )
      (while (< (strlen mints) 2) (setq mints (strcat "0" mints)))
      (setq sec (substr ang 2))
      (while (< (strlen sec) 3) (setq sec (strcat "0" sec)))
      (setq DASTR (strcat deg "d" mints "'" sec))
      (princ)
   )
  (defun tan (ang) (/ (sin ang) (cos ang)))
  (setvar "cmdecho" 0)
  (setq ENAME (car (entsel)))
  (setq TYP (cdr (assoc 0 (entget ENAME))))
  (setq LAN (cdr (assoc 8 (entget ENAME))))
  (setq LTN (cdr (assoc 6 (entget ENAME))))
  (if (= LTN NIL)
    (setq LTN "BYLAYER")
  )
  (setq CLN (cdr (assoc 62 (entget ENAME))))
  (if (= CLN NIL)
    (setq CLN "BYLAYER")
    (setq CLN (rtos CLN 2 0))
  )
  (cond
    ((eq TYP "LINE")
     (setq PT1 (cdr (assoc 10 (entget ENAME))))
     (setq PT2 (cdr (assoc 11 (entget ENAME))))
     (setq DST (distance PT1 PT2))
     (setq ANG (angle PT1 PT2))
     (prompt
       (strcat
	 "\n               "
	 TYP
	 "    Length: "
	 (rtos DST)
	 "    Angle: "
	 (angtos ANG 4 5)
	 "    Layer: "
	 LAN
	 "\n             Linetype: "
	 LTN
	 "    Color: "
	 CLN
       )
     )
    )
    ((or (eq ANS "POLYLINE") (eq ANS "LWPOLYLINE"))
     (setq WDT1 (cdr (assoc 40 EE)))
     (setq WDT2 (cdr (assoc 41 EE)))
     (if (= WDT1 WDT2)
       (princ (strcat
		"\n"
		ANS
		" Width - "
		(rtos WDT1 2 4)
		" Layer - "
		LAN
		" linetype - "
		LTN
		" color - "
		CLN
	      )
       )
       (princ (strcat
		"\n"
		ANS
		" Width from: "
		(rtos WDT1 2 4)
		" To: "
		(rtos WDT2 2 4)
		" Layer - "
		LAN
		" Linetype - "
		LTN
		" Color - "
		CLN
	      )
       )
     )
    )
    ((eq TYP "ARC")
     (setq R  (cdr (assoc 40
			  (entget ename)
		   )
	      )
	   CP (cdr (assoc 10
			  (entget ename)
		   )
	      )

	   SA (cdr (assoc 50
			  (entget ename)
		   )
	      )
	   EA (cdr (assoc 51
			  (entget ename)
		   )
	      )
     )
     (if (< SA EA)
       (setq DA (- EA SA))
       (setq DA (- (* 2 PI) (- SA EA)))
     )
     (setq D  (/ (/ 36000 (* 2 PI)) R)
	   L  (* R DA)
	   TA (* R (tan (/ DA 2)))
	   C  (* 2 R (sin (/ DA 2)))
	   M  (* R (- 1 (cos (/ DA 2))))
	   E  (* R (- (/ 1 (cos (/ DA 2))) 1))
	   RI (- EA PI)
	   RO (- SA PI)
	   CB (- PI (+ (/ (- PI DA) 2) EA))
	   SW (strcat
		"\n\n\n\n\t\t\t\t\tChord Bearing: "
		(angtos cb 4 6)
		"\n\t\t\t\t\tChord Length: "
		(rtos C 2 4)
		"\n\t\t\t\t\tDegree of Curvature: "
		(angtos D 4 5)
		"\n\t\t\t\t\tDelta Angle: "))
                (degfrm (angtos da 1 4))
       (setq
           SW2 (strcat
		"\n\t\t\t\t\tExternal Secant: "
		(rtos E 2 4)
		"\n\t\t\t\t\tLength: "
		(rtos L 2 4)
		"\n\t\t\t\t\tMiddle Ordinate: "
		(rtos M 2 4)
		"\n\t\t\t\t\tTangent Length: "
		(rtos TA 2 4)
		"\n\t\t\t\t\tRadial In: "
		(angtos RI 4 5)
		"\n\t\t\t\t\tRadial Out: "
		(angtos RO 4 5)
		"\n\t\t\t\t\tRadius: "
		(rtos R 2 5)
		"\n\n\n\n\n"
	      )

     )
     (princ)
     (prompt SW)
     (prompt DASTR)
     (prompt SW2)
     (princ)
     (command "_textscr")
     (princ)
    )
    ((eq ANS "CIRCLE")
     (setq RAD (cdr (assoc 40 EE)))
     (princ (strcat
	      "\n  The object is: "
	      ANS
	      ", radius= "
	      (rtos RAD 2 4)
	      ", (dia.= "
	      (rtos (* RAD 2) 2 4)
	      "), layer= "
	      LAN
	      ", linetype= "
	      LTN
	      ", color= "
	      CLN
	      ". "
	    )
     )
    )
    ((eq ANS "MTEXT")
     (setq OBN (cdr (assoc 7 EE)))
     (setq TXH (cdr (assoc 40 EE)))
     (princ (strcat
	      "\n  The object is: "
	      ANS
	      ", text style= "
	      OBN
	      ", text height= "
	      (rtos TXH 2 4)
	      ", layer= "
	      LAN
	      ", color= "
	      CLN
	      "."
	    )
     )
    )
    ((or (eq ANS "ATTDEF") (eq ANS "TEXT"))
     (setq OBN (cdr (assoc 7 EE)))
     (setq TXH (cdr (assoc 40 EE)))
     (princ (strcat
	      "\n  The object is: "
	      ANS
	      ", text style= "
	      OBN
	      ", text height= "
	      (rtos TXH 2 4)
	      ", width= "
	      (rtos (cdr (assoc 41 EE)) 2 3)
	      ", oblique= "
	      (rtos (RTD (cdr (assoc 51 EE))) 2 2)
	      "º, layer= "
	      LAN
	      ", color= "
	      CLN
	      "."
	    )
     )
    )
    ((or (eq ANS "DIMENSION")
	 (eq ANS "LEADER")
	 (eq ANS "TOLERANCE")
     )
     (setq OBN (cdr (assoc 3 EE)))
     (if (= OBN NIL)
       (setq OBN "*UN-NAMED*")
     )
     (princ (strcat
	      "\n  The object is: "	      ANS
	      ", dim style= " OBN	      ", layer= "
	      LAN	      ", color= "     CLN
	      "."
	     )
     )
    )
    ((eq ANS "INSERT")
     (setq OBN (cdr (assoc 2 EE)))
     (setq SCLX (cdr (assoc 41 EE)))
     (setq SCLY (cdr (assoc 42 EE)))
     (setq SCLZ (cdr (assoc 43 EE)))
     (setq VATT (cdr (assoc 66 EE)))
     (setq ANS2 (substr OBN 1 1))
     (if (= ANS2 "*")
       (progn
	 (if (null (tblsearch "BLOCK" OBN))
	   (princ
	     (strcat
	       "\n  The object is: Hatch, block name= "
	       OBN
	       ", layer= "
	       LAN
	       ", linetype= "
	       LTN
	       ", color= "
	       CLN
	       ", scale= "
	       (rtos SCLX 2 3)
	       ". "
	     )
	   )
	   (princ
	     (strcat
	       "\n  The object is: Anonymous Block or Hatch, block name= "
	       OBN
	       ", layer= "
	       LAN
	       ", linetype= "
	       LTN
	       ", color= "
	       CLN
	       ", scale= "
	       (rtos SCLX 2 3)
	       ". "
	     )
	   )
	 )
       )
       (progn
	 (if (= SCLX SCLY)
	   (princ
	     (strcat
	       "\n  The object is: BLOCK, block name= "
	       OBN
	       ", layer= "
	       LAN
	       ", linetype= "
	       LTN
	       ", color= "
	       CLN
	       ", scale= "
	       (rtos SCLX 2 3)
	     )
	   )
	   (progn
	     (if (or (= SCLZ SCLY) (= SCLZ SCLX))
	       (princ
		 (strcat
		   "\n  The object is: BLOCK, block name= "
		   OBN
		   ", layer= "
		   LAN
		   ", linetype= "
		   LTN
		   ", color= "
		   CLN
		   ", scale X= "
		   (rtos SCLX 2 3)
		   ", scale Y= "
		   (rtos SCLY 2 3)
		 )
	       )
	       (princ
		 (strcat
		   "\n  The object is: BLOCK, block name= "
		   OBN
		   ", layer= "
		   LAN
		   ", linetype= "
		   LTN
		   ", color= "
		   CLN
		   ", scale X= "
		   (rtos SCLX 2 3)
		   ", scale Y= "
		   (rtos SCLY 2 3)
		   ", scale Z= "
		   (rtos SCLZ 2 3)
		 )
	       )
	     )
	   )
	 )
	 (if (= VATT 1)
	   (princ ", w/ variable attributes. ")
	   (princ ". ")
	 )
       )
     )
    )

  )
)