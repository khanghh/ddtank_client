package drgnBoatBuild.components{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.common.LevelIcon;   import drgnBoatBuild.DrgnBoatBuildCellInfo;   import drgnBoatBuild.DrgnBoatBuildManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import vip.VipController;      public class DrgnBoatBuildListCell extends Sprite implements Disposeable, IListCell   {                   private var _bg:Image;            private var _light:ScaleBitmapImage;            private var _levelIcon:LevelIcon;            private var _nameText:FilterFrameText;            private var _canIcon:Bitmap;            private var _vipName:GradientText;            private var _info:DrgnBoatBuildCellInfo;            private var _selected:Boolean = false;            public function DrgnBoatBuildListCell() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            protected function __itemClick(event:MouseEvent) : void { }
            protected function __itemOut(event:MouseEvent) : void { }
            protected function __itemOver(event:MouseEvent) : void { }
            private function removeEvents() : void { }
            public function dispose() : void { }
            private function isFriendSelected() : Boolean { return false; }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            private function update() : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}