package morn.core.components
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.Event;
   import flash.events.TextEvent;
   import morn.core.handlers.Handler;
   
   [Event(name="textInput",type="flash.events.TextEvent")]
   public class TextInput extends Label
   {
       
      
      private var _changeHandler:Handler;
      
      public function TextInput(text:String = "", skin:String = null)
      {
         super(text,skin);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         mouseChildren = true;
         width = 128;
         height = 22;
         selectable = true;
         _textField.type = "input";
         _textField.autoSize = "none";
         _textField.addEventListener("change",onTextFieldChange);
         _textField.addEventListener("textInput",onTextFieldTextInput);
      }
      
      private function onTextFieldTextInput(e:TextEvent) : void
      {
         dispatchEvent(e);
      }
      
      protected function onTextFieldChange(e:Event) : void
      {
         text = !!_isHtml?_textField.htmlText:_textField.text;
         e.stopPropagation();
         if(_changeHandler)
         {
            _changeHandler.execute();
         }
      }
      
      public function get changeHandler() : Handler
      {
         return _changeHandler;
      }
      
      public function set changeHandler(value:Handler) : void
      {
         _changeHandler = value;
      }
      
      public function get restrict() : String
      {
         return _textField.restrict;
      }
      
      public function set restrict(value:String) : void
      {
         _textField.restrict = value;
      }
      
      public function get editable() : Boolean
      {
         return _textField.type == "input";
      }
      
      public function set editable(value:Boolean) : void
      {
         _textField.type = !!value?"input":"dynamic";
      }
      
      public function get maxChars() : int
      {
         return _textField.maxChars;
      }
      
      public function set maxChars(value:int) : void
      {
         _textField.maxChars = value;
      }
      
      public function setFocus() : void
      {
         StageReferance.stage.focus = _textField;
      }
      
      override public function dispose() : void
      {
         _changeHandler = null;
         super.dispose();
      }
   }
}
