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
      
      private function __overTimeHandler(e:MouseEvent) : void
      {
      }
      
      private function __outTimeHandler(e:MouseEvent) : void
      {
      }
      
      private function __txtChangeHandler(e:Event) : void
      {
         setTimesTips();
      }
      
      private function setTimesTips() : void
      {
         var temp:int = _times.text;
         var totleTimes:int = _itemInfo.Cost / 100;
         var num:* = Number(int(temp / totleTimes * 1000) / 10);
         if(num < 0.1)
         {
            num = 0.1;
         }
         _times.tipData = LanguageMgr.GetTranslation("Indiana.resoult.getPro",num.toString() + "%");
      }
      
      private function __outFocusHandler(e:FocusEvent) : void
      {
         if(_times.text == "")
         {
            _times.text = "1";
         }
      }
      
      private function __inputHandler(e:TextEvent) : void
      {
         var str:* = null;
         var temp:int = 0;
         var distance:int = 0;
         var totle:* = 0;
         e.preventDefault();
         if(isNaN(Number(e.text)))
         {
            e.text = "";
            setTimesTips();
         }
         else
         {
            str = _times.text + e.text;
            temp = str;
            distance = _itemInfo.Cost / 100 - showdata.buyNumber;
            totle = distance;
            if(temp < totle)
            {
               if(temp / _info.MinBuyTimes == 0)
               {
                  _times.appendText(e.text);
               }
               else if(temp < _info.MinBuyTimes)
               {
                  _times.text = _info.MinBuyTimes.toString();
               }
               else
               {
                  _times.text = int(Math.floor(temp / _info.MinBuyTimes)).toString();
               }
               setTimesTips();
            }
            else
            {
               _times.text = totle.toString();
               setTimesTips();
            }
         }
      }
      
      private function __linkHandler(e:TextEvent) : void
      {
         var id:int = 0;
         var cmdArray:Array = e.text.split("|");
         var cmd:String = cmdArray[0];
         if(cmd == "clickother")
         {
            id = cmdArray[1];
         }
         if(cmd == "clickself")
         {
            id = PlayerManager.Instance.Self.ID;
         }
         SocketManager.Instance.out.sendIndianaCode(showdata.per_id,id);
      }
      
      private function __TimerHander(evt:Event) : void
      {
         var second:int = 0;
         var minute:int = 0;
         var hour:int = 0;
         if(_countDownDate > 0)
         {
            _countDownDate = _countDownDate - 1000;
            if(_countDownDate / 3600000 > 0)
            {
               hour = _countDownDate / 3600000;
            }
            if(_countDownDate / 60000 > 0)
            {
               minute = _countDownDate / 60000 - hour * 60;
            }
            if(_countDownDate % 60000 / 1000 > 0)
            {
               second = _countDownDate % 60000 / 1000;
            }
            if(hour == 0 && minute == 0 && second == 0)
            {
               countDownComplete = true;
               SocketManager.Instance.out.sendUpdateSysDate();
               SocketManager.Instance.out.sendIndianaEnterGame(0);
            }
            setDownValue(second,minute,hour);
         }
      }
      
      private function setDownValue(secon:int, minute:int, hour:int) : void
      {
         if(secon > 0)
         {
            if(secon > 9)
            {
               _secondNum01.count = int(secon.toString().charAt(1));
               _secondNum02.count = int(secon.toString().charAt(0));
            }
            else
            {
               _secondNum01.count = secon;
               _secondNum02.count = 0;
            }
         }
         else
         {
            _secondNum01.count = 0;
            _secondNum02.count = 0;
         }
         if(minute > 0)
         {
            if(minute > 9)
            {
               _minuteNum01.count = int(minute.toString().charAt(1));
               _minuteNum02.count = int(minute.toString().charAt(0));
            }
            else
            {
               _minuteNum01.count = minute;
               _minuteNum02.count = 0;
            }
         }
         else
         {
            _minuteNum01.count = 0;
            _minuteNum02.count = 0;
         }
         if(hour > 0)
         {
            if(hour > 9 && hour < 99)
            {
               _hourNum01.count = int(hour.toString().charAt(1));
               _hourNum02.count = int(hour.toString().charAt(0));
               _hourNum03.count = 0;
            }
            else if(hour > 99)
            {
               _hourNum01.count = int(hour.toString().charAt(2));
               _hourNum02.count = int(hour.toString().charAt(1));
               _hourNum03.count = int(hour.toString().charAt(0));
            }
            else
            {
               _hourNum01.count = hour;
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
      
      private function __TimerCompleteHander(evt:Event) : void
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
      
      public function setInfo($_info:IndianaShopItemInfo) : void
      {
         var totleTimes:int = 0;
         var buyNum:int = 0;
         var preNum:Number = NaN;
         _info = $_info;
         if(_info)
         {
            _itemInfo = IndianaDataManager.instance.getIndianaGoodsItemInfoByshopId(_info.ShopId);
            showdata = IndianaDataManager.instance.currentShowData;
            totleTimes = _itemInfo.Cost / 100;
            buyNum = showdata.buyNumber;
            preNum = buyNum / totleTimes;
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
            _hasJoin.text = LanguageMgr.GetTranslation("Indiana.has.join.count",buyNum);
            _totleJoin.text = LanguageMgr.GetTranslation("Indiana.totle.count",totleTimes);
            _progressBar.setProgress(preNum);
            _times.text = _info.MinBuyTimes.toString();
            setTimesTips();
            if(!_timer.running)
            {
               _timer.start();
            }
            if(preNum == 1)
            {
               SocketManager.Instance.out.sendIndianaEnterGame(0);
            }
         }
      }
      
      private function __indianaBtnClickHandler(event:MouseEvent) : void
      {
         var alertInfo:* = null;
         var iteminfo:* = null;
         var msg:* = null;
         var temp:* = null;
         var alertFrame:* = null;
         if(_info)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            time = int(_times.text);
            alertInfo = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"));
            iteminfo = IndianaDataManager.instance.getIndianaGoodsItemInfoByshopId(_info.ShopId);
            if(iteminfo)
            {
               if(iteminfo.IsBindMoney == 0)
               {
                  msg = LanguageMgr.GetTranslation("Indiana.propt.money",time * 100,LanguageMgr.GetTranslation("createConsortionFrame.ticketText.Text2"));
                  alertInfo.data = msg;
                  baseAlerFrame = AlertManager.Instance.alert("SimpleAlert",alertInfo,2);
                  baseAlerFrame.addEventListener("response",__frameEvent);
               }
               else
               {
                  temp = LanguageMgr.GetTranslation("createConsortionFrame.ticketText.Text2") + "(" + LanguageMgr.GetTranslation("consortion.skillFrame.richesText3") + ")";
                  msg = LanguageMgr.GetTranslation("Indiana.propt.money",time * 100,temp);
                  alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
                  alertFrame.addEventListener("response",__onAlertBuyStiveFrame);
               }
            }
         }
      }
      
      private function __onAlertBuyStiveFrame(e:FrameEvent) : void
      {
         e = e;
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
      
      private function __frameEvent(evt:FrameEvent) : void
      {
         evt = evt;
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
      
      private function __subClickHandler(event:MouseEvent) : void
      {
         var time:int = _times.text;
         if(time > _info.MinBuyTimes)
         {
            time = time - _info.MinBuyTimes;
         }
         else
         {
            time = _info.MinBuyTimes;
         }
         _times.text = time.toString();
         setTimesTips();
      }
      
      private function __addClickHandler(event:MouseEvent) : void
      {
         var time:* = int(_times.text);
         var distance:int = _itemInfo.Cost / 100 - showdata.buyNumber;
         var totle:* = distance;
         if(time < totle)
         {
            time = int(time + _info.MinBuyTimes);
         }
         else
         {
            time = totle;
         }
         _times.text = time.toString();
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
