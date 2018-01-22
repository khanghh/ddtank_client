package mysteriousRoullete.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RouletteRun extends Sprite implements Disposeable
   {
      
      public static const repeatCount:int = 20;
       
      
      private var _yellowGlint:MovieClip;
      
      private var _orangeGlint:MovieClip;
      
      private var _pinkGlint:MovieClip;
      
      private var _blueGlint:MovieClip;
      
      private var _greenGlint:MovieClip;
      
      private var glintArr:Array;
      
      private var glintTimer:Timer;
      
      private var lastGlintTimer:Timer;
      
      private var selectedIndex:int;
      
      private var currentIndex:int;
      
      private var _sound:RouletteSound;
      
      public function RouletteRun(){super();}
      
      private function initView() : void{}
      
      public function select(param1:int) : void{}
      
      public function run(param1:int) : void{}
      
      protected function onGlintTimer(param1:TimerEvent) : void{}
      
      protected function onLastGlintTimer(param1:TimerEvent) : void{}
      
      protected function onEnterFrame(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
