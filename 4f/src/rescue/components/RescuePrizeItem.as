package rescue.components{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.CellFactory;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import rescue.RescueControl;   import rescue.data.RescueRewardInfo;      public class RescuePrizeItem extends Sprite implements Disposeable   {                   private var _sp:Sprite;            private var _bg:Bitmap;            private var _prizeImg:Bitmap;            private var _bagCell:BagCell;            private var _alreadyGet:Bitmap;            private var _index:int;            private var _downFlag:Boolean;            public function RescuePrizeItem(index:int) { super(); }
            private function initView() : void { }
            private function addEvents() : void { }
            protected function __mouseOut(event:MouseEvent) : void { }
            protected function __mouseOver(event:MouseEvent) : void { }
            protected function __mouseUp(event:MouseEvent) : void { }
            protected function __mouseDown(event:MouseEvent) : void { }
            public function setData(reward:RescueRewardInfo) : void { }
            public function setStatus(value:int) : void { }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}