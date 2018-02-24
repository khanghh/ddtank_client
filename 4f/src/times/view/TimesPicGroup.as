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
      
      public function TimesPicGroup(param1:Vector.<TimesPicInfo>, param2:int){super();}
      
      public function init() : void{}
      
      protected function initEvent() : void{}
      
      private function __onMouseOut(param1:MouseEvent) : void{}
      
      private function __onMouseOver(param1:MouseEvent) : void{}
      
      private function __onPicClick(param1:MouseEvent) : void{}
      
      private function __onTick(param1:Event) : void{}
      
      public function get currentIdx() : int{return 0;}
      
      public function set currentIdx(param1:int) : void{}
      
      public function get currentInfo() : TimesPicInfo{return null;}
      
      public function set picType(param1:String) : void{}
      
      public function load(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
