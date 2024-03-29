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
      
      public function LimitAwardButton(param1:int){super();}
      
      private function initView(param1:int) : void{}
      
      private function initEvent() : void{}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      private function __complete(param1:TimerEvent) : void{}
      
      private function getTimeDiff(param1:int) : String{return null;}
      
      private function fixZero(param1:uint) : String{return null;}
      
      private function onClick(param1:MouseEvent) : void{}
      
      private function _getPoint() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
