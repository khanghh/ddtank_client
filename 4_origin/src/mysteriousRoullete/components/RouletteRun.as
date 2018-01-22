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
      
      public function RouletteRun()
      {
         super();
         currentIndex = 0;
         glintArr = [];
         glintTimer = new Timer(200);
         lastGlintTimer = new Timer(500);
         _sound = new RouletteSound();
         initView();
      }
      
      private function initView() : void
      {
         _yellowGlint = ComponentFactory.Instance.creat("mysteriousRoulette.mc.yellowGlint");
         PositionUtils.setPos(_yellowGlint,"mysteriousRoulette.mc.yellowGlintPos");
         addChild(_yellowGlint);
         _yellowGlint.visible = false;
         _orangeGlint = ComponentFactory.Instance.creat("mysteriousRoulette.mc.orangeGlint");
         PositionUtils.setPos(_orangeGlint,"mysteriousRoulette.mc.orangeGlintPos");
         addChild(_orangeGlint);
         _orangeGlint.visible = false;
         _pinkGlint = ComponentFactory.Instance.creat("mysteriousRoulette.mc.pinkGlint");
         PositionUtils.setPos(_pinkGlint,"mysteriousRoulette.mc.pinkGlintPos");
         addChild(_pinkGlint);
         _pinkGlint.visible = false;
         _blueGlint = ComponentFactory.Instance.creat("mysteriousRoulette.mc.blueGlint");
         PositionUtils.setPos(_blueGlint,"mysteriousRoulette.mc.blueGlintPos");
         addChild(_blueGlint);
         _blueGlint.visible = false;
         _greenGlint = ComponentFactory.Instance.creat("mysteriousRoulette.mc.greenGlint");
         PositionUtils.setPos(_greenGlint,"mysteriousRoulette.mc.greenGlintPos");
         addChild(_greenGlint);
         _greenGlint.visible = false;
         glintArr.push(_yellowGlint);
         glintArr.push(_orangeGlint);
         glintArr.push(_pinkGlint);
         glintArr.push(_blueGlint);
         glintArr.push(_greenGlint);
      }
      
      public function select(param1:int) : void
      {
         glintArr[param1].visible = true;
         glintArr[param1].gotoAndStop(9);
      }
      
      public function run(param1:int) : void
      {
         selectedIndex = param1;
         glintTimer.addEventListener("timer",onGlintTimer);
         glintTimer.start();
      }
      
      protected function onGlintTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = currentIndex;
         glintArr[_loc2_].visible = true;
         glintArr[_loc2_].gotoAndStop(1);
         glintArr[_loc2_].addEventListener("enterFrame",onEnterFrame);
         glintArr[_loc2_].play();
         _sound.playOneStep();
         if(glintTimer.currentCount > 20 && _loc2_ == selectedIndex)
         {
            lastGlintTimer.addEventListener("timer",onLastGlintTimer);
            lastGlintTimer.start();
            glintTimer.stop();
         }
         else if(_loc2_ >= 4)
         {
            currentIndex = 0;
         }
         else
         {
            currentIndex = Number(currentIndex) + 1;
         }
      }
      
      protected function onLastGlintTimer(param1:TimerEvent) : void
      {
         glintArr[selectedIndex].visible = true;
         glintArr[selectedIndex].play();
         if(lastGlintTimer.currentCount == 5)
         {
            (glintArr[selectedIndex] as MovieClip).gotoAndStop(1);
            lastGlintTimer.stop();
            lastGlintTimer.removeEventListener("timer",onLastGlintTimer);
            dispatchEvent(new Event("complete"));
         }
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         if((param1.target as MovieClip).currentFrame == (param1.target as MovieClip).totalFrames)
         {
            (param1.target as MovieClip).stop();
            (param1.target as MovieClip).visible = false;
            (param1.target as MovieClip).gotoAndStop(1);
            (param1.target as MovieClip).removeEventListener("enterFrame",onEnterFrame);
         }
      }
      
      private function removeEvent() : void
      {
         glintTimer.removeEventListener("timer",onGlintTimer);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_blueGlint)
         {
            ObjectUtils.disposeObject(_blueGlint);
         }
         _blueGlint = null;
         if(_greenGlint)
         {
            ObjectUtils.disposeObject(_greenGlint);
         }
         _greenGlint = null;
         if(_orangeGlint)
         {
            ObjectUtils.disposeObject(_orangeGlint);
         }
         _orangeGlint = null;
         if(_pinkGlint)
         {
            ObjectUtils.disposeObject(_pinkGlint);
         }
         _pinkGlint = null;
         if(_yellowGlint)
         {
            ObjectUtils.disposeObject(_yellowGlint);
         }
         _yellowGlint = null;
      }
   }
}
