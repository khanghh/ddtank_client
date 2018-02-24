package newChickenBox.view
{
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.greensock.easing.Sine;
   import com.gskinner.geom.ColorMatrix;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.ui.Mouse;
   import flash.utils.Timer;
   import newChickenBox.NewChickenBoxControl;
   import newChickenBox.events.NewChickenBoxEvents;
   import newChickenBox.model.NewChickenBoxModel;
   
   public class NewChickenBoxFrame extends Frame implements Disposeable
   {
       
      
      private var _model:NewChickenBoxModel;
      
      private var tipSprite:Sprite;
      
      private var _newBoxBG:Image;
      
      public var countNum:ScaleFrameImage;
      
      private var openCardTimes:Image;
      
      public var eyeBtn:BaseButton;
      
      private var _eyeBtnSprite:Sprite;
      
      public var openCardBtn:BaseButton;
      
      private var _openCardBtnSprite:Sprite;
      
      public var startBnt:BaseButton;
      
      public var flushBnt:TextButton;
      
      public var msgText:FilterFrameText;
      
      public var newBoxView:NewChickenBoxView;
      
      private var _timer:Timer;
      
      private var _help_btn:BaseButton;
      
      private var egg:MovieClip;
      
      private var eyepic:MovieClip;
      
      private var _refreshTimerTxt:FilterFrameText;
      
      private var _helpFrame:BaseAlerFrame;
      
      private var _freeOpenCountTxt:FilterFrameText;
      
      private var _freeEyeCountTxt:FilterFrameText;
      
      private var _freeRefreshCountTxt:FilterFrameText;
      
      private var _openCardBtnColorMatrixFilter:ColorMatrixFilter;
      
      private var _openCardBtnGlowFilter:GlowFilter;
      
      private var _eyeBtnColorMatrixFilter:ColorMatrixFilter;
      
      private var _eyeBtnGlowFilter:GlowFilter;
      
      private var _timePlayTxt:FilterFrameText;
      
      private var _timePlayTimer:Timer;
      
      private var _isEnd:Boolean;
      
      public function NewChickenBoxFrame()
      {
         super();
         _model = NewChickenBoxModel.instance;
         _openCardBtnColorMatrixFilter = new ColorMatrixFilter();
         var _loc2_:ColorMatrix = new ColorMatrix();
         _loc2_.adjustBrightness(25);
         _loc2_.adjustContrast(8);
         _loc2_.adjustSaturation(13);
         _loc2_.adjustHue(14);
         _openCardBtnColorMatrixFilter.matrix = _loc2_;
         _openCardBtnGlowFilter = new GlowFilter(16724787,1,10,10);
         _eyeBtnColorMatrixFilter = new ColorMatrixFilter();
         var _loc1_:ColorMatrix = new ColorMatrix();
         _loc1_.adjustBrightness(38);
         _loc1_.adjustContrast(11);
         _loc1_.adjustSaturation(13);
         _loc1_.adjustHue(14);
         _eyeBtnColorMatrixFilter.matrix = _loc1_;
         _eyeBtnGlowFilter = new GlowFilter(16724787,1,10,10);
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("newChickenBox.newChickenTitle");
         _newBoxBG = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.newChickenBoxFrame.BG");
         addToContent(_newBoxBG);
         countNum = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.countNum");
         var _loc3_:int = _model.canOpenCounts + 1 - _model.countTime;
         countNum.setFrame(_loc3_);
         addToContent(countNum);
         openCardTimes = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.openCardTimes");
         addToContent(openCardTimes);
         openCardBtn = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.openCardBtn");
         _openCardBtnSprite = new Sprite();
         _openCardBtnSprite.mouseEnabled = false;
         _openCardBtnSprite.x = openCardBtn.x;
         _openCardBtnSprite.y = openCardBtn.y;
         openCardBtn.x = 0;
         openCardBtn.y = 0;
         _openCardBtnSprite.addChild(openCardBtn);
         addToContent(_openCardBtnSprite);
         _freeOpenCountTxt = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.openCardFreeTxt");
         addToContent(_freeOpenCountTxt);
         refreshOpenCardBtnTxt();
         setOpenCardLight(true);
         eyeBtn = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.eyeBtn");
         _eyeBtnSprite = new Sprite();
         _eyeBtnSprite.mouseEnabled = false;
         _eyeBtnSprite.x = eyeBtn.x;
         _eyeBtnSprite.y = eyeBtn.y;
         eyeBtn.x = 0;
         eyeBtn.y = 0;
         _eyeBtnSprite.addChild(eyeBtn);
         addToContent(_eyeBtnSprite);
         _freeEyeCountTxt = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.eyeFreeTxt");
         addToContent(_freeEyeCountTxt);
         refreshEagleEyeBtnTxt();
         var _loc2_:Sprite = new Sprite();
         var _loc1_:ScrollPanel = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.ReaderScrollpanel");
         _loc1_.setView(ComponentFactory.Instance.creat("asset.newChickenBox.helpPageWord"));
         _loc1_.invalidateViewport(false);
         _loc2_.addChild(_loc1_);
         _help_btn = HelpFrameUtils.Instance.simpleHelpButton(this,"newChickenBox.helpPageBtn",null,LanguageMgr.GetTranslation("tank.view.emailII.ReadingView.useHelp"),_loc2_,412,485,true,true,{"submitLabel":LanguageMgr.GetTranslation("close")},3);
         startBnt = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.startBtn");
         if(_model.isShowAll)
         {
            startBnt.enable = true;
         }
         else
         {
            startBnt.enable = false;
         }
         addToContent(startBnt);
         flushBnt = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.freeFluashBnt");
         flushBnt.text = LanguageMgr.GetTranslation("newChickenBox.freeFlush");
         flushBnt.tipData = LanguageMgr.GetTranslation("newChickenBox.flushTipData");
         addToContent(flushBnt);
         _freeRefreshCountTxt = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.refreshCardFreeTxt");
         addToContent(_freeRefreshCountTxt);
         _refreshTimerTxt = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.text.adoptRefreshTimer");
         firestGetTime();
         addToContent(_refreshTimerTxt);
         msgText = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.TextStyle_1");
         addToContent(msgText);
         msgText.text = LanguageMgr.GetTranslation("newChickenBox.useMoneyMsg",_model.openCardPrice[_model.countTime]);
         msgText.visible = false;
         newBoxView = new NewChickenBoxView();
         addToContent(newBoxView);
         eyepic = ClassUtils.CreatInstance("asset.newChickenBox.eyePic") as MovieClip;
         eyepic.visible = false;
         eyepic.mouseChildren = false;
         eyepic.mouseEnabled = false;
         addEventListener("enterFrame",useEyePic);
         LayerManager.Instance.addToLayer(eyepic,0);
         _isEnd = false;
         _timePlayTxt = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.timePlayTxt");
         addToContent(_timePlayTxt);
         startTimePlayTimer();
         refreshTimePlayTxt();
      }
      
      private function startTimePlayTimer() : void
      {
         _timePlayTimer = new Timer(1000,0);
         _timePlayTimer.addEventListener("timer",countChangeHandler,false,0,true);
         _timePlayTimer.start();
      }
      
      private function refreshTimePlayTxt() : void
      {
         var _loc5_:* = null;
         var _loc4_:Number = _model.endTime.getTime();
         var _loc3_:Number = TimeManager.Instance.Now().getTime();
         var _loc1_:Number = _loc4_ - _loc3_;
         _loc1_ = _loc1_ < 0?0:Number(_loc1_);
         var _loc2_:int = 0;
         if(_loc1_ / 86400000 > 1)
         {
            _loc2_ = _loc1_ / 86400000;
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("day");
         }
         else if(_loc1_ / 3600000 > 1)
         {
            _loc2_ = _loc1_ / 3600000;
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("hour");
         }
         else if(_loc1_ / 60000 > 1)
         {
            _loc2_ = _loc1_ / 60000;
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            _loc2_ = _loc1_ / 1000;
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("second");
         }
         _timePlayTxt.text = LanguageMgr.GetTranslation("newChickenBox.timePlayTxt") + _loc5_;
         if(_loc2_ <= 0)
         {
            _isEnd = true;
         }
      }
      
      private function countChangeHandler(param1:TimerEvent) : void
      {
         if(!_isEnd)
         {
            refreshTimePlayTxt();
         }
         firestGetTime();
      }
      
      private function disposeTimePlayTimer() : void
      {
         if(_timePlayTimer)
         {
            _timePlayTimer.stop();
            _timePlayTimer.removeEventListener("timer",countChangeHandler);
            _timePlayTimer = null;
         }
      }
      
      public function setEyeLight(param1:Boolean) : void
      {
         if(param1)
         {
            _eyeBtnSprite.filters = [_eyeBtnColorMatrixFilter,_eyeBtnGlowFilter];
         }
         else
         {
            _eyeBtnSprite.filters = null;
         }
      }
      
      public function setOpenCardLight(param1:Boolean) : void
      {
         if(param1)
         {
            _openCardBtnSprite.filters = [_openCardBtnColorMatrixFilter,_openCardBtnGlowFilter];
         }
         else
         {
            _openCardBtnSprite.filters = null;
         }
      }
      
      public function refreshEagleEyeBtnTxt() : void
      {
         if(_model.freeEyeCount <= 0)
         {
            eyeBtn.backStyle = "asset.newChickenBox.eagleEyeBtn";
            eyeBtn.tipStyle = "ddt.view.tips.OneLineTip";
            eyeBtn.tipData = LanguageMgr.GetTranslation("newChickenBox.useEyeCost",_model.eagleEyePrice[_model.countEye]);
            _freeEyeCountTxt.visible = false;
         }
         else
         {
            eyeBtn.backStyle = "asset.newChickenBox.eagleEyeBtnFree";
            eyeBtn.tipStyle = null;
            eyeBtn.tipData = null;
            _freeEyeCountTxt.text = "（" + _model.freeEyeCount + "）";
            _freeEyeCountTxt.visible = true;
         }
      }
      
      public function refreshOpenCardBtnTxt() : void
      {
         if(_model.freeOpenCardCount <= 0)
         {
            openCardBtn.backStyle = "asset.newChickenBox.openCardBtn";
            openCardBtn.tipStyle = "ddt.view.tips.OneLineTip";
            openCardBtn.tipData = LanguageMgr.GetTranslation("newChickenBox.useOpenCardCost",_model.openCardPrice[_model.countTime]);
            _freeOpenCountTxt.visible = false;
         }
         else
         {
            openCardBtn.backStyle = "asset.newChickenBox.openCardBtnFree";
            openCardBtn.tipStyle = null;
            openCardBtn.tipData = null;
            _freeOpenCountTxt.text = "（" + _model.freeOpenCardCount + "）";
            _freeOpenCountTxt.visible = true;
         }
      }
      
      private function useEyePic(param1:Event) : void
      {
         if(_model.clickEagleEye)
         {
            eyepic.visible = true;
            Mouse.hide();
         }
         else
         {
            eyepic.visible = false;
            Mouse.show();
         }
         eyepic.x = mouseX;
         eyepic.y = mouseY;
      }
      
      public function firestGetTime() : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Date = TimeManager.Instance.Now();
         var _loc5_:Number = _loc3_.getTime();
         var _loc8_:Number = _model.lastFlushTime.getTime();
         var _loc1_:Number = _model.freeFlushTime * 60 * 1000;
         if(_model.freeRefreshBoxCount > 0 || _loc5_ - _loc8_ > _loc1_)
         {
            _refreshTimerTxt.visible = false;
            _refreshTimerTxt.text = LanguageMgr.GetTranslation("newChickenBox.flushTimecut",0,0);
            if(flushBnt)
            {
               flushBnt.text = LanguageMgr.GetTranslation("newChickenBox.freeFlush");
            }
            if(_freeRefreshCountTxt)
            {
               _freeRefreshCountTxt.text = "(" + (_model.freeRefreshBoxCount + (_loc5_ - _loc8_ > _loc1_?1:0)) + ")";
               _freeRefreshCountTxt.visible = true;
            }
            _loc2_ = true;
         }
         else
         {
            _loc7_ = _loc1_ - (_loc5_ - _loc8_);
            _loc4_ = _loc7_ / 3600000;
            _loc6_ = (_loc7_ - _loc4_ * 1000 * 60 * 60) / 60000 + 1;
            _loc6_ = _loc6_ > _model.freeFlushTime?_model.freeFlushTime:int(_loc6_);
            _refreshTimerTxt.text = LanguageMgr.GetTranslation("newChickenBox.flushTimecut",_loc4_,_loc6_);
            _refreshTimerTxt.visible = true;
            if(flushBnt)
            {
               flushBnt.text = LanguageMgr.GetTranslation("newChickenBox.flushText");
            }
            if(_freeRefreshCountTxt)
            {
               _freeRefreshCountTxt.visible = false;
            }
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",useEyePic);
         removeEventListener("response",__confirmResponse);
         if(startBnt)
         {
            startBnt.removeEventListener("click",clickStart);
         }
         if(eyeBtn)
         {
            eyeBtn.removeEventListener("click",clickEye);
         }
         if(openCardBtn)
         {
            openCardBtn.removeEventListener("click",clickOpenCard);
         }
         if(flushBnt)
         {
            flushBnt.removeEventListener("click",flushItem);
         }
         _model.removeEventListener("canclickenable",playMovie);
         _model.removeEventListener("mouseShapoff",mouseoff);
      }
      
      private function mouseoff(param1:Event) : void
      {
         eyepic.visible = false;
         Mouse.show();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__confirmResponse);
         startBnt.addEventListener("click",clickStart);
         eyeBtn.addEventListener("click",clickEye);
         openCardBtn.addEventListener("click",clickOpenCard);
         flushBnt.addEventListener("click",flushItem);
         _model.addEventListener("canclickenable",playMovie);
         _model.addEventListener("mouseShapoff",mouseoff);
      }
      
      private function clickOpenCard(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setOpenCardLight(true);
         setEyeLight(false);
         if(_model.clickEagleEye)
         {
            eyepic.visible = false;
            Mouse.show();
            _model.clickEagleEye = false;
         }
      }
      
      public function firstEnterHelp() : void
      {
         if(_model.firstEnterHelp)
         {
            _model.firstEnterHelp = false;
            _help_btn.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function playMovie(param1:NewChickenBoxEvents) : void
      {
         eyeBtn.enable = true;
         openCardBtn.enable = true;
         __start();
      }
      
      private function clickStart(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         startBnt.enable = false;
         SocketManager.Instance.out.sendClickStartBntNewChickenBox();
      }
      
      private function flushItem(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         SoundManager.instance.play("008");
         _model.clickEagleEye = false;
         setOpenCardLight(true);
         setEyeLight(false);
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         Mouse.show();
         var _loc5_:int = _model.flushPrice;
         var _loc4_:Boolean = firestGetTime();
         if(!_loc4_ && PlayerManager.Instance.Self.Money < _loc5_)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         if(_model.AlertFlush && !_loc4_ && _helpFrame == null)
         {
            openAlertFrame();
         }
         else if(_loc4_)
         {
            startBnt.enable = true;
            eyeBtn.enable = false;
            openCardBtn.enable = false;
            _loc2_ = _model.canOpenCounts + 1;
            countNum.setFrame(_loc2_);
            _model.countTime = 0;
            _model.countEye = 0;
            _model.canclickEnable = false;
            SocketManager.Instance.out.sendFlushNewChickenBox();
         }
         else
         {
            startBnt.enable = true;
            _loc3_ = _model.canOpenCounts + 1;
            countNum.setFrame(_loc3_);
            _model.countTime = 0;
            _model.countEye = 0;
            eyeBtn.enable = false;
            openCardBtn.enable = false;
            _model.canclickEnable = false;
            SocketManager.Instance.out.sendFlushNewChickenBox();
         }
      }
      
      private function openAlertFrame() : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("newChickenBox.useMoneyAlert",_model.flushPrice);
         var _loc2_:TextField = new TextField();
         var _loc1_:SelectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.selectBnt");
         _loc1_.text = LanguageMgr.GetTranslation("newChickenBox.noAlert");
         _loc1_.addEventListener("click",noAlertEable);
         if(_helpFrame)
         {
            _helpFrame.removeEventListener("response",__onResponse);
            ObjectUtils.disposeObject(_helpFrame);
            _helpFrame = null;
         }
         _helpFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("newChickenBox.newChickenTitle"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         _helpFrame.addChild(_loc1_);
         _helpFrame.addEventListener("response",__onResponse);
      }
      
      private function noAlertEable(param1:MouseEvent) : void
      {
         var _loc2_:SelectedCheckButton = param1.currentTarget as SelectedCheckButton;
         if(_loc2_.selected)
         {
            _model.AlertFlush = false;
         }
         else
         {
            _model.AlertFlush = true;
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         _helpFrame.removeEventListener("response",__onResponse);
         ObjectUtils.disposeObject(_helpFrame);
         _helpFrame = null;
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            startBnt.enable = true;
            eyeBtn.enable = false;
            _loc2_ = _model.canOpenCounts + 1;
            countNum.setFrame(_loc2_);
            _model.countTime = 0;
            _model.countEye = 0;
            _model.canclickEnable = false;
            SocketManager.Instance.out.sendFlushNewChickenBox();
         }
      }
      
      private function clickEye(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setEyeLight(true);
         setOpenCardLight(false);
         if(_model.countEye >= _model.canEagleEyeCounts)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newChickenBox.eyeNotUseEnable"));
            return;
         }
         if(_model.canclickEnable)
         {
            eyepic.visible = true;
            Mouse.hide();
            _model.clickEagleEye = true;
            param1.stopImmediatePropagation();
         }
      }
      
      private function __start() : void
      {
         TweenLite.to(newBoxView,0.5,{
            "alpha":0,
            "scaleX":0,
            "scaleY":0,
            "x":470,
            "y":300,
            "ease":Sine.easeInOut
         });
         _timer = new Timer(500,1);
         _timer.start();
         _timer.addEventListener("timerComplete",_timerComplete);
      }
      
      private function showOutItem(param1:Event) : void
      {
         if(newBoxView)
         {
            TweenLite.to(newBoxView,0.5,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1,
               "x":0,
               "y":0,
               "ease":Sine.easeInOut
            });
         }
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_)
         {
            _loc2_.removeEventListener("showItems",showOutItem);
            _loc2_.gotoAndStop(_loc2_.totalFrames);
            removeChild(_loc2_);
            _loc2_ = null;
         }
      }
      
      private function _timerComplete(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         egg = ClassUtils.CreatInstance("asset.newChickenBox.dan") as MovieClip;
         egg.addEventListener("showItems",showOutItem);
         PositionUtils.setPos(egg,"newChickenBox.eggPos");
         addChild(egg);
         egg.mouseEnabled = false;
         egg.mouseChildren = false;
         _loc2_ = 0;
         while(_loc2_ < _model.itemList.length)
         {
            _model.itemList[_loc2_].setBg(3);
            _loc2_++;
         }
         _timer.removeEventListener("timerComplete",_timerComplete);
         _timer = null;
         msgText.text = LanguageMgr.GetTranslation("newChickenBox.useMoneyMsg",_model.openCardPrice[_model.countTime]);
      }
      
      private function __confirmResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         removeEventListener("response",__confirmResponse);
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         TweenLite.killTweensOf(newBoxView);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timerComplete",_timerComplete);
            _timer = null;
         }
         disposeTimePlayTimer();
         _openCardBtnColorMatrixFilter = null;
         _openCardBtnGlowFilter = null;
         _eyeBtnColorMatrixFilter = null;
         _eyeBtnGlowFilter = null;
         ObjectUtils.disposeObject(_freeOpenCountTxt);
         _freeOpenCountTxt = null;
         ObjectUtils.disposeObject(_freeEyeCountTxt);
         _freeEyeCountTxt = null;
         ObjectUtils.disposeObject(_freeRefreshCountTxt);
         _freeRefreshCountTxt = null;
         ObjectUtils.disposeObject(_timePlayTxt);
         _timePlayTxt = null;
         ObjectUtils.disposeObject(_eyeBtnSprite);
         _eyeBtnSprite = null;
         ObjectUtils.disposeObject(_openCardBtnSprite);
         _openCardBtnSprite = null;
         ObjectUtils.disposeObject(openCardBtn);
         openCardBtn = null;
         if(egg)
         {
            egg.removeEventListener("showItems",showOutItem);
            egg.gotoAndStop(egg.totalFrames);
            if(egg.parent)
            {
               removeChild(egg);
            }
            egg = null;
         }
         if(_newBoxBG)
         {
            ObjectUtils.disposeObject(_newBoxBG);
         }
         _newBoxBG = null;
         if(countNum)
         {
            ObjectUtils.disposeObject(countNum);
         }
         countNum = null;
         if(flushBnt)
         {
            ObjectUtils.disposeObject(flushBnt);
         }
         flushBnt = null;
         if(_help_btn)
         {
            ObjectUtils.disposeObject(_help_btn);
         }
         _help_btn = null;
         if(openCardTimes)
         {
            ObjectUtils.disposeObject(openCardTimes);
         }
         openCardTimes = null;
         if(_newBoxBG)
         {
            ObjectUtils.disposeObject(_newBoxBG);
         }
         _newBoxBG = null;
         if(startBnt)
         {
            ObjectUtils.disposeObject(startBnt);
         }
         startBnt = null;
         if(msgText)
         {
            ObjectUtils.disposeObject(msgText);
         }
         msgText = null;
         if(newBoxView)
         {
            newBoxView.dispose();
         }
         newBoxView = null;
         if(_helpFrame)
         {
            _helpFrame.removeEventListener("response",__onResponse);
            ObjectUtils.disposeObject(_helpFrame);
            _helpFrame = null;
         }
         if(eyepic)
         {
            ObjectUtils.disposeObject(eyepic);
            eyepic = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
         NewChickenBoxControl.instance.firstEnter = true;
         _model.canclickEnable = false;
         _model.countTime = 0;
         _model.countTime = 0;
         if(eyepic)
         {
            eyepic.visible = false;
         }
         Mouse.show();
         _model.clickEagleEye = false;
      }
   }
}
