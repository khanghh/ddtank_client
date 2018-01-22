package godCardRaise.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.ConfirmAlertHelper;
   import ddt.utils.HelperBuyAlert;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardListInfo;
   
   public class GodCardRaiseDivineView extends Sprite implements Disposeable
   {
      
      public static const OPENCARDLOCK_CHANGE:String = "openCardLockChange";
      
      public static const MAX_INPUT:int = 999;
      
      public static const MIN_INPUT:int = 1;
       
      
      private var _bg:MutipleImage;
      
      private var _divineBtn:BaseButton;
      
      private var _manyDivineBtn:BaseButton;
      
      private var _freeCountBg:Bitmap;
      
      private var _freeCountTxt:FilterFrameText;
      
      private var _buyCount:int = 1;
      
      private var _buyMoney:int = 0;
      
      private var _openCardsMovie:MovieClip;
      
      private var _cardsLoader:GodCardRaiseDivineCardsLoader;
      
      private var _openCardLock:Boolean = false;
      
      private var _selectedBtn:SelectedCheckButton;
      
      protected var _selectedCB:ComboBox;
      
      private var godcardLevels:Array;
      
      public var continueOpen:int = 0;
      
      private var _inputSelectedBtn:SelectedCheckButton;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _inputValue:String;
      
      private var _isContinuous:Boolean;
      
      private var _isContinuousBind:Boolean;
      
      private var needMoney:int;
      
      private var _currentCards:Array;
      
      private var _card1:MovieClip;
      
      private var _card2:MovieClip;
      
      private var _card3:MovieClip;
      
      private var _card4:MovieClip;
      
      private var _card5:MovieClip;
      
      public function GodCardRaiseDivineView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseDivineView.bg");
         addChild(_bg);
         _divineBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseDivineView.divineBtn");
         addChild(_divineBtn);
         setButtonFrame(_divineBtn,1);
         _freeCountBg = ComponentFactory.Instance.creatBitmap("asset.godCardRaiseDivineView.freeCountBg");
         addChild(_freeCountBg);
         _freeCountTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseDivineView.freeCountTxt");
         addChild(_freeCountTxt);
         _manyDivineBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseDivineView.manyDivineBtn");
         addChild(_manyDivineBtn);
         setButtonFrame(_manyDivineBtn,1);
         _openCardsMovie = ClassUtils.CreatInstance("asset.godCardRaiseDivineView.openCardsMovie");
         PositionUtils.setPos(_openCardsMovie,"godCardRaiseDivineView.openCardsMoviePos");
         _openCardsMovie.addFrameScript(60,exeScriptHandler,_openCardsMovie.totalFrames - 2,playEndMovie);
         addChild(_openCardsMovie);
         _cardsLoader = new GodCardRaiseDivineCardsLoader();
         showFreeCount();
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseDivineView.selectBtn");
         _selectedBtn.text = LanguageMgr.GetTranslation("godCardRaiseDivineView.selectBtnMsg");
         addChild(_selectedBtn);
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.godCardRaiseDivineView.divineSelectCheckBg");
         PositionUtils.setPos(_inputBg,"godCardRaiseDivineView.inputBgPos");
         _inputBg.width = 70;
         addChild(_inputBg);
         _inputSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseDivineView.inputNum.selectBtn");
         _inputSelectedBtn.text = LanguageMgr.GetTranslation("godCardRaiseDivineView.inputNum.selectBtnMsg");
         addChild(_inputSelectedBtn);
         _inputText = ComponentFactory.Instance.creat("godCardRaiseDivineView.inputText");
         _inputValue = "";
         _inputText.text = LanguageMgr.GetTranslation("godCardRaiseDivineView.inputTextMsg");
         _inputText.maxChars = 5;
         _inputText.restrict = "0-9";
         addChild(_inputText);
         _selectedCB = ComponentFactory.Instance.creat("godCardRaiseDivineView.dropListCombo");
         addChild(_selectedCB);
         _selectedCB.beginChanges();
         var _loc1_:VectorListModel = _selectedCB.listPanel.vectorListModel;
         _loc1_.clear();
         godcardLevels = LanguageMgr.GetTranslation("godCardRaiseDivineView.godcardLevelsMsg").split("|");
         _loc2_ = 0;
         while(_loc2_ < godcardLevels.length)
         {
            _loc1_.append(godcardLevels[_loc2_]);
            _loc2_++;
         }
         _selectedCB.commitChanges();
         _selectedCB.textField.text = godcardLevels[godcardLevels.length - 1];
      }
      
      private function initEvent() : void
      {
         _divineBtn.addEventListener("click",__divineClickHandler);
         _manyDivineBtn.addEventListener("click",__manyDivineClickHandler);
         _selectedCB.listPanel.list.addEventListener("listItemClick",__onListClicked);
         _selectedBtn.addEventListener("click",__selectedClickHandler);
         _inputSelectedBtn.addEventListener("click",__selectedClickHandler);
         _inputText.addEventListener("change",__inputChange,false,0,true);
         _inputText.addEventListener("focusIn",__inputTextFousIn);
         _inputText.addEventListener("focusOut",__inputTextFousOut);
      }
      
      private function __selectedClickHandler(param1:Event) : void
      {
         if(param1.target == _selectedBtn)
         {
            _inputSelectedBtn.selected = false;
         }
         else if(param1.target == _inputSelectedBtn)
         {
            _selectedBtn.selected = false;
         }
      }
      
      private function setButtonFrame(param1:BaseButton, param2:int) : void
      {
         var _loc3_:ScaleFrameImage = param1.backgound as ScaleFrameImage;
         _loc3_.setFrame(param2);
      }
      
      private function getButtonCurrentFrame(param1:BaseButton) : int
      {
         var _loc2_:ScaleFrameImage = param1.backgound as ScaleFrameImage;
         return _loc2_.getFrame;
      }
      
      private function __onListClicked(param1:ListItemEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = godcardLevels.indexOf(param1.cellValue);
      }
      
      private function showFreeCount() : void
      {
         _freeCountTxt.text = LanguageMgr.GetTranslation("godCardRaiseDivineView.freeCountTxtMsg",freeCount);
         var _loc1_:* = freeCount > 0;
         _freeCountTxt.visible = _loc1_;
         _freeCountBg.visible = _loc1_;
      }
      
      private function get freeCount() : int
      {
         return ServerConfigManager.instance.godCardDailyFreeCount - GodCardRaiseManager.Instance.model.freeCount;
      }
      
      private function __divineClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = getButtonCurrentFrame(_divineBtn);
         if(_selectedBtn.selected == false && _inputSelectedBtn.selected == true)
         {
            if(_loc2_ == 1)
            {
               selectedContinuous(1);
            }
            else
            {
               setButtonFrame(_divineBtn,1);
               _isContinuous = false;
               _inputText.type = "input";
               continueOpen = 0;
            }
         }
         else if(_loc2_ == 1)
         {
            if(openCardLock)
            {
               return;
            }
            if(freeCount > 0)
            {
               sendOpenCard(1,false);
            }
            else
            {
               _buyCount = 1;
               _buyMoney = ServerConfigManager.instance.godCardOpenOneTimeMoney;
               buyAlert();
            }
         }
         else
         {
            setButtonFrame(_divineBtn,1);
            _isContinuous = false;
            _inputText.type = "input";
            continueOpen = 0;
         }
      }
      
      private function selectedContinuous(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         _buyCount = param1;
         if(int(_inputText.text) > 0)
         {
            if(param1 == 1)
            {
               if(int(_inputText.text) > freeCount)
               {
                  needMoney = (int(_inputText.text) - freeCount) * ServerConfigManager.instance.godCardOpenOneTimeMoney;
               }
               else
               {
                  needMoney = 0;
               }
               _loc3_ = LanguageMgr.GetTranslation("godCardRaiseDivineView.continuousMsg1",needMoney,int(_inputText.text));
            }
            else if(param1 == 5)
            {
               needMoney = int(_inputText.text) * ServerConfigManager.instance.godCardOpenFiveTimeMoney;
               _loc3_ = LanguageMgr.GetTranslation("godCardRaiseDivineView.continuousMsg2",needMoney,int(_inputText.text));
            }
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
            _loc2_.addEventListener("response",__onContinuous);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("godCardRaiseDivineView.continuous.notInputNumMsg"));
         }
      }
      
      private function __onContinuous(param1:FrameEvent) : void
      {
         e = param1;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onContinuous);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,needMoney,function():void
            {
               _isContinuous = true;
               _isContinuousBind = CheckMoneyUtils.instance.isBind;
               sendOpenCard(_buyCount,_isContinuousBind);
            });
         }
         else if(e.responseCode == 4 || 1 || 0)
         {
            _inputText.type = "input";
         }
         frame.dispose();
      }
      
      private function isMoney(param1:int) : Boolean
      {
         var _loc2_:Number = NaN;
         _buyCount = param1;
         if(param1 == 1)
         {
            if(freeCount > 0)
            {
               return true;
            }
            _loc2_ = ServerConfigManager.instance.godCardOpenOneTimeMoney;
         }
         else if(param1 == 5)
         {
            _loc2_ = ServerConfigManager.instance.godCardOpenFiveTimeMoney;
         }
         if(_isContinuousBind)
         {
            if(PlayerManager.Instance.Self.BandMoney < _loc2_)
            {
               return false;
            }
            return true;
         }
         if(PlayerManager.Instance.Self.Money < _loc2_)
         {
            return false;
         }
         return true;
      }
      
      private function __manyDivineClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = getButtonCurrentFrame(_manyDivineBtn);
         if(_selectedBtn.selected == false && _inputSelectedBtn.selected == true)
         {
            if(_loc2_ == 1)
            {
               selectedContinuous(5);
            }
            else
            {
               setButtonFrame(_manyDivineBtn,1);
               _isContinuous = false;
               _inputText.type = "input";
               continueOpen = 0;
            }
         }
         else if(_loc2_ == 1)
         {
            if(openCardLock)
            {
               return;
            }
            _buyCount = 5;
            _buyMoney = ServerConfigManager.instance.godCardOpenFiveTimeMoney;
            buyAlert();
         }
         else
         {
            setButtonFrame(_manyDivineBtn,1);
            _isContinuous = false;
            _inputText.type = "input";
            continueOpen = 0;
         }
      }
      
      private function buyAlert() : void
      {
         __onCheckOut = function():void
         {
            GodCardRaiseManager.Instance.buyIsBind = __data.isBind;
            sendOpenCard(_buyCount,__data.isBind);
         };
         __onConfirm = function(param1:BaseAlerFrame):void
         {
            if(param1.selectedCheckButton.selected)
            {
               GodCardRaiseManager.Instance.notShowAlertAgain = true;
            }
         };
         __onCanel = function():void
         {
            continueOpen = 0;
            openCardLock = false;
            _inputText.type = "input";
         };
         var __data:ConfirmAlertData = new ConfirmAlertData();
         __data.moneyNeeded = _buyMoney;
         if(_buyCount == 1)
         {
            __data.notShowAlertAgain = GodCardRaiseManager.Instance.notShowAlertAgain || continueOpen > 0 || freeCount > 0;
         }
         else
         {
            __data.notShowAlertAgain = GodCardRaiseManager.Instance.notShowAlertAgain || continueOpen > 0;
         }
         __data.isBind = GodCardRaiseManager.Instance.buyIsBind;
         var __msg:String = LanguageMgr.GetTranslation("godCardRaise.godCardRaiseDivineView.divineMsg",_buyMoney,_buyCount);
         var helperFrame:ConfirmAlertHelper = HelperBuyAlert.getInstance().alert(__msg,__data,null,__onCheckOut,__onConfirm,__onCanel,1,-11);
         if(helperFrame.frame)
         {
            helperFrame.frame.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
         }
      }
      
      private function sendOpenCard(param1:int, param2:Boolean, param3:Boolean = false) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _inputText.type = "dynamic";
         if(_selectedBtn.selected || _inputSelectedBtn.selected)
         {
            continueOpen = param1;
         }
         else
         {
            continueOpen = 0;
         }
         GameInSocketOut.sendGodCardOpenCard(param1,param2);
         openCardLock = true;
      }
      
      public function set openCardLock(param1:Boolean) : void
      {
         _openCardLock = param1;
         var _loc2_:* = !_openCardLock;
         _manyDivineBtn.enable = _loc2_;
         _divineBtn.enable = _loc2_;
         _loc2_ = !_openCardLock;
         _selectedBtn.enable = _loc2_;
         _loc2_ = _loc2_;
         _selectedCB.enable = _loc2_;
         _inputSelectedBtn.enable = _loc2_;
         if(_openCardLock)
         {
            if(continueOpen == 1)
            {
               _divineBtn.enable = true;
               setButtonFrame(_manyDivineBtn,1);
               setButtonFrame(_divineBtn,2);
            }
            else if(continueOpen == 5)
            {
               _manyDivineBtn.enable = true;
               setButtonFrame(_divineBtn,1);
               setButtonFrame(_manyDivineBtn,2);
            }
         }
         else
         {
            setButtonFrame(_divineBtn,1);
            setButtonFrame(_manyDivineBtn,1);
         }
         dispatchEvent(new Event("openCardLockChange"));
      }
      
      public function get openCardLock() : Boolean
      {
         return _openCardLock;
      }
      
      public function playCardMovie(param1:Array) : void
      {
         _currentCards = param1;
         _cardsLoader.loadCards(_currentCards,loaderCardsComplete);
      }
      
      private function playEndMovie() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:Boolean = false;
         var _loc2_:int = godcardLevels.indexOf(_selectedCB.textField.text) + 3;
         if(_selectedBtn.selected == false && _inputSelectedBtn.selected == true)
         {
            _inputText.text = (int(_inputText.text) - 1).toString();
         }
         if(int(_inputText.text) == 0 && _selectedBtn.selected == false && _inputSelectedBtn.selected == true)
         {
            continueOpen = 0;
            _isContinuous = false;
            _inputText.type = "input";
         }
         if(!_isContinuous)
         {
            _loc4_ = 0;
            while(_loc4_ < _currentCards.length)
            {
               _loc1_ = GodCardRaiseManager.Instance.godCardListInfoList[_currentCards[_loc4_]];
               if(_loc1_ && _loc1_.Level == _loc2_)
               {
                  _loc3_ = true;
                  break;
               }
               _loc4_++;
            }
         }
         if(continueOpen == 0 || _loc3_)
         {
            openCardLock = false;
         }
         else if(continueOpen == 1)
         {
            if(_isContinuous)
            {
               if(int(_inputText.text) > 0)
               {
                  _inputText.type = "dynamic";
                  if(!isMoney(1))
                  {
                     _isContinuous = false;
                     showNoMoeny();
                     return;
                  }
                  sendOpenCard(1,_isContinuousBind);
               }
               else
               {
                  _isContinuous = false;
                  _inputText.type = "input";
                  return;
               }
            }
            else if(freeCount > 0)
            {
               sendOpenCard(1,false);
            }
            else
            {
               _buyCount = 1;
               _buyMoney = ServerConfigManager.instance.godCardOpenOneTimeMoney;
               buyAlert();
            }
         }
         else if(continueOpen == 5)
         {
            if(_isContinuous)
            {
               if(int(_inputText.text) > 0)
               {
                  _buyCount = 5;
                  if(!isMoney(5))
                  {
                     _isContinuous = false;
                     showNoMoeny();
                     return;
                  }
                  sendOpenCard(5,_isContinuousBind);
               }
               else
               {
                  _isContinuous = false;
                  _inputText.type = "input";
                  return;
               }
            }
            else
            {
               _buyCount = 5;
               _buyMoney = ServerConfigManager.instance.godCardOpenFiveTimeMoney;
               buyAlert();
            }
         }
      }
      
      private function showNoMoeny() : void
      {
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("godCardRaiseDivineView.continuous.noMoneyMsg"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
         _loc1_.addEventListener("response",__onNoMoeny);
      }
      
      protected function __onNoMoeny(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onContinuous);
         _loc2_.dispose();
         _inputText.type = "input";
      }
      
      private function loaderCardsComplete() : void
      {
         SoundManager.instance.play("217");
         _openCardsMovie.gotoAndPlay(2);
      }
      
      private function exeScriptHandler() : void
      {
         if(_currentCards)
         {
            _card1 = _openCardsMovie.getChildByName("card1") as MovieClip;
            _card2 = _openCardsMovie.getChildByName("card2") as MovieClip;
            _card3 = _openCardsMovie.getChildByName("card3") as MovieClip;
            _card4 = _openCardsMovie.getChildByName("card4") as MovieClip;
            _card5 = _openCardsMovie.getChildByName("card5") as MovieClip;
            if(_currentCards.length == 1)
            {
               _card3.addFrameScript(1,cardScript3,5,cardScript3,10,cardScript3);
            }
            else
            {
               _card1.addFrameScript(1,cardScript1,5,cardScript1,10,cardScript1);
               _card2.addFrameScript(1,cardScript2,5,cardScript2,10,cardScript2);
               _card3.addFrameScript(1,cardScript3,5,cardScript3,10,cardScript3);
               _card4.addFrameScript(1,cardScript4,5,cardScript4,10,cardScript4);
               _card5.addFrameScript(1,cardScript5,5,cardScript5,10,cardScript5);
            }
         }
      }
      
      private function cardScript1() : void
      {
         var _loc2_:MovieClip = _card1.getChildByName("card") as MovieClip;
         var _loc1_:int = _currentCards[0];
         addCardToMovie(_loc2_,_loc1_);
      }
      
      private function cardScript2() : void
      {
         var _loc2_:MovieClip = _card2.getChildByName("card") as MovieClip;
         var _loc1_:int = _currentCards[1];
         addCardToMovie(_loc2_,_loc1_);
      }
      
      private function cardScript3() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = _card3.getChildByName("card") as MovieClip;
         if(_currentCards.length == 1)
         {
            _loc1_ = _currentCards[0];
         }
         else
         {
            _loc1_ = _currentCards[2];
         }
         addCardToMovie(_loc2_,_loc1_);
      }
      
      private function cardScript4() : void
      {
         var _loc2_:MovieClip = _card4.getChildByName("card") as MovieClip;
         var _loc1_:int = _currentCards[3];
         addCardToMovie(_loc2_,_loc1_);
      }
      
      private function cardScript5() : void
      {
         var _loc2_:MovieClip = _card5.getChildByName("card") as MovieClip;
         var _loc1_:int = _currentCards[4];
         addCardToMovie(_loc2_,_loc1_);
      }
      
      private function clearMovie(param1:MovieClip) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            while(param1.numChildren > 0)
            {
               _loc2_ = param1.getChildAt(0);
               param1.removeChild(_loc2_);
            }
         }
      }
      
      private function addCardToMovie(param1:MovieClip, param2:int) : void
      {
         var _loc3_:* = null;
         clearMovie(param1);
         var _loc4_:Bitmap = _cardsLoader.displayCards[param2] as Bitmap;
         if(_loc4_)
         {
            _loc3_ = new Bitmap(_loc4_.bitmapData,_loc4_.pixelSnapping,true);
            _loc3_.x = -83;
            _loc3_.y = -123;
            param1.addChild(_loc3_);
         }
      }
      
      public function updateView() : void
      {
         showFreeCount();
      }
      
      private function __clickInput(param1:MouseEvent) : void
      {
         if(_inputText.text == LanguageMgr.GetTranslation("godCardRaiseDivineView.inputTextMsg"))
         {
            _inputText.text = "";
         }
      }
      
      protected function __inputTextFousIn(param1:FocusEvent) : void
      {
         if(_inputText.text == LanguageMgr.GetTranslation("godCardRaiseDivineView.inputTextMsg"))
         {
            _inputText.text = "";
         }
      }
      
      protected function __inputTextFousOut(param1:FocusEvent) : void
      {
         if(_inputText.text.length == 0)
         {
            _inputText.text = LanguageMgr.GetTranslation("godCardRaiseDivineView.inputTextMsg");
         }
      }
      
      private function __inputChange(param1:Event) : void
      {
         if(_inputText.text.indexOf(LanguageMgr.GetTranslation("godCardRaiseDivineView.inputTextMsg")) > -1)
         {
            _inputText.text = _inputText.text.replace(LanguageMgr.GetTranslation("godCardRaiseDivineView.inputTextMsg"),"");
         }
         var _loc2_:int = _inputText.text;
         if(_loc2_ > 999)
         {
            _inputText.text = 999.toString();
         }
         if(_loc2_ < 1)
         {
            _inputText.text = 1.toString();
         }
      }
      
      private function removeEvent() : void
      {
         _divineBtn.removeEventListener("click",__divineClickHandler);
         _manyDivineBtn.removeEventListener("click",__manyDivineClickHandler);
         _selectedCB.listPanel.list.removeEventListener("listItemClick",__onListClicked);
         _selectedBtn.removeEventListener("click",__selectedClickHandler);
         _inputSelectedBtn.addEventListener("click",__selectedClickHandler);
         _inputText.removeEventListener("mouseDown",__clickInput);
         _inputText.removeEventListener("change",__inputChange);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_cardsLoader);
         _cardsLoader = null;
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _divineBtn = null;
         _freeCountBg = null;
         _freeCountTxt = null;
         _manyDivineBtn = null;
         if(_openCardsMovie)
         {
            _openCardsMovie.stop();
            _openCardsMovie = null;
         }
         _selectedBtn = null;
         _selectedCB = null;
         if(_inputBg)
         {
            ObjectUtils.disposeObject(_inputBg);
         }
         _inputBg = null;
         if(_inputSelectedBtn)
         {
            ObjectUtils.disposeObject(_inputSelectedBtn);
         }
         _inputSelectedBtn = null;
         if(_inputText)
         {
            ObjectUtils.disposeObject(_inputText);
         }
         _inputText = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
