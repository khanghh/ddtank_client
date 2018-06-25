package store.view.storeBag{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.greensock.TweenMax;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import store.StrengthDataManager;   import store.equipGhost.EquipGhostManager;   import store.events.StoreDargEvent;      public class StoreBagCell extends BagCell   {                   private var _light:Boolean;            private var _lockDisplayObject:DisplayObject;            private var _cellLocked:Boolean = false;            public var showLock:Boolean = false;            public function StoreBagCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:Sprite = null) { super(null,null,null,null); }
            public function get lockDisplayObject() : DisplayObject { return null; }
            public function set lockDisplayObject(value:DisplayObject) : void { }
            public function get cellLocked() : Boolean { return false; }
            public function set cellLocked(value:Boolean) : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            override public function dragStart() : void { }
            override public function dragStop(effect:DragEffect) : void { }
            private function getPlace(dragItemInfo:InventoryItemInfo) : int { return 0; }
            private function checkBagType(info:InventoryItemInfo) : Boolean { return false; }
            public function set light(value:Boolean) : void { }
            private function showEffect() : void { }
            private function hideEffect() : void { }
            override public function dispose() : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
   }}