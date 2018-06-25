package store.view.storeBag{   import bagAndInfo.cell.DragEffect;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.Image;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.interfaces.IDragable;   import ddt.manager.DragManager;   import ddt.manager.PlayerManager;   import flash.display.Sprite;      public class StoreBagbgbmp extends Sprite implements IBagDrag   {                   private var bg:Image;            public function StoreBagbgbmp() { super(); }
            public function dragDrop(effect:DragEffect) : void { }
            public function dragStop(effect:DragEffect) : void { }
            public function getSource() : IDragable { return null; }
            public function dispose() : void { }
   }}