package cmodule.decry
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   class TextFieldO extends IO
   {
       
      
      private var m_trace:Boolean;
      
      private var m_tf:TextField;
      
      function TextFieldO(param1:TextField, param2:Boolean = false){super();}
      
      override public function write(param1:int, param2:int) : int{return 0;}
   }
}
