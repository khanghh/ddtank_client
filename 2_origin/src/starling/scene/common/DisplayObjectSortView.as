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
      
      public function addDisplayObject(value:DisplayObject) : void
      {
         var index:int = indexOfDisplayObject(value);
         if(index == -1)
         {
            _disObjArr.push(value);
            addChild(value);
         }
      }
      
      public function removeDisplayObject(value:DisplayObject, dispose:Boolean) : void
      {
         var index:int = indexOfDisplayObject(value);
         if(index != -1)
         {
            _disObjArr.splice(index,1);
            value.removeFromParent(dispose);
         }
      }
      
      public function removeDisplayObjectByType(typeClazz:Class, dispose:Boolean) : void
      {
         var i:int = 0;
         var disObj:* = null;
         var length:int = _disObjArr.length;
         for(i = length - 1; i > -1; )
         {
            disObj = _disObjArr[i];
            if(disObj is typeClazz)
            {
               _disObjArr.splice(i,1);
               disObj.removeFromParent(dispose);
            }
            i--;
         }
      }
      
      public function removeDisplayObjectByIndex(index:int, dispose:Boolean) : void
      {
         var disObj:DisplayObject = _disObjArr[index];
         if(disObj)
         {
            _disObjArr.splice(index,1);
            disObj.removeFromParent(dispose);
         }
      }
      
      public function indexOfDisplayObject(value:DisplayObject) : int
      {
         var i:int = 0;
         var entity:* = null;
         var length:int = _disObjArr.length;
         for(i = 0; i < length; )
         {
            entity = _disObjArr[i];
            if(entity == value)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function indexOfDisplayObjectByFun(checkFun:Function) : int
      {
         var i:int = 0;
         var entity:* = null;
         var length:int = _disObjArr.length;
         for(i = 0; i < length; )
         {
            entity = _disObjArr[i];
            if(checkFun(entity))
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function getDisplayObjectByIndex(index:int) : *
      {
         return _disObjArr[index];
      }
      
      public function sortDisplayObjectLayer() : void
      {
         var i:int = 0;
         var obj:* = null;
         _disObjArr.sortOn("laySortY",16);
         for(i = 0; i < _disObjArr.length; )
         {
            obj = _disObjArr[i];
            if(obj)
            {
               setChildIndex(obj,i);
            }
            i++;
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
