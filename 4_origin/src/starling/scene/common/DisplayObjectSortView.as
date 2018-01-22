package starling.scene.common
{
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class DisplayObjectSortView extends Sprite
   {
       
      
      private var _disObjArr:Array;
      
      public function DisplayObjectSortView()
      {
         super();
         _disObjArr = [];
      }
      
      public function addDisplayObject(param1:DisplayObject) : void
      {
         var _loc2_:int = indexOfDisplayObject(param1);
         if(_loc2_ == -1)
         {
            _disObjArr.push(param1);
            addChild(param1);
         }
      }
      
      public function removeDisplayObject(param1:DisplayObject, param2:Boolean) : void
      {
         var _loc3_:int = indexOfDisplayObject(param1);
         if(_loc3_ != -1)
         {
            _disObjArr.splice(_loc3_,1);
            param1.removeFromParent(param2);
         }
      }
      
      public function removeDisplayObjectByType(param1:Class, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = _disObjArr.length;
         _loc5_ = _loc4_ - 1;
         while(_loc5_ > -1)
         {
            _loc3_ = _disObjArr[_loc5_];
            if(_loc3_ is param1)
            {
               _disObjArr.splice(_loc5_,1);
               _loc3_.removeFromParent(param2);
            }
            _loc5_--;
         }
      }
      
      public function removeDisplayObjectByIndex(param1:int, param2:Boolean) : void
      {
         var _loc3_:DisplayObject = _disObjArr[param1];
         if(_loc3_)
         {
            _disObjArr.splice(param1,1);
            _loc3_.removeFromParent(param2);
         }
      }
      
      public function indexOfDisplayObject(param1:DisplayObject) : int
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = _disObjArr.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _disObjArr[_loc4_];
            if(_loc2_ == param1)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
      
      public function indexOfDisplayObjectByFun(param1:Function) : int
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = _disObjArr.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _disObjArr[_loc4_];
            if(param1(_loc2_))
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
      
      public function getDisplayObjectByIndex(param1:int) : *
      {
         return _disObjArr[param1];
      }
      
      public function sortDisplayObjectLayer() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _disObjArr.sortOn("laySortY",16);
         _loc2_ = 0;
         while(_loc2_ < _disObjArr.length)
         {
            _loc1_ = _disObjArr[_loc2_];
            if(_loc1_)
            {
               setChildIndex(_loc1_,_loc2_);
            }
            _loc2_++;
         }
      }
      
      public function get disObjArr() : Array
      {
         return _disObjArr;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _disObjArr = null;
      }
   }
}
