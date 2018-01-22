package demonChiYou.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import demonChiYou.DemonChiYouManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class RewardBuyCartItem extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _data:Object;
      
      private var _cartItemCloseBtn:BaseButton;
      
      private var _bagCell:BagCell;
      
      public function RewardBuyCartItem(param1:int){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
      
      public function get data() : Object{return null;}
   }
}
