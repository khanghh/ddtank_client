package farm.viewx{   import bagAndInfo.cell.BaseCell;   import bagAndInfo.cell.DragEffect;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.DragManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class FarmKillCropCell extends BaseCell   {                   private var _bgbmp:BaseButton;            private var _invInfo:InventoryItemInfo;            private var _killCropIcon:Bitmap;            public function FarmKillCropCell() { super(null); }
            public function setBtnVis(value:Boolean) : void { }
            private function __clickHandler(event:MouseEvent) : void { }
            protected function __outFilter(event:MouseEvent) : void { }
            protected function __overFilter(event:MouseEvent) : void { }
            override protected function createChildren() : void { }
            public function get itemInfo() : InventoryItemInfo { return null; }
            public function set itemInfo(value:InventoryItemInfo) : void { }
            private function get killCropIcon() : DisplayObject { return null; }
            override public function dragStart() : void { }
            override public function dragStop(effect:DragEffect) : void { }
            override protected function updateSize(sp:Sprite) : void { }
            override protected function updateSizeII(sp:Sprite) : void { }
            override public function dispose() : void { }
   }}