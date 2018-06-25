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
      
      private function clickHandler(event:MouseEvent) : void
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
      
      private function onBuyConfirmResponse(e:FrameEvent) : void
      {
         frame.removeEventListener("response",onBuyConfirmResponse);
         if(e.responseCode == 2 || e.responseCode == 3)
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
         var sendInfoVec:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var sendInfo:SendGiftInfo = new SendGiftInfo();
         sendInfo.activityId = CondiscountManager.instance.model.actId;
         var temp:Array = [];
         var childInfo:GiftChildInfo = new GiftChildInfo();
         childInfo.giftId = _info.giftbagId;
         if(_info.giftConditionArr[0].remain2 == "-1")
         {
            childInfo.index = !!CheckMoneyUtils.instance.isBind?-9:-8;
         }
         else
         {
            childInfo.index = !!frame.isBand?-9:-8;
         }
         temp.push(childInfo);
         sendInfo.giftIdArr = temp;
         sendInfoVec.push(sendInfo);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
      }
      
      public function setInfo(value:GiftBagInfo) : void
      {
         var i:int = 0;
         var name:* = null;
         var count:* = null;
         _info = value;
         _goodsIcon.gotoAndStop(_info.rewardMark + 1);
         var str:String = "";
         for(i = 0; i < _info.giftRewardArr.length; )
         {
            name = ItemManager.Instance.getTemplateById(_info.giftRewardArr[i].templateId).Name;
            count = "*" + String(_info.giftRewardArr[i].count);
            str = str + (name + count + "\n");
            i++;
         }
         icon.tipData = str;
         _normalPriceTxt.text = LanguageMgr.GetTranslation("ddt.condiscount.item.normalPrice",_info.giftConditionArr[0].remain1);
         _disCountPriceTxt.text = LanguageMgr.GetTranslation("ddt.condiscount.item.discountPrice",_info.giftConditionArr[0].conditionValue);
      }
      
      public function changeData(buyType:int) : void
      {
         buyBtn.enable = buyType == 2;
         if(buyType == 0)
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
