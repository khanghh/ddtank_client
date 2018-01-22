package vip.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.OpitionEnum;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.PlayerPortraitView;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import vip.VipController;
   
   public class VipFrameHead extends Sprite implements Disposeable
   {
      
      private static var eachLevelEXP:Array = [0,150,350,700,1250,2050,3050,4250,5650];
       
      
      private var _topBG:DisplayObject;
      
      private var _selfName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _ClockImg:Bitmap;
      
      private var _dueTime:FilterFrameText;
      
      private var _vipLevelProgress:VipLevelProgress;
      
      private var _noticeOnVip12LoginSelectedBtn:SelectedButton;
      
      private var _noticeOnVip12LoginText:FilterFrameText;
      
      private var _vipHelpBtn:TextButton;
      
      private var _vipRuleDescriptionBtn:TextButton;
      
      private var _selfLevel:FilterFrameText;
      
      private var _nextLevel:FilterFrameText;
      
      private var _dueDataWord:FilterFrameText;
      
      private var _dueData:FilterFrameText;
      
      private var _DueTipSprite:Sprite;
      
      private var _DueTip:OneLineTip;
      
      private var _portrait:PlayerPortraitView;
      
      private var _isVipRechargeShow:Boolean = false;
      
      private var _isShowReward:Boolean = false;
      
      private var _descriptionFrame:Frame;
      
      private var _frameBg:Scale9CornerImage;
      
      private var _okBtn:TextButton;
      
      private var _contenttxt:MovieImage;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _getIntegralBtn:BaseButton;
      
      private var _helpFrame:VIPHelpFrame;
      
      public function VipFrameHead(param1:Boolean = false, param2:Boolean = true)
      {
         super();
         _isVipRechargeShow = param1;
         _isShowReward = param2;
         init();
      }
      
      private function init() : void
      {
         if(_isVipRechargeShow)
         {
            _topBG = ComponentFactory.Instance.creatComponentByStylename("VIPFrame.topReChargeBG");
         }
         else
         {
            _topBG = ComponentFactory.Instance.creatComponentByStylename("VIPFrame.topBG");
         }
         _selfName = ComponentFactory.Instance.creat("VipStatusView.name");
         _vipIcon = ComponentFactory.Instance.creatCustomObject("VipStatusView.vipIcon");
         _ClockImg = ComponentFactory.Instance.creatBitmap("asset.vip.timeBitmap");
         _dueTime = ComponentFactory.Instance.creat("VIPFrame.dueTime");
         _vipLevelProgress = ComponentFactory.Instance.creat("VIPFrame.vipLevelProgress");
         if(!_isVipRechargeShow)
         {
            _dueDataWord = ComponentFactory.Instance.creatComponentByStylename("VipStatusView.dueDateFontTxt");
            _dueDataWord.text = LanguageMgr.GetTranslation("ddt.vip.dueDateFontTxt");
            _dueData = ComponentFactory.Instance.creat("VipStatusView.dueDate");
            _vipHelpBtn = ComponentFactory.Instance.creatComponentByStylename("VipStatusView.vipHelp");
            _vipHelpBtn.text = LanguageMgr.GetTranslation("ddt.vip.vipHelpBtn");
            _vipRuleDescriptionBtn = ComponentFactory.Instance.creatComponentByStylename("vipHead.RuleDescriptionBtn");
            _vipRuleDescriptionBtn.text = LanguageMgr.GetTranslation("ddt.vip.vipFrameHead.VipPrivilegeTxt");
         }
         if(PlayerManager.Instance.Self.VIPLevel >= 12 && PlayerManager.Instance.Self.IsVIP)
         {
            _noticeOnVip12LoginSelectedBtn = ComponentFactory.Instance.creat("ddtvip.NoticeVip12LoginCheckBtn");
            _noticeOnVip12LoginSelectedBtn.selected = OpitionEnum.getOptionEnumState(256) == 0;
            _noticeOnVip12LoginText = ComponentFactory.Instance.creat("ddtvip.UnselectText");
            if(PlayerManager.Instance.Self.VIPLevel >= 14)
            {
               _noticeOnVip12LoginText.text = LanguageMgr.GetTranslation("ddt.vip.vip14notice");
            }
            else
            {
               _noticeOnVip12LoginText.text = LanguageMgr.GetTranslation("ddt.vip.vip12notice");
            }
         }
         _selfLevel = ComponentFactory.Instance.creat("VipStatusView.selfLevel");
         _nextLevel = ComponentFactory.Instance.creat("VipStatusView.nextLevel");
         _portrait = ComponentFactory.Instance.creatCustomObject("vip.PortraitView",["right"]);
         _portrait.info = PlayerManager.Instance.Self;
         addChild(_topBG);
         addChild(_portrait);
         addChild(_vipLevelProgress);
         if(_noticeOnVip12LoginSelectedBtn)
         {
            addChildAt(_noticeOnVip12LoginSelectedBtn,1);
         }
         if(_noticeOnVip12LoginText)
         {
            addChildAt(_noticeOnVip12LoginText,1);
         }
         if(!_isVipRechargeShow)
         {
            addChild(_vipRuleDescriptionBtn);
            addChild(_dueDataWord);
            addChild(_dueData);
         }
         addChild(_selfLevel);
         addTipSprite();
         upView();
         if(_portrait.info.isAttest)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
            _attestBtn.x = _vipIcon.x + 37;
            _attestBtn.y = _vipIcon.y;
            addChild(_attestBtn);
         }
         creatGetIntegralBtn();
         addEvent();
      }
      
      private function creatGetIntegralBtn() : void
      {
         var _loc1_:int = 0;
         if(_isShowReward)
         {
            _getIntegralBtn = ComponentFactory.Instance.creatComponentByStylename("vip.getIntegralBtn");
            _loc1_ = _portrait.info.VIPLevel;
            if(_loc1_ >= 15)
            {
               _getIntegralBtn.tipData = LanguageMgr.GetTranslation("vipIntegralShopView.getReward.tipsText2",ServerConfigManager.instance.getVipIntegral()[_loc1_ - 1]);
            }
            else
            {
               _getIntegralBtn.tipData = LanguageMgr.GetTranslation("vipIntegralShopView.getReward.tipsText1",ServerConfigManager.instance.getVipIntegral()[_loc1_ - 1],ServerConfigManager.instance.getVipIntegral()[_loc1_]);
            }
            addChild(_getIntegralBtn);
            _getIntegralBtn.enable = PlayerManager.Instance.Self.canTakeVipReward;
         }
      }
      
      private function addTipSprite() : void
      {
         _DueTipSprite = new Sprite();
         _DueTipSprite.graphics.beginFill(0,0);
         _DueTipSprite.graphics.drawRect(0,0,_vipLevelProgress.width,_vipLevelProgress.height);
         _DueTipSprite.graphics.endFill();
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("Vip.DueTipSpritePos");
         _DueTipSprite.x = _loc1_.x;
         _DueTipSprite.y = _loc1_.y;
         addChild(_DueTipSprite);
         _DueTip = new OneLineTip();
         addChild(_DueTip);
         _DueTip.x = _DueTipSprite.x;
         _DueTip.y = _DueTipSprite.y + 25;
         _DueTip.visible = false;
      }
      
      private function addEvent() : void
      {
         PlayerManager.Instance.addEventListener("VIPStateChange",vipStateChange);
         _noticeOnVip12LoginSelectedBtn && _noticeOnVip12LoginSelectedBtn.addEventListener("select",onSelectedChange);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
         if(_vipHelpBtn)
         {
            _vipHelpBtn.addEventListener("click",__showHelpFrame);
         }
         if(_vipRuleDescriptionBtn)
         {
            _vipRuleDescriptionBtn.addEventListener("click",__helpHandler);
         }
         _DueTipSprite.addEventListener("mouseOver",__showDueTip);
         _DueTipSprite.addEventListener("mouseOut",__hideDueTip);
         if(_getIntegralBtn != null)
         {
            _getIntegralBtn.addEventListener("click",__onGetIntegralClick);
         }
      }
      
      protected function __onGetIntegralClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("vipIntegralShopView.getReward.tipsText3",ServerConfigManager.instance.getVipIntegral()[_portrait.info.VIPLevel - 1]));
         SocketManager.Instance.out.sendDailyAward(3);
         PlayerManager.Instance.Self.canTakeVipReward = false;
         _getIntegralBtn.enable = false;
      }
      
      protected function onSelectedChange(param1:Event) : void
      {
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _descriptionFrame = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeFrame");
         LayerManager.Instance.addToLayer(_descriptionFrame,3,true,2);
      }
      
      private function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            disposeHelpFrame();
         }
      }
      
      private function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function disposeHelpFrame() : void
      {
         _okBtn.removeEventListener("click",__closeHelpFrame);
         _descriptionFrame.dispose();
         _okBtn = null;
         _contenttxt = null;
         _descriptionFrame = null;
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.removeEventListener("VIPStateChange",vipStateChange);
         _noticeOnVip12LoginSelectedBtn && _noticeOnVip12LoginSelectedBtn.removeEventListener("select",onSelectedChange);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         if(_vipHelpBtn)
         {
            _vipHelpBtn.removeEventListener("click",__showHelpFrame);
         }
         if(_DueTipSprite)
         {
            _DueTipSprite.removeEventListener("mouseOver",__showDueTip);
            _DueTipSprite.removeEventListener("mouseOut",__hideDueTip);
         }
         if(_getIntegralBtn != null)
         {
            _getIntegralBtn.removeEventListener("click",__onGetIntegralClick);
         }
      }
      
      protected function vipStateChange(param1:Event) : void
      {
         if(PlayerManager.Instance.Self.IsVIP)
         {
            if(PlayerManager.Instance.Self.VIPLevel == 12)
            {
               if(!_noticeOnVip12LoginSelectedBtn)
               {
                  _noticeOnVip12LoginSelectedBtn = ComponentFactory.Instance.creat("ddtvip.NoticeVip12LoginCheckBtn");
                  _noticeOnVip12LoginSelectedBtn.selected = OpitionEnum.getOptionEnumState(256) == 0;
                  _noticeOnVip12LoginText = ComponentFactory.Instance.creat("ddtvip.UnselectText");
                  _noticeOnVip12LoginText.text = LanguageMgr.GetTranslation("ddt.vip.vip12notice");
                  addChildAt(_noticeOnVip12LoginSelectedBtn,1);
                  addChildAt(_noticeOnVip12LoginText,1);
                  _noticeOnVip12LoginSelectedBtn.addEventListener("select",onSelectedChange);
               }
            }
            if(_getIntegralBtn != null)
            {
               _getIntegralBtn.enable = PlayerManager.Instance.Self.canTakeVipReward;
            }
         }
      }
      
      private function __showDueTip(param1:MouseEvent) : void
      {
         _DueTip.visible = true;
      }
      
      private function __hideDueTip(param1:MouseEvent) : void
      {
         _DueTip.visible = false;
      }
      
      private function __showHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _helpFrame = ComponentFactory.Instance.creatComponentByStylename("vip.viphelpFrame");
         _helpFrame.show();
         _helpFrame.addEventListener("response",__responseHandler);
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         _helpFrame.removeEventListener("response",__responseHandler);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _helpFrame.dispose();
               _helpFrame = null;
         }
      }
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["isVip"] || param1.changedProperties["VipExpireDay"] || param1.changedProperties["VIPNextLevelDaysNeeded"])
         {
            _portrait.info = PlayerManager.Instance.Self;
            upView();
         }
      }
      
      private function upView() : void
      {
         var _loc1_:int = 0;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         if(_portrait.info.VIPLevel != 15 && _portrait.info.IsVIP)
         {
            _loc1_ = ServerConfigManager.instance.VIPExpNeededForEachLv[_portrait.info.VIPLevel] - _portrait.info.VIPExp;
            _DueTip.tipData = LanguageMgr.GetTranslation("ddt.vip.dueTime.tip",_loc1_,_portrait.info.VIPLevel + 1);
         }
         else if(!_portrait.info.IsVIP)
         {
            _DueTip.tipData = LanguageMgr.GetTranslation("ddt.vip.vipIcon.reduceVipExp");
         }
         else
         {
            _DueTip.tipData = LanguageMgr.GetTranslation("ddt.vip.vipIcon.upGradFull");
         }
         if(!_portrait.info.IsVIP && _portrait.info.VIPExp <= 0)
         {
            _DueTip.tipData = LanguageMgr.GetTranslation("ddt.vip.vipFrame.youarenovip");
         }
         _selfName.text = _portrait.info.NickName;
         if(_portrait.info.IsVIP)
         {
            if(_vipName)
            {
               ObjectUtils.disposeObject(_vipName);
            }
            _vipName = VipController.instance.getVipNameTxt(263,_portrait.info.typeVIP);
            _vipName.textSize = 18;
            _vipName.x = _selfName.x;
            _vipName.y = _selfName.y;
            _vipName.text = _selfName.text;
            addChild(_vipName);
            DisplayUtils.removeDisplay(_selfName);
         }
         else
         {
            addChild(_selfName);
            DisplayUtils.removeDisplay(_vipName);
         }
         _vipIcon.setInfo(_portrait.info,true,true);
         if(_portrait.info.IsVIP)
         {
            _vipIcon.x = _vipName.x + _vipName.textWidth + 15;
         }
         else
         {
            _vipIcon.x = _selfName.x + _selfName.textWidth + 15;
         }
         addChild(_vipIcon);
         _selfLevel.text = "LV:" + _portrait.info.VIPLevel;
         _nextLevel.text = "LV:" + (_portrait.info.VIPLevel + 1);
         if(!_isVipRechargeShow)
         {
            _loc6_ = PlayerManager.Instance.Self.VIPExpireDay as Date;
            _dueData.text = _loc6_.fullYear + "-" + (_loc6_.month + 1) + "-" + _loc6_.date;
         }
         if(!_portrait.info.IsVIP && !_isVipRechargeShow)
         {
            _dueData.text = "";
         }
         if(_portrait.info.VIPLevel == 15)
         {
            _nextLevel.text = "";
         }
         if(!_portrait.info.IsVIP && _portrait.info.VIPExp <= 0)
         {
            _dueTime.text = 0 + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
         }
         else
         {
            _dueTime.text = PlayerManager.Instance.Self.VIPNextLevelDaysNeeded + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
         }
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = _portrait.info.VIPLevel;
         if(_portrait.info.VIPLevel == 15)
         {
            _loc2_ = ServerConfigManager.instance.VIPExpNeededForEachLv[11] - ServerConfigManager.instance.VIPExpNeededForEachLv[10];
            _vipLevelProgress.setProgress(1,1);
            _vipLevelProgress.labelText = _loc2_ + "/" + _loc2_;
         }
         else
         {
            _loc4_ = _portrait.info.VIPExp - ServerConfigManager.instance.VIPExpNeededForEachLv[_loc5_ - 1];
            _loc3_ = ServerConfigManager.instance.VIPExpNeededForEachLv[_loc5_] - ServerConfigManager.instance.VIPExpNeededForEachLv[_loc5_ - 1];
            _vipLevelProgress.setProgress(_loc4_,_loc3_);
            _vipLevelProgress.labelText = _loc4_ + "/" + _loc3_;
         }
         grayOrLightVIP();
         if(_getIntegralBtn != null)
         {
            _getIntegralBtn.enable = PlayerManager.Instance.Self.canTakeVipReward;
         }
      }
      
      private function grayOrLightVIP() : void
      {
         if(!_portrait.info.IsVIP)
         {
            _vipIcon.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _vipLevelProgress.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            _vipIcon.filters = null;
            _vipLevelProgress.filters = null;
         }
      }
      
      public function dispose() : void
      {
         if(_noticeOnVip12LoginSelectedBtn != null)
         {
            PlayerManager.Instance.Self.OptionOnOff = OpitionEnum.setOpitionState(!_noticeOnVip12LoginSelectedBtn.selected,256);
            SocketManager.Instance.out.sendOpition(PlayerManager.Instance.Self.OptionOnOff);
            ObjectUtils.disposeObject(_noticeOnVip12LoginSelectedBtn);
            _noticeOnVip12LoginSelectedBtn = null;
         }
         removeEvent();
         if(_topBG)
         {
            ObjectUtils.disposeObject(_topBG);
         }
         _topBG = null;
         if(_vipIcon)
         {
            ObjectUtils.disposeObject(_vipIcon);
         }
         _vipIcon = null;
         if(_ClockImg)
         {
            ObjectUtils.disposeObject(_ClockImg);
         }
         _ClockImg = null;
         if(_dueTime)
         {
            ObjectUtils.disposeObject(_dueTime);
         }
         _dueTime = null;
         if(_vipLevelProgress)
         {
            ObjectUtils.disposeObject(_vipLevelProgress);
         }
         _vipLevelProgress = null;
         if(_noticeOnVip12LoginText)
         {
            ObjectUtils.disposeObject(_noticeOnVip12LoginText);
         }
         _noticeOnVip12LoginText = null;
         if(_vipHelpBtn)
         {
            ObjectUtils.disposeObject(_vipHelpBtn);
            _vipHelpBtn = null;
         }
         if(_selfLevel)
         {
            ObjectUtils.disposeObject(_selfLevel);
         }
         _selfLevel = null;
         if(_nextLevel)
         {
            ObjectUtils.disposeObject(_nextLevel);
         }
         _nextLevel = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         if(_DueTipSprite)
         {
            ObjectUtils.disposeObject(_DueTipSprite);
         }
         _DueTipSprite = null;
         if(_DueTip)
         {
            ObjectUtils.disposeObject(_DueTip);
         }
         _DueTip = null;
         if(_dueDataWord)
         {
            ObjectUtils.disposeObject(_dueDataWord);
         }
         _dueDataWord = null;
         if(_dueData)
         {
            ObjectUtils.disposeObject(_dueData);
         }
         _dueData = null;
         if(_helpFrame)
         {
            _helpFrame.dispose();
         }
         _helpFrame = null;
         if(_vipRuleDescriptionBtn)
         {
            _vipRuleDescriptionBtn.dispose();
         }
         _vipRuleDescriptionBtn = null;
         if(_attestBtn)
         {
            _attestBtn.dispose();
         }
         _attestBtn = null;
         if(parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_portrait);
      }
   }
}
