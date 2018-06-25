package farm.viewx{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.view.common.LevelIcon;   import farm.FarmModelController;   import farm.modelx.FramFriendStateInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.filters.ColorMatrixFilter;   import vip.VipController;      public class FarmFriendListItem extends Sprite implements IListCell, Disposeable   {                   private var _itemBG:Bitmap;            private var _levelIcon:LevelIcon;            private var _nameText:FilterFrameText;            private var _stoleIcon:Bitmap;            private var _feedIcon:Bitmap;            private var _info:FramFriendStateInfo;            private var _myColorMatrix_filter:ColorMatrixFilter;            private var _vipName:GradientText;            public function FarmFriendListItem() { super(); }
            public function get info() : FramFriendStateInfo { return null; }
            private function init() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __itemClick(event:MouseEvent) : void { }
            private function __itemOver(event:MouseEvent) : void { }
            private function __itemOut(event:MouseEvent) : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            private function update() : void { }
            private function isFriendSelected() : Boolean { return false; }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}