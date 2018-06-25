package ddt.view.caddyII
{
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Sprite;
   
   public class RightView extends Sprite implements Disposeable
   {
      
      public static const START_TURN:String = "caddy_start_turn";
      
      public static const START_MOVE_AFTER_TURN:String = "start_move_after_turn";
       
      
      protected var _item:ItemTemplateInfo;
      
      protected var _type:int = 0;
      
      protected var _autoCheck:SelectedCheckButton;
      
      public function RightView()
      {
         super();
      }
      
      public function again() : void
      {
      }
      
      public function setSelectGoodsInfo(info:InventoryItemInfo) : void
      {
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_autoCheck);
         _autoCheck = null;
      }
      
      public function get item() : ItemTemplateInfo
      {
         return _item;
      }
      
      public function set item(val:ItemTemplateInfo) : void
      {
         _item = val;
      }
      
      public function setType(val:int) : void
      {
         _type = val;
      }
      
      public function get openBtnEnable() : Boolean
      {
         return false;
      }
   }
}
