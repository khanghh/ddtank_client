package bagAndInfo.cell
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class LockableBagCell extends BagCell
   {
       
      
      private var _lockDisplayObject:DisplayObject;
      
      private var _cellLocked:Boolean = false;
      
      public function LockableBagCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,info,showLoading,bg,mouseOverEffBoolean);
         _cellLocked = false;
         mouseChildren = false;
         _isShowIsUsedBitmap = true;
      }
      
      public function get lockDisplayObject() : DisplayObject
      {
         return _lockDisplayObject;
      }
      
      public function set lockDisplayObject(value:DisplayObject) : void
      {
         _lockDisplayObject = value;
      }
      
      public function get cellLocked() : Boolean
      {
         return _cellLocked;
      }
      
      public function set cellLocked(value:Boolean) : void
      {
         _cellLocked = value;
         if(_lockDisplayObject == null)
         {
            return;
         }
         if(value == true)
         {
            addChild(_lockDisplayObject);
         }
         else
         {
            _lockDisplayObject.parent && removeChild(_lockDisplayObject);
         }
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         if(value == null)
         {
            cellLocked = false;
         }
         else
         {
            cellLocked = (value as InventoryItemInfo).cellLocked;
         }
      }
   }
}
