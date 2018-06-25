package team.view.main
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.model.TeamShopInfo;
   import team.view.mornui.item.TeamShopViewItemUI;
   
   public class TeamShopViewItem extends TeamShopViewItemUI
   {
       
      
      private var _info:TeamShopInfo;
      
      private var _cell:BagCell;
      
      public function TeamShopViewItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         var shape:Shape = new Shape();
         shape.graphics.beginFill(0,0);
         shape.graphics.drawRect(0,0,63,63);
         shape.graphics.endFill();
         _cell = new BagCell(0,null,false,shape);
         PositionUtils.setPos(_cell,"team.shop.itemCellPos");
         _cell.setContentSize(60,60);
         addChild(_cell);
         btn_buy.clickHandler = new Handler(__onClickBuy);
         btn_buy.label = LanguageMgr.GetTranslation("ddt.team.allView.text1");
      }
      
      private function __onClickBuy() : void
      {
         var condition:int = 0;
         var _buyView:* = null;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_info)
         {
            if(TeamManager.instance.model.selfTeamInfo.grade < _info.NeedLevel)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("team.shop.notOpen"));
               return;
            }
            if(_info.Condition == 1)
            {
               condition = TeamManager.instance.model.selfScore;
            }
            else if(_info.Condition == 2)
            {
               condition = TeamManager.instance.model.selfAllActive;
            }
            if(condition < _info.Value)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("team.shop.conditionTip" + _info.Condition));
               return;
            }
            _buyView = ComponentFactory.Instance.creatComponentByStylename("team.view.alertShopBuyFrame");
            _buyView.setData(_cell.info.TemplateID,_info.ID,_info.Price);
            LayerManager.Instance.addToLayer(_buyView,2,true,1);
         }
      }
      
      public function set info(value:TeamShopInfo) : void
      {
         var shopInfo:* = null;
         var itemInfo:* = null;
         _info = value;
         if(_info)
         {
            shopInfo = ShopManager.Instance.getShopItemByGoodsID(_info.ID);
            itemInfo = ItemManager.fillByID(shopInfo.TemplateID);
            itemInfo.IsBinds = true;
            _cell.info = itemInfo;
            _cell.refreshTbxPos();
            label_name.text = itemInfo.Name;
            label_coin.text = LanguageMgr.GetTranslation("team.shop.consume",_info.Price);
            if(_info.Condition)
            {
               label_tip.text = LanguageMgr.GetTranslation("team.shop.condition" + _info.Condition,_info.Value);
            }
            else
            {
               label_tip.text = "";
            }
            label_tip.visible = true;
            label_name.visible = true;
            label_coin.visible = true;
            btn_buy.visible = true;
         }
         else
         {
            label_name.visible = false;
            label_coin.visible = false;
            label_tip.visible = false;
            btn_buy.visible = false;
            _cell.info = null;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_cell);
         super.dispose();
      }
   }
}
