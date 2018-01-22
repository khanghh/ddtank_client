package Indiana
{
   import Indiana.analyzer.IndianaGoodsItemInfo;
   import Indiana.analyzer.IndianaShopItemInfo;
   import Indiana.model.IndianaShowData;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import road7th.utils.DateUtils;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class IndianaInfoPanel extends Sprite implements Disposeable
   {
       
      
      private var _progressBar:IndianaProgressBar;
      
      private var _hasJoin:FilterFrameText;
      
      private var _totleJoin:FilterFrameText;
      
      private var _line:MutipleImage;
      
      private var _timesDis:FilterFrameText;
      
      private var _timesDis1:FilterFrameText;
      
      private var _timesDisII:FilterFrameText;
      
      private var _times:TextInput;
      
      private var _timesBg:ScaleBitmapImage;
      
      private var _addTimeBtn:BaseButton;
      
      private var _subtractTimeBtn:BaseButton;
      
      private var _timeHelpBtn:BaseButton;
      
      private var _indianaBtn:BaseButton;
      
      private var _indianaDis:FilterFrameText;
      
      private var _lookNumSelf:FilterFrameText;
      
      private var _indianaDisII:FilterFrameText;
      
      private var _countDown:MovieClip;
      
      private var _scoller:ScrollPanel;
      
      private var _secondNum01:NumberImage;
      
      private var _secondNum02:NumberImage;
      
      private var _minuteNum01:NumberImage;
      
      private var _minuteNum02:NumberImage;
      
      private var _hourNum01:NumberImage;
      
      private var _hourNum02:NumberImage;
      
      private var _hourNum03:NumberImage;
      
      private var _itemDisBg:Bitmap;
      
      private var _info:IndianaShopItemInfo;
      
      private var _itemInfo:IndianaGoodsItemInfo;
      
      private var _timer:TimerJuggler;
      
      private var _countDownDate:Number;
      
      private var _endtimer:Date;
      
      private var showdata:IndianaShowData;
      
      private var countDownComplete:Boolean = false;
      
      private var baseAlerFrame:BaseAlerFrame;
      
      private var time:int;
      
      public function IndianaInfoPanel()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _hasJoin = ComponentFactory.Instance.creatComponentByStylename("indiana.hasJoin.Txt");
         _totleJoin = ComponentFactory.Instance.creatComponentByStylename("indiana.hasJoin.Txt");
         PositionUtils.setPos(_totleJoin,"indiana.totlejoin.pos");
         _line = ComponentFactory.Instance.creatComponentByStylename("indiana.line");
         _countDown = ComponentFactory.Instance.creat("asset.countDown.bg");
         PositionUtils.setPos(_countDown,"indiana.countDown.pos");
         _timesDis = ComponentFactory.Instance.creatComponentByStylename("indiana.timesDisI.Txt");
         _timesDis.text = LanguageMgr.GetTranslation("Indiana.join.count");
         _timesDis1 = ComponentFactory.Instance.creatComponentByStylename("indiana.timesDisI.Txt");
         _timesDis1.text = LanguageMgr.GetTranslation("Indiana.join.count1");
         PositionUtils.setPos(_timesDis1,"indiana.timesDisI.Txt.pos");
         _timesDisII = ComponentFactory.Instance.creatComponentByStylename("indiana.timesDisII.Txt");
         _timesDisII.text = LanguageMgr.GetTranslation("Indiana.infopanel.dis");
         _timesBg = ComponentFactory.Instance.creatComponentByStylename("indiana.timesTxt.bg");
         _times = ComponentFactory.Instance.creatComponentByStylename("indiana.timesDisI.inputTxt");
         PositionUtils.setPos(_times,"itemDisII.pos");
         _addTimeBtn = ComponentFactory.Instance.creatComponentByStylename("indiana.addTimebtn");
         _subtractTimeBtn = ComponentFactory.Instance.creatComponentByStylename("indiana.subtractTimebtn");
         _indianaBtn = ComponentFactory.Instance.creatComponentByStylename("indiana.btn");
         _indianaDis = ComponentFactory.Instance.creatComponentByStylename("indiana.hasJoin.Txt");
         _indianaDis.htmlText = LanguageMgr.GetTranslation("Indiana.infopanel.disII");
         _lookNumSelf = ComponentFactory.Instance.creatComponentByStylename("indiana.hasJoin.Txt");
         _lookNumSelf.mouseEnabled = true;
         _lookNumSelf.htmlText = LanguageMgr.GetTranslation("Indiana.resoult.checkSelfCode");
         PositionUtils.setPos(_lookNumSelf,"indiana.infopanel.lookself.pos");
         _indianaDisII = ComponentFactory.Instance.creatComponentByStylename("indiana.hasJoin.Txt");
         _indianaDisII.text = LanguageMgr.GetTranslation("Indiana.infopanel.disIII");
         _timeHelpBtn = ComponentFactory.Instance.creatComponentByStylename("indiana.timehelpbtn");
         _timeHelpBtn.tipStyle = "ddt.view.tips.OneLineTip";
         _timeHelpBtn.tipDirctions = "0";
         PositionUtils.setPos(_indianaDis,"indiana.Dis.pos");
         PositionUtils.setPos(_indianaDisII,"indiana.DisII.pos");
         _progressBar = new IndianaProgressBar();
         _progressBar.setProgress(0);
         PositionUtils.setPos(_progressBar,"indiana.progressbar.pos");
         _secondNum01 = ComponentFactory.Instance.creatComponentByStylename("indiana.snum");
         _secondNum02 = ComponentFactory.Instance.creatComponentByStylename("indiana.snum");
         _secondNum01.count = 0;
         _secondNum02.count = 0;
         PositionUtils.setPos(_secondNum01,"indiana.countDown.second01pos");
         PositionUtils.setPos(_secondNum02,"indiana.countDown.second02pos");
         _minuteNum01 = ComponentFactory.Instance.creatComponentByStylename("indiana.snum");
         _minuteNum02 = ComponentFactory.Instance.creatComponentByStylename("indiana.snum");
         PositionUtils.setPos(_minuteNum01,"indiana.countDown.minute01pos");
         PositionUtils.setPos(_minuteNum02,"indiana.countDown.minute02pos");
         _minuteNum01.count = 0;
         _minuteNum02.count = 0;
         _hourNum01 = ComponentFactory.Instance.creatComponentByStylename("indiana.snum");
         _hourNum02 = ComponentFactory.Instance.creatComponentByStylename("indiana.snum");
         _hourNum03 = ComponentFactory.Instance.creatComponentByStylename("indiana.snum");
         PositionUtils.setPos(_hourNum01,"indiana.countDown.hour01pos");
         PositionUtils.setPos(_hourNum02,"indiana.countDown.hour02pos");
         PositionUtils.setPos(_hourNum03,"indiana.countDown.hour03pos");
         _hourNum01.count = 0;
         _hourNum02.count = 0;
         _hourNum03.count = 0;
         _timer = TimerManager.getInstance().addTimerJuggler(1000,10000);
         _timer.stop();
         addChild(_hasJoin);
         addChild(_totleJoin);
         addChild(_line);
         addChild(_timesDis);
         addChild(_timesDis1);
         addChild(_timesDisII);
         addChild(_timesBg);
         addChild(_times);
         addChild(_addTimeBtn);
         addChild(_subtractTimeBtn);
         addChild(_timeHelpBtn);
         addChild(_indianaBtn);
         addChild(_indianaDis);
         addChild(_indianaDisII);
         addChild(_countDown);
         addChild(_secondNum01);
         addChild(_secondNum02);
         addChild(_minuteNum01);
         addChild(_minuteNum02);
         addChild(_hourNum01);
         addChild(_hourNum02);
         addChild(_hourNum03);
         addChild(_progressBar);
         addChild(_lookNumSelf);
      }
      
      private function initEvent() : void
      {
         _addTimeBtn.addEventListener("click",__addClickHandler);
         _subtractTimeBtn.addEventListener("click",__subClickHandler);
         _indianaBtn.addEventListener("click",__indianaBtnClickHandler);
         _timer.addEventListener("timer",__TimerHander);
         _timer.addEventListener("timerComplete",__TimerCompleteHander);
         _lookNumSelf.addEventListener("link",__linkHandler);
         _times.addEventListener("textInput",__inputHandler);
         _times.addEventListener("focusOut",__outFocusHandler);
         _times.addEventListener("mouseOver",__overTimeHandler);
         _times.addEventListener("mouseOut",__outTimeHandler);
         _times.addEventListener("change",__txtChangeHandler);
      }
      
      private function __overTimeHandler(param1:MouseEvent) : void
      {
      }
      
      private function __outTimeHandler(param1:MouseEvent) : void
      {
      }
      
      private function __txtChangeHandler(param1:Event) : void
      {
         setTimesTips();
      }
      
      private function setTimesTips() : void
      {
         var _loc3_:int = _times.text;
         var _loc2_:int = _itemInfo.Cost / 100;
         var _loc1_:* = Number(int(_loc3_ / _loc2_ * 1000) / 10);
         if(_loc1_ < 0.1)
         {
            _loc1_ = 0.1;
         }
         _times.tipData = LanguageMgr.GetTranslation("Indiana.resoult.getPro",_loc1_.toString() + "%");
      }
      
      private function __outFocusHandler(param1:FocusEvent) : void
      {
         if(_times.text == "")
         {
            _times.text = "1";
         }
      }
      
      private function __inputHandler(param1:TextEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         param1.preventDefault();
         if(isNaN(Number(param1.text)))
         {
            param1.text = "";
            setTimesTips();
         }
         else
         {
            _loc4_ = _times.text + param1.text;
            _loc5_ = _loc4_;
            _loc2_ = _itemInfo.Cost / 100 - showdata.buyNumber;
            _loc3_ = _loc2_;
            if(_loc5_ < _loc3_)
            {
               if(_loc5_ / _info.MinBuyTimes == 0)
               {
                  _times.appendText(param1.text);
               }
               else if(_loc5_ < _info.MinBuyTimes)
               {
                  _times.text = _info.MinBuyTimes.toString();
               }
               else
               {
                  _times.text = int(Math.floor(_loc5_ / _info.MinBuyTimes)).toString();
               }
               setTimesTips();
            }
            else
            {
               _times.text = _loc3_.toString();
               setTimesTips();
            }
         }
      }
      
      private function __linkHandler(param1:TextEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = param1.text.split("|");
         var _loc4_:String = _loc3_[0];
         if(_loc4_ == "clickother")
         {
            _loc2_ = _loc3_[1];
         }
         if(_loc4_ == "clickself")
         {
            _loc2_ = PlayerManager.Instance.Self.ID;
         }
         SocketManager.Instance.out.sendIndianaCode(showdata.per_id,_loc2_);
      }
      
      private function __TimerHander(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_countDownDate > 0)
         {
            _countDownDate = _countDownDate - 1000;
            if(_countDownDate / 3600000 > 0)
            {
               _loc4_ = _countDownDate / 3600000;
            }
            if(_countDownDate / 60000 > 0)
            {
               _loc2_ = _countDownDate / 60000 - _loc4_ * 60;
            }
            if(_countDownDate % 60000 / 1000 > 0)
            {
               _loc3_ = _countDownDate % 60000 / 1000;
            }
            if(_loc4_ == 0 && _loc2_ == 0 && _loc3_ == 0)
            {
               countDownComplete = true;
               SocketManager.Instance.out.sendUpdateSysDate();
               SocketManager.Instance.out.sendIndianaEnterGame(0);
            }
            setDownValue(_loc3_,_loc2_,_loc4_);
         }
      }
      
      private function setDownValue(param1:int, param2:int, param3:int) : void
      {
         if(param1 > 0)
         {
            if(param1 > 9)
            {
               _secondNum01.count = int(param1.toString().charAt(1));
               _secondNum02.count = int(param1.toString().charAt(0));
            }
            else
            {
               _secondNum01.count = param1;
               _secondNum02.count = 0;
            }
         }
         else
         {
            _secondNum01.count = 0;
            _secondNum02.count = 0;
         }
         if(param2 > 0)
         {
            if(param2 > 9)
            {
               _minuteNum01.count = int(param2.toString().charAt(1));
               _minuteNum02.count = int(param2.toString().charAt(0));
            }
            else
            {
               _minuteNum01.count = param2;
               _minuteNum02.count = 0;
            }
         }
         else
         {
            _minuteNum01.count = 0;
            _minuteNum02.count = 0;
         }
         if(param3 > 0)
         {
            if(param3 > 9 && param3 < 99)
            {
               _hourNum01.count = int(param3.toString().charAt(1));
               _hourNum02.count = int(param3.toString().charAt(0));
               _hourNum03.count = 0;
            }
            else if(param3 > 99)
            {
               _hourNum01.count = int(param3.toString().charAt(2));
               _hourNum02.count = int(param3.toString().charAt(1));
               _hourNum03.count = int(param3.toString().charAt(0));
            }
            else
            {
               _hourNum01.count = param3;
               _hourNum02.count = 0;
               _hourNum03.count = 0;
            }
         }
         else
         {
            _hourNum01.count = 0;
            _hourNum02.count = 0;
            _hourNum03.count = 0;
         }
      }
      
      private function __TimerCompleteHander(param1:Event) : void
      {
         if(countDownComplete)
         {
            _timer.stop();
            countDownComplete = false;
         }
         else
         {
            _timer.reset();
            _timer.start();
         }
      }
      
      public function setInfo(param1:IndianaShopItemInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         _info = param1;
         if(_info)
         {
            _itemInfo = IndianaDataManager.instance.getIndianaGoodsItemInfoByshopId(_info.ShopId);
            showdata = IndianaDataManager.instance.currentShowData;
            _loc2_ = _itemInfo.Cost / 100;
            _loc3_ = showdata.buyNumber;
            _loc4_ = _loc3_ / _loc2_;
            _times.maxChars = _info.MinBuyTimes * 10;
            if(_info.MinBuyTimes > 1)
            {
               _timeHelpBtn.visible = true;
               _timeHelpBtn.tipData = LanguageMgr.GetTranslation("Indiana.buy.dis",_info.MinBuyTimes);
            }
            else
            {
               _timeHelpBtn.visible = false;
            }
            _endtimer = DateUtils.decodeDated(_info.EndTime);
            _countDownDate = _endtimer.time - TimeManager.Instance.Now().time;
            if(showdata.joinCount > 0)
            {
               _indianaDis.htmlText = LanguageMgr.GetTranslation("Indiana.resoult.checkSelfCodeII",showdata.joinCount);
               _lookNumSelf.visible = true;
               _lookNumSelf.x = _indianaDis.x + _indianaDis.textWidth + 4;
            }
            else
            {
               _indianaDis.htmlText = LanguageMgr.GetTranslation("Indiana.infopanel.disII");
               _lookNumSelf.visible = false;
            }
            _hasJoin.text = LanguageMgr.GetTranslation("Indiana.has.join.count",_loc3_);
            _totleJoin.text = LanguageMgr.GetTranslation("Indiana.totle.count",_loc2_);
            _progressBar.setProgress(_loc4_);
            _times.text = _info.MinBuyTimes.toString();
            setTimesTips();
            if(!_timer.running)
            {
               _timer.start();
            }
            if(_loc4_ == 1)
            {
               SocketManager.Instance.out.sendIndianaEnterGame(0);
            }
         }
      }
      
      private function __indianaBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_info)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            time = int(_times.text);
            _loc6_ = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"));
            _loc4_ = IndianaDataManager.instance.getIndianaGoodsItemInfoByshopId(_info.ShopId);
            if(_loc4_)
            {
               if(_loc4_.IsBindMoney == 0)
               {
                  _loc5_ = LanguageMgr.GetTranslation("Indiana.propt.money",time * 100,LanguageMgr.GetTranslation("createConsortionFrame.ticketText.Text2"));
                  _loc6_.data = _loc5_;
                  baseAlerFrame = AlertManager.Instance.alert("SimpleAlert",_loc6_,2);
                  baseAlerFrame.addEventListener("response",__frameEvent);
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("createConsortionFrame.ticketText.Text2") + "(" + LanguageMgr.GetTranslation("consortion.skillFrame.richesText3") + ")";
                  _loc5_ = LanguageMgr.GetTranslation("Indiana.propt.money",time * 100,_loc3_);
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),_loc5_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
                  _loc2_.addEventListener("response",__onAlertBuyStiveFrame);
               }
            }
         }
      }
      
      private function __onAlertBuyStiveFrame(param1:FrameEvent) : void
      {
         e = param1;
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertBuyStiveFrame);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(alertFrame.isBand,time * 100,function():void
            {
               SocketManager.Instance.out.sendIndiana(_info.PeriodId,time,CheckMoneyUtils.instance.isBind);
               if(IndianaDataManager.instance.updataRecode)
               {
                  SocketManager.Instance.out.sendIndianaCurrentData(_info.PeriodId);
               }
            });
         }
         alertFrame.dispose();
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         evt = param1;
         baseAlerFrame.removeEventListener("response",__frameEvent);
         ObjectUtils.disposeObject(baseAlerFrame);
         baseAlerFrame = null;
         SoundManager.instance.play("008");
         switch(int(evt.responseCode) - 2)
         {
            case 0:
            case 1:
               CheckMoneyUtils.instance.checkMoney(false,time * 100,function():void
               {
                  SocketManager.Instance.out.sendIndiana(_info.PeriodId,time,false);
                  if(IndianaDataManager.instance.updataRecode)
                  {
                     SocketManager.Instance.out.sendIndianaCurrentData(_info.PeriodId);
                  }
               });
         }
      }
      
      private function __subClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = _times.text;
         if(_loc2_ > _info.MinBuyTimes)
         {
            _loc2_ = _loc2_ - _info.MinBuyTimes;
         }
         else
         {
            _loc2_ = _info.MinBuyTimes;
         }
         _times.text = _loc2_.toString();
         setTimesTips();
      }
      
      private function __addClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = int(_times.text);
         var _loc2_:int = _itemInfo.Cost / 100 - showdata.buyNumber;
         var _loc4_:* = _loc2_;
         if(_loc3_ < _loc4_)
         {
            _loc3_ = int(_loc3_ + _info.MinBuyTimes);
         }
         else
         {
            _loc3_ = _loc4_;
         }
         _times.text = _loc3_.toString();
         setTimesTips();
      }
      
      private function removeEvent() : void
      {
         _addTimeBtn.removeEventListener("click",__addClickHandler);
         _subtractTimeBtn.removeEventListener("click",__subClickHandler);
         _indianaBtn.removeEventListener("click",__indianaBtnClickHandler);
         _timer.removeEventListener("timer",__TimerHander);
         _timer.removeEventListener("timerComplete",__TimerCompleteHander);
         _lookNumSelf.removeEventListener("link",__linkHandler);
         _times.removeEventListener("textInput",__inputHandler);
         _times.removeEventListener("focusOut",__outFocusHandler);
         _times.removeEventListener("change",__txtChangeHandler);
         _times.removeEventListener("mouseOver",__overTimeHandler);
         _times.removeEventListener("mouseOut",__outTimeHandler);
      }
      
      public function dispose() : void
      {
         _timer.stop();
         removeEvent();
         TimerManager.getInstance().removeJugglerByTimer(_timer);
         _timer = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _hasJoin = null;
         _totleJoin = null;
         _line = null;
         _timesDis = null;
         _timesDis1 = null;
         _timesDisII = null;
         _timesBg = null;
         _times = null;
         _addTimeBtn = null;
         _subtractTimeBtn = null;
         _timeHelpBtn = null;
         _indianaBtn = null;
         _indianaDis = null;
         _indianaDisII = null;
         _countDown = null;
         _secondNum01 = null;
         _secondNum02 = null;
         _minuteNum01 = null;
         _minuteNum02 = null;
         _hourNum01 = null;
         _hourNum02 = null;
         _hourNum03 = null;
         _progressBar = null;
         _endtimer = null;
         _lookNumSelf = null;
      }
   }
}
