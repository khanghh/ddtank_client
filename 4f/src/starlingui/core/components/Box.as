package starlingui.core.components{   import starling.display.DisplayObject;   import starlingui.editor.core.IBox;      public class Box extends Component implements IBox   {                   public function Box() { super(); }
            override protected function preinitialize() : void { }
            public function addElement(element:DisplayObject, x:Number = 0, y:Number = 0) : void { }
            public function addElementAt(element:DisplayObject, index:int, x:Number = 0, y:Number = 0) : void { }
            public function addElements(elements:Array) : void { }
            public function removeElement(element:DisplayObject, dispose:Boolean = false) : void { }
            public function removeAllChild(except:DisplayObject = null, dispose:Boolean = false) : void { }
            public function insertAbove(element:DisplayObject, compare:DisplayObject) : void { }
            public function insertBelow(element:DisplayObject, compare:DisplayObject) : void { }
            override public function set dataSource(value:Object) : void { }
   }}