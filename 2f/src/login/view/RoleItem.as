package login.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.Role;   import ddt.view.common.LevelIcon;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class RoleItem extends Sprite implements Disposeable, IListCell   {                   private var _roleInfo:Role;            private var _backImage:Bitmap;            private var _levelIcon:LevelIcon;            private var _nicknameField:FilterFrameText;            private var _data:Object;            private var _light:ScaleBitmapImage;            private var _isSelected:Boolean;            private var _deletedIcon:Bitmap;            public function RoleItem() { super(); }
            private function configUi() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __mouseOverHandler(evt:MouseEvent) : void { }
            private function __mouseOutHandler(evt:MouseEvent) : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(val:Boolean) : void { }
            public function get roleInfo() : Role { return null; }
            public function set roleInfo(val:Role) : void { }
            public function refreshDeleteIcon() : void { }
            public function dispose() : void { }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
   }}