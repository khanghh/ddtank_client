package horseRace.view{   import com.pickgliss.ui.core.Disposeable;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import flash.utils.getTimer;   import hall.player.HallPlayer;   import hall.player.vo.PlayerVO;      public class HorseRaceWalkPlayer extends HallPlayer implements Disposeable   {                   public var index:int;            public var speed:int = 10;            public var raceLen:Number = 0;            public var isGoToEnd:Boolean = false;            public var isStartRace:Boolean = false;            public var initPosX:int;            public var endPosX:int;            private var _raceTimer:Timer;            public var id:int;            public var rank:int;            public var isSelf:Boolean;            public var gameId:int;            public var buffList:Array;            public var isGetEnd:Boolean = false;            public var currentTime:int;            public var isRankByCilent:Boolean = true;            private var mytime:int = 0;            public function HorseRaceWalkPlayer(playerVO:PlayerVO, callBack:Function = null) { super(null,null); }
            private function addRaceTimer() : void { }
            private function removeRaceTimer() : void { }
            public function startRace() : void { }
            public function stopRace() : void { }
            public function turnTo(direction:String = "left") : void { }
            public function stand() : void { }
            public function walk() : void { }
            public function _playerChangePos(e:TimerEvent) : void { }
            public function stop() : void { }
            private function onEnterFrame(e:Event) : void { }
            override public function refreshCharacterState() : void { }
            private function characterMirror() : void { }
            override public function dispose() : void { }
   }}