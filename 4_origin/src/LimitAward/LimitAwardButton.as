package LimitAward
{
   import calendar.CalendarManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.view.bossbox.TimeTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class LimitAwardButton extends Component
   {
      
      public static const HALL_POINT:int = 0;
      
      public static const PVR_ROOMLIST_POINT:int = 1;
      
      public static const PVP_ROOM_POINT:int = 2;
      
      public static const PVE_ROOMLIST_POINT:int = 3;
      
      public static const PVE_ROOM_POINT:int = 4;
       
      
      private var _openLimitAward:Sprite;
      
      private var _LimitAwardButton:MovieClip;
      
      private var _delayText:Sprite;
      
      private var timeText:FilterFrameText;
      
      private var _eventActives:Array;
      
      private var timeDiff:int;
      
      private var beginTime:Date;
      
      private var endTime:Date;
      
      private var _pointArray:Vector.<Point>;
      
      private var _timeSprite:TimeTip;
      
      private var _timer:Timer;
      
      private var _taskShineEffect:IEffect;
      
      public function LimitAwardButton(type:int)
      {
         super();
         initView(type);
         initEvent();
      }
      
      private function initView(type:int) : void
      {
         _getPoint();
         timeDiff = (CalendarManager.getInstance().getShowActiveInfo().end.getTime() - TimeManager.Instance.Now().getTime()) / 1000;
         _delayText = new Sprite();
         _openLimitAward = new Sprite();
         _openLimitAward.graphics.beginFill(0,0);
         _openLimitAward.graphics.drawRect(75,78,115,70);
         _openLimitAward.graphics.endFill();
         _LimitAwardButton = ComponentFactory.Instance.creat("asset.timeBox.LimitAwardButton");
         var timeBG:Bitmap = ComponentFactory.Instance.creatBitmap("asset.timeBox.timeBGAsset");
         timeText = ComponentFactory.Instance.creat("LimitAward.TimeBoxStyle");
         addChild(_LimitAwardButton);
         _delayText.addChild(timeBG);
         _delayText.addChild(timeText);
         _timeSprite = ComponentFactory.Instance.creat("LimitAwardBox.TimeTipTwo");
         _timeSprite.tipData = LanguageMgr.GetTranslation("tanl.timebox.LimitAwardTip");
         _timeSprite.setView(_LimitAwardButton,null);
         _timeSprite.buttonMode = true;
         addChild(_timeSprite);
         _timer = new Timer(1000,int(timeDiff));
         _timer.start();
         if((type == 3 || type == 1) && timeDiff > -1)
         {
            _LimitAwardButton.y = 26;
            _delayText.x = 79;
            _delayText.y = -29;
            _delayText.width = 130;
         }
         else if((type == 2 || type == 4) && timeDiff > -1)
         {
            _LimitAwardButton.x = 3;
            _LimitAwardButton.y = 15;
            _delayText.x = -30;
            _delayText.y = 20;
            _delayText.width = 115;
         }
         else if(type == 0 && timeDiff > -1)
         {
            _LimitAwardButton.x = 3;
            _LimitAwardButton.y = 15;
            _delayText.x = -7;
            _delayText.y = 32;
            _delayText.width = 115;
         }
         x = _pointArray[type].x;
         y = _pointArray[type].y;
      }
      
      private function initEvent() : void
      {
         if(_timeSprite)
         {
            _timeSprite.addEventListener("click",onClick);
         }
         _timer.addEventListener("timer",timerHandler);
         _timer.addEventListener("timerComplete",__complete);
      }
      
      private function timerHandler(evnet:TimerEvent) : void
      {
         timeText.text = getTimeDiff(timeDiff);
         _timeSprite.tipData = getTimeDiff(timeDiff);
         timeDiff = Number(timeDiff) - 1;
      }
      
      private function __complete(e:TimerEvent) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function getTimeDiff(diff:int) : String
      {
         var d:* = 0;
         var h:* = 0;
         var m:* = 0;
         if(diff >= 0)
         {
            d = uint(Math.floor(diff / 60 / 60 / 24));
            diff = diff % 86400;
            h = uint(Math.floor(diff / 60 / 60));
            diff = diff % 3600;
            m = uint(Math.floor(diff / 60));
         }
         return d + LanguageMgr.GetTranslation("day") + fixZero(h) + LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.hour") + fixZero(m) + LanguageMgr.GetTranslation("church.weddingRoom.frame.AddWeddingRoomFrame.minute");
      }
      
      private function fixZero(num:uint) : String
      {
         return num < 10?"0" + String(num):String(num);
      }
      
      private function onClick(event:MouseEvent) : void
      {
         CalendarManager.getInstance().qqOpen(CalendarManager.getInstance().getShowActiveInfo().ActiveID);
      }
      
      private function _getPoint() : void
      {
         var i:int = 0;
         var point:* = null;
         _pointArray = new Vector.<Point>();
         for(i = 0; i < 5; )
         {
            point = ComponentFactory.Instance.creatCustomObject("limitAwardButton.point" + i);
            _pointArray.push(point);
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         if(_timeSprite)
         {
            _timeSprite.removeEventListener("click",onClick);
         }
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
         }
         if(_timer)
         {
            _timer.removeEventListener("timerComplete",__complete);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_delayText)
         {
            ObjectUtils.disposeObject(_delayText);
         }
         _delayText = null;
         if(_openLimitAward)
         {
            ObjectUtils.disposeObject(_openLimitAward);
         }
         _openLimitAward = null;
         if(_LimitAwardButton)
         {
            ObjectUtils.disposeObject(_LimitAwardButton);
         }
         _LimitAwardButton = null;
         if(timeText)
         {
            ObjectUtils.disposeObject(timeText);
         }
         timeText = null;
         if(_timeSprite)
         {
            ObjectUtils.disposeObject(_timeSprite);
         }
         _timeSprite = null;
         _pointArray = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
