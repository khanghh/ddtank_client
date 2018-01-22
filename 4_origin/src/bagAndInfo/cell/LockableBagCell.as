package bagAndInfo.cell
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class LockableBagCell extends BagCell
   {
       
      
      private var _lockDisplayObject:DisplayObject;
      
      private var _cellLocked:Boolean = false;
      
      public function LockableBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true)
      {
         super(param1,param2,param3,param4,param5);
         _cellLocked = false;
         mouseChildren = false;
         _isShowIsUsedBitmap = true;
      }
      
      public function get lockDisplayObject() : DisplayObject
      {
         return _lockDisplayObject;
      }
      
      public function set lockDisplayObject(param1:DisplayObject) : void
      {
         _lockDisplayObject = param1;
      }
      
      public function get cellLocked() : Boolean
      {
         return _cellLocked;
      }
      
      public function set cellLocked(param1:Boolean) : void
      {
         _cellLocked = param1;
         if(_lockDisplayObject == null)
         {
            return;
         }
         if(param1 == true)
         {
            addChild(_lockDisplayObject);
         }
         else
         {
            _lockDisplayObject.parent && removeChild(_lockDisplayObject);
         }
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(param1 == null)
         {
            cellLocked = false;
         }
         else
         {
            cellLocked = (param1 as InventoryItemInfo).cellLocked;
         }
      }
   }
}
