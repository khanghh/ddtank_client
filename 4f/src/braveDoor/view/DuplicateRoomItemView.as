package braveDoor.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.display.Sprite;   import room.model.RoomInfo;      public class DuplicateRoomItemView extends Sprite implements Disposeable   {                   private var _info:RoomInfo;            private var _itemBg:Bitmap;            private var _desc:FilterFrameText;            private var _placeCountText:FilterFrameText;            public function DuplicateRoomItemView(info:RoomInfo = null) { super(); }
            private function init() : void { }
            private function update() : void { }
            private function updateBgItem(id:int) : void { }
            public function get info() : RoomInfo { return null; }
            public function set info(value:RoomInfo) : void { }
            public function dispose() : void { }
   }}