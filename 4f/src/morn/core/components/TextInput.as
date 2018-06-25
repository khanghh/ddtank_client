package morn.core.components{   import com.pickgliss.toplevel.StageReferance;   import flash.events.Event;   import flash.events.TextEvent;   import morn.core.handlers.Handler;      [Event(name="textInput",type="flash.events.TextEvent")]   public class TextInput extends Label   {                   private var _changeHandler:Handler;            public function TextInput(text:String = "", skin:String = null) { super(null,null); }
            override protected function initialize() : void { }
            private function onTextFieldTextInput(e:TextEvent) : void { }
            protected function onTextFieldChange(e:Event) : void { }
            public function get changeHandler() : Handler { return null; }
            public function set changeHandler(value:Handler) : void { }
            public function get restrict() : String { return null; }
            public function set restrict(value:String) : void { }
            public function get editable() : Boolean { return false; }
            public function set editable(value:Boolean) : void { }
            public function get maxChars() : int { return 0; }
            public function set maxChars(value:int) : void { }
            public function setFocus() : void { }
            override public function dispose() : void { }
   }}