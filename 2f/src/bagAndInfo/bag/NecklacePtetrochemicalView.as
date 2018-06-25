package bagAndInfo.bag{   import bagAndInfo.cell.CellFactory;   import bagAndInfo.cell.PersonalInfoCell;   import bagAndInfo.info.NecklaceLevelProgress;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import store.data.StoreEquipExperience;      public class NecklacePtetrochemicalView extends BaseAlerFrame   {                   private var _bg:Bitmap;            private var _levelText:FilterFrameText;            private var _currentLevel:FilterFrameText;            private var _nextLevel:FilterFrameText;            private var _numText:FilterFrameText;            private var _expText:FilterFrameText;            private var _progress:NecklaceLevelProgress;            private var _stoneCell:PersonalInfoCell;            private var _stoneInfo:InventoryItemInfo;            private var _minNum:int = 1;            private var _maxNum:int = 999;            private var _num:int;            private var _maxBtn:SimpleBitmapButton;            private var _lastCreatTime:int = 0;            public function NecklacePtetrochemicalView() { super(); }
            override protected function init() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            protected function __onMax(event:MouseEvent) : void { }
            protected function __updateInfo(event:PlayerPropertyEvent) : void { }
            protected function __onInput(event:Event) : void { }
            protected function __onFrameEvent(event:FrameEvent) : void { }
            private function isStrength() : Boolean { return false; }
            protected function __onBagUpdate(event:BagEvent) : void { }
            public function show() : void { }
            public function set number(value:int) : void { }
            private function updateView() : void { }
            override public function dispose() : void { }
   }}