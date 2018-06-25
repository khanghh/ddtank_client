package Indiana
{
   import Indiana.analyzer.IndianaShopItemInfo;
   import Indiana.model.IndianaShowData;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TextEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class IndiananDiscloseCountDownPanel extends Sprite implements Disposeable
   {
       
      
      private var _coutDown:MovieClip;
      
      private var _isMeImag:Bitmap;
      
      private var _line:MutipleImage;
      
      private var _hasNum:FilterFrameText;
      
      private var _linkNum:FilterFrameText;
      
      private var _secondNum01:NumberImage;
      
      private var _secondNum02:NumberImage;
      
      private var _minuteNum01:NumberImage;
      
      private var _minuteNum02:NumberImage;
      
      private var _hourNum01:NumberImage;
      
      private var _hourNum02:NumberImage;
      
      private var _info:IndianaShopItemInfo;
      
      private var _timer:TimerJuggler;
      
      private var _countDownDate:Number = 0;
      
      private var _endtimer:Date;
      
      private var _showdata:IndianaShowData;
      
      private var countDownComplete:Boolean = false;
      
      private var baseAlerFrame:BaseAlerFrame;
      
      public function IndiananDiscloseCountDownPanel()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _coutDown = ComponentFactory.Instance.creat("asset.countDown.resoult.bg");
         PositionUtils.setPos(_coutDown,"indiana.countDownII.pos");
         _isMeImag = ComponentFactory.Instance.creatBitmap("asset.indiana.isMe");
         _line = ComponentFactory.Instance.creatComponentByStylename("indiana.line_1");
         _hasNum = ComponentFactory.Instance.creatComponentByStylename("indiana.hasJoin.Txt");
         PositionUtils.setPos(_hasNum,"indiana.hasNum.pos");
         _hasNum.htmlText = LanguageMgr.GetTranslation("Indiana.resoult.checkSelfCodeII");
         _linkNum = ComponentFactory.Instance.creatComponentByStylename("indiana.hasJoin.Txt");
         PositionUtils.setPos(_linkNum,"indiana.hasNumII.pos");
         _linkNum.mouseEnabled = true;
         _secondNum01 = ComponentFactory.Instance.creatComponentByStylename("indiana.bnum");
         _secondNum02 = ComponentFactory.Instance.creatComponentByStylename("indiana.bnum");
         _secondNum01.count = 0;
         _secondNum02.count = 0;
         _minuteNum01 = ComponentFactory.Instance.creatComponentByStylename("indiana.bnum");
         _minuteNum02 = ComponentFactory.Instance.creatComponentByStylename("indiana.bnum");
         _minuteNum01.count = 0;
         _minuteNum02.count = 0;
         _hourNum01 = ComponentFactory.Instance.creatComponentByStylename("indiana.bnum");
         _hourNum02 = ComponentFactory.Instance.creatComponentByStylename("indiana.bnum");
         _hourNum01.count = 0;
         _hourNum02.count = 0;
         PositionUtils.setPos(_secondNum01,"indiana.countDown.second01pos_1");
         PositionUtils.setPos(_secondNum02,"indiana.countDown.second02pos_1");
         PositionUtils.setPos(_minuteNum01,"indiana.countDown.minute01pos_1");
         PositionUtils.setPos(_minuteNum02,"indiana.countDown.minute02pos_1");
         PositionUtils.setPos(_hourNum01,"indiana.countDown.hour01pos_1");
         PositionUtils.setPos(_hourNum02,"indiana.countDown.hour02pos_1");
         _timer = TimerManager.getInstance().addTimerJuggler(1000,10000);
         _timer.stop();
         addChild(_coutDown);
         addChild(_isMeImag);
         addChild(_line);
         addChild(_hasNum);
         addChild(_secondNum01);
         addChild(_secondNum02);
         addChild(_minuteNum01);
         addChild(_minuteNum02);
         addChild(_hourNum01);
         addChild(_hourNum02);
         addChild(_linkNum);
      }
      
      public function setInfo(info:IndianaShopItemInfo) : void
      {
         var severTime:* = null;
         _info = info;
         if(_info)
         {
            _showdata = IndianaDataManager.instance.currentShowData;
            severTime = TimeManager.Instance.Now();
            _countDownDate = (_showdata.humanFullTime.time - severTime.time) / 1000 + _info.CountDown;
            _timer.start();
            if(_showdata.joinCount > 0)
            {
               _linkNum.htmlText = LanguageMgr.GetTranslation("Indiana.resoult.checkSelfCode");
               _hasNum.text = LanguageMgr.GetTranslation("Indiana.resoult.checkSelfCodeII",_showdata.joinCount);
               _linkNum.x = _hasNum.x + _hasNum.textWidth + 3;
            }
            else
            {
               _hasNum.text = LanguageMgr.GetTranslation("Indiana.infopanel.disIII");
               _linkNum.text = "";
            }
         }
      }
      
      private function initEvent() : void
      {
         _timer.addEventListener("timer",__TimerHander);
         _timer.addEventListener("timerComplete",__TimerCompleteHander);
         _linkNum.addEventListener("link",__linkHandler);
      }
      
      public function stopTime() : void
      {
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
         SocketManager.Instance.out.sendIndianaCode(_showdata.per_id,id);
      }
      
      private function removeEvent() : void
      {
         _timer.removeEventListener("timer",__TimerHander);
         _timer.removeEventListener("timerComplete",__TimerCompleteHander);
         _linkNum.removeEventListener("link",__linkHandler);
      }
      
      private function __TimerHander(evt:Event) : void
      {
         var second:int = 0;
         var minute:int = 0;
         var hour:int = 0;
         if(_countDownDate > 0)
         {
            _countDownDate = Number(_countDownDate) - 1;
            if(_countDownDate / 3600 > 0)
            {
               hour = _countDownDate / 3600;
            }
            if(_countDownDate / 60 > 0)
            {
               minute = _countDownDate / 60;
            }
            if(_countDownDate % 60 > 0)
            {
               second = _countDownDate % 60;
            }
            if(hour == 0 && minute == 0 && second == 0)
            {
               countDownComplete = true;
               if(_timer)
               {
                  _timer.stop();
               }
               alert();
            }
            setDownValue(second,minute,hour);
         }
      }
      
      private function alert() : void
      {
         var alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"));
         alertInfo.data = LanguageMgr.GetTranslation("Indiana.update.view");
         baseAlerFrame = AlertManager.Instance.alert("SimpleAlert",alertInfo,2);
         baseAlerFrame.addEventListener("response",__frameEvent);
      }
      
      private function __frameEvent(event:FrameEvent) : void
      {
         baseAlerFrame.removeEventListener("response",__frameEvent);
         ObjectUtils.disposeObject(baseAlerFrame);
         baseAlerFrame = null;
         SoundManager.instance.play("008");
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendUpdateSysDate();
               SocketManager.Instance.out.sendIndianaEnterGame(0);
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
            if(hour > 9)
            {
               _hourNum01.count = int(hour.toString().charAt(1));
               _hourNum02.count = int(hour.toString().charAt(0));
            }
            else
            {
               _hourNum01.count = hour;
               _hourNum02.count = 0;
            }
         }
         else
         {
            _hourNum01.count = 0;
            _hourNum02.count = 0;
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
      
      public function dispose() : void
      {
         removeEvent();
         if(baseAlerFrame)
         {
            baseAlerFrame.removeEventListener("response",__frameEvent);
            baseAlerFrame.dispose();
            baseAlerFrame = null;
         }
         TimerManager.getInstance().removeJugglerByTimer(_timer);
         _timer = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _hourNum01 = null;
         _hourNum02 = null;
         _minuteNum01 = null;
         _minuteNum02 = null;
         _secondNum01 = null;
         _secondNum02 = null;
         _coutDown = null;
         _isMeImag = null;
         _line = null;
         _hasNum = null;
         _linkNum = null;
      }
   }
}
