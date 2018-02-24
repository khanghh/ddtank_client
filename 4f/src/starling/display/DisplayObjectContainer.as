package starling.display
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.utils.getQualifiedClassName;
   import starling.core.RenderSupport;
   import starling.errors.AbstractClassError;
   import starling.events.Event;
   import starling.filters.FragmentFilter;
   import starling.utils.MatrixUtil;
   
   public class DisplayObjectContainer extends DisplayObject
   {
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sBroadcastListeners:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
      
      private static var sSortBuffer:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
       
      
      private var mChildren:Vector.<DisplayObject>;
      
      private var mTouchGroup:Boolean;
      
      public function DisplayObjectContainer(){super();}
      
      private static function mergeSort(param1:Vector.<DisplayObject>, param2:Function, param3:int, param4:int, param5:Vector.<DisplayObject>) : void{}
      
      override public function dispose() : void{}
      
      public function addChild(param1:DisplayObject) : DisplayObject{return null;}
      
      public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject{return null;}
      
      public function removeChild(param1:DisplayObject, param2:Boolean = false) : DisplayObject{return null;}
      
      public function removeChildAt(param1:int, param2:Boolean = false) : DisplayObject{return null;}
      
      public function removeChildren(param1:int = 0, param2:int = -1, param3:Boolean = false) : void{}
      
      public function getChildAt(param1:int) : DisplayObject{return null;}
      
      public function getChildByName(param1:String) : DisplayObject{return null;}
      
      public function getChildIndex(param1:DisplayObject) : int{return 0;}
      
      public function setChildIndex(param1:DisplayObject, param2:int) : void{}
      
      public function swapChildren(param1:DisplayObject, param2:DisplayObject) : void{}
      
      public function swapChildrenAt(param1:int, param2:int) : void{}
      
      public function sortChildren(param1:Function) : void{}
      
      public function contains(param1:DisplayObject) : Boolean{return false;}
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle{return null;}
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject{return null;}
      
      override public function render(param1:RenderSupport, param2:Number) : void{}
      
      public function broadcastEvent(param1:Event) : void{}
      
      public function broadcastEventWith(param1:String, param2:Object = null) : void{}
      
      public function get numChildren() : int{return 0;}
      
      public function get touchGroup() : Boolean{return false;}
      
      public function set touchGroup(param1:Boolean) : void{}
      
      private function spliceChildren(param1:int, param2:uint = 4294967295, param3:DisplayObject = null) : void{}
      
      function getChildEventListeners(param1:DisplayObject, param2:String, param3:Vector.<DisplayObject>) : void{}
   }
}
