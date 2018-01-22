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
      
      public function RouletteGlintView(param1:Array)
      {
         super();
         init();
         initEvent();
         _pointArray = param1;
      }
      
      private function init() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
         _timer = TimerManager.getInstance().addTimerJuggler(100,1);
         _timer.stop();
         _glintArray = new Vector.<MovieClip>();
      }
      
      private function initEvent() : void
      {
         _timer.addEventListener("timerComplete",_timerComplete);
      }
      
      private function _timerComplete(param1:Event) : void
      {
         _timer.stop();
         _clearGlint();
      }
      
      private function _restartTimer(param1:int) : void
      {
         _timer.delay = param1;
         _timer.reset();
         _timer.start();
      }
      
      public function showOneCell(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         glintType = 1;
         if(param1 >= 0 && param1 <= 17)
         {
            _loc3_ = ComponentFactory.Instance.creat("asset.awardSystem.roulette.GlintAsset");
            _loc3_.x = _pointArray[param1].x + 2;
            _loc3_.y = _pointArray[param1].y + 14;
            addChild(_loc3_);
            _glintArray.push(_loc3_);
            _restartTimer(param2);
         }
      }
      
      public function showTwoStep(param1:int) : void
      {
         glintType = 2;
         showAllCell();
         showBigGlint();
         _restartTimer(param1);
      }
      
      public function showAllCell() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ <= 17)
         {
            _loc1_ = ComponentFactory.Instance.creat("asset.awardSystem.roulette.GlintAsset");
            _loc1_.x = _pointArray[_loc2_].x + 2;
            _loc1_.y = _pointArray[_loc2_].y + 14;
            addChild(_loc1_);
            _glintArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function showBigGlint() : void
      {
         _bigGlintSprite = ComponentFactory.Instance.creat("asset.awardSystem.roulette.BigGlintAsset");
         addChild(_bigGlintSprite);
      }
      
      private function _clearGlint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _glintArray.length)
         {
            _loc1_ = _glintArray[_loc2_] as MovieClip;
            removeChild(_loc1_);
            _loc2_++;
         }
         if(_bigGlintSprite)
         {
            removeChild(_bigGlintSprite);
            _bigGlintSprite = null;
         }
         _glintArray.splice(0,_glintArray.length);
         if(glintType == 2)
         {
            dispatchEvent(new Event("bigGlintComplete"));
         }
      }
      
      public function set glintType(param1:int) : void
      {
         _glintType = param1;
      }
      
      public function get glintType() : int
      {
         return _glintType;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_timer)
         {
            _timer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
         }
         if(_bigGlintSprite)
         {
            ObjectUtils.disposeObject(_bigGlintSprite);
         }
         _bigGlintSprite = null;
         _loc1_ = 0;
         while(_loc1_ < _glintArray.length)
         {
            ObjectUtils.disposeObject(_glintArray[_loc1_]);
            _loc1_++;
         }
         _glintArray.splice(0,_glintArray.length);
      }
   }
}
