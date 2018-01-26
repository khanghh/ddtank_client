package cmodule.decry
{
   import flash.events.KeyboardEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.setTimeout;
   
   class TextFieldI extends IO
   {
       
      
      private var m_buf:String = "";
      
      private var m_tf:TextField;
      
      private var m_start:int = -1;
      
      private var m_closed:Boolean = false;
      
      function TextFieldI(param1:TextField){super();}
      
      override public function read(param1:int, param2:int) : int{return 0;}
   }
}
