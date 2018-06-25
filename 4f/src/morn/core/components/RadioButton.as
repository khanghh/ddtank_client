package morn.core.components{   import flash.events.Event;      public class RadioButton extends Button   {                   protected var _value:Object;            public function RadioButton(skin:String = null, label:String = "") { super(null,null); }
            override protected function preinitialize() : void { }
            override protected function initialize() : void { }
            override protected function changeLabelSize() : void { }
            override public function commitMeasure() : void { }
            protected function onClick(e:Event) : void { }
            public function get value() : Object { return null; }
            public function set value(obj:Object) : void { }
            override public function dispose() : void { }
   }}