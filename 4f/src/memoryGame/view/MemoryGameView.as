package memoryGame.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.clearTimeout;   import flash.utils.setTimeout;   import memoryGame.MemoryGameManager;   import road7th.data.DictionaryData;   import road7th.utils.DateUtils;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class MemoryGameView extends Sprite implements Disposeable   {                   private const MAX_CELL:int = 16;            private var _bg:Bitmap;            private var _openCountText:FilterFrameText;            private var _dayText:FilterFrameText;            private var _timeRemainTimer:TimerJuggler;            private var _scoreText:FilterFrameText;            private var _cellList:DictionaryData;            private var _cellContainer:Sprite;            private var _rewardList:DictionaryData;            private var _rewardContainer:Sprite;            private var _buyBtn:SimpleBitmapButton;            private var _resetBtn:SimpleBitmapButton;            private var _frame:MemoryGameFrame;            private var _infoList:Vector.<MemoryGameInfo>;            private var _closeList:Array;            public function MemoryGameView(view:MemoryGameFrame) { super(); }
            private function init() : void { }
            private function __timeRemainHandler(evt:Event) : void { }
            private function getTimeRemainStr() : String { return null; }
            private function initCell() : void { }
            private function initReward() : void { }
            private function __onGameInfo(e:PkgEvent) : void { }
            private function update(isReset:Boolean) : void { }
            private function __onGameTurnover(e:PkgEvent) : void { }
            private function __onEnter(e:Event) : void { }
            private function closeAction() : void { }
            public function gameReset() : void { }
            private function onResponse(e:FrameEvent) : void { }
            private function rewardIsGet(TemplateID:int, count:int) : void { }
            private function __onResetClick(e:MouseEvent) : void { }
            private function onResetConfirmResponse(e:FrameEvent) : void { }
            private function __onBuyClick(e:MouseEvent) : void { }
            private function __onGameBuy(e:PkgEvent) : void { }
            private function updateText() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}class MemoryGameInfo{          public var TemplateID:int;      public var count:int;      public var place1:int;      public var place2:int;      public var isGet:Boolean;      public var show1:Boolean;      public var show2:Boolean;      function MemoryGameInfo() { super(); }
}