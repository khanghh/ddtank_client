package vip.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.bossbox.AwardsViewII;
   import ddt.view.bossbox.VipInfoTipBox;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import vip.VipController;
   
   public class VipViewFrame extends Frame
   {
      
      private static var _instance:VipViewFrame;
      
      public static const VIP_LEVEL1:String = "112112";
      
      public static const VIP_LEVEL2:String = "112113";
      
      public static const VIP_LEVEL3:String = "112114";
      
      public static const VIP_LEVEL4:String = "112115";
      
      public static const VIP_LEVEL5:String = "112116";
      
      public static const VIP_LEVEL6:String = "112117";
      
      public static const VIP_LEVEL7:String = "112118";
      
      public static const VIP_LEVEL8:String = "112119";
      
      public static const VIP_LEVEL9:String = "112120";
      
      public static const VIP_LEVEL10:String = "112204";
      
      public static const VIP_LEVEL11:String = "112205";
      
      public static const VIP_LEVEL12:String = "112206";
      
      public static var _vipChestsArr:Array = ["112112","112113","112114","112115","112116","112117","112118","112119","112120","112204","112205","112206"];
      
      public static var millisecondsPerDays:int = 86400000;
       
      
      private var _currentVip:Bitmap;
      
      private var _nextVip:Bitmap;
      
      private var _receiveBtn:BaseButton;
      
      private var _receiveShin:Scale9CornerImage;
      
      private var _openVipBtn:BaseButton;
      
      private var _BG:ScaleBitmapImage;
      
      private var _vipViewBg1:MutipleImage;
      
      private var _vipViewBg2:MutipleImage;
      
      private var _vipSp:Disposeable;
      
      private var _vipFrame:VipFrame;
      
      private var _head:VipFrameHead;
      
      private var _vipInfoTipBox:VipInfoTipBox;
      
      private var alertFrame:BaseAlerFrame;
      
      private var awards:AwardsViewII;
      
      private var LeftRechargeAlerTxt:VipPrivilegeTxt;
      
      private var RightRechargeAlerTxt:VipPrivilegeTxt;
      
      private var _text:FilterFrameText;
      
      private var _Pattern:Bitmap;
      
      private var _Pattern1:Bitmap;
      
      public function VipViewFrame()
      {
         super();
         _init();
      }
      
      public static function get instance() : VipViewFrame
      {
         if(!_instance)
         {
            _instance = new VipViewFrame();
         }
         return _instance;
      }
      
      private function _init() : void
      {
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.vip.vipViewFrame.title");
         _BG = ComponentFactory.Instance.creatComponentByStylename("VIPViewFrame.BG");
         _head = new VipFrameHead();
         _vipViewBg1 = ComponentFactory.Instance.creatComponentByStylename("vipView.BG1");
         _vipViewBg2 = ComponentFactory.Instance.creatComponentByStylename("vipView.BG2");
         _Pattern = ComponentFactory.Instance.creatBitmap("asset.vip.PrivilegeTxtBg");
         _Pattern1 = ComponentFactory.Instance.creatBitmap("asset.vip.PrivilegeTxtBg");
         PositionUtils.setPos(_Pattern1,"PrivilegeTxtBgPos");
         _currentVip = ComponentFactory.Instance.creatBitmap("asset.vip.currentVip");
         _nextVip = ComponentFactory.Instance.creatBitmap("asset.vip.nextVip");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.rewardBtn");
         PositionUtils.setPos(_receiveBtn,"vip.ReceiveBtnPos");
         _receiveShin = ComponentFactory.Instance.creatComponentByStylename("rewardBtn.shin");
         PositionUtils.setPos(_receiveShin,"vip.ReceiveShinPos");
         _openVipBtn = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.openVipBtn");
         PositionUtils.setPos(_openVipBtn,"vip.OpenVipBtnPos");
         _text = ComponentFactory.Instance.creatComponentByStylename("VipView.Text");
         _text.text = LanguageMgr.GetTranslation("tank.vip.PrivilegeTxt11");
         addToContent(_BG);
         addToContent(_vipViewBg1);
         addToContent(_vipViewBg2);
         addToContent(_Pattern);
         addToContent(_Pattern1);
         addToContent(_head);
         addToContent(_currentVip);
         addToContent(_nextVip);
         addToContent(_receiveBtn);
         addToContent(_receiveShin);
         var _loc2_:Boolean = false;
         _receiveShin.mouseChildren = _loc2_;
         _receiveShin.mouseEnabled = _loc2_;
         addToContent(_openVipBtn);
         receiveBtnCanUse();
         var selfInfo:SelfInfo = PlayerManager.Instance.Self;
         if(selfInfo.VIPLevel < 12)
         {
            LeftRechargeAlerTxt = new VipPrivilegeTxt();
            LeftRechargeAlerTxt.AlertContent = selfInfo.VIPLevel;
            PositionUtils.setPos(LeftRechargeAlerTxt,"LeftRechageAlerTxtPos");
            RightRechargeAlerTxt = new VipPrivilegeTxt();
            RightRechargeAlerTxt.AlertContent = selfInfo.VIPLevel + 1;
            PositionUtils.setPos(RightRechargeAlerTxt,"RightRechageAlerTxtPos");
            addToContent(LeftRechargeAlerTxt);
            addToContent(RightRechargeAlerTxt);
         }
         if(selfInfo.VIPLevel == 12)
         {
            LeftRechargeAlerTxt = new VipPrivilegeTxt();
            LeftRechargeAlerTxt.AlertContent = 12;
            PositionUtils.setPos(LeftRechargeAlerTxt,"LeftRechageAlerTxtPos");
            addToContent(LeftRechargeAlerTxt);
            addToContent(_text);
         }
      }
      
      private function initEvent() : void
      {
         _receiveBtn.addEventListener("click",__receive);
         _openVipBtn.addEventListener("click",__openVipHandler);
         addEventListener("response",__frameEventHandler);
      }
      
      private function removeEvent() : void
      {
         _receiveBtn.removeEventListener("click",__receive);
         _openVipBtn.removeEventListener("click",__openVipHandler);
         removeEventListener("response",__frameEventHandler);
      }
      
      private function __openVipHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_vipFrame == null)
         {
            _vipFrame = ComponentFactory.Instance.creatComponentByStylename("vip.VipFrame");
         }
         _vipFrame.show();
         VipController.instance.hide();
      }
      
      private function __receive(event:MouseEvent) : void
      {
         var incream:int = 0;
         var date:* = null;
         var nowDate:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.canTakeVipReward || PlayerManager.Instance.Self.IsVIP == false)
         {
            _vipInfoTipBox = ComponentFactory.Instance.creat("vip.VipInfoTipFrame");
            _vipInfoTipBox.escEnable = true;
            _vipInfoTipBox.vipAwardGoodsList = getVIPInfoTip(BossBoxManager.instance.inventoryItemList);
            _vipInfoTipBox.addEventListener("response",__responseVipInfoTipHandler);
            LayerManager.Instance.addToLayer(_vipInfoTipBox,3,true,1);
         }
         else
         {
            incream = 0;
            date = PlayerManager.Instance.Self.systemDate as Date;
            nowDate = new Date();
            alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.vip.vipView.cueDateScript",nowDate.month + 1,nowDate.date + 1),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
            alertFrame.moveEnable = false;
            alertFrame.addEventListener("response",__alertHandler);
         }
      }
      
      private function __alertHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         alertFrame.removeEventListener("response",__alertHandler);
         if(alertFrame && alertFrame.parent)
         {
            alertFrame.parent.removeChild(alertFrame);
         }
         if(alertFrame)
         {
            alertFrame.dispose();
         }
         alertFrame = null;
      }
      
      private function __responseVipInfoTipHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _vipInfoTipBox.removeEventListener("response",__responseHandler);
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               _vipInfoTipBox.dispose();
               _vipInfoTipBox = null;
               break;
            case 2:
               showAwards(_vipInfoTipBox.selectCellInfo);
               _vipInfoTipBox.dispose();
               _vipInfoTipBox = null;
         }
      }
      
      private function showAwards(para:ItemTemplateInfo) : void
      {
         awards = ComponentFactory.Instance.creat("vip.awardFrame");
         awards.escEnable = true;
         awards.boxType = 2;
         awards.vipAwardGoodsList = _getStrArr(BossBoxManager.instance.inventoryItemList);
         awards.addEventListener("response",__responseHandler);
         awards.addEventListener("_haveBtnClick",__sendReward);
         LayerManager.Instance.addToLayer(awards,3,true,1);
      }
      
      private function __sendReward(event:Event) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendDailyAward(3);
         awards.removeEventListener("_haveBtnClick",__sendReward);
         awards.dispose();
         PlayerManager.Instance.Self.canTakeVipReward = false;
         receiveBtnCanUse();
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         awards.removeEventListener("response",__responseHandler);
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               awards.dispose();
               awards = null;
         }
      }
      
      private function _getStrArr(dic:DictionaryData) : Array
      {
         var goodsArr:Array = dic[_vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1]];
         return goodsArr;
      }
      
      private function getVIPInfoTip(dic:DictionaryData) : Array
      {
         var resultGoodsArray:* = null;
         resultGoodsArray = PlayerManager.Instance.Self.VIPLevel == 12?[ItemManager.Instance.getTemplateById(int(_vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1])),ItemManager.Instance.getTemplateById(int(_vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 2]))]:[ItemManager.Instance.getTemplateById(int(_vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1])),ItemManager.Instance.getTemplateById(int(_vipChestsArr[PlayerManager.Instance.Self.VIPLevel]))];
         return resultGoodsArray;
      }
      
      private function receiveBtnCanUse() : void
      {
         if(PlayerManager.Instance.Self.IsVIP)
         {
            if(PlayerManager.Instance.Self.canTakeVipReward)
            {
               _receiveShin.alpha = 1;
               _receiveShin.visible = true;
               TweenMax.to(_receiveShin,0.5,{
                  "alpha":0,
                  "yoyo":true,
                  "repeat":-1
               });
            }
            else
            {
               _receiveShin.visible = false;
               TweenMax.killChildTweensOf(_receiveShin);
            }
         }
         else
         {
            _receiveShin.visible = false;
            TweenMax.killChildTweensOf(_receiveShin);
         }
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               VipController.instance.hide();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      public function hide() : void
      {
         if(_vipFrame != null)
         {
            _vipFrame.dispose();
         }
         _vipFrame = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_BG)
         {
            _BG.dispose();
         }
         _BG = null;
         if(_head)
         {
            _head.dispose();
            _head = null;
         }
         if(_vipViewBg1)
         {
            _vipViewBg1.dispose();
         }
         _vipViewBg1 = null;
         if(_vipViewBg2)
         {
            _vipViewBg2.dispose();
         }
         _vipViewBg2 = null;
         if(_receiveBtn)
         {
            _receiveBtn.dispose();
         }
         _receiveBtn = null;
         if(_openVipBtn)
         {
            _openVipBtn.dispose();
         }
         _openVipBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
