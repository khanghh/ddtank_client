package condiscount.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import condiscount.CondiscountManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftChildInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class CondiscountItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _normalPriceTxt:FilterFrameText;
      
      private var _disCountPriceTxt:FilterFrameText;
      
      private var buyBtn:BaseButton;
      
      private var buyIcon:Bitmap;
      
      private var _info:GiftBagInfo;
      
      private var icon:Component;
      
      private var _goodsIcon:MovieClip;
      
      private var arrow:MovieClip;
      
      private var frame:BaseAlerFrame;
      
      public function CondiscountItem()
      {
         super();
         init();
      }
      
      public function get info() : GiftBagInfo
      {
         return _info;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("condiscount.view.item.bg");
         addChild(_bg);
         icon = new Component();
         addChild(icon);
         icon.tipStyle = "ddt.view.tips.WordWrapLineTip";
         _goodsIcon = ClassUtils.CreatInstance("condiscount.view.goods.icon");
         _goodsIcon.gotoAndStop(1);
         PositionUtils.setPos(_goodsIcon,"condiscount.view.goods.icon.pos");
         icon.addChild(_goodsIcon);
         icon.tipDirctions = "7,5";
         PositionUtils.setPos(icon,"condiscount.view.goods.icon.component.pos");
         _normalPriceTxt = ComponentFactory.Instance.creatComponentByStylename("condiscount.item.normalPriceText");
         addChild(_normalPriceTxt);
         _disCountPriceTxt = ComponentFactory.Instance.creatComponentByStylename("condiscount.item.discountPriceText");
         addChild(_disCountPriceTxt);
         buyBtn = ComponentFactory.Instance.creatComponentByStylename("condiscount.view.buyBtn");
         addChild(buyBtn);
         buyBtn.addEventListener("click",clickHandler);
         buyIcon = ComponentFactory.Instance.creatBitmap("condiscount.view.buyIcon");
         addChild(buyIcon);
         buyIcon.visible = false;
         arrow = ClassUtils.CreatInstance("condiscount.view.arrow");
         arrow.gotoAndStop(1);
         PositionUtils.setPos(arrow,"condiscount.view.arrow.pos");
         addChild(arrow);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_info.giftConditionArr[0].remain2 == "-1")
         {
            frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.condiscount.item.buyalart",_info.giftConditionArr[0].conditionValue),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
            frame.addEventListener("response",onBuyConfirmResponse);
         }
         else if(_info.giftConditionArr[0].remain2 == "-8")
         {
            frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.condiscount.item.buyalart",_info.giftConditionArr[0].conditionValue),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false);
            frame.isBand = false;
            frame.addEventListener("response",onBuyConfirmResponse);
         }
         else if(_info.giftConditionArr[0].remain2 == "-9")
         {
            frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.condiscount.item.buyalart.band",_info.giftConditionArr[0].conditionValue),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false);
            frame.isBand = true;
            frame.addEventListener("response",onBuyConfirmResponse);
         }
      }
      
      private function onBuyConfirmResponse(param1:FrameEvent) : void
      {
         frame.removeEventListener("response",onBuyConfirmResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(_info.giftConditionArr[0].remain2 == "-1")
            {
               CheckMoneyUtils.instance.checkMoney(frame.isBand,_info.giftConditionArr[0].conditionValue,onCheckComplete);
               return;
            }
            if(frame.isBand && PlayerManager.Instance.Self.BandMoney < _info.giftConditionArr[0].conditionValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               return;
            }
            if(!frame.isBand && PlayerManager.Instance.Self.Money < _info.giftConditionArr[0].conditionValue)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            onCheckComplete();
         }
      }
      
      protected function onCheckComplete() : void
      {
         var _loc4_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var _loc2_:SendGiftInfo = new SendGiftInfo();
         _loc2_.activityId = CondiscountManager.instance.model.actId;
         var _loc3_:Array = [];
         var _loc1_:GiftChildInfo = new GiftChildInfo();
         _loc1_.giftId = _info.giftbagId;
         if(_info.giftConditionArr[0].remain2 == "-1")
         {
            _loc1_.index = !!CheckMoneyUtils.instance.isBind?-9:-8;
         }
         else
         {
            _loc1_.index = !!frame.isBand?-9:-8;
         }
         _loc3_.push(_loc1_);
         _loc2_.giftIdArr = _loc3_;
         _loc4_.push(_loc2_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc4_);
      }
      
      public function setInfo(param1:GiftBagInfo) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         _info = param1;
         _goodsIcon.gotoAndStop(_info.rewardMark + 1);
         var _loc3_:String = "";
         _loc5_ = 0;
         while(_loc5_ < _info.giftRewardArr.length)
         {
            _loc4_ = ItemManager.Instance.getTemplateById(_info.giftRewardArr[_loc5_].templateId).Name;
            _loc2_ = "*" + String(_info.giftRewardArr[_loc5_].count);
            _loc3_ = _loc3_ + (_loc4_ + _loc2_ + "\n");
            _loc5_++;
         }
         icon.tipData = _loc3_;
         _normalPriceTxt.text = LanguageMgr.GetTranslation("ddt.condiscount.item.normalPrice",_info.giftConditionArr[0].remain1);
         _disCountPriceTxt.text = LanguageMgr.GetTranslation("ddt.condiscount.item.discountPrice",_info.giftConditionArr[0].conditionValue);
      }
      
      public function changeData(param1:int) : void
      {
         buyBtn.enable = param1 == 2;
         if(param1 == 0)
         {
            arrow.gotoAndStop(1);
            buyIcon.visible = true;
         }
         else
         {
            arrow.gotoAndStop(2);
            buyIcon.visible = false;
         }
         if(_info.giftbagOrder == 3)
         {
            arrow.visible = false;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _normalPriceTxt = null;
         _disCountPriceTxt = null;
         buyBtn = null;
         buyIcon = null;
      }
   }
}
