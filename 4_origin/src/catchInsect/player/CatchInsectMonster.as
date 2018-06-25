package catchInsect.player
{
   import catchInsect.CatchInsectManager;
   import catchInsect.CatchInsectMonsterManager;
   import catchInsect.data.InsectInfo;
   import catchInsect.event.InsectEvent;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
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
   
   public class CatchInsectMonster extends Sprite implements Disposeable
   {
      
      private static const Time:int = 5;
      
      private static const Distance:int = 300;
       
      
      private var _monsterInfo:InsectInfo;
      
      private var LastPos:Point;
      
      protected var _actionMovie:ActionMovie;
      
      protected var _movieTouch:Sprite;
      
      private var _timer:TimerJuggler;
      
      private var _walkTimer:TimerJuggler;
      
      private var _fightIcon:MovieClip;
      
      private var _pos:Point;
      
      private var _state:int;
      
      private var timeoutID1:uint;
      
      private var timeoutID2:uint;
      
      private var tween:TweenLite;
      
      private var aimX:int;
      
      private var aimY:int;
      
      private var isFollow:Boolean = false;
      
      public function CatchInsectMonster(pInsectInfo:InsectInfo, pPos:Point)
      {
         super();
         _pos = pPos.clone();
         LastPos = pPos;
         _monsterInfo = pInsectInfo;
         initMovie();
         this.x = _pos.x;
         this.y = _pos.y;
         initEvent();
         _fightIcon = ComponentFactory.Instance.creat("catchInsect.fighting");
         addChild(_fightIcon);
         _fightIcon.visible = false;
         _fightIcon.gotoAndStop(1);
         this.MonsterState = _monsterInfo.State;
      }
      
      public function set Pos(value:Point) : void
      {
         _pos = value;
         LastPos = value;
      }
      
      private function TimeEx() : Number
      {
         return 5 / 300;
      }
      
      public function get MonsterState() : int
      {
         return _state;
      }
      
      public function set MonsterState(value:int) : void
      {
         _state = value;
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
      
      public function get monsterInfo() : InsectInfo
      {
         return _monsterInfo;
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__onMonsterClick);
         addEventListener("mouseOver",__onMouseOverMonster);
         addEventListener("mouseOut",__onMouseOutMonster);
         _monsterInfo.addEventListener("update_monster_state",__onStateChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onMonsterClick);
         removeEventListener("mouseOver",__onMouseOverMonster);
         removeEventListener("mouseOut",__onMouseOutMonster);
         _monsterInfo.removeEventListener("update_monster_state",__onStateChange);
      }
      
      private function __onMouseOverMonster(e:MouseEvent) : void
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
      
      private function __onMouseOutMonster(e:MouseEvent) : void
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
      
      private function __onStateChange(pEvent:InsectEvent) : void
      {
         this.MonsterState = pEvent.data as int;
      }
      
      private function startTimer() : void
      {
         timeoutID1 = setTimeout(_walkTimer.start,Math.abs(Math.random() * 5000));
      }
      
      private function initMovie() : void
      {
         var movieClass:* = null;
         if(ModuleLoader.hasDefinition(_monsterInfo.ActionMovieName))
         {
            movieClass = ModuleLoader.getDefinition(_monsterInfo.ActionMovieName) as Class;
            if(_actionMovie)
            {
               _actionMovie.dispose();
               _actionMovie = null;
               ObjectUtils.disposeObject(_movieTouch);
               _movieTouch = null;
            }
            _actionMovie = new movieClass();
            addChild(_actionMovie);
            _movieTouch = new Sprite();
            _movieTouch.graphics.beginFill(0,0);
            _movieTouch.graphics.drawRect(0,0,_actionMovie.width,_actionMovie.height);
            _movieTouch.graphics.endFill();
            addChild(_movieTouch);
            _movieTouch.x = -(_actionMovie.width / 2);
            _movieTouch.y = -_actionMovie.height;
            _movieTouch.buttonMode = true;
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
            addChild(_actionMovie);
            _movieTouch = new Sprite();
            _movieTouch.graphics.beginFill(0,0);
            _movieTouch.graphics.drawRect(0,0,_actionMovie.width,_actionMovie.height);
            _movieTouch.graphics.endFill();
            addChild(_movieTouch);
            _movieTouch.x = -(_actionMovie.width / 2);
            _movieTouch.y = -_actionMovie.height;
            _movieTouch.buttonMode = true;
            _timer = TimerManager.getInstance().addTimerJuggler(500);
            _timer.addEventListener("timer",__checkActionIsReady);
            _timer.start();
         }
      }
      
      private function __walkingNow(pEvent:Event) : void
      {
         if(_actionMovie)
         {
            walk();
         }
      }
      
      protected function __checkActionIsReady(event:Event) : void
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
      
      private function __onMonsterClick(pEvent:MouseEvent) : void
      {
         CatchInsectMonsterManager.Instance.curMonster = this;
      }
      
      public function StartFight() : void
      {
         var alertAsk:* = null;
         var alertAsk2:* = null;
         if(!CatchInsectMonsterManager.Instance.isFighting && this.MonsterState <= 0)
         {
            CheckWeaponManager.instance.setFunction(this,StartFight);
            if(CheckWeaponManager.instance.isNoWeapon())
            {
               CheckWeaponManager.instance.showAlert();
               return;
            }
            if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(10616) <= 0)
            {
               alertAsk = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("catchInsect.alertNoNet"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
               alertAsk.addEventListener("response",__reponse);
               return;
            }
            if(CatchInsectManager.instance.useCakeFlag && PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(10615) <= 0)
            {
               alertAsk2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("catchInsect.alertNoBall"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
               alertAsk2.addEventListener("response",__reponse);
               return;
            }
            fight();
         }
      }
      
      protected function __reponse(event:FrameEvent) : void
      {
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__reponse);
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               fight();
         }
         frame.dispose();
      }
      
      private function fight() : void
      {
         CatchInsectMonsterManager.Instance.setupFightEvent();
         SocketManager.Instance.out.sendFightWithInsect(_monsterInfo.ID);
         CatchInsectMonsterManager.Instance.isFighting = true;
         CatchInsectMonsterManager.Instance.CurrentMonster = _monsterInfo;
         timeoutID2 = setTimeout(resetStartState,3000);
      }
      
      private function resetStartState() : void
      {
         CatchInsectMonsterManager.Instance.isFighting = false;
         CatchInsectMonsterManager.Instance.CurrentMonster = null;
      }
      
      public function walk(pAimPoint:Point = null) : void
      {
         var dis:int = 0;
         if(pAimPoint)
         {
            dis = Point.distance(pAimPoint,new Point(this.x,this.y));
            if(dis > 30)
            {
               aimX = pAimPoint.x;
               aimY = pAimPoint.y;
               _pos = new Point(aimX,aimY);
               isFollow = true;
               if(aimX >= this.x)
               {
                  _actionMovie.scaleX = -1;
               }
               else
               {
                  _actionMovie.scaleX = 1;
               }
               _actionMovie.doAction("walk");
               tween = TweenLite.to(this,dis * TimeEx(),{
                  "x":aimX,
                  "y":aimY,
                  "onComplete":onTweenComplete
               });
            }
         }
         else
         {
            if(isFollow)
            {
               return;
            }
            aimX = Math.abs(Math.random()) * 300 + (_pos.x - 150);
            aimY = _pos.y;
            if(aimX >= LastPos.x)
            {
               dis = aimX - LastPos.x;
               _actionMovie.scaleX = -1;
               _actionMovie.doAction("walk");
            }
            else
            {
               dis = LastPos.x - aimX;
               _actionMovie.scaleX = 1;
               _actionMovie.doAction("walk");
            }
            tween = TweenLite.to(this,dis * TimeEx(),{
               "x":aimX,
               "onComplete":onTweenComplete
            });
         }
      }
      
      private function onTweenComplete() : void
      {
         _actionMovie.doAction("stand");
         LastPos.x = aimX;
         LastPos.y = aimY;
         isFollow = false;
         tween = null;
      }
      
      public function dispose() : void
      {
         CatchInsectMonsterManager.Instance.isFighting = false;
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
