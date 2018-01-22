package cardSystem.view
{
   import baglocked.BaglockedManager;
   import cardSystem.CardManager;
   import cardSystem.CardSocketEvent;
   import cardSystem.CardTemplateInfoManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.CardTemplateInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.ConfirmAlertHelper;
   import ddt.utils.HelperBuyAlert;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import road7th.comm.PackageIn;
   
   public class PropResetFrame extends BaseAlerFrame
   {
      
      public static var resetPointNotAlertAgain:Boolean = false;
      
      public static var buyIsBind:Boolean = true;
       
      
      private var _cardInfo:CardInfo;
      
      private var _cardCell:ResetCardCell;
      
      private var _newProperty:Bitmap;
      
      private var _oldProperty:Bitmap;
      
      private var _inputSmallBg1:Vector.<ScaleLeftRightImage>;
      
      private var _inputSmallBg2:Vector.<ScaleLeftRightImage>;
      
      private var _basicPropVec1:Vector.<FilterFrameText>;
      
      private var _oldPropVec:Vector.<FilterFrameText>;
      
      private var _newPropVec:Vector.<FilterFrameText>;
      
      private var _upAndDownVec:Vector.<ScaleFrameImage>;
      
      private var _smallinputPropContainer1:VBox;
      
      private var _smallinputPropContainer2:VBox;
      
      private var _basePropContainer1:VBox;
      
      private var _oldPropContainer:VBox;
      
      private var _newPropContainer:VBox;
      
      private var _upAndDownContainer:VBox;
      
      private var _canReplace:Boolean;
      
      private var _isFirst:Boolean = true;
      
      private var _headBg1:ScaleBitmapImage;
      
      private var _headBg2:ScaleBitmapImage;
      
      private var _headBg3:ScaleBitmapImage;
      
      private var _headTextBg1:ScaleLeftRightImage;
      
      private var _headTextBg2:ScaleLeftRightImage;
      
      private var _headTextBg3:ScaleLeftRightImage;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _bg3:ScaleBitmapImage;
      
      private var _bg4:ScaleBitmapImage;
      
      private var _resetArrow:Bitmap;
      
      private var _alertInfo:AlertInfo;
      
      private var _helpButton:BaseButton;
      
      private var _needSoul:FilterFrameText;
      
      private var _needSoulText:FilterFrameText;
      
      private var _ownSoul:FilterFrameText;
      
      private var _ownSoulText:FilterFrameText;
      
      private var _useMoneyTitleTxt:FilterFrameText;
      
      private var _useMoneyTxt:FilterFrameText;
      
      private var _resetAlert:BaseAlerFrame;
      
      private var _cancelAlert:BaseAlerFrame;
      
      private var _propertyPool:Object;
      
      private var _strArray:Object;
      
      private var _newArray:Array;
      
      private var _propertys:Vector.<PropertyEmu>;
      
      private var _sendReplace:Boolean = false;
      
      private var _resetNeedSoul:int;
      
      private var _lockContainer:VBox;
      
      private var _lockVec:Vector.<ScaleFrameImage>;
      
      private var _lockStates:Array;
      
      private var _levelSelectedBg:ScaleLeftRightImage;
      
      private var _levelSelectGroup:SelectedButtonGroup;
      
      private var _levelSelectedNomalChkBtn:SelectedCheckButton;
      
      private var _levelSelectedAdvancedChkBtn:SelectedCheckButton;
      
      private var _levelSelectedNomalTxt:FilterFrameText;
      
      private var _levelSelectedAdvancedTxt:FilterFrameText;
      
      private var _tipTxt:FilterFrameText;
      
      private var _attrTFs:Array;
      
      private var _attrGFs:Array;
      
      private var _enableSubmit:Boolean = true;
      
      private var soulValue:int = 0;
      
      public function PropResetFrame()
      {
         _propertyPool = {};
         _strArray = {};
         _newArray = [];
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc1_:* = null;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         _headBg1 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.headBG1");
         _headBg2 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.headBG2");
         _headBg3 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.headBG3");
         addToContent(_headBg1);
         addToContent(_headBg2);
         addToContent(_headBg3);
         _headTextBg1 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.numBg1");
         addToContent(_headTextBg1);
         _headTextBg2 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.numBg2");
         addToContent(_headTextBg2);
         _headTextBg3 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.numBg3");
         addToContent(_headTextBg3);
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.BG1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.BG2");
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.BG3");
         _bg4 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.BG4");
         addToContent(_bg1);
         addToContent(_bg2);
         addToContent(_bg3);
         addToContent(_bg4);
         _resetArrow = ComponentFactory.Instance.creatBitmap("asset.cardSystem.resetArrow");
         addToContent(_resetArrow);
         _helpButton = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.Help");
         addToContent(_helpButton);
         _oldProperty = ComponentFactory.Instance.creatBitmap("asset.ddtcardSystem.oldProperty");
         addToContent(_oldProperty);
         _newProperty = ComponentFactory.Instance.creatBitmap("asset.ddtcardSystem.newProperty");
         addToContent(_newProperty);
         _needSoul = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.needSoul");
         _needSoul.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.needSoul");
         addToContent(_needSoul);
         _needSoulText = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.needSoulText");
         _needSoulText.text = ServerConfigManager.instance.CardRestSoulValue;
         addToContent(_needSoulText);
         _ownSoul = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.ownSoul");
         _ownSoul.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.ownSoul");
         addToContent(_ownSoul);
         _useMoneyTitleTxt = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.useMoneyTitleTxt");
         _useMoneyTitleTxt.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.useMoneyTitleTxt");
         addToContent(_useMoneyTitleTxt);
         _useMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.useMoneyTxt");
         _useMoneyTxt.text = "0";
         addToContent(_useMoneyTxt);
         _ownSoulText = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.ownSoulText");
         _ownSoulText.text = PlayerManager.Instance.Self.CardSoul.toString();
         addToContent(_ownSoulText);
         escEnable = true;
         _inputSmallBg1 = new Vector.<ScaleLeftRightImage>(4);
         _inputSmallBg2 = new Vector.<ScaleLeftRightImage>(4);
         _basicPropVec1 = new Vector.<FilterFrameText>(4);
         _oldPropVec = new Vector.<FilterFrameText>(4);
         _newPropVec = new Vector.<FilterFrameText>(4);
         _upAndDownVec = new Vector.<ScaleFrameImage>(4);
         _lockVec = new Vector.<ScaleFrameImage>(4);
         _lockStates = [0,0,0,0];
         _cardCell = ComponentFactory.Instance.creatCustomObject("PropResetCell");
         _smallinputPropContainer1 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.smallinputPropContainer1");
         _smallinputPropContainer2 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.smallinputPropContainer2");
         _basePropContainer1 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.basePropContainer1");
         _oldPropContainer = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.oldPropContainer");
         _newPropContainer = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.newPropContainer");
         _upAndDownContainer = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.upAndDownContainer");
         _lockContainer = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.lockContainer");
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.lockImg");
            _loc6_.setFrame(1);
            _loc6_.buttonMode = true;
            _loc6_.addEventListener("click",__lockImgClickHandler);
            _lockVec[_loc3_] = _loc6_;
            _lockContainer.addChild(_loc6_);
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.preNumBg");
            _inputSmallBg1[_loc3_] = _loc5_;
            _smallinputPropContainer1.addChild(_inputSmallBg1[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.newNumBg");
            _inputSmallBg2[_loc4_] = _loc8_;
            _smallinputPropContainer2.addChild(_inputSmallBg2[_loc4_]);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("asset.cardSystem.upAndDown");
            _loc1_.setFrame(1);
            _loc1_.visible = false;
            _upAndDownVec[_loc4_] = _loc1_;
            _upAndDownContainer.addChild(_upAndDownVec[_loc4_]);
            _loc4_++;
         }
         _loc7_ = 0;
         while(_loc7_ < 12)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.PropText");
            if(_loc7_ < 4)
            {
               _basicPropVec1[_loc7_] = _loc2_;
               _basePropContainer1.addChild(_basicPropVec1[_loc7_]);
            }
            else if(_loc7_ < 8)
            {
               _oldPropVec[_loc7_ % 4] = _loc2_;
               _oldPropContainer.addChild(_oldPropVec[_loc7_ % 4]);
            }
            else
            {
               _newPropVec[_loc7_ % 4] = _loc2_;
               _newPropContainer.addChild(_newPropVec[_loc7_ % 4]);
            }
            _loc7_++;
         }
         addToContent(_cardCell);
         addToContent(_smallinputPropContainer1);
         addToContent(_smallinputPropContainer2);
         addToContent(_basePropContainer1);
         addToContent(_oldPropContainer);
         addToContent(_newPropContainer);
         addToContent(_upAndDownContainer);
         addToContent(_lockContainer);
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.title");
         _alertInfo.submitLabel = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.reset");
         _alertInfo.cancelLabel = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.replace");
         _alertInfo.moveEnable = false;
         _alertInfo.enterEnable = false;
         _alertInfo.cancelEnabled = false;
         info = _alertInfo;
         checkSoul();
         _levelSelectedBg = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.LevelSelectedBg");
         addToContent(_levelSelectedBg);
         _levelSelectedNomalChkBtn = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.LevelSelectedNomalChkBtn");
         addToContent(_levelSelectedNomalChkBtn);
         _levelSelectedAdvancedChkBtn = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.LevelSelectedAdvancedChkBtn");
         addToContent(_levelSelectedAdvancedChkBtn);
         _levelSelectGroup = new SelectedButtonGroup();
         _levelSelectGroup.addSelectItem(_levelSelectedNomalChkBtn);
         _levelSelectGroup.addSelectItem(_levelSelectedAdvancedChkBtn);
         _levelSelectGroup.selectIndex = 0;
         _levelSelectedNomalTxt = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.levelSelectedNomalTxt");
         addToContent(_levelSelectedNomalTxt);
         _levelSelectedAdvancedTxt = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.levelSelectedAdvancedTxt");
         addToContent(_levelSelectedAdvancedTxt);
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.tipTxt");
         _tipTxt.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.tipTxtMsg");
         addToContent(_tipTxt);
         _attrTFs = [ComponentFactory.Instance.model.getSet("PropResetFrame.attrTF_Green"),ComponentFactory.Instance.model.getSet("PropResetFrame.attrTF_Blue"),ComponentFactory.Instance.model.getSet("PropResetFrame.attrTF_Purple"),ComponentFactory.Instance.model.getSet("PropResetFrame.attrTF_Orange")];
         _attrGFs = [ComponentFactory.Instance.creatFilters("PropResetFrame.attrGF_Green"),ComponentFactory.Instance.creatFilters("PropResetFrame.attrGF_Blue"),ComponentFactory.Instance.creatFilters("PropResetFrame.attrGF_Purple"),ComponentFactory.Instance.creatFilters("PropResetFrame.attrGF_Orange")];
      }
      
      private function _levelSelectGroupChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         if(_levelSelectGroup.selectIndex == 0)
         {
            _needSoulText.text = ServerConfigManager.instance.CardRestSoulValue;
         }
         else
         {
            _needSoulText.text = ServerConfigManager.instance.highCardResetSoulValue;
         }
         checkSoul();
      }
      
      private function __lockImgClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         SoundManager.instance.play("008");
         var _loc4_:ScaleFrameImage = param1.currentTarget as ScaleFrameImage;
         var _loc3_:int = 0;
         if(_loc4_.getFrame == 1)
         {
            if(lockStateNum >= 3)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.lockImgClickMaxMsg"));
               return;
            }
            _loc4_.setFrame(2);
            _loc3_ = 1;
         }
         else
         {
            _loc4_.setFrame(1);
            _loc3_ = 0;
         }
         _loc5_ = 0;
         while(_loc5_ < _lockVec.length)
         {
            if(_loc4_ == _lockVec[_loc5_])
            {
               _lockStates[_loc5_] = _loc3_;
               break;
            }
            _loc5_++;
         }
         var _loc2_:int = lockStateNum;
         if(_loc2_ == 0)
         {
            _useMoneyTxt.text = "0";
         }
         else
         {
            _useMoneyTxt.text = ServerConfigManager.instance.cardLockAttrMoney[_loc2_ - 1] + "";
         }
      }
      
      private function get lockStateNum() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _lockStates.length)
         {
            if(_lockStates[_loc2_] == 1)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function checkSoul() : void
      {
         var _loc1_:int = ServerConfigManager.instance.CardRestSoulValue;
         if(_levelSelectGroup && _levelSelectGroup.selectIndex == 1)
         {
            _loc1_ = ServerConfigManager.instance.highCardResetSoulValue;
         }
         if(PlayerManager.Instance.Self.CardSoul < _loc1_)
         {
            _alertInfo.submitEnabled = false;
         }
         else
         {
            _alertInfo.submitEnabled = true;
         }
      }
      
      public function show(param1:CardInfo) : void
      {
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc7_:* = null;
         _cardInfo = param1;
         _cardCell.cardInfo = _cardInfo;
         _cardCell.Visibles = false;
         _propertys = new Vector.<PropertyEmu>();
         if(_cardInfo.realAttack > 0)
         {
            _propertys.push(new PropertyEmu("Attack",0));
         }
         if(_cardInfo.realDefence > 0)
         {
            _propertys.push(new PropertyEmu("Defence",1));
         }
         if(_cardInfo.realAgility > 0)
         {
            _propertys.push(new PropertyEmu("Agility",2));
         }
         if(_cardInfo.realLuck > 0)
         {
            _propertys.push(new PropertyEmu("Luck",3));
         }
         if(_cardInfo.realGuard > 0)
         {
            _propertys.push(new PropertyEmu("Guard",4));
         }
         if(_cardInfo.realDamage > 0)
         {
            _propertys.push(new PropertyEmu("Damage",5));
         }
         _loc8_ = 0;
         while(_loc8_ < _propertys.length)
         {
            _basicPropVec1[_loc8_].text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame." + _propertys[_loc8_].key + "1");
            _loc8_++;
         }
         UpdateStrArray();
         if(_strArray != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _propertys.length)
            {
               _oldPropVec[_loc5_].text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.prop",_strArray[_propertys[_loc5_].key] == null || _strArray[_propertys[_loc5_].key] == ""?"0":_strArray[_propertys[_loc5_].key]);
               _loc5_++;
            }
         }
         var _loc4_:Array = [_cardInfo.Attack,_cardInfo.Defence,_cardInfo.Agility,_cardInfo.Luck];
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc3_ = getTxtColorIndex(_loc4_[_loc6_]);
            _loc2_ = _attrTFs[_loc3_];
            _loc7_ = _attrGFs[_loc3_];
            _basicPropVec1[_loc6_].setTextFormat(_loc2_);
            _basicPropVec1[_loc6_].defaultTextFormat = _loc2_;
            _basicPropVec1[_loc6_].filters = _loc7_;
            _oldPropVec[_loc6_].setTextFormat(_loc2_);
            _oldPropVec[_loc6_].defaultTextFormat = _loc2_;
            _oldPropVec[_loc6_].filters = _loc7_;
            _loc6_++;
         }
         _levelSelectedNomalTxt.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.levelSelectedNomalTxtMsg",ServerConfigManager.instance.CardRestSoulValue,_cardInfo.templateInfo.Property1,_cardInfo.templateInfo.Property2);
         _levelSelectedAdvancedTxt.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.levelSelectedAdvancedTxtMsg",ServerConfigManager.instance.highCardResetSoulValue,_cardInfo.templateInfo.Property3,_cardInfo.templateInfo.Property2);
         LayerManager.Instance.addToLayer(this,2,true,1);
         this.y = this.y - 40;
      }
      
      private function getTxtColorIndex(param1:int) : int
      {
         if(param1 >= int(_cardInfo.templateInfo.Property2))
         {
            return 3;
         }
         if(param1 <= 10)
         {
            return 0;
         }
         if(param1 <= 20)
         {
            return 1;
         }
         if(param1 <= 25)
         {
            return 2;
         }
         return 2;
      }
      
      private function UpdateStrArray() : void
      {
         var _loc4_:CardTemplateInfo = CardTemplateInfoManager.instance.getInfoByCardId(String(_cardInfo.TemplateID),String(_cardInfo.CardType));
         var _loc6_:String = _cardInfo.Attack.toString();
         var _loc3_:String = _cardInfo.Defence.toString();
         var _loc5_:String = _cardInfo.Agility.toString();
         var _loc2_:String = _cardInfo.Luck.toString();
         var _loc7_:String = _cardInfo.Damage.toString();
         var _loc1_:String = _cardInfo.Guard.toString();
         _strArray = {
            "Attack":_loc6_,
            "Defence":_loc3_,
            "Agility":_loc5_,
            "Luck":_loc2_
         };
      }
      
      public function set cardInfo(param1:CardInfo) : void
      {
         _cardInfo = param1;
         _propertys = new Vector.<PropertyEmu>();
         if(_cardInfo.realAttack > 0)
         {
            _propertys.push(new PropertyEmu("Attack",0));
         }
         if(_cardInfo.realDefence > 0)
         {
            _propertys.push(new PropertyEmu("Defence",1));
         }
         if(_cardInfo.realAgility > 0)
         {
            _propertys.push(new PropertyEmu("Agility",2));
         }
         if(_cardInfo.realLuck > 0)
         {
            _propertys.push(new PropertyEmu("Luck",3));
         }
         if(_cardInfo.realGuard > 0)
         {
            _propertys.push(new PropertyEmu("Guard",4));
         }
         if(_cardInfo.realDamage > 0)
         {
            _propertys.push(new PropertyEmu("Damage",5));
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(196),__reset);
         CardManager.Instance.model.addEventListener("change_soul",__changeSoul);
         addEventListener("response",__response);
         _helpButton.addEventListener("click",__helpOpen);
         _levelSelectGroup.addEventListener("change",_levelSelectGroupChangeHandler);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_alertInfo.cancelEnabled == true)
               {
                  __cancelHandel();
                  break;
               }
               dispose();
               break;
            default:
               if(_alertInfo.cancelEnabled == true)
               {
                  __cancelHandel();
                  break;
               }
               dispose();
               break;
            case 3:
               __resethandler(null);
               break;
            case 4:
               __replaceHandler(null);
         }
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(196),__reset);
         CardManager.Instance.model.removeEventListener("change_soul",__changeSoul);
         removeEventListener("response",__response);
         _helpButton.removeEventListener("click",__helpOpen);
         _levelSelectGroup.removeEventListener("change",_levelSelectGroupChangeHandler);
      }
      
      protected function __replaceHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:String = LanguageMgr.GetTranslation("tank.view.card.resetAlertMsg");
         _resetAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _resetAlert.moveEnable = false;
         _resetAlert.addEventListener("response",__replaceAlert);
      }
      
      private function __replaceAlert(param1:FrameEvent) : void
      {
         if(_resetAlert)
         {
            _resetAlert.removeEventListener("response",__replaceAlert);
         }
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               submitReplace();
               break;
            case 2:
         }
         _resetAlert.dispose();
         if(_resetAlert.parent)
         {
            _resetAlert.parent.removeChild(_resetAlert);
         }
         _resetAlert = null;
      }
      
      private function submitReplace() : void
      {
         SoundManager.instance.play("008");
         if(_canReplace)
         {
            SocketManager.Instance.out.sendReplaceCardProp(_cardInfo.Place);
            setReplaceAbled(false);
            _alertInfo.cancelEnabled = false;
            _sendReplace = true;
            updateText();
         }
      }
      
      private function __changeSoul(param1:CardSocketEvent) : void
      {
         _ownSoulText.text = PlayerManager.Instance.Self.CardSoul.toString();
         checkSoul();
         _enableSubmit = true;
      }
      
      private function updateText() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         if(_sendReplace)
         {
            _ownSoulText.text = PlayerManager.Instance.Self.CardSoul.toString();
            if(_strArray != null)
            {
               _loc3_ = 0;
               while(_loc3_ < _propertys.length)
               {
                  _oldPropVec[_loc3_].text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.prop",_newArray[_loc3_].toString());
                  _strArray[_propertys[_loc3_].key] = _newArray[_loc3_];
                  _loc2_ = getTxtColorIndex(_newArray[_loc3_]);
                  _loc1_ = _attrTFs[_loc2_];
                  _loc4_ = _attrGFs[_loc2_];
                  _oldPropVec[_loc3_].setTextFormat(_loc1_);
                  _oldPropVec[_loc3_].defaultTextFormat = _loc1_;
                  _oldPropVec[_loc3_].filters = _loc4_;
                  _basicPropVec1[_loc3_].setTextFormat(_loc1_);
                  _basicPropVec1[_loc3_].defaultTextFormat = _loc1_;
                  _basicPropVec1[_loc3_].filters = _loc4_;
                  _loc3_++;
               }
            }
            _loc5_ = 0;
            while(_loc5_ < _newPropVec.length)
            {
               _upAndDownVec[_loc5_].visible = false;
               _newPropVec[_loc5_].text = "";
               _loc5_++;
            }
            _sendReplace = false;
            _alertInfo.submitEnabled = true;
            checkSoul();
         }
      }
      
      protected function __resethandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc4_:int = _cardInfo.templateInfo.Property2;
         if(_strArray.Attack >= _loc4_ && _strArray.Defence >= _loc4_ && _strArray.Agility >= _loc4_ && _strArray.Luck >= _loc4_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.allMaxMsg"));
            return;
         }
         var _loc3_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < _newArray.length)
         {
            if(_newArray[_loc5_] >= _loc4_ && _lockStates[_loc5_] == 0 && _newPropVec[_loc5_].text != "")
            {
               _loc3_ = true;
               break;
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.resetMaxMsg"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc2_.addEventListener("response",__resetDialogAlertResponse);
         }
         else
         {
            buyAlert();
         }
      }
      
      private function __resetDialogAlertResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__resetDialogAlertResponse);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               buyAlert();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function buyAlert() : void
      {
         __onCheckOut = function():void
         {
            buyIsBind = __data.isBind;
            resetExe(__data.isBind);
         };
         __onConfirm = function(param1:BaseAlerFrame):void
         {
            if(param1.selectedCheckButton.selected)
            {
               resetPointNotAlertAgain = true;
            }
         };
         var buyMoney:int = _useMoneyTxt.text;
         var __data:ConfirmAlertData = new ConfirmAlertData();
         __data.moneyNeeded = buyMoney;
         __data.notShowAlertAgain = resetPointNotAlertAgain;
         __data.isBind = buyIsBind;
         var __msg:String = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.resetMoneyMsg",_needSoulText.text,_useMoneyTxt.text);
         var helperFrame:ConfirmAlertHelper = HelperBuyAlert.getInstance().alert(__msg,__data,null,__onCheckOut,__onConfirm,null,1);
         if(helperFrame.frame)
         {
            helperFrame.frame.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
         }
      }
      
      private function resetExe(param1:Boolean) : void
      {
         if(_levelSelectGroup.selectIndex == 0)
         {
            soulValue = int(ServerConfigManager.instance.CardRestSoulValue);
         }
         else
         {
            soulValue = int(ServerConfigManager.instance.highCardResetSoulValue);
         }
         if(!_enableSubmit)
         {
            return;
         }
         _enableSubmit = false;
         SocketManager.Instance.out.sendCardReset(_cardInfo.Place,_levelSelectGroup.selectIndex + 1,_lockStates,param1);
         setReplaceAbled(true);
         checkSoul();
      }
      
      private function __cancelHandel() : void
      {
         SoundManager.instance.play("008");
         var _loc1_:String = LanguageMgr.GetTranslation("tank.view.card.cancelAlertMsg");
         _cancelAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc1_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _cancelAlert.moveEnable = false;
         _cancelAlert.addEventListener("response",__cancelResponse);
      }
      
      private function __cancelResponse(param1:FrameEvent) : void
      {
         if(_cancelAlert)
         {
            _cancelAlert.removeEventListener("response",__cancelResponse);
         }
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_cancelAlert)
               {
                  ObjectUtils.disposeObject(_cancelAlert);
               }
               _cancelAlert = null;
               break;
            case 2:
            case 3:
            case 4:
               dispose();
         }
      }
      
      private function setReplaceAbled(param1:Boolean) : void
      {
         _alertInfo.cancelEnabled = param1;
      }
      
      private function __reset(param1:PkgEvent) : void
      {
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc9_:* = null;
         var _loc8_:* = null;
         _newArray = [];
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:int = _loc4_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc5_)
         {
            _newArray.push(_loc4_.readInt());
            _loc10_++;
         }
         var _loc7_:int = _cardInfo.templateInfo.Property2;
         _loc6_ = 0;
         while(_loc6_ < _propertys.length)
         {
            _loc3_ = getTxtColorIndex(_newArray[_loc6_]);
            _loc2_ = _attrTFs[_loc3_];
            _loc9_ = _attrGFs[_loc3_];
            _newPropVec[_loc6_].text = String(_newArray[_loc6_]);
            _newPropVec[_loc6_].setTextFormat(_loc2_);
            _newPropVec[_loc6_].defaultTextFormat = _loc2_;
            _newPropVec[_loc6_].filters = _loc9_;
            if(_newArray[_loc6_] != int(_strArray[_propertys[_loc6_].key]))
            {
               _upAndDownVec[_loc6_].visible = true;
               if(_newArray[_loc6_] < int(_strArray[_propertys[_loc6_].key]))
               {
                  _upAndDownVec[_loc6_].setFrame(2);
               }
               else if(_newArray[_loc6_] >= _loc7_)
               {
                  _upAndDownVec[_loc6_].setFrame(3);
                  _loc8_ = _upAndDownVec[_loc6_].getFrameImage(2) as FilterFrameText;
                  _loc8_.setTextFormat(_loc2_);
                  _loc8_.defaultTextFormat = _loc2_;
                  _loc8_.filters = _loc9_;
               }
               else
               {
                  _upAndDownVec[_loc6_].setFrame(1);
               }
            }
            else
            {
               _upAndDownVec[_loc6_].visible = false;
            }
            _loc6_++;
         }
         _canReplace = true;
         PlayerManager.Instance.Self.CardSoul = PlayerManager.Instance.Self.CardSoul - soulValue;
         CardManager.Instance.model.dispatchEvent(new CardSocketEvent("change_soul"));
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_cardCell)
         {
            _cardCell.dispose();
         }
         _cardCell = null;
         super.dispose();
         removeEvent();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _basicPropVec1[_loc2_] = null;
            _oldPropVec[_loc2_] = null;
            _newPropVec[_loc2_] = null;
            _inputSmallBg1[_loc2_] = null;
            _inputSmallBg2[_loc2_] = null;
            _loc2_++;
         }
         _bg1 = null;
         _bg2 = null;
         _bg3 = null;
         _headBg1 = null;
         _headBg2 = null;
         _bg2 = null;
         _bg3 = null;
         _bg4 = null;
         _basePropContainer1 = null;
         _oldPropContainer = null;
         _newPropContainer = null;
         _smallinputPropContainer1 = null;
         _smallinputPropContainer2 = null;
         _upAndDownContainer = null;
         _helpButton = null;
         _resetArrow = null;
         _propertyPool = null;
         _propertys = null;
         _oldProperty = null;
         _newProperty = null;
         _upAndDownVec = null;
         _needSoul = null;
         _ownSoul = null;
         _needSoulText = null;
         _ownSoulText = null;
         _headBg3 = null;
         _headTextBg3 = null;
         _levelSelectedBg = null;
         _levelSelectedNomalChkBtn = null;
         _levelSelectedAdvancedChkBtn = null;
         _levelSelectGroup = null;
         _lockContainer = null;
         _tipTxt = null;
         _levelSelectedNomalTxt = null;
         _levelSelectedAdvancedTxt = null;
         if(_lockVec)
         {
            _loc1_ = 0;
            while(_loc1_ < _lockVec.length)
            {
               _lockVec[_loc1_].removeEventListener("click",__lockImgClickHandler);
               ObjectUtils.disposeObject(_lockVec[_loc1_]);
               _lockVec[_loc1_] = null;
               _loc1_++;
            }
            _lockVec = null;
         }
         if(_resetAlert)
         {
            ObjectUtils.disposeObject(_resetAlert);
         }
         _resetAlert = null;
         if(_cancelAlert)
         {
            ObjectUtils.disposeObject(_cancelAlert);
         }
         _cancelAlert = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function __helpOpen(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         var _loc3_:DisplayObject = ComponentFactory.Instance.creatComponentByStylename("Scale9CornerImage17");
         var _loc4_:MovieImage = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.resetFrame.help");
         PositionUtils.setPos(_loc4_,"resetFrame.help.contentPos");
         var _loc5_:AlertInfo = new AlertInfo();
         _loc5_.title = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.help.title");
         _loc5_.submitLabel = LanguageMgr.GetTranslation("ok");
         _loc5_.showCancel = false;
         _loc5_.moveEnable = false;
         var _loc2_:BaseAlerFrame = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.HelpFrame");
         _loc2_.info = _loc5_;
         _loc2_.addToContent(_loc3_);
         _loc2_.addToContent(_loc4_);
         _loc2_.addEventListener("response",__helpResponse);
         LayerManager.Instance.addToLayer(_loc2_,1,true,1);
      }
      
      private function __helpResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__helpResponse);
         _loc2_.dispose();
         SoundManager.instance.play("008");
         StageReferance.stage.focus = this;
      }
   }
}

class PropertyEmu
{
    
   
   public var key:String;
   
   public var idx:int;
   
   function PropertyEmu(param1:String, param2:int)
   {
      super();
      this.key = param1;
      this.idx = param2;
   }
}
