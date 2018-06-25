package pyramid.view{   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.PyramidSystemItemsInfo;   import ddt.events.PyramidEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.PyramidManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import flash.utils.Timer;   import flash.utils.clearTimeout;   import flash.utils.setTimeout;   import pyramid.PyramidControl;      public class PyramidCards extends Sprite implements Disposeable   {            public static const SHUFFLE:String = "shuffle";            public static const OPEN:String = "open";            public static const CLOSE:String = "close";            public static const BG:String = "bg";                   private var _topBox:PyramidTopBox;            private var _cards:Dictionary;            private var _cardsSprite:Sprite;            private var _currentCard:PyramidCard;            private var _shuffleMovie:MovieClip;            private var _movieCountArr:Array;            private var _playLevel:int;            private var _shuffleWaitTimer:Timer;            private var _timerCurrentCount:int;            private var _playLevelMovieStep:int = 0;            private var _timerOutNum:uint;            public function PyramidCards() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function initData() : void { }
            private function createCard(i:int, j:int) : void { }
            public function topBoxMovieMode(modeType:int = 0) : void { }
            private function __cardClickHandler(event:MouseEvent) : void { }
            private function openTopBox() : void { }
            private function openCurrendCard($card:PyramidCard) : void { }
            public function playTurnCardMovie() : void { }
            private function __cardOpenMovieHandler(event:PyramidEvent) : void { }
            public function playShuffleFullMovie() : void { }
            private function __shuffleWaitTimerHandler(event:TimerEvent) : void { }
            private function playShuffleMovie() : void { }
            private function shuffleFrameScript() : void { }
            public function checkAutoOpenCard() : void { }
            private function exeAutoOpenCard() : void { }
            public function playLevelMovie(level:int, action:String) : void { }
            private function cardLevelVisible(level:int, bool:Boolean) : void { }
            private function cardLevelState(level:int, state:int) : void { }
            private function cardLevelTimerDataUpdate(level:int, repeatCount:int) : void { }
            public function updateSelectItems() : void { }
            private function __delayReset(event:Event) : void { }
            public function upClear() : void { }
            public function reset() : void { }
            public function dispose() : void { }
   }}