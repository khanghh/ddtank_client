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
      
      public function CampGameSmallEnemy(param1:SmallEnemy)
      {
         super(param1);
         _actContent = new Sprite();
         initEvents();
         loadGameLiving(param1);
         _timer = TimerManager.getInstance().addTimerJuggler(10000);
         _timer.addEventListener("timer",__onTimerHander);
         _timer.start();
      }
      
      override protected function initView() : void
      {
         initMovie();
         _fighting = ComponentFactory.Instance.creat("campbattle.fighting");
         _fighting.x = -1;
         _fighting.visible = false;
         if(_info)
         {
            if(SmallEnemy(_info).stateType == 2)
            {
               _fighting.visible = true;
            }
         }
         _sword = ComponentFactory.Instance.creat("asset.CampBattle.overEnemySword");
         _sword.visible = false;
      }
      
      private function loadGameLiving(param1:SmallEnemy) : void
      {
         _gameLiving = new GameNeedMovieInfo();
         _gameLiving.type = 2;
         _gameLiving.path = "image/game/living/" + param1.actionMovieName + ".swf";
         param1.actionMovieName = "game.living." + param1.actionMovieName;
         _gameLiving.classPath = param1.actionMovieName;
         _gameLiving.addEventListener("complete",__onLoadGameLivingComplete);
         _gameLiving.startLoad();
      }
      
      public function get LivingID() : int
      {
         return info.LivingID;
      }
      
      public function setStateType(param1:int) : void
      {
         _fighting.visible = false;
         if(param1 == 2)
         {
            _fighting.visible = true;
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerHander);
         }
         else if(param1 == 1)
         {
            _timer.reset();
            _timer.start();
            _timer.addEventListener("timer",__onTimerHander);
         }
      }
      
      private function initEvents() : void
      {
         addEventListener("click",__onMouseClick);
         _actContent.addEventListener("mouseOver",__onMouseOver);
         _actContent.addEventListener("mouseOut",__onMouseOut);
      }
      
      protected function __onMouseMove(param1:MouseEvent) : void
      {
         if(_sword.visible)
         {
            _sword.x = mouseX;
            _sword.y = mouseY;
         }
      }
      
      protected function __onMouseOut(param1:MouseEvent) : void
      {
         if(_sword)
         {
            _sword.visible = false;
         }
         setCharacterFilter(false);
         Mouse.show();
         _actContent.removeEventListener("mouseMove",__onMouseMove);
      }
      
      protected function __onMouseOver(param1:MouseEvent) : void
      {
         if(_sword)
         {
            _sword.visible = true;
         }
         setCharacterFilter(true);
         Mouse.hide();
         _actContent.addEventListener("mouseMove",__onMouseMove);
      }
      
      protected function setCharacterFilter(param1:Boolean) : void
      {
         if(_actionMovie)
         {
            _actionMovie.filters = !!param1?MOUSE_ON_GLOW_FILTER:null;
         }
      }
      
      private function __onMouseClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         param1.stopImmediatePropagation();
         CampBattleControl.instance.dispatchEvent(new MapEvent("enter_fight",[x,y,_info.LivingID]));
      }
      
      private function removeEvents() : void
      {
         removeEventListener("click",__onMouseClick);
         if(_timer)
         {
            _timer.removeEventListener("timer",__onTimerHander);
         }
         if(_gameLiving)
         {
            _gameLiving.removeEventListener("complete",__onLoadGameLivingComplete);
         }
         if(_actContent)
         {
            _actContent.removeEventListener("mouseOver",__onMouseOver);
            _actContent.removeEventListener("mouseOut",__onMouseOut);
            _actContent.removeEventListener("mouseMove",__onMouseMove);
         }
      }
      
      protected function __onTimerHander(param1:Event) : void
      {
         if(!_isChange)
         {
            _isChange = true;
            _info.direction = 1;
            livingMove(x + 50);
         }
         else
         {
            _isChange = false;
            _info.direction = -1;
            livingMove(x - 50);
         }
         if(hasThisAction(WALK))
         {
            doAction(WALK);
         }
         else
         {
            doAction(FLY);
         }
      }
      
      private function livingMove(param1:int) : void
      {
         TweenMax.to(this,1,{
            "x":param1,
            "onComplete":walkOver
         });
      }
      
      private function walkOver() : void
      {
         if(hasThisAction(END))
         {
            doAction(END);
         }
         else
         {
            doAction(STANDA);
         }
      }
      
      private function hasThisAction(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         if(actionMovie)
         {
            var _loc5_:int = 0;
            var _loc4_:* = actionMovie.currentLabels;
            for each(var _loc3_ in actionMovie.currentLabels)
            {
               if(_loc3_.name == param1)
               {
                  _loc2_ = true;
                  break;
               }
            }
         }
         return _loc2_;
      }
      
      protected function __onLoadGameLivingComplete(param1:LoaderEvent) : void
      {
         replaceMovie();
         _sword.y = _actionMovie.y - (_actionMovie.height / 2 - _sword.height / 2);
         addChild(_sword);
         _fighting.y = _actionMovie.y - _actionMovie.height;
         addChild(_fighting);
         _actContent.graphics.beginFill(0,0);
         _actContent.graphics.drawRect(0,0,_actionMovie.width,_actionMovie.height);
         _actContent.graphics.endFill();
         _actContent.x = -_actionMovie.width / 2;
         _actContent.y = -_actionMovie.height;
         addChild(_actContent);
         if(!hasThisAction(END))
         {
            doAction(STANDA);
         }
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_fighting)
         {
            _fighting.stop();
            while(_fighting.numChildren)
            {
               ObjectUtils.disposeObject(_fighting.getChildAt(0));
            }
         }
         ObjectUtils.disposeObject(_fighting);
         _fighting = null;
         if(_actContent)
         {
            _actContent.graphics.clear();
         }
         _actContent = null;
         if(_sword)
         {
            ObjectUtils.disposeObject(_sword);
         }
         _sword = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerHander);
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
         }
         _timer = null;
         if(_actionMovie)
         {
            _actionMovie.stop();
            _actionMovie.mute();
            _actionMovie.dispose();
         }
         _actionMovie = null;
         super.dispose();
      }
   }
}
