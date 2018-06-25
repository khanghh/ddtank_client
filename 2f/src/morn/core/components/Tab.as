package morn.core.components{   import flash.display.DisplayObject;      public class Tab extends Group   {            public static const HORIZENTAL:String = "horizontal";            public static const VERTICAL:String = "vertical";                   public function Tab(labels:String = null, skin:String = null) { super(null,null); }
            override protected function createItem(skin:String, label:String) : DisplayObject { return null; }
            override protected function changeLabels() : void { }
   }}