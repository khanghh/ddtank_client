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
      
      public function TextInput(param1:String = "", param2:String = null)
      {
         super(param1,param2);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         mouseChildren = true;
         width = 128;
         height = 22;
         selectable = true;
         _textField.type = TextFieldType.INPUT;
         _textField.autoSize = "none";
         _textField.addEventListener(Event.CHANGE,this.onTextFieldChange);
         _textField.addEventListener(TextEvent.TEXT_INPUT,this.onTextFieldTextInput);
      }
      
      private function onTextFieldTextInput(param1:TextEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onTextFieldChange(param1:Event) : void
      {
         text = !!_isHtml?_textField.htmlText:_textField.text;
         param1.stopPropagation();
         if(this._changeHandler)
         {
            this._changeHandler.execute();
         }
      }
      
      public function get changeHandler() : Handler
      {
         return this._changeHandler;
      }
      
      public function set changeHandler(param1:Handler) : void
      {
         this._changeHandler = param1;
      }
      
      public function get restrict() : String
      {
         return _textField.restrict;
      }
      
      public function set restrict(param1:String) : void
      {
         _textField.restrict = param1;
      }
      
      public function get editable() : Boolean
      {
         return _textField.type == TextFieldType.INPUT;
      }
      
      public function set editable(param1:Boolean) : void
      {
         _textField.type = !!param1?TextFieldType.INPUT:TextFieldType.DYNAMIC;
      }
      
      public function get maxChars() : int
      {
         return _textField.maxChars;
      }
      
      public function set maxChars(param1:int) : void
      {
         _textField.maxChars = param1;
      }
      
      public function setFocus() : void
      {
         StageReferance.stage.focus = _textField;
      }
      
      override public function dispose() : void
      {
         this._changeHandler = null;
         super.dispose();
      }
   }
}
