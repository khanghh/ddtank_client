package wasteRecycle.view{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;      public class WasteRecycleGoodsCell extends BagCell   {                   public function WasteRecycleGoodsCell(bg:Sprite) { super(null,null,null,null); }
            override public function dragDrop(effect:DragEffect) : void { }
            protected function __clickHandler(evt:InteractiveEvent) : void { }
            override public function dragStop(effect:DragEffect) : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override public function dragStart() : void { }
            protected function __cellChanged(event:Event) : void { }
            override public function dispose() : void { }
   }}