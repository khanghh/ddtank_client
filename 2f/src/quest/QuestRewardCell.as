package quest{   import bagAndInfo.cell.CellFactory;   import beadSystem.beadSystemManager;   import com.greensock.TweenLite;   import com.greensock.easing.Quad;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import shop.view.ShopItemCell;      public class QuestRewardCell extends Sprite implements Disposeable   {                   private const NAME_AREA_HEIGHT:int = 44;            private var quantityTxt:FilterFrameText;            private var nameTxt:FilterFrameText;            private var bgStyle:MutipleImage;            private var shine:Bitmap;            private var item:ShopItemCell;            private var _info:InventoryItemInfo;            public function QuestRewardCell(isShowBg:Boolean = true) { super(); }
            public function get _shine() : Bitmap { return null; }
            private function __overHandler(event:MouseEvent) : void { }
            private function __outHandler(event:MouseEvent) : void { }
            public function set taskType(type:int) : void { }
            public function set opitional(value:Boolean) : void { }
            public function set info(info:InventoryItemInfo) : void { }
            public function get info() : InventoryItemInfo { return null; }
            public function __setItemName(e:Event) : void { }
            public function set itemName(name:String) : void { }
            public function set selected(value:Boolean) : void { }
            public function initSelected() : void { }
            public function get selected() : Boolean { return false; }
            public function canBeSelected() : void { }
            private function __selected(evt:MouseEvent) : void { }
            public function dispose() : void { }
   }}