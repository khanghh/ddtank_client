package starlingui.core.components
{
   import starling.display.DisplayObject;
   import starlingui.editor.core.IBox;
   
   public class Box extends Component implements IBox
   {
       
      
      public function Box(){super();}
      
      override protected function preinitialize() : void{}
      
      public function addElement(param1:DisplayObject, param2:Number = 0, param3:Number = 0) : void{}
      
      public function addElementAt(param1:DisplayObject, param2:int, param3:Number = 0, param4:Number = 0) : void{}
      
      public function addElements(param1:Array) : void{}
      
      public function removeElement(param1:DisplayObject, param2:Boolean = false) : void{}
      
      public function removeAllChild(param1:DisplayObject = null, param2:Boolean = false) : void{}
      
      public function insertAbove(param1:DisplayObject, param2:DisplayObject) : void{}
      
      public function insertBelow(param1:DisplayObject, param2:DisplayObject) : void{}
      
      override public function set dataSource(param1:Object) : void{}
   }
}
