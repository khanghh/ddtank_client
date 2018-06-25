package church.view.weddingRoomList{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.ChurchRoomInfo;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class WeddingRoomListItemView extends Sprite implements Disposeable   {                   private var _selected:Boolean;            private var _churchRoomInfo:ChurchRoomInfo;            private var _highClassWeddingBg:MutipleImage;            private var _weddingRoomListItemAsset:Scale9CornerImage;            private var _weddingRoomListItemNumber:FilterFrameText;            private var _roomListItemLockAsset:Bitmap;            private var _weddingRoomListItemName:FilterFrameText;            private var _weddingRoomListItemCount:FilterFrameText;            public function WeddingRoomListItemView() { super(); }
            protected function initialize() : void { }
            private function update() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __mouseOverHandler(evt:MouseEvent) : void { }
            private function __mouseOutHandler(evt:MouseEvent) : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            public function get churchRoomInfo() : ChurchRoomInfo { return null; }
            public function set churchRoomInfo(value:ChurchRoomInfo) : void { }
            public function dispose() : void { }
   }}