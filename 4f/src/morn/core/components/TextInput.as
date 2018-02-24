package morn.core.components
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.text.TextFieldType;
   import morn.core.handlers.Handler;
   
   [Event(name="textInput",type="flash.events.TextEvent")]
   public class TextInput extends Label
   {
       
      
      private var _changeHandler:Handler;
      
      public function TextInput(param1:String = "", param2:String = null){super(null,null);}
      
      override protected function initialize() : void{}
      
      private function onTextFieldTextInput(param1:TextEvent) : void{}
      
      protected function onTextFieldChange(param1:Event) : void{}
      
      public function get changeHandler() : Handler{return null;}
      
      public function set changeHandler(param1:Handler) : void{}
      
      public function get restrict() : String{return null;}
      
      public function set restrict(param1:String) : void{}
      
      public function get editable() : Boolean{return false;}
      
      public function set editable(param1:Boolean) : void{}
      
      public function get maxChars() : int{return 0;}
      
      public function set maxChars(param1:int) : void{}
      
      public function setFocus() : void{}
      
      override public function dispose() : void{}
   }
}
