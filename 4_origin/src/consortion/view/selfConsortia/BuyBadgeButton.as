package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.utils.DateUtils;
   
   public class BuyBadgeButton extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _buyBadgeTxt:Bitmap;
      
      private var _badge:Badge;
      
      private var _badgeID:int;
      
      public function BuyBadgeButton()
      {
         super();
         initView();
         addEvent();
      }
      
      private function onClick(event:MouseEvent) : void
      {
         var shopFrame:* = null;
         if(PlayerManager.Instance.Self.consortiaInfo.ChairmanID == PlayerManager.Instance.Self.ID)
         {
            SoundManager.instance.playButtonSound();
            shopFrame = ComponentFactory.Instance.creatComponentByStylename("consortion.badgeShopFrame");
            LayerManager.Instance.addToLayer(shopFrame,3,true,2,true);
         }
      }
      
      private function onMouseOver(evt:MouseEvent) : void
      {
         filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      private function onMouseOut(evt:MouseEvent) : void
      {
         filters = [];
      }
      
      private function initView() : void
      {
         buttonMode = PlayerManager.Instance.Self.consortiaInfo.ChairmanID == PlayerManager.Instance.Self.ID;
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortion.buyBadgeBtnBg");
         _buyBadgeTxt = ComponentFactory.Instance.creatBitmap("asset.consortion.buyBadgeBtnTxt");
         _badge = new Badge("large");
         addChild(_bg);
         addChild(_buyBadgeTxt);
         addChild(_badge);
         PositionUtils.setPos(_badge,"consortiaBadgeBtn.badge.pos");
      }
      
      private function addEvent() : void
      {
         addEventListener("click",onClick);
         addEventListener("mouseOver",onMouseOver);
         addEventListener("mouseOut",onMouseOut);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",onClick);
         removeEventListener("mouseOver",onMouseOver);
         removeEventListener("mouseOut",onMouseOut);
      }
      
      public function get badgeID() : int
      {
         return _badgeID;
      }
      
      public function set badgeID(value:int) : void
      {
         if(_badgeID == value)
         {
            return;
         }
         _badgeID = value;
         _buyBadgeTxt.visible = _badgeID == 0;
         if(PlayerManager.Instance.Self.consortiaInfo.BadgeID > 0)
         {
            _badge.buyDate = DateUtils.dealWithStringDate(PlayerManager.Instance.Self.consortiaInfo.BadgeBuyTime);
            ShowTipManager.Instance.addTip(_badge);
         }
         _badge.badgeID = value;
         _badge.visible = _badgeID > 0;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ShowTipManager.Instance.removeTip(_badge);
         _badge.dispose();
         _badge = null;
         ObjectUtils.disposeObject(_buyBadgeTxt);
         _buyBadgeTxt = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
