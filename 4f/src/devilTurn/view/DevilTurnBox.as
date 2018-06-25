package devilTurn.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import devilTurn.DevilTurnManager;   import devilTurn.event.DevilTurnEvent;   import devilTurn.model.DevilTurnBoxInfo;   import devilTurn.model.DevilTurnBoxItem;   import devilTurn.view.mornui.DevilTurnBoxUI;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import road7th.utils.DateUtils;      public class DevilTurnBox extends DevilTurnBoxUI   {                   private var _giftCell:BagCell;            private var _info:DevilTurnBoxItem;            private var _boxInfo:DevilTurnBoxInfo;            private var _timer:Timer;            private var _showTipsSprite:Sprite;            public function DevilTurnBox() { super(); }
            override protected function initialize() : void { }
            private function __onClick(e:MouseEvent) : void { }
            private function __onUpdateBoxInfo(e:DevilTurnEvent) : void { }
            public function set info(value:DevilTurnBoxItem) : void { }
            private function updateView() : void { }
            private function __onTimer(e:TimerEvent) : void { }
            private function updateTime() : void { }
            private function __onOver(event:MouseEvent) : void { }
            private function __onOut(event:MouseEvent) : void { }
            private function getBagCellBg() : Sprite { return null; }
            override public function dispose() : void { }
   }}