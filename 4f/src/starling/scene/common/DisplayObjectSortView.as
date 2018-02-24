package starling.scene.common
{
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class DisplayObjectSortView extends Sprite
   {
       
      
      private var _disObjArr:Array;
      
      public function DisplayObjectSortView(){super();}
      
      public function addDisplayObject(param1:DisplayObject) : void{}
      
      public function removeDisplayObject(param1:DisplayObject, param2:Boolean) : void{}
      
      public function removeDisplayObjectByType(param1:Class, param2:Boolean) : void{}
      
      public function removeDisplayObjectByIndex(param1:int, param2:Boolean) : void{}
      
      public function indexOfDisplayObject(param1:DisplayObject) : int{return 0;}
      
      public function indexOfDisplayObjectByFun(param1:Function) : int{return 0;}
      
      public function getDisplayObjectByIndex(param1:int) : *{return null;}
      
      public function sortDisplayObjectLayer() : void{}
      
      public function get disObjArr() : Array{return null;}
      
      override public function dispose() : void{}
   }
}
