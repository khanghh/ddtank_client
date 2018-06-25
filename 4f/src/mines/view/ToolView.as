package mines.view{   import bagAndInfo.cell.BagCell;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import mines.MinesManager;   import mines.mornui.view.ToolViewUI;   import morn.core.handlers.Handler;      public class ToolView extends ToolViewUI   {                   private var shape:Shape;            private var nameList:Array;            private var cell:MinesCell;            private var place:int;            public function ToolView() { super(); }
            override protected function initialize() : void { }
            private function levelUpTool(e:Event) : void { }
            private function levelUp() : void { }
            public function cellChange(value:BagCell) : void { }
            public function DrawSector(shape:Shape, x:Number = 200, y:Number = 200, r:Number = 100, angle:Number = 27, startFrom:Number = 270, color:Number = 16711680) : void { }
            private function setData() : void { }
            override public function dispose() : void { }
   }}