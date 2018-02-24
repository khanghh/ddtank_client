package bagAndInfo.cell
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class LockableBagCell extends BagCell
   {
       
      
      private var _lockDisplayObject:DisplayObject;
      
      private var _cellLocked:Boolean = false;
      
      public function LockableBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true){super(null,null,null,null,null);}
      
      public function get lockDisplayObject() : DisplayObject{return null;}
      
      public function set lockDisplayObject(param1:DisplayObject) : void{}
      
      public function get cellLocked() : Boolean{return false;}
      
      public function set cellLocked(param1:Boolean) : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
   }
}
