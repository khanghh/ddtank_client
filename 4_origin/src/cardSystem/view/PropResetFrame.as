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
         var j:int = 0;
         var lockImg:* = null;
         var preTextBg1:* = null;
         var k:int = 0;
         var preTextBg2:* = null;
         var upAndDownImg:* = null;
         var i:int = 0;
         var text:* = null;
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
         for(j = 0; j < 4; )
         {
            lockImg = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.lockImg");
            lockImg.setFrame(1);
            lockImg.buttonMode = true;
            lockImg.addEventListener("click",__lockImgClickHandler);
            _lockVec[j] = lockImg;
            _lockContainer.addChild(lockImg);
            preTextBg1 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.preNumBg");
            _inputSmallBg1[j] = preTextBg1;
            _smallinputPropContainer1.addChild(_inputSmallBg1[j]);
            j++;
         }
         for(k = 0; k < 4; )
         {
            preTextBg2 = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.newNumBg");
            _inputSmallBg2[k] = preTextBg2;
            _smallinputPropContainer2.addChild(_inputSmallBg2[k]);
            upAndDownImg = ComponentFactory.Instance.creatComponentByStylename("asset.cardSystem.upAndDown");
            upAndDownImg.setFrame(1);
            upAndDownImg.visible = false;
            _upAndDownVec[k] = upAndDownImg;
            _upAndDownContainer.addChild(_upAndDownVec[k]);
            k++;
         }
         for(i = 0; i < 12; )
         {
            text = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.PropText");
            if(i < 4)
            {
               _basicPropVec1[i] = text;
               _basePropContainer1.addChild(_basicPropVec1[i]);
            }
            else if(i < 8)
            {
               _oldPropVec[i % 4] = text;
               _oldPropContainer.addChild(_oldPropVec[i % 4]);
            }
            else
            {
               _newPropVec[i % 4] = text;
               _newPropContainer.addChild(_newPropVec[i % 4]);
            }
            i++;
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
      
      private function _levelSelectGroupChangeHandler(event:Event) : void
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
      
      private function __lockImgClickHandler(event:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.play("008");
         var img:ScaleFrameImage = event.currentTarget as ScaleFrameImage;
         var currentState:int = 0;
         if(img.getFrame == 1)
         {
            if(lockStateNum >= 3)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.lockImgClickMaxMsg"));
               return;
            }
            img.setFrame(2);
            currentState = 1;
         }
         else
         {
            img.setFrame(1);
            currentState = 0;
         }
         for(i = 0; i < _lockVec.length; )
         {
            if(img == _lockVec[i])
            {
               _lockStates[i] = currentState;
               break;
            }
            i++;
         }
         var stateNum:int = lockStateNum;
         if(stateNum == 0)
         {
            _useMoneyTxt.text = "0";
         }
         else
         {
            _useMoneyTxt.text = ServerConfigManager.instance.cardLockAttrMoney[stateNum - 1] + "";
         }
      }
      
      private function get lockStateNum() : int
      {
         var j:int = 0;
         var stateNum:int = 0;
         for(j = 0; j < _lockStates.length; )
         {
            if(_lockStates[j] == 1)
            {
               stateNum++;
            }
            j++;
         }
         return stateNum;
      }
      
      public function checkSoul() : void
      {
         var soulValue:int = ServerConfigManager.instance.CardRestSoulValue;
         if(_levelSelectGroup && _levelSelectGroup.selectIndex == 1)
         {
            soulValue = ServerConfigManager.instance.highCardResetSoulValue;
         }
         if(PlayerManager.Instance.Self.CardSoul < soulValue)
         {
            _alertInfo.submitEnabled = false;
         }
         else
         {
            _alertInfo.submitEnabled = true;
         }
      }
      
      public function show(card:CardInfo) : void
      {
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var tempIndex:int = 0;
         var tempTxtTF:* = null;
         var tempTxtFilters:* = null;
         _cardInfo = card;
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
         i = 0;
         while(i < _propertys.length)
         {
            _basicPropVec1[i].text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame." + _propertys[i].key + "1");
            i++;
         }
         UpdateStrArray();
         if(_strArray != null)
         {
            for(j = 0; j < _propertys.length; )
            {
               _oldPropVec[j].text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.prop",_strArray[_propertys[j].key] == null || _strArray[_propertys[j].key] == ""?"0":_strArray[_propertys[j].key]);
               j++;
            }
         }
         var tempArr:Array = [_cardInfo.Attack,_cardInfo.Defence,_cardInfo.Agility,_cardInfo.Luck];
         for(k = 0; k < 4; )
         {
            tempIndex = getTxtColorIndex(tempArr[k]);
            tempTxtTF = _attrTFs[tempIndex];
            tempTxtFilters = _attrGFs[tempIndex];
            _basicPropVec1[k].setTextFormat(tempTxtTF);
            _basicPropVec1[k].defaultTextFormat = tempTxtTF;
            _basicPropVec1[k].filters = tempTxtFilters;
            _oldPropVec[k].setTextFormat(tempTxtTF);
            _oldPropVec[k].defaultTextFormat = tempTxtTF;
            _oldPropVec[k].filters = tempTxtFilters;
            k++;
         }
         _levelSelectedNomalTxt.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.levelSelectedNomalTxtMsg",ServerConfigManager.instance.CardRestSoulValue,_cardInfo.templateInfo.Property1,_cardInfo.templateInfo.Property2);
         _levelSelectedAdvancedTxt.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.levelSelectedAdvancedTxtMsg",ServerConfigManager.instance.highCardResetSoulValue,_cardInfo.templateInfo.Property3,_cardInfo.templateInfo.Property2);
         LayerManager.Instance.addToLayer(this,2,true,1);
         this.y = this.y - 40;
      }
      
      private function getTxtColorIndex(num:int) : int
      {
         if(num >= int(_cardInfo.templateInfo.Property2))
         {
            return 3;
         }
         if(num <= 10)
         {
            return 0;
         }
         if(num <= 20)
         {
            return 1;
         }
         if(num <= 25)
         {
            return 2;
         }
         return 2;
      }
      
      private function UpdateStrArray() : void
      {
         var cardTempleInfo:CardTemplateInfo = CardTemplateInfoManager.instance.getInfoByCardId(String(_cardInfo.TemplateID),String(_cardInfo.CardType));
         var Attackstr:String = _cardInfo.Attack.toString();
         var Defencestr:String = _cardInfo.Defence.toString();
         var Agilitystr:String = _cardInfo.Agility.toString();
         var Luckystr:String = _cardInfo.Luck.toString();
         var Damagestr:String = _cardInfo.Damage.toString();
         var Guardstr:String = _cardInfo.Guard.toString();
         _strArray = {
            "Attack":Attackstr,
            "Defence":Defencestr,
            "Agility":Agilitystr,
            "Luck":Luckystr
         };
      }
      
      public function set cardInfo(value:CardInfo) : void
      {
         _cardInfo = value;
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
      
      private function __response(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
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
      
      protected function __replaceHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var msg:String = LanguageMgr.GetTranslation("tank.view.card.resetAlertMsg");
         _resetAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _resetAlert.moveEnable = false;
         _resetAlert.addEventListener("response",__replaceAlert);
      }
      
      private function __replaceAlert(event:FrameEvent) : void
      {
         if(_resetAlert)
         {
            _resetAlert.removeEventListener("response",__replaceAlert);
         }
         switch(int(event.responseCode) - 2)
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
      
      private function __changeSoul(event:CardSocketEvent) : void
      {
         _ownSoulText.text = PlayerManager.Instance.Self.CardSoul.toString();
         checkSoul();
         _enableSubmit = true;
      }
      
      private function updateText() : void
      {
         var j:int = 0;
         var tempIndex:int = 0;
         var tempTxtTF:* = null;
         var tempTxtFilters:* = null;
         var i:int = 0;
         if(_sendReplace)
         {
            _ownSoulText.text = PlayerManager.Instance.Self.CardSoul.toString();
            if(_strArray != null)
            {
               for(j = 0; j < _propertys.length; )
               {
                  _oldPropVec[j].text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.prop",_newArray[j].toString());
                  _strArray[_propertys[j].key] = _newArray[j];
                  tempIndex = getTxtColorIndex(_newArray[j]);
                  tempTxtTF = _attrTFs[tempIndex];
                  tempTxtFilters = _attrGFs[tempIndex];
                  _oldPropVec[j].setTextFormat(tempTxtTF);
                  _oldPropVec[j].defaultTextFormat = tempTxtTF;
                  _oldPropVec[j].filters = tempTxtFilters;
                  _basicPropVec1[j].setTextFormat(tempTxtTF);
                  _basicPropVec1[j].defaultTextFormat = tempTxtTF;
                  _basicPropVec1[j].filters = tempTxtFilters;
                  j++;
               }
            }
            i = 0;
            while(i < _newPropVec.length)
            {
               _upAndDownVec[i].visible = false;
               _newPropVec[i].text = "";
               i++;
            }
            _sendReplace = false;
            _alertInfo.submitEnabled = true;
            checkSoul();
         }
      }
      
      protected function __resethandler(event:MouseEvent) : void
      {
         var i:int = 0;
         var dialogAlert:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var maxNum:int = _cardInfo.templateInfo.Property2;
         if(_strArray.Attack >= maxNum && _strArray.Defence >= maxNum && _strArray.Agility >= maxNum && _strArray.Luck >= maxNum)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.allMaxMsg"));
            return;
         }
         var bool:Boolean = false;
         for(i = 0; i < _newArray.length; )
         {
            if(_newArray[i] >= maxNum && _lockStates[i] == 0 && _newPropVec[i].text != "")
            {
               bool = true;
               break;
            }
            i++;
         }
         if(bool)
         {
            dialogAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.resetMaxMsg"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            dialogAlert.addEventListener("response",__resetDialogAlertResponse);
         }
         else
         {
            buyAlert();
         }
      }
      
      private function __resetDialogAlertResponse(event:FrameEvent) : void
      {
         event.currentTarget.removeEventListener("response",__resetDialogAlertResponse);
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               buyAlert();
         }
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function buyAlert() : void
      {
         __onCheckOut = function():void
         {
            buyIsBind = __data.isBind;
            resetExe(__data.isBind);
         };
         __onConfirm = function(frame:BaseAlerFrame):void
         {
            if(frame.selectedCheckButton.selected)
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
      
      private function resetExe(isBind:Boolean) : void
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
         SocketManager.Instance.out.sendCardReset(_cardInfo.Place,_levelSelectGroup.selectIndex + 1,_lockStates,isBind);
         setReplaceAbled(true);
         checkSoul();
      }
      
      private function __cancelHandel() : void
      {
         SoundManager.instance.play("008");
         var msg:String = LanguageMgr.GetTranslation("tank.view.card.cancelAlertMsg");
         _cancelAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _cancelAlert.moveEnable = false;
         _cancelAlert.addEventListener("response",__cancelResponse);
      }
      
      private function __cancelResponse(event:FrameEvent) : void
      {
         if(_cancelAlert)
         {
            _cancelAlert.removeEventListener("response",__cancelResponse);
         }
         switch(int(event.responseCode))
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
      
      private function setReplaceAbled(val:Boolean) : void
      {
         _alertInfo.cancelEnabled = val;
      }
      
      private function __reset(event:PkgEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         var tempIndex:int = 0;
         var tempTxtTF:* = null;
         var tempTxtFilters:* = null;
         var maxTxt:* = null;
         _newArray = [];
         var pkg:PackageIn = event.pkg;
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            _newArray.push(pkg.readInt());
            i++;
         }
         var maxNum:int = _cardInfo.templateInfo.Property2;
         for(j = 0; j < _propertys.length; )
         {
            tempIndex = getTxtColorIndex(_newArray[j]);
            tempTxtTF = _attrTFs[tempIndex];
            tempTxtFilters = _attrGFs[tempIndex];
            _newPropVec[j].text = String(_newArray[j]);
            _newPropVec[j].setTextFormat(tempTxtTF);
            _newPropVec[j].defaultTextFormat = tempTxtTF;
            _newPropVec[j].filters = tempTxtFilters;
            if(_newArray[j] != int(_strArray[_propertys[j].key]))
            {
               _upAndDownVec[j].visible = true;
               if(_newArray[j] < int(_strArray[_propertys[j].key]))
               {
                  _upAndDownVec[j].setFrame(2);
               }
               else if(_newArray[j] >= maxNum)
               {
                  _upAndDownVec[j].setFrame(3);
                  maxTxt = _upAndDownVec[j].getFrameImage(2) as FilterFrameText;
                  maxTxt.setTextFormat(tempTxtTF);
                  maxTxt.defaultTextFormat = tempTxtTF;
                  maxTxt.filters = tempTxtFilters;
               }
               else
               {
                  _upAndDownVec[j].setFrame(1);
               }
            }
            else
            {
               _upAndDownVec[j].visible = false;
            }
            j++;
         }
         _canReplace = true;
         PlayerManager.Instance.Self.CardSoul = PlayerManager.Instance.Self.CardSoul - soulValue;
         CardManager.Instance.model.dispatchEvent(new CardSocketEvent("change_soul"));
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         var k:int = 0;
         if(_cardCell)
         {
            _cardCell.dispose();
         }
         _cardCell = null;
         super.dispose();
         removeEvent();
         for(i = 0; i < 6; )
         {
            _basicPropVec1[i] = null;
            _oldPropVec[i] = null;
            _newPropVec[i] = null;
            _inputSmallBg1[i] = null;
            _inputSmallBg2[i] = null;
            i++;
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
            for(k = 0; k < _lockVec.length; )
            {
               _lockVec[k].removeEventListener("click",__lockImgClickHandler);
               ObjectUtils.disposeObject(_lockVec[k]);
               _lockVec[k] = null;
               k++;
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
      
      private function __helpOpen(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
         var helpBg:DisplayObject = ComponentFactory.Instance.creatComponentByStylename("Scale9CornerImage17");
         var helpContent:MovieImage = ComponentFactory.Instance.creatComponentByStylename("ddtcardSystem.resetFrame.help");
         PositionUtils.setPos(helpContent,"resetFrame.help.contentPos");
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.title = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.help.title");
         alertInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         alertInfo.showCancel = false;
         alertInfo.moveEnable = false;
         var frame:BaseAlerFrame = ComponentFactory.Instance.creatComponentByStylename("PropResetFrame.HelpFrame");
         frame.info = alertInfo;
         frame.addToContent(helpBg);
         frame.addToContent(helpContent);
         frame.addEventListener("response",__helpResponse);
         LayerManager.Instance.addToLayer(frame,1,true,1);
      }
      
      private function __helpResponse(event:FrameEvent) : void
      {
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__helpResponse);
         alert.dispose();
         SoundManager.instance.play("008");
         StageReferance.stage.focus = this;
      }
   }
}

class PropertyEmu
{
    
   
   public var key:String;
   
   public var idx:int;
   
   function PropertyEmu(key:String, idx:int)
   {
      super();
      this.key = key;
      this.idx = idx;
   }
}
