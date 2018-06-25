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
      
      public function RouletteGlintView(pointArray:Array)
      {
         super();
         init();
         initEvent();
         _pointArray = pointArray;
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
      
      private function _timerComplete(e:Event) : void
      {
         _timer.stop();
         _clearGlint();
      }
      
      private function _restartTimer(time:int) : void
      {
         _timer.delay = time;
         _timer.reset();
         _timer.start();
      }
      
      public function showOneCell(value:int, time:int) : void
      {
         var glintSp:* = null;
         glintType = 1;
         if(value >= 0 && value <= 17)
         {
            glintSp = ComponentFactory.Instance.creat("asset.awardSystem.roulette.GlintAsset");
            glintSp.x = _pointArray[value].x + 2;
            glintSp.y = _pointArray[value].y + 14;
            addChild(glintSp);
            _glintArray.push(glintSp);
            _restartTimer(time);
         }
      }
      
      public function showTwoStep(time:int) : void
      {
         glintType = 2;
         showAllCell();
         showBigGlint();
         _restartTimer(time);
      }
      
      public function showAllCell() : void
      {
         var i:int = 0;
         var glintSp:* = null;
         for(i = 0; i <= 17; )
         {
            glintSp = ComponentFactory.Instance.creat("asset.awardSystem.roulette.GlintAsset");
            glintSp.x = _pointArray[i].x + 2;
            glintSp.y = _pointArray[i].y + 14;
            addChild(glintSp);
            _glintArray.push(glintSp);
            i++;
         }
      }
      
      public function showBigGlint() : void
      {
         _bigGlintSprite = ComponentFactory.Instance.creat("asset.awardSystem.roulette.BigGlintAsset");
         addChild(_bigGlintSprite);
      }
      
      private function _clearGlint() : void
      {
         var i:int = 0;
         var glintSp:* = null;
         for(i = 0; i < _glintArray.length; )
         {
            glintSp = _glintArray[i] as MovieClip;
            removeChild(glintSp);
            i++;
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
      
      public function set glintType(value:int) : void
      {
         _glintType = value;
      }
      
      public function get glintType() : int
      {
         return _glintType;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
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
         for(i = 0; i < _glintArray.length; )
         {
            ObjectUtils.disposeObject(_glintArray[i]);
            i++;
         }
         _glintArray.splice(0,_glintArray.length);
      }
   }
}
