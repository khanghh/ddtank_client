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
      
      public function RewardBuyCartItem(param1:int)
      {
         super();
         _index = param1;
         _data = DemonChiYouManager.instance.model.shopInfoArr[_index];
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         UICreatShortcut.creatAndAdd("demonChiYou.rewardBuyCard.CartItemBg",this);
         UICreatShortcut.creatAndAdd("demonChiYou.rewardBuyCard.goldline",this);
         UICreatShortcut.creatAndAdd("demonChiYou.rewardBuyCard.ItemCellBg",this);
         var _loc3_:InventoryItemInfo = _data["InventoryItemInfo"];
         _bagCell = new BagCell(1);
         _bagCell.BGVisible = false;
         _bagCell.setContentSize(60,60);
         _bagCell.info = _loc3_;
         _bagCell.setCount(_loc3_.Count);
         PositionUtils.setPos(_bagCell,"demonChiYou.rewardBuyCardItemGoodPos");
         addChild(_bagCell);
         var _loc2_:int = DemonChiYouManager.instance.model.rankInfo.myConsortiaRank;
         var _loc1_:int = Math.floor(_loc2_ / 10 * _data["Cost"]);
         UICreatShortcut.creatTextAndAdd("demonChiYou.rewardBuyCardItem.goodNameTf",_loc3_.Name,this);
         UICreatShortcut.creatTextAndAdd("demonChiYou.rewardBuyCardItem.goodOrglCostTf",LanguageMgr.GetTranslation("callbacklotterdraw.priceTxt",_data["Cost"]),this);
         UICreatShortcut.creatTextAndAdd("demonChiYou.rewardBuyCardItem.goodDisCountCostTf",LanguageMgr.GetTranslation("callbacklotterdraw.newPriceTxt",_loc1_),this);
         _cartItemCloseBtn = UICreatShortcut.creatAndAdd("demonChiYou.rewardBuyCard.CartItemCloseBtn",this);
      }
      
      private function initEvent() : void
      {
         _cartItemCloseBtn.addEventListener("click",onClick);
      }
      
      private function removeEvent() : void
      {
         _cartItemCloseBtn.removeEventListener("click",onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         DemonChiYouManager.instance.dispatchEvent(new CEvent("event_buy_card_remove_item",this));
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
         _cartItemCloseBtn = null;
         _bagCell = null;
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
