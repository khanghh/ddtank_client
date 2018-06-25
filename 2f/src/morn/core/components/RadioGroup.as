package morn.core.components{   import flash.display.DisplayObject;      public class RadioGroup extends Group   {            public static const HORIZENTAL:String = "horizontal";            public static const VERTICAL:String = "vertical";                   public function RadioGroup(labels:String = null, skin:String = null) { super(null,null); }
            override protected function createItem(skin:String, label:String) : DisplayObject { return null; }
            override protected function changeLabels() : void { }
            public function get selectedValue() : Object { return null; }
            public function set selectedValue(value:Object) : void { }
   }}