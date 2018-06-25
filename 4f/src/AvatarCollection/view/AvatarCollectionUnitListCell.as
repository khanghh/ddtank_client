package AvatarCollection.view{   import AvatarCollection.AvatarCollectionManager;   import AvatarCollection.data.AvatarCollectionUnitVo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.Helpers;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class AvatarCollectionUnitListCell extends Sprite implements Disposeable, IListCell   {                   private var _bg:ScaleFrameImage;            private var _nameTxt:FilterFrameText;            private var _data:AvatarCollectionUnitVo;            private var _canActivityIcon:Bitmap;            private var _selector:SelectedCheckButton;            private var _completeCount:int;            public function AvatarCollectionUnitListCell() { super(); }
            private function initView() : void { }
            private function onClick(e:MouseEvent) : void { }
            public function set select(value:Boolean) : void { }
            public function get select() : Boolean { return false; }
            private function updateViewData() : void { }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}