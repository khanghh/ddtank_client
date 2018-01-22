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
      
      public function ChristmasMonster(param1:MonsterInfo, param2:Point){super();}
      
      public function set Pos(param1:Point) : void{}
      
      private function TimeEx() : Number{return 0;}
      
      public function get MonsterState() : int{return 0;}
      
      public function set MonsterState(param1:int) : void{}
      
      public function get monsterInfo() : MonsterInfo{return null;}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onMouseOverMonster(param1:MouseEvent) : void{}
      
      private function __onMouseOutMonster(param1:MouseEvent) : void{}
      
      private function __onStateChange(param1:ChristmasMonsterEvent) : void{}
      
      private function startTimer() : void{}
      
      private function initMovie() : void{}
      
      private function __walkingNow(param1:Event) : void{}
      
      protected function __checkActionIsReady(param1:Event) : void{}
      
      private function __onMonsterClick(param1:MouseEvent) : void{}
      
      public function StartFight() : void{}
      
      private function resetStartState() : void{}
      
      public function walk(param1:Point = null) : void{}
      
      private function onTweenComplete() : void{}
      
      public function dispose() : void{}
   }
}
