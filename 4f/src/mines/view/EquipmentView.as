package mines.view{   import bagAndInfo.cell.BagCell;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import mines.MinesManager;   import mines.mornui.view.EquipmentViewUI;   import morn.core.handlers.Handler;      public class EquipmentView extends EquipmentViewUI   {                   private var itemList:Vector.<EquipmentItem>;            private var cell:MinesCell;            private var chooseType:int = 0;            private var progress:MinesProgress;            private var place:int;            public function EquipmentView() { super(); }
            override protected function initialize() : void { }
            private function levelUpArm(e:Event) : void { }
            private function levelUpHandler() : void { }
            public function cellChange(value:BagCell) : void { }
            private function clickHandler(e:MouseEvent) : void { }
            private function setProgress() : void { }
            override public function dispose() : void { }
   }}