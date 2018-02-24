package ddt.view.roulette
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class RouletteGlintView extends Sprite implements Disposeable
   {
      
      public static const BIGGLINTCOMPLETE:String = "bigGlintComplete";
       
      
      private var _timer:TimerJuggler;
      
      private var _glintType:int = 0;
      
      private var _pointArray:Array;
      
      private var _bigGlintSprite:MovieClip;
      
      private var _glintArray:Vector.<MovieClip>;
      
      public function RouletteGlintView(param1:Array){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function _timerComplete(param1:Event) : void{}
      
      private function _restartTimer(param1:int) : void{}
      
      public function showOneCell(param1:int, param2:int) : void{}
      
      public function showTwoStep(param1:int) : void{}
      
      public function showAllCell() : void{}
      
      public function showBigGlint() : void{}
      
      private function _clearGlint() : void{}
      
      public function set glintType(param1:int) : void{}
      
      public function get glintType() : int{return 0;}
      
      public function dispose() : void{}
   }
}
