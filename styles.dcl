dcl_settings : default_dcl_settings { audit_level = 3; }
STYLES : dialog {
label = "General Settings" ;
: row {
 : boxed_column {
 label = "Annotations" ;
 : edit_box {
      edit_width = 15 ;
      key = "ala" ;
      label = "Area layer:" ;
   }
   : edit_box {
      edit_width = 15 ;
      key = "ats" ;
      label = "Area text size:" ;
   }
   : edit_box {
      edit_width = 15 ;
      key = "atsty" ;
      label = "Area text style:" ;
   }
   : edit_box {
      edit_width = 15 ;
      key = "lts" ;
      label = "Line text size:" ;
   }
   : edit_box {
      edit_width = 15 ;
      key = "ltsty" ;
      label = "Line text style:" ;
   }
   : edit_box {
      edit_width = 15 ;
      key = "tol" ;
      label = "Line layer:" ;
   }
   : edit_box {
      edit_width = 15 ;
      key = "lots" ;
      label = "Lot text size:" ;
   }
   : edit_box {
      edit_width = 15 ;
      key = "lotstyle" ;
      label = "Lot text style:" ;
   }
   : edit_box {
      edit_width = 15 ;
      key = "lol" ;
      label = "Lot layer:" ;
   }
  }
  : boxed_column {
  label = "Drafting" ;
    : edit_box {
      edit_width = 15 ;
      key = "curbla" ;
      label = "Curb layer" ;
    }
    : edit_box {
      edit_width = 15 ;
      key = "offla" ;
      label = "Offset layer" ;
    }
    spacer ;
    spacer ;
    spacer ;
    spacer ;
  }
  }
   ok_cancel ;   
}