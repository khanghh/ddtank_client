package farm.viewx.poultry
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import farm.FarmModelController;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class WakeFeedCountDown extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _wakeFeed:ScaleFrameImage;
      
      private var _timeText:FilterFrameText;
      
      private var _cdTime:Number;
      
      private var _feedTimer:Timer;
      
      private var _lastClick:Number = 0;
      
      public function WakeFeedCountDown()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("farm.poultry.countdown.bg");
         addChild(_bg);
         _timeText = ComponentFactory.Instance.creatComponentByStylename("farm.poultry.countdownTime");
         addChild(_timeText);
         _wakeFeed = ComponentFactory.Instance.creatComponentByStylename("farm.poultry.wakefeedBtn");
         addChild(_wakeFeed);
         creatTimer();
      }
      
      private function creatTimer() : void
      {
         _feedTimer = new Timer(1000);
         _feedTimer.addEventListener("timer",__onTimer);
      }
      
      protected function __onTimer(param1:TimerEvent) : void
      {
         _cdTime = Number(_cdTime) - 1;
         if(_cdTime > 0)
         {
            _timeText.text = transSecond(_cdTime);
         }
         else
         {
            var _loc2_:Boolean = false;
            _timeText.visible = _loc2_;
            _bg.visible = _loc2_;
            _feedTimer.stop();
         }
      }
      
      public function setCountDownTime(param1:Date) : void
      {
         var _loc2_:Number = param1.time - TimeManager.Instance.Now().time;
         if(_loc2_ <= 0)
         {
            var _loc3_:Boolean = false;
            _timeText.visible = _loc3_;
            _bg.visible = _loc3_;
            _feedTimer.stop();
         }
         else
         {
            _loc3_ = true;
            _timeText.visible = _loc3_;
            _bg.visible = _loc3_;
            _cdTime = _loc2_ / 1000;
            if(!_feedTimer.running)
            {
               _timeText.text = transSecond(_cdTime);
               _feedTimer.start();
            }
         }
      }
      
      private function transSecond(param1:Number) : String
      {
         var _loc3_:int = Math.floor(param1 / 3600);
         var _loc4_:int = Math.floor((param1 - _loc3_ * 3600) / 60);
         var _loc2_:int = param1 - _loc3_ * 3600 - _loc4_ * 60;
         return (String("0" + _loc3_)).substr(-2) + ":" + (String("0" + _loc4_)).substr(-2) + ":" + (String("0" + _loc2_)).substr(-2);
      }
      
      protected function __onWakeFeedClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_wakeFeed.getFrame == 1)
         {
            if(PlayerManager.Instance.Self.ID == FarmModelController.instance.model.currentFarmerId)
            {
               if(getTimer() - _lastClick > 5000)
               {
                  _lastClick = getTimer();
                  SocketManager.Instance.out.inviteWakeFarmPoultry();
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.poultry.wakefeedLimitTxt"));
               }
            }
            else
            {
               SocketManager.Instance.out.wakeFarmPoultry(FarmModelController.instance.model.currentFarmerId);
            }
         }
         else
         {
            SocketManager.Instance.out.feedFarmPoultry(FarmModelController.instance.model.currentFarmerId);
         }
      }
      
      protected function __onFeedOver(param1:PkgEvent) : void
      {
         FarmModelController.instance.updateFriendListStolen();
      }
      
      public function setFrame(param1:int) : void
      {
         _wakeFeed.setFrame(param1);
         var _loc2_:* = param1 != 1;
         _timeText.visible = _loc2_;
         _bg.visible = _loc2_;
      }
      
      public function set tipData(param1:*) : void
      {
         _wakeFeed.tipData = param1;
      }
      
      private function initEvent() : void
      {
         _wakeFeed.addEventListener("click",__onWakeFeedClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,33),__onFeedOver);
      }
      
      private function removeEvent() : void
      {
         if(_wakeFeed)
         {
            _wakeFeed.removeEventListener("click",__onWakeFeedClick);
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(81,33),__onFeedOver);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
            _bg = null;
         }
         if(_wakeFeed)
         {
            _wakeFeed.dispose();
            _wakeFeed = null;
         }
         if(_timeText)
         {
            _timeText.dispose();
            _timeText = null;
         }
         if(_feedTimer)
         {
            _feedTimer.removeEventListener("timer",__onTimer);
            _feedTimer.stop();
            _feedTimer = null;
         }
      }
   }
}
