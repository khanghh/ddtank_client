package consortionBattle.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortionBattle.ConsortiaBattleManager;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class ConsBatInTimer extends Sprite implements Disposeable   {                   protected var _promptTxt:FilterFrameText;            protected var _timeCD:MovieClip;            protected var _timer:TimerJuggler;            protected var _totalCount:int;            public function ConsBatInTimer() { super(); }
            protected function init() : void { }
            protected function __startCount(e:Event) : void { }
            protected function setFormat(value:int) : String { return null; }
            protected function __timerComplete(e:Event = null) : void { }
            public function dispose() : void { }
   }}