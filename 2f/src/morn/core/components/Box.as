package morn.core.components{   import flash.display.DisplayObject;   import morn.editor.core.IBox;      public class Box extends Component implements IBox   {                   public function Box() { super(); }
            override protected function preinitialize() : void { }
            public function addElement(element:DisplayObject, x:Number, y:Number) : void { }
            public function addElementAt(element:DisplayObject, index:int, x:Number, y:Number) : void { }
            public function addElements(elements:Array) : void { }
            public function removeElement(element:DisplayObject) : void { }
            public function removeAllChild(except:DisplayObject = null) : void { }
            public function insertAbove(element:DisplayObject, compare:DisplayObject) : void { }
            public function insertBelow(element:DisplayObject, compare:DisplayObject) : void { }
            override public function set dataSource(value:Object) : void { }
   }}