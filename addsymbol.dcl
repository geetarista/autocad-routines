dcl_settings : default_dcl_settings { audit_level = 3; }
addsymbol : dialog {
label = "Add symbol to text" ;
 :column {
      :text {
      label = "First symbol (or text):" ;
      alignment = centered ;
      }
      :edit_box {
      key = "s1" ;
      }
      :text {
      label = "Second symbol (or text):" ;
      alignment = centered ;
      }
      :edit_box {
      key = "s2" ;
      }
      :button {
      key = "pick" ;
      label = "< Select Objects";      
      }
  }
  ok_cancel;
}