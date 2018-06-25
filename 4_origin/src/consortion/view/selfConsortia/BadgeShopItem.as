package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.BadgeInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BadgeShopItem extends Sprite implements Disposeable
   {
       
      
      private var _badge:Badge;
      
      private var _btn:SimpleBitmapButton;
      
      private var _nametxt:FilterFrameText;
      
      private var _day:FilterFrameText;
      
      private var _pay:FilterFrameText;
      
      private var _info:BadgeInfo;
      
      private var _bg:ScaleBitmapImage;
      
      private var _cellBG:DisplayObject;
      
      private var _line:MutipleImage;
      
      private var _alert:BaseAlerFrame;
      
      public function BadgeShopItem(badgeInfo:BadgeInfo)
      {
         super();
         _info = badgeInfo;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("badgeShopFrame.ItemBG");
         addChild(_bg);
         _cellBG = ComponentFactory.Instance.creatCustomObject("badgeShopFrame.ItemCellBG");
         addChild(_cellBG);
         _badge = new Badge("normal");
         _badge.badgeID = _info.BadgeID;
         PositionUtils.setPos(_badge,"badgeshopItem.pos");
         ShowTipManager.Instance.addTip(_badge);
         _nametxt = ComponentFactory.Instance.creatComponentByStylename("consortion.badgeShopItem.name");
         addChild(_nametxt);
         _nametxt.text = _info.BadgeName;
         _btn = ComponentFactory.Instance.creatComponentByStylename("consortion.buyBadgeItemBtn");
         _day = ComponentFactory.Instance.creatComponentByStylename("consortion.shopItemBtn.day");
         _pay = ComponentFactory.Instance.creatComponentByStylename("consortion.shopItemBtn.Pay");
         PositionUtils.setPos(_pay,"consortion.shopItemBtn.Pay.pos");
         addChild(_badge);
         addChild(_btn);
         _btn.addChild(_day);
         _btn.addChild(_pay);
         _pay.text = _info.Cost.toString() + LanguageMgr.GetTranslation("consortia.Money");
         _day.text = _info.ValidDate.toString() + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
         _line = ComponentFactory.Instance.creatComponentByStylename("consortion.badgeShop.VerticalLine");
         addChild(_line);
         if(PlayerManager.Instance.Self.consortiaInfo.Level < _info.LimitLevel)
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            filters = null;
         }
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",onClick);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",onClick);
      }
      
      private function onClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.consortiaInfo.Level >= _info.LimitLevel)
         {
            if(PlayerManager.Instance.Self.consortiaInfo.Riches >= _info.Cost)
            {
               if(_alert)
               {
                  _alert.removeEventListener("response",onResponse);
                  ObjectUtils.disposeObject(_alert);
               }
               _alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.common.AddPricePanel.pay"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               _alert.addEventListener("response",onResponse);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.skillItem.click.enough1"));
               ConsortionModelManager.Instance.alertTaxFrame();
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.buyBadge.levelTooLow"));
         }
      }
      
      private function onResponse(event:FrameEvent) : void
      {
         _alert.removeEventListener("response",onResponse);
         _alert.dispose();
         _alert = null;
         SoundManager.instance.playButtonSound();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendBuyBadge(_info.BadgeID);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_alert)
         {
            _alert.removeEventListener("response",onResponse);
            _alert.dispose();
         }
         _alert = null;
         ShowTipManager.Instance.removeTip(_badge);
         ObjectUtils.disposeObject(_badge);
         _badge = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_nametxt);
         _nametxt = null;
         ObjectUtils.disposeObject(_day);
         _day = null;
         ObjectUtils.disposeObject(_pay);
         _pay = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_cellBG);
         _cellBG = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
