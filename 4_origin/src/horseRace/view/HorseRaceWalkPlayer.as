package horseRace.view
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import hall.player.HallPlayer;
   import hall.player.vo.PlayerVO;
   
   public class HorseRaceWalkPlayer extends HallPlayer implements Disposeable
   {
       
      
      public var index:int;
      
      public var speed:int = 10;
      
      public var raceLen:Number = 0;
      
      public var isGoToEnd:Boolean = false;
      
      public var isStartRace:Boolean = false;
      
      public var initPosX:int;
      
      public var endPosX:int;
      
      private var _raceTimer:Timer;
      
      public var id:int;
      
      public var rank:int;
      
      public var isSelf:Boolean;
      
      public var gameId:int;
      
      public var buffList:Array;
      
      public var isGetEnd:Boolean = false;
      
      public var currentTime:int;
      
      public var isRankByCilent:Boolean = true;
      
      private var mytime:int = 0;
      
      public function HorseRaceWalkPlayer(param1:PlayerVO, param2:Function = null)
      {
         buffList = [];
         super(param1,param2);
         addRaceTimer();
      }
      
      private function addRaceTimer() : void
      {
         _raceTimer = new Timer(20);
         _raceTimer.addEventListener("timer",_playerChangePos);
      }
      
      private function removeRaceTimer() : void
      {
         if(_raceTimer)
         {
            _raceTimer.removeEventListener("timer",_playerChangePos);
            _raceTimer.stop();
         }
         _raceTimer = null;
      }
      
      public function startRace() : void
      {
         isStartRace = true;
         _raceTimer.start();
         currentTime = getTimer();
         this.walk();
      }
      
      public function stopRace() : void
      {
         isStartRace = false;
         this.stand();
      }
      
      public function turnTo(param1:String = "left") : void
      {
         if(param1 == "right")
         {
            isDefaultCharacter = false;
         }
         else
         {
            isDefaultCharacter = true;
         }
         characterMirror();
      }
      
      public function stand() : void
      {
         if(hasEventListener("enterFrame"))
         {
            this.removeEventListener("enterFrame",onEnterFrame);
         }
         sceneCharacterActionType = "naturalStandFront";
         this.addEventListener("enterFrame",onEnterFrame);
      }
      
      public function walk() : void
      {
         if(hasEventListener("enterFrame"))
         {
            this.removeEventListener("enterFrame",onEnterFrame);
         }
         sceneCharacterActionType = "naturalWalkFront";
         this.addEventListener("enterFrame",onEnterFrame);
      }
      
      public function _playerChangePos(param1:TimerEvent) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - currentTime;
         if(isStartRace)
         {
            this.raceLen = this.raceLen + speed * _loc3_ / 1000;
         }
         currentTime = _loc2_;
      }
      
      public function stop() : void
      {
         sceneCharacterActionType = "naturalStandFront";
         if(hasEventListener("enterFrame"))
         {
            this.removeEventListener("enterFrame",onEnterFrame);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         refreshCharacterState();
         characterMirror();
         update();
      }
      
      override public function refreshCharacterState() : void
      {
      }
      
      private function characterMirror() : void
      {
         if(this.character == null)
         {
            return;
         }
         var _loc1_:int = playerHeight;
         if(!isDefaultCharacter)
         {
            this.character.scaleX = !!sceneCharacterDirection.isMirror?-1:1;
            this.character.x = !!sceneCharacterDirection.isMirror?playerWidth / 2:Number(-playerWidth / 2);
            this.playerHitArea.scaleX = this.character.scaleX;
            this.playerHitArea.x = this.character.x;
         }
         else
         {
            this.character.scaleX = 1;
            this.character.x = -60;
            this.playerHitArea.scaleX = 1;
            this.playerHitArea.x = this.character.x;
            _loc1_ = 175;
         }
         this.character.y = -_loc1_ + 12;
         this.playerHitArea.y = this.character.y;
      }
      
      override public function dispose() : void
      {
         removeRaceTimer();
         super.dispose();
      }
   }
}
