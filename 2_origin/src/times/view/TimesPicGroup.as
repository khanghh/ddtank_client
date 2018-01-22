package times.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import times.TimesController;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   import times.updateView.TimesUpdateView;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class TimesPicGroup extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _pics:Vector.<Sprite>;
      
      private var _infos:Vector.<TimesPicInfo>;
      
      private var _currentIdx:int;
      
      private var _maxIdx:int;
      
      private var _picType:String;
      
      private var _timer:TimerJuggler;
      
      public function TimesPicGroup(param1:Vector.<TimesPicInfo>, param2:int)
      {
         super();
         _infos = param1;
         _index = param2;
         init();
         initEvent();
      }
      
      public function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pics = new Vector.<Sprite>();
         _timer = TimerManager.getInstance().addTimerJuggler(5000);
         _maxIdx = _infos.length;
         _loc2_ = 0;
         while(_loc2_ < _maxIdx)
         {
            if(_index == 0 && TimesController.Instance.isShowUpdateView && _loc2_ == 0)
            {
               _loc1_ = new TimesUpdateView(TimesController.Instance.updateContenList,true);
               _loc1_.x = 15;
               _loc1_.y = 47;
               _pics.push(_loc1_);
            }
            else
            {
               _pics.push(new TimesPicBase(_infos[_loc2_]));
               (_pics[_loc2_] as TimesPicBase).load();
            }
            _loc2_++;
         }
         addChild(_pics[_currentIdx]);
      }
      
      protected function initEvent() : void
      {
         addEventListener("click",__onPicClick);
         if(_infos && _infos[0] && _infos[0].type == "big")
         {
            addEventListener("rollOver",__onMouseOver);
            addEventListener("rollOut",__onMouseOut);
            _timer.addEventListener("timer",__onTick);
            _timer.start();
         }
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         if(_timer && !_timer.running)
         {
            _timer.start();
         }
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         if(_timer && _timer.running)
         {
            _timer.stop();
         }
      }
      
      private function __onPicClick(param1:MouseEvent) : void
      {
         if(_infos[_currentIdx].type == "big" || _infos[_currentIdx].type == "small")
         {
            TimesController.Instance.dispatchEvent(new TimesEvent("gotoContent",_infos[_currentIdx]));
         }
      }
      
      private function __onTick(param1:Event) : void
      {
         if(_currentIdx == _maxIdx - 1)
         {
            currentIdx = 0;
         }
         else
         {
            currentIdx = Number(currentIdx) + 1;
         }
         dispatchEvent(new Event("change"));
      }
      
      public function get currentIdx() : int
      {
         return _currentIdx;
      }
      
      public function set currentIdx(param1:int) : void
      {
         if(contains(_pics[_currentIdx]))
         {
            removeChild(_pics[_currentIdx]);
         }
         _currentIdx = param1;
         if(_timer.hasEventListener("timer"))
         {
            _timer.reset();
            _timer.start();
         }
         load(_currentIdx);
         addChild(_pics[_currentIdx]);
      }
      
      public function get currentInfo() : TimesPicInfo
      {
         return _infos[_currentIdx];
      }
      
      public function set picType(param1:String) : void
      {
         var _loc2_:int = 0;
         _picType = param1;
         _loc2_ = 0;
         while(_loc2_ < _maxIdx)
         {
            _infos[_loc2_].type = param1;
            _loc2_++;
         }
      }
      
      public function load(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEventListener("click",__onPicClick);
         if(_infos && _infos[0] && _infos[0].type == "big")
         {
            removeEventListener("rollOver",__onMouseOver);
            removeEventListener("rollOut",__onMouseOut);
         }
         _loc1_ = 0;
         while(_loc1_ < _pics.length)
         {
            ObjectUtils.disposeObject(_pics[_loc1_]);
            _pics[_loc1_] = null;
            _loc1_++;
         }
         _infos = null;
         _pics = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTick);
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
      }
   }
}
