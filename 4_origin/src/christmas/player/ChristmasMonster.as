package christmas.player
{
   import christmas.ChristmasCoreManager;
   import christmas.event.ChristmasMonsterEvent;
   import christmas.info.MonsterInfo;
   import christmas.manager.ChristmasMonsterManager;
   import com.greensock.TweenLite;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.media.SoundTransform;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import road.game.resource.ActionMovie;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ChristmasMonster extends Sprite implements Disposeable
   {
      
      private static const Time:int = 5;
      
      private static const Distance:int = 300;
       
      
      private var _monsterInfo:MonsterInfo;
      
      private var LastPos:Point;
      
      protected var _actionMovie:ActionMovie;
      
      private var _timer:TimerJuggler;
      
      private var _walkTimer:TimerJuggler;
      
      private var _monsterNameTxt:FilterFrameText;
      
      private var _fightIcon:MovieClip;
      
      private var _pos:Point;
      
      private var _state:int;
      
      private var timeoutID1:uint;
      
      private var timeoutID2:uint;
      
      private var aimX:int;
      
      public function ChristmasMonster(param1:MonsterInfo, param2:Point)
      {
         super();
         _pos = param2.clone();
         LastPos = param2;
         _monsterInfo = param1;
         initMovie();
         _monsterNameTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.monster.name");
         _monsterNameTxt.text = _monsterInfo.MonsterName;
         _monsterNameTxt.x = -31;
         _monsterNameTxt.y = 13;
         addChild(_monsterNameTxt);
         this.x = _pos.x;
         this.y = _pos.y;
         initEvent();
         _fightIcon = ComponentFactory.Instance.creat("asset.christmasMonster.fighting");
         addChild(_fightIcon);
         _fightIcon.visible = false;
         _fightIcon.gotoAndStop(1);
         this.MonsterState = _monsterInfo.State;
      }
      
      public function set Pos(param1:Point) : void
      {
         _pos = param1;
         LastPos = param1;
      }
      
      private function TimeEx() : Number
      {
         return 5 / 300;
      }
      
      public function get MonsterState() : int
      {
         return _state;
      }
      
      public function set MonsterState(param1:int) : void
      {
         _state = param1;
         if(_state >= 1)
         {
            this.visible = true;
            _fightIcon.visible = true;
            _fightIcon.gotoAndPlay(1);
            this.filters = [new GlowFilter(16711680,1,8,8,2,2)];
            if(_walkTimer)
            {
               _walkTimer.stop();
            }
         }
         else
         {
            this.visible = true;
            _fightIcon.visible = false;
            _fightIcon.gotoAndStop(1);
            this.filters = null;
            if(_walkTimer && !_walkTimer.running)
            {
               startTimer();
            }
         }
      }
      
      public function get monsterInfo() : MonsterInfo
      {
         return _monsterInfo;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",__onMonsterClick);
         this.addEventListener("mouseOver",__onMouseOverMonster);
         this.addEventListener("mouseOut",__onMouseOutMonster);
         _monsterInfo.addEventListener("update_monster_state",__onStateChange);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__onMonsterClick);
         _monsterInfo.removeEventListener("update_monster_state",__onStateChange);
      }
      
      private function __onMouseOverMonster(param1:MouseEvent) : void
      {
         if(this.MonsterState >= 1)
         {
            this.filters = [new GlowFilter(16711680,1,8,8,2,2)];
         }
         else
         {
            this.filters = [new GlowFilter(16776960,1,8,8,2,2)];
         }
      }
      
      private function __onMouseOutMonster(param1:MouseEvent) : void
      {
         if(this.MonsterState >= 1)
         {
            this.filters = [new GlowFilter(16711680,1,8,8,2,2)];
         }
         else
         {
            this.filters = null;
         }
      }
      
      private function __onStateChange(param1:ChristmasMonsterEvent) : void
      {
         this.MonsterState = param1.data as int;
      }
      
      private function startTimer() : void
      {
         timeoutID1 = setTimeout(_walkTimer.start,Math.abs(Math.random() * 5000));
      }
      
      private function initMovie() : void
      {
         var _loc1_:* = null;
         if(ModuleLoader.hasDefinition(_monsterInfo.ActionMovieName))
         {
            _loc1_ = ModuleLoader.getDefinition(_monsterInfo.ActionMovieName) as Class;
            if(_actionMovie)
            {
               _actionMovie.dispose();
               _actionMovie = null;
            }
            _actionMovie = new _loc1_();
            _actionMovie.mouseEnabled = true;
            _actionMovie.mouseChildren = true;
            _actionMovie.buttonMode = true;
            _actionMovie.scrollRect = null;
            addChild(_actionMovie);
            this.soundTransform = new SoundTransform(0);
            _actionMovie.doAction("stand");
            _actionMovie.scaleX = -1;
            _walkTimer = TimerManager.getInstance().addTimerJuggler(5000);
            _walkTimer.addEventListener("timer",__walkingNow);
            if(this.monsterInfo.State != 1)
            {
               startTimer();
            }
         }
         else
         {
            _actionMovie = ClassUtils.CreatInstance("game.living.defaultSmallEnemyLiving") as ActionMovie;
            _actionMovie.mouseEnabled = false;
            _actionMovie.mouseChildren = false;
            _actionMovie.scrollRect = null;
            addChild(_actionMovie);
            _timer = TimerManager.getInstance().addTimerJuggler(500);
            _timer.addEventListener("timer",__checkActionIsReady);
            _timer.start();
         }
      }
      
      private function __walkingNow(param1:Event) : void
      {
         if(_actionMovie)
         {
            walk();
         }
      }
      
      protected function __checkActionIsReady(param1:Event) : void
      {
         if(ModuleLoader.hasDefinition(_monsterInfo.ActionMovieName))
         {
            _timer.stop();
            _timer.removeEventListener("timer",__checkActionIsReady);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
            initMovie();
         }
      }
      
      private function __onMonsterClick(param1:MouseEvent) : void
      {
         ChristmasMonsterManager.Instance.curMonster = this;
      }
      
      public function StartFight() : void
      {
         if(!ChristmasMonsterManager.Instance.isFighting && this.MonsterState <= 0)
         {
            CheckWeaponManager.instance.setFunction(this,StartFight);
            if(CheckWeaponManager.instance.isNoWeapon())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
               return;
            }
            SocketManager.Instance.out.sendStartFightWithMonster(this._monsterInfo.ID);
            ChristmasMonsterManager.Instance.isFighting = true;
            ChristmasMonsterManager.Instance.CurrentMonster = _monsterInfo;
            ChristmasCoreManager.instance.setupFightEvent();
            timeoutID2 = setTimeout(resetStartState,3000);
         }
      }
      
      private function resetStartState() : void
      {
         ChristmasMonsterManager.Instance.isFighting = false;
         ChristmasMonsterManager.Instance.CurrentMonster = null;
      }
      
      public function walk(param1:Point = null) : void
      {
         var _loc2_:int = 0;
         aimX = Math.abs(Math.random()) * 300 + (_pos.x - 150);
         if(aimX >= LastPos.x)
         {
            _loc2_ = aimX - LastPos.x;
            _actionMovie.scaleX = -1;
            _actionMovie.doAction("walk");
         }
         else
         {
            _loc2_ = LastPos.x - aimX;
            _actionMovie.scaleX = 1;
            _actionMovie.doAction("walk");
         }
         TweenLite.to(this,_loc2_ * TimeEx(),{
            "x":aimX,
            "onComplete":onTweenComplete
         });
      }
      
      private function onTweenComplete() : void
      {
         _actionMovie.doAction("stand");
         LastPos.x = aimX;
      }
      
      public function dispose() : void
      {
         clearTimeout(timeoutID1);
         clearTimeout(timeoutID2);
         TweenLite.killTweensOf(this);
         if(_actionMovie)
         {
            _actionMovie.dispose();
            _actionMovie = null;
         }
         if(_fightIcon && _fightIcon.parent)
         {
            _fightIcon.visible = false;
            _fightIcon.gotoAndStop(1);
            _fightIcon.parent.removeChild(_fightIcon);
         }
         _fightIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
