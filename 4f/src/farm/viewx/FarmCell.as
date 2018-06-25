package farm.viewx{   import bagAndInfo.cell.BaseCell;   import bagAndInfo.cell.DragEffect;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.DragManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class FarmCell extends BaseCell   {                   private var _bgbmp:ScaleBitmapImage;            private var _manureNum:FilterFrameText;            private var _invInfo:InventoryItemInfo;            private var _continueDrag:Boolean;            private var _contentData:BitmapData;            public function FarmCell() { super(null); }
            protected function __outFilter(event:MouseEvent) : void { }
            protected function __overFilter(event:MouseEvent) : void { }
            override protected function createChildren() : void { }
            public function get itemInfo() : InventoryItemInfo { return null; }
            public function set itemInfo(value:InventoryItemInfo) : void { }
            override public function dragStart() : void { }
            override protected function createContentComplete() : void { }
            override public function dragStop(effect:DragEffect) : void { }
            override protected function createDragImg() : DisplayObject { return null; }
            override protected function updateSize(sp:Sprite) : void { }
            override protected function updateSizeII(sp:Sprite) : void { }
   }}