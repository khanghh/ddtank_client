package vip.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.manager.VipIntegralShopManager;
   import ddt.utils.PositionUtils;
   import ddt.view.bossbox.AwardsViewII;
   import ddt.view.bossbox.VipInfoTipBox;
   import ddtBuried.BuriedManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import vip.VipController;
   
   public class GiveYourselfOpenView extends Sprite implements Disposeable
   {
      
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
      
      public static var millisecondsPerDay:int = 86400000;
      
      public static var vip_reward_arr:Array;
      
      private static const ONE_MONTH_PAY:int = ServerConfigManager.instance.VIPRenewalPrice[0];
      
      private static const THREE_MONTH_PAY:int = ServerConfigManager.instance.VIPRenewalPrice[1];
      
      private static const HALF_YEAR_PAY:int = ServerConfigManager.instance.VIPRenewalPrice[2];
      
      private static const VIP_VALIDITY:int = 24;
       
      
      private var _BG:MutipleImage;
      
      protected var _showPayMoneyBG:Image;
      
      protected var _openVipBtn:BaseButton;
      
      protected var _renewalVipBtn:BaseButton;
      
      protected var _rewardBtn:BaseButton;
      
      private var _rewardEffet:IEffect;
      
      protected var _money:FilterFrameText;
      
      protected var _isSelf:Boolean;
      
      private var _halfYearBtn:SelectedButton;
      
      private var _threeMonthBtn:SelectedButton;
      
      private var _oneMonthBtn:SelectedButton;
      
      protected var _vipPrivilegeTxt:VipPrivilegeTxt;
      
      private var _vipPrivilegeTxtBg:Image;
      
      private var _openVipTimeBtnGroup:SelectedButtonGroup;
      
      private var _selectedBtnImage:Image;
      
      public var discountCode:int;
      
      private var _halfYearTxt:FilterFrameText;
      
      private var _threeMonthTxt:FilterFrameText;
      
      private var _oneMonthTxt:FilterFrameText;
      
      private var awards:AwardsViewII;
      
      private var alertFrame:BaseAlerFrame;
      
      private var _vipInfoTipBox:VipInfoTipBox;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _moneyConfirm:BaseAlerFrame;
      
      protected var days:int = 0;
      
      protected var payNum:int = 0;
      
      protected var time:String = "";
      
      public function GiveYourselfOpenView($discountCode:int = 0)
      {
         super();
         discountCode = $discountCode;
         _init();
      }
      
      public static function getVipinfo() : Array
      {
         var info:* = null;
         var i:int = 0;
         vip_reward_arr = [];
         for(i = 0; i < _vipChestsArr[i]; )
         {
            info = ItemManager.Instance.getTemplateById(_vipChestsArr[i]);
            vip_reward_arr.push(info);
            i++;
         }
         return vip_reward_arr;
      }
      
      private function _init() : void
      {
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _isSelf = true;
         initContent();
         addTextAndBtn();
         upPayMoneyText();
         showOpenOrRenewal();
         rewardBtnCanUse();
      }
      
      private function initContent() : void
      {
         _BG = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.BGI");
         _halfYearBtn = ComponentFactory.Instance.creatComponentByStylename("ddtvip.halfYearBtn");
         _threeMonthBtn = ComponentFactory.Instance.creatComponentByStylename("ddtvip.threeMonthBtn");
         _oneMonthBtn = ComponentFactory.Instance.creatComponentByStylename("ddtvip.oneMonthBtn");
         _halfYearTxt = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.halfYearTxt");
         _threeMonthTxt = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.threeMonthTxt");
         _oneMonthTxt = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.oneMonthTxt");
         _halfYearTxt.htmlText = LanguageMgr.GetTranslation("ddt.vipView.halfYearDiscount",int(PlayerManager.Instance.vipPriceArr[2]) > 0?PlayerManager.Instance.vipPriceArr[2]:HALF_YEAR_PAY);
         _threeMonthTxt.htmlText = LanguageMgr.GetTranslation("ddt.vipView.threeMonthDiscount",int(PlayerManager.Instance.vipPriceArr[1]) > 0?PlayerManager.Instance.vipPriceArr[1]:THREE_MONTH_PAY);
         _oneMonthTxt.htmlText = LanguageMgr.GetTranslation("ddt.vipView.oneMonthDiscount",int(PlayerManager.Instance.vipPriceArr[0]) > 0?PlayerManager.Instance.vipPriceArr[0]:ONE_MONTH_PAY);
         _vipPrivilegeTxtBg = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeTxtBg");
         _vipPrivilegeTxt = ComponentFactory.Instance.creatCustomObject("vip.vipPrivilegeTxt");
         _vipPrivilegeTxt.AlertContent = 6;
         _selectedBtnImage = ComponentFactory.Instance.creatComponentByStylename("vip.LevelPrivilegeView.selectedBtnImage");
         addChild(_BG);
         addChild(_halfYearBtn);
         addChild(_threeMonthBtn);
         addChild(_oneMonthBtn);
         addChild(_halfYearTxt);
         addChild(_threeMonthTxt);
         addChild(_oneMonthTxt);
         addChild(_vipPrivilegeTxtBg);
         addChild(_vipPrivilegeTxt);
         addChild(_selectedBtnImage);
         _openVipTimeBtnGroup = new SelectedButtonGroup();
         _openVipTimeBtnGroup.addSelectItem(_halfYearBtn);
         _openVipTimeBtnGroup.addSelectItem(_threeMonthBtn);
         _openVipTimeBtnGroup.addSelectItem(_oneMonthBtn);
         _openVipTimeBtnGroup.selectIndex = 0;
      }
      
      private function addTextAndBtn() : void
      {
         _money = ComponentFactory.Instance.creat("GiveYourselfOpenView.money");
         _openVipBtn = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.openVipBtn");
         _renewalVipBtn = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.renewalVipBtn");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.rewardBtn");
         addChild(_openVipBtn);
         addChild(_renewalVipBtn);
         addChild(_rewardBtn);
         _money.text = PlayerManager.Instance.Self.Money + LanguageMgr.GetTranslation("money");
      }
      
      protected function showOpenOrRenewal() : void
      {
         if(_isSelf)
         {
            if(PlayerManager.Instance.Self.VIPExp <= 0 && !PlayerManager.Instance.Self.IsVIP)
            {
               _openVipBtn.visible = true;
               _renewalVipBtn.visible = false;
            }
            else
            {
               _openVipBtn.visible = false;
               _renewalVipBtn.visible = true;
            }
         }
         else
         {
            _openVipBtn.visible = true;
            _renewalVipBtn.visible = false;
         }
      }
      
      protected function rewardBtnCanUse() : void
      {
         if(_isSelf && PlayerManager.Instance.Self.IsVIP)
         {
            PositionUtils.setPos(_openVipBtn,"vip.rewardState.OpenRenewalBtnPos");
            PositionUtils.setPos(_renewalVipBtn,"vip.rewardState.OpenRenewalBtnPos");
         }
         else
         {
            PositionUtils.setPos(_openVipBtn,"vip.normalState.OpenRenewalBtnPos");
            PositionUtils.setPos(_renewalVipBtn,"vip.normalState.OpenRenewalBtnPos");
         }
      }
      
      private function initEvent() : void
      {
         _openVipBtn.addEventListener("click",__openVip);
         _renewalVipBtn.addEventListener("click",__openVip);
         _openVipTimeBtnGroup.addEventListener("change",__upPayNum);
         _rewardBtn.addEventListener("click",__reward);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
      }
      
      private function removeEvent() : void
      {
         _openVipBtn.removeEventListener("click",__openVip);
         _renewalVipBtn.removeEventListener("click",__openVip);
         _openVipTimeBtnGroup.removeEventListener("change",__upPayNum);
         _rewardBtn.removeEventListener("click",__reward);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
      }
      
      private function __reward(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         VipIntegralShopManager.Instance.show();
      }
      
      private function __alertHandler(evt:FrameEvent) : void
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
      
      private function __responseVipInfoTipHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _vipInfoTipBox.removeEventListener("response",__responseHandler);
         switch(int(evt.responseCode))
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
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         awards.removeEventListener("response",__responseHandler);
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               awards.dispose();
               awards = null;
         }
      }
      
      private function showAwards(para:ItemTemplateInfo) : void
      {
         awards = ComponentFactory.Instance.creat("vip.awardFrame");
         awards.escEnable = true;
         awards.boxType = 2;
         awards.vipAwardGoodsList = _getStrArr(BossBoxManager.instance.inventoryItemList);
         awards.addEventListener("_haveBtnClick",__sendReward);
         awards.addEventListener("response",__responseHandler);
         LayerManager.Instance.addToLayer(awards,3,true,1);
      }
      
      private function __sendReward(evt:Event) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendDailyAward(3);
         awards.removeEventListener("_haveBtnClick",__sendReward);
         awards.dispose();
         PlayerManager.Instance.Self.canTakeVipReward = false;
         rewardBtnCanUse();
      }
      
      private function __propertyChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["Money"])
         {
            _money.text = PlayerManager.Instance.Self.Money + LanguageMgr.GetTranslation("money");
         }
         if(evt.changedProperties["isVip"] || evt.changedProperties["canTakeVipReward"])
         {
            showOpenOrRenewal();
            rewardBtnCanUse();
         }
      }
      
      private function __upPayNum(e:Event) : void
      {
         SoundManager.instance.play("008");
         upPayMoneyText();
      }
      
      protected function __openVip(evt:MouseEvent) : void
      {
         var curTime:Number = NaN;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         upPayMoneyText();
         upPayMoneyText();
         var isCanUse:* = false;
         var temCoupons:int = PlayerManager.Instance.Self.vipDiscount;
         var useDate:Date = PlayerManager.Instance.Self.vipDiscountValidity;
         var endDate:Date = new Date(useDate.time);
         var _loc10_:String = "hours";
         var _loc11_:* = endDate[_loc10_] + 24;
         endDate[_loc10_] = _loc11_;
         if(useDate != null)
         {
            curTime = TimeManager.Instance.Now().getTime();
            isCanUse = endDate.getTime() >= curTime;
         }
         var totalPoint:int = payNum;
         var couponsPoint:int = 0;
         if(temCoupons > 0 && isCanUse)
         {
            payNum = totalPoint * temCoupons / 10;
            couponsPoint = totalPoint - payNum;
         }
         var msg:String = LanguageMgr.GetTranslation("ddt.vip.vipView.confirmforSelf",time,payNum);
         if(temCoupons > 0 && isCanUse)
         {
            msg = msg + ("\n" + LanguageMgr.GetTranslation("ddt.vip.vipView.useVipCoupons.tipMsg",couponsPoint));
         }
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.vip.vipFrame.ConfirmTitle"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1,null,"SimpleAlert",30,true);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirm);
      }
      
      private function __moneyConfirmHandler(evt:FrameEvent) : void
      {
         _moneyConfirm.removeEventListener("response",__moneyConfirmHandler);
         switch(int(evt.responseCode) - 2)
         {
            case 0:
            case 1:
               LeavePageManager.leaveToFillPath();
         }
         _moneyConfirm.dispose();
         if(_moneyConfirm.parent)
         {
            _moneyConfirm.parent.removeChild(_moneyConfirm);
         }
         _moneyConfirm = null;
      }
      
      private function __confirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode) - 2)
         {
            case 0:
            case 1:
               if(BuriedManager.Instance.checkMoney(_confirmFrame.isBand,payNum))
               {
                  return;
               }
               sendVip();
               upVipDiscount();
               upPayMoneyText();
               break;
         }
         _confirmFrame.removeEventListener("response",__confirm);
         _confirmFrame.dispose();
         if(_confirmFrame.parent)
         {
            _confirmFrame.parent.removeChild(_confirmFrame);
         }
      }
      
      private function upVipDiscount() : void
      {
         PlayerManager.Instance.Self.vipDiscount = 0;
      }
      
      protected function sendVip() : void
      {
         days = 0;
         switch(int(_openVipTimeBtnGroup.selectIndex))
         {
            case 0:
               days = 180;
               break;
            case 1:
               days = 90;
               break;
            case 2:
               days = 30;
         }
         send();
      }
      
      protected function send() : void
      {
         VipController.instance.sendOpenVip(PlayerManager.Instance.Self.NickName,days,_confirmFrame.isBand);
      }
      
      protected function upPayMoneyText() : void
      {
         payNum = 0;
         time = "";
         payNum = PlayerManager.Instance.vipPriceArr[2 - _openVipTimeBtnGroup.selectIndex];
         switch(int(_openVipTimeBtnGroup.selectIndex))
         {
            case 0:
               time = "Nửa năm";
               _vipPrivilegeTxt.AlertContent = 6;
               break;
            case 1:
               time = "3 tháng";
               _vipPrivilegeTxt.AlertContent = 4;
               break;
            case 2:
               time = "1 tháng";
               _vipPrivilegeTxt.AlertContent = 1;
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
         resultGoodsArray = PlayerManager.Instance.Self.VIPLevel == 12?[ItemManager.Instance.getTemplateById(int(_vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 2])),ItemManager.Instance.getTemplateById(int(_vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1]))]:[ItemManager.Instance.getTemplateById(int(_vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1])),ItemManager.Instance.getTemplateById(int(_vipChestsArr[PlayerManager.Instance.Self.VIPLevel]))];
         return resultGoodsArray;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_halfYearBtn);
         _halfYearBtn = null;
         ObjectUtils.disposeObject(_threeMonthBtn);
         _threeMonthBtn = null;
         ObjectUtils.disposeObject(_oneMonthBtn);
         _oneMonthBtn = null;
         ObjectUtils.disposeObject(_halfYearTxt);
         _halfYearTxt = null;
         ObjectUtils.disposeObject(_threeMonthTxt);
         _threeMonthTxt = null;
         ObjectUtils.disposeObject(_oneMonthTxt);
         _oneMonthTxt = null;
         ObjectUtils.disposeObject(_vipPrivilegeTxt);
         _vipPrivilegeTxt = null;
         ObjectUtils.disposeObject(_vipPrivilegeTxtBg);
         _vipPrivilegeTxtBg = null;
         ObjectUtils.disposeObject(_selectedBtnImage);
         _selectedBtnImage = null;
         if(_rewardEffet)
         {
            _rewardEffet.dispose();
         }
         _rewardEffet = null;
         if(_openVipBtn)
         {
            ObjectUtils.disposeObject(_openVipBtn);
         }
         _openVipBtn = null;
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_money)
         {
            ObjectUtils.disposeObject(_money);
         }
         _money = null;
         if(_showPayMoneyBG)
         {
            ObjectUtils.disposeObject(_showPayMoneyBG);
         }
         _showPayMoneyBG = null;
         if(_confirmFrame)
         {
            _confirmFrame.dispose();
         }
         _confirmFrame = null;
         if(_moneyConfirm)
         {
            _moneyConfirm.dispose();
         }
         _moneyConfirm = null;
         if(_renewalVipBtn)
         {
            ObjectUtils.disposeObject(_renewalVipBtn);
         }
         _renewalVipBtn = null;
         if(_rewardBtn)
         {
            ObjectUtils.disposeObject(_rewardBtn);
         }
         _rewardBtn = null;
         if(alertFrame)
         {
            alertFrame.dispose();
         }
         alertFrame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
