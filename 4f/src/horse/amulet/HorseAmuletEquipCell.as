package horse.amulet{   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import horse.HorseAmuletManager;   import horse.HorseManager;      public class HorseAmuletEquipCell extends HorseAmuletCell   {                   private var _openLevel:int;            private var _lockBg:Bitmap;            public function HorseAmuletEquipCell(index:int, info:ItemTemplateInfo = null) { super(null,null,null); }
            override protected function initEvent() : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            public function set openLevel(value:int) : void { }
            public function get isOpen() : Boolean { return false; }
            override public function dragDrop(effect:DragEffect) : void { }
            private function __onMouseClick(e:InteractiveEvent) : void { }
            override protected function removeEvent() : void { }
            override public function dispose() : void { }
   }}