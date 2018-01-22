package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.FilterFrameTextWithTips;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortion.ConsortionModelManager;
   import consortion.event.ConsortionEvent;
   import ddt.data.ConsortiaInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import road7th.utils.StringHelper;
   import vip.VipController;
   
   public class ConsortionInfoView extends Sprite implements Disposeable
   {
       
      
      private var _badgeBtn:BuyBadgeButton;
      
      private var _shopIcon:BuildingLevelItem;
      
      private var _storeIcon:BuildingLevelItem;
      
      private var _bankIcon:BuildingLevelItem;
      
      private var _skillIcon:BuildingLevelItem;
      
      private var _infoWordBG:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _consortionName:FilterFrameText;
      
      private var _level:ScaleFrameImage;
      
      private var _consortionNameInput:FilterFrameText;
      
      private var _chairmanName:FilterFrameText;
      
      private var _vipChairman:GradientText;
      
      private var _count:FilterFrameText;
      
      private var _riches:FilterFrameText;
      
      private var _honor:FilterFrameText;
      
      private var _repute:FilterFrameText;
      
      private var _weekPay:FilterFrameTextWithTips;
      
      private var _consortiaInfo:ConsortiaInfo;
      
      private var _BG2:ScaleBitmapImage;
      
      private var _chairmanText:FilterFrameText;
      
      private var _numberText:FilterFrameText;
      
      private var _richesText:FilterFrameText;
      
      private var _exploitText:FilterFrameText;
      
      private var _rankingText:FilterFrameText;
      
      private var _holdText:FilterFrameText;
      
      private var _chairmanTextInputBg:Scale9CornerImage;
      
      private var _numberTextInputBg:Scale9CornerImage;
      
      private var _richesTextInputBg:Scale9CornerImage;
      
      private var _exploitTextInputBg:Scale9CornerImage;
      
      private var _rankingTextInputBg:Scale9CornerImage;
      
      private var _holdTextInputBg:Scale9CornerImage;
      
      private var _activeBtn:SimpleBitmapButton;
      
      private var _activeBg:ScaleLeftRightImage;
      
      public function ConsortionInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _badgeBtn = new BuyBadgeButton();
         PositionUtils.setPos(_badgeBtn,"consortiaBadgeBtn.pos");
         _shopIcon = new BuildingLevelItem(1);
         PositionUtils.setPos(_shopIcon,"shopIcon.pos");
         _storeIcon = new BuildingLevelItem(2);
         PositionUtils.setPos(_storeIcon,"storeIcon.pos");
         _bankIcon = new BuildingLevelItem(3);
         PositionUtils.setPos(_bankIcon,"bankIcon.pos");
         _skillIcon = new BuildingLevelItem(4);
         PositionUtils.setPos(_skillIcon,"skillIcon.pos");
         _infoWordBG = ComponentFactory.Instance.creat("consortion.wordBG");
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortion.level");
         _level = ComponentFactory.Instance.creatComponentByStylename("consortion.level");
         _consortionName = ComponentFactory.Instance.creatComponentByStylename("consortion.nameText");
         _consortionName.text = LanguageMgr.GetTranslation("tank.consortionClub.MemberListTitleText1.text");
         _consortionNameInput = ComponentFactory.Instance.creatComponentByStylename("consortion.nameInputText");
         _chairmanName = ComponentFactory.Instance.creatComponentByStylename("consortion.chairmanName");
         _BG2 = ComponentFactory.Instance.creatComponentByStylename("consortion.consortionInfoView.bg");
         _chairmanText = ComponentFactory.Instance.creatComponentByStylename("consortion.chairmanText");
         _chairmanText.text = LanguageMgr.GetTranslation("tanl.consortion.chairmanText.text");
         _numberText = ComponentFactory.Instance.creatComponentByStylename("consortion.numberText");
         _numberText.text = LanguageMgr.GetTranslation("tanl.consortion.numberText.text");
         _richesText = ComponentFactory.Instance.creatComponentByStylename("consortion.richesText");
         _richesText.text = LanguageMgr.GetTranslation("tanl.consortion.richesText.text");
         _exploitText = ComponentFactory.Instance.creatComponentByStylename("consortion.exploitText");
         _exploitText.text = LanguageMgr.GetTranslation("tanl.consortion.exploitText.text");
         _rankingText = ComponentFactory.Instance.creatComponentByStylename("consortion.rankingText");
         _rankingText.text = LanguageMgr.GetTranslation("tanl.consortion.rankingText.text");
         _holdText = ComponentFactory.Instance.creatComponentByStylename("consortion.holdText");
         _holdText.text = LanguageMgr.GetTranslation("tanl.consortion.holdText.text");
         _chairmanTextInputBg = ComponentFactory.Instance.creat("consortion.chairmanTextInputBg");
         _numberTextInputBg = ComponentFactory.Instance.creat("consortion.numberTextInputBg");
         _richesTextInputBg = ComponentFactory.Instance.creat("consortion.richesTextInputBg");
         _exploitTextInputBg = ComponentFactory.Instance.creat("consortion.exploitTextInputBg");
         _rankingTextInputBg = ComponentFactory.Instance.creat("consortion.rankingTextInputBg");
         _holdTextInputBg = ComponentFactory.Instance.creat("consortion.holdTextInputBg");
         _count = ComponentFactory.Instance.creatComponentByStylename("consortion.count");
         _riches = ComponentFactory.Instance.creatComponentByStylename("consortion.riches");
         _honor = ComponentFactory.Instance.creatComponentByStylename("consortion.offer");
         _repute = ComponentFactory.Instance.creatComponentByStylename("consortion.repute");
         _weekPay = ComponentFactory.Instance.creatComponentByStylename("consortion.weekPay");
         _weekPay.mouseEnabled = true;
         _weekPay.selectable = false;
         addChild(_badgeBtn);
         addChild(_shopIcon);
         addChild(_storeIcon);
         addChild(_bankIcon);
         addChild(_skillIcon);
         addChild(_infoWordBG);
         addChild(_bg);
         addChild(_level);
         addChild(_consortionName);
         addChild(_consortionNameInput);
         addChild(_BG2);
         addChild(_chairmanText);
         addChild(_numberText);
         addChild(_richesText);
         addChild(_exploitText);
         addChild(_rankingText);
         addChild(_holdText);
         addChild(_chairmanTextInputBg);
         addChild(_numberTextInputBg);
         addChild(_richesTextInputBg);
         addChild(_exploitTextInputBg);
         addChild(_rankingTextInputBg);
         addChild(_holdTextInputBg);
         addChild(_count);
         addChild(_riches);
         addChild(_honor);
         addChild(_repute);
         addChild(_weekPay);
         consortionInfo = PlayerManager.Instance.Self.consortiaInfo;
         SocketManager.Instance.out.getConsortiaDomainConsortiaInfo();
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",_consortiaInfoChange);
         PlayerManager.Instance.Self.consortiaInfo.addEventListener("propertychange",__consortiaInfoPropChange);
         ConsortionModelManager.Instance.model.addEventListener("levelUpRuleChange",_levelUpRuleChange);
         ConsortiaDomainManager.instance.addEventListener("event_get_consortia_info_res",onGetConsortiaInfoRes);
         ConsortiaDomainManager.instance.addEventListener("event_active_res",onActiveRes);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",_consortiaInfoChange);
         PlayerManager.Instance.Self.consortiaInfo.removeEventListener("propertychange",__consortiaInfoPropChange);
         ConsortionModelManager.Instance.model.removeEventListener("levelUpRuleChange",_levelUpRuleChange);
         ConsortiaDomainManager.instance.removeEventListener("event_get_consortia_info_res",onGetConsortiaInfoRes);
         ConsortiaDomainManager.instance.removeEventListener("event_active_res",onActiveRes);
         if(_activeBtn)
         {
            _activeBtn.removeEventListener("click",onClickActiveBtn);
         }
      }
      
      private function onGetConsortiaInfoRes(param1:Event) : void
      {
         if(!ConsortiaDomainManager.instance.model.isActive)
         {
            _activeBg = UICreatShortcut.creatAndAdd("consortionDomain.activeBg",this);
            _activeBtn = UICreatShortcut.creatAndAdd("consortionDomain.activeBtn",this);
            _activeBtn.addEventListener("click",onClickActiveBtn);
         }
         consortionInfo = PlayerManager.Instance.Self.consortiaInfo;
      }
      
      private function onClickActiveBtn(param1:MouseEvent) : void
      {
         SocketManager.Instance.out.sendConsortiaDomainActive();
      }
      
      private function onActiveRes(param1:Event) : void
      {
         if(ConsortiaDomainManager.instance.model.isActive)
         {
            ObjectUtils.disposeObject(_activeBg);
            ObjectUtils.disposeObject(_activeBtn);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortiadomain.activateSuccess"));
         }
      }
      
      private function _levelUpRuleChange(param1:ConsortionEvent) : void
      {
         setWeekyPay();
      }
      
      private function _consortiaInfoChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["consortiaInfo"])
         {
            consortionInfo = PlayerManager.Instance.Self.consortiaInfo;
         }
      }
      
      private function __consortiaInfoPropChange(param1:PlayerPropertyEvent) : void
      {
         consortionInfo = PlayerManager.Instance.Self.consortiaInfo;
      }
      
      private function setWeekyPay() : void
      {
         if(_consortiaInfo && _consortiaInfo.Level != 0 && ConsortionModelManager.Instance.model.levelUpData != null)
         {
            _weekPay.text = String(ConsortionModelManager.Instance.model.getLevelData(_consortiaInfo.Level).Deduct);
            if(_weekPay.text != "")
            {
               _weekPay.mouseEnabled = true;
            }
            else
            {
               _weekPay.mouseEnabled = false;
            }
            _weekPay.tipData = StringHelper.parseTime(_consortiaInfo.DeductDate,7);
         }
      }
      
      private function set consortionInfo(param1:ConsortiaInfo) : void
      {
         var _loc2_:* = null;
         _consortiaInfo = param1;
         if(param1.ConsortiaID != 0)
         {
            var _loc3_:* = true;
            _skillIcon.mouseEnabled = _loc3_;
            _loc3_ = _loc3_;
            _skillIcon.mouseChildren = _loc3_;
            _loc3_ = _loc3_;
            _bankIcon.mouseEnabled = _loc3_;
            _loc3_ = _loc3_;
            _bankIcon.mouseChildren = _loc3_;
            _loc3_ = _loc3_;
            _storeIcon.mouseEnabled = _loc3_;
            _loc3_ = _loc3_;
            _storeIcon.mouseChildren = _loc3_;
            _loc3_ = _loc3_;
            _shopIcon.mouseEnabled = _loc3_;
            _shopIcon.mouseChildren = _loc3_;
            _shopIcon.tipData = param1.ShopLevel;
            _storeIcon.tipData = param1.SmithLevel;
            _bankIcon.tipData = param1.StoreLevel;
            _skillIcon.tipData = param1.BufferLevel;
            _level.setFrame(param1.Level);
            _consortionNameInput.text = param1.ConsortiaName;
            if(param1.ChairmanIsVIP)
            {
               ObjectUtils.disposeObject(_vipChairman);
               _vipChairman = VipController.instance.getVipNameTxt(142,param1.ChairmanTypeVIP);
               _loc2_ = new TextFormat();
               _loc2_.align = "center";
               _loc2_.bold = true;
               _vipChairman.textField.defaultTextFormat = _loc2_;
               _vipChairman.textSize = 16;
               _vipChairman.x = _chairmanName.x;
               _vipChairman.y = _chairmanName.y;
               _vipChairman.text = param1.ChairmanName;
               addChild(_vipChairman);
               DisplayUtils.removeDisplay(_chairmanName);
            }
            else
            {
               _chairmanName.text = param1.ChairmanName;
               addChild(_chairmanName);
               DisplayUtils.removeDisplay(_vipChairman);
            }
            _count.text = String(param1.Count);
            _riches.text = String(param1.Riches);
            _honor.text = String(param1.Honor);
            _repute.text = String(param1.Repute);
            _badgeBtn.badgeID = param1.BadgeID;
            setWeekyPay();
         }
         else
         {
            _weekPay.mouseEnabled = false;
            _loc3_ = false;
            _skillIcon.mouseEnabled = _loc3_;
            _loc3_ = _loc3_;
            _skillIcon.mouseChildren = _loc3_;
            _loc3_ = _loc3_;
            _bankIcon.mouseEnabled = _loc3_;
            _loc3_ = _loc3_;
            _bankIcon.mouseChildren = _loc3_;
            _loc3_ = _loc3_;
            _storeIcon.mouseEnabled = _loc3_;
            _loc3_ = _loc3_;
            _storeIcon.mouseChildren = _loc3_;
            _loc3_ = _loc3_;
            _shopIcon.mouseEnabled = _loc3_;
            _shopIcon.mouseChildren = _loc3_;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_badgeBtn)
         {
            ObjectUtils.disposeObject(_badgeBtn);
         }
         _badgeBtn = null;
         ObjectUtils.disposeAllChildren(this);
         _shopIcon = null;
         _storeIcon = null;
         _bankIcon = null;
         _skillIcon = null;
         if(_infoWordBG)
         {
            ObjectUtils.disposeObject(_infoWordBG);
         }
         _infoWordBG = null;
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg.bitmapData = null;
         }
         _bg = null;
         if(_BG2)
         {
            ObjectUtils.disposeObject(_BG2);
         }
         if(_level)
         {
            ObjectUtils.disposeObject(_level);
         }
         if(_consortionName)
         {
            ObjectUtils.disposeObject(_consortionName);
         }
         if(_consortionNameInput)
         {
            ObjectUtils.disposeObject(_consortionNameInput);
         }
         if(_chairmanName)
         {
            ObjectUtils.disposeObject(_chairmanName);
         }
         if(_vipChairman)
         {
            ObjectUtils.disposeObject(_vipChairman);
         }
         if(_chairmanText)
         {
            ObjectUtils.disposeObject(_chairmanText);
         }
         if(_numberText)
         {
            ObjectUtils.disposeObject(_numberText);
         }
         if(_richesText)
         {
            ObjectUtils.disposeObject(_richesText);
         }
         if(_exploitText)
         {
            ObjectUtils.disposeObject(_exploitText);
         }
         if(_rankingText)
         {
            ObjectUtils.disposeObject(_rankingText);
         }
         if(_holdText)
         {
            ObjectUtils.disposeObject(_holdText);
         }
         _BG2 = null;
         _level = null;
         _consortionName = null;
         _consortionNameInput = null;
         _chairmanName = null;
         _vipChairman = null;
         _chairmanText = null;
         _numberText = null;
         _richesText = null;
         _exploitText = null;
         _rankingText = null;
         _holdText = null;
         if(_chairmanTextInputBg)
         {
            ObjectUtils.disposeObject(_chairmanTextInputBg);
         }
         _chairmanTextInputBg = null;
         if(_numberTextInputBg)
         {
            ObjectUtils.disposeObject(_numberTextInputBg);
         }
         _numberTextInputBg = null;
         if(_richesTextInputBg)
         {
            ObjectUtils.disposeObject(_richesTextInputBg);
         }
         _richesTextInputBg = null;
         if(_exploitTextInputBg)
         {
            ObjectUtils.disposeObject(_exploitTextInputBg);
         }
         _exploitTextInputBg = null;
         if(_rankingTextInputBg)
         {
            ObjectUtils.disposeObject(_rankingTextInputBg);
         }
         _rankingTextInputBg = null;
         if(_holdTextInputBg)
         {
            ObjectUtils.disposeObject(_holdTextInputBg);
         }
         _holdTextInputBg = null;
         _count = null;
         _riches = null;
         _honor = null;
         _repute = null;
         _weekPay = null;
         ObjectUtils.disposeObject(_activeBg);
         _activeBg = null;
         ObjectUtils.disposeObject(_activeBtn);
         _activeBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
