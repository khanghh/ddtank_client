package campbattle.view.roleView
{
   import campbattle.CampBattleControl;
   import campbattle.event.MapEvent;
   import com.greensock.TweenMax;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.ui.Mouse;
   import game.objects.GameSmallEnemy;
   import gameCommon.model.GameNeedMovieInfo;
   import gameCommon.model.SmallEnemy;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CampGameSmallEnemy extends GameSmallEnemy
   {
      
      public static const MOUSE_ON_GLOW_FILTER:Array = [new GlowFilter(16776960,1,8,8,2,2)];
      
      private static var WALK:String = "walk";
      
      private static var END:String = "stand";
      
      private static var FLY:String = "fly";
      
      private static var STANDA:String = "standA";
       
      
      private var _gameLiving:GameNeedMovieInfo;
      
      private var _timer:TimerJuggler;
      
      private var _isChange:Boolean;
      
      private var _actContent:Sprite;
      
      private var _sword:MovieClip;
      
      private var _fighting:MovieClip;
      
      public function CampGameSmallEnemy(param1:SmallEnemy){super(null);}
      
      override protected function initView() : void{}
      
      private function loadGameLiving(param1:SmallEnemy) : void{}
      
      public function get LivingID() : int{return 0;}
      
      public function setStateType(param1:int) : void{}
      
      private function initEvents() : void{}
      
      protected function __onMouseMove(param1:MouseEvent) : void{}
      
      protected function __onMouseOut(param1:MouseEvent) : void{}
      
      protected function __onMouseOver(param1:MouseEvent) : void{}
      
      protected function setCharacterFilter(param1:Boolean) : void{}
      
      private function __onMouseClick(param1:MouseEvent) : void{}
      
      private function removeEvents() : void{}
      
      protected function __onTimerHander(param1:Event) : void{}
      
      private function livingMove(param1:int) : void{}
      
      private function walkOver() : void{}
      
      private function hasThisAction(param1:String) : Boolean{return false;}
      
      protected function __onLoadGameLivingComplete(param1:LoaderEvent) : void{}
      
      override public function dispose() : void{}
   }
}
