package mark.items{   import bagAndInfo.cell.BaseCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import flash.display.Shape;   import mark.MarkMgr;   import mark.data.MarkChipData;   import mark.event.MarkEvent;   import mark.mornUI.items.MarkBagItemUI;   import mark.views.MarkBagMenu;      public class MarkBagItem extends MarkBagItemUI   {                   private var _cell:BaseCell = null;            private var _id:int = -1;            public function MarkBagItem() { super(); }
            override protected function initialize() : void { }
            private function clickHandler(evt:InteractiveEvent) : void { }
            public function set data(value:MarkChipData) : void { }
            protected function doubleClickHandler(evt:InteractiveEvent) : void { }
            override public function dispose() : void { }
   }}