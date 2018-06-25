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
      
      public function TimesPicGroup($info:Vector.<TimesPicInfo>, index:int)
      {
         super();
         _infos = $info;
         _index = index;
         init();
         initEvent();
      }
      
      public function init() : void
      {
         var i:int = 0;
         var tmpUV:* = null;
         _pics = new Vector.<Sprite>();
         _timer = TimerManager.getInstance().addTimerJuggler(5000);
         _maxIdx = _infos.length;
         for(i = 0; i < _maxIdx; )
         {
            if(_index == 0 && TimesController.Instance.isShowUpdateView && i == 0)
            {
               tmpUV = new TimesUpdateView(TimesController.Instance.updateContenList,true);
               tmpUV.x = 15;
               tmpUV.y = 47;
               _pics.push(tmpUV);
            }
            else
            {
               _pics.push(new TimesPicBase(_infos[i]));
               (_pics[i] as TimesPicBase).load();
            }
            i++;
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
      
      private function __onMouseOut(event:MouseEvent) : void
      {
         if(_timer && !_timer.running)
         {
            _timer.start();
         }
      }
      
      private function __onMouseOver(event:MouseEvent) : void
      {
         if(_timer && _timer.running)
         {
            _timer.stop();
         }
      }
      
      private function __onPicClick(e:MouseEvent) : void
      {
         if(_infos[_currentIdx].type == "big" || _infos[_currentIdx].type == "small")
         {
            TimesController.Instance.dispatchEvent(new TimesEvent("gotoContent",_infos[_currentIdx]));
         }
      }
      
      private function __onTick(event:Event) : void
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
      
      public function set currentIdx(value:int) : void
      {
         if(contains(_pics[_currentIdx]))
         {
            removeChild(_pics[_currentIdx]);
         }
         _currentIdx = value;
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
      
      public function set picType(str:String) : void
      {
         var i:int = 0;
         _picType = str;
         for(i = 0; i < _maxIdx; )
         {
            _infos[i].type = str;
            i++;
         }
      }
      
      public function load(startIdx:int) : void
      {
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEventListener("click",__onPicClick);
         if(_infos && _infos[0] && _infos[0].type == "big")
         {
            removeEventListener("rollOver",__onMouseOver);
            removeEventListener("rollOut",__onMouseOut);
         }
         i = 0;
         while(i < _pics.length)
         {
            ObjectUtils.disposeObject(_pics[i]);
            _pics[i] = null;
            i++;
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
