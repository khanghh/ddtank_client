package hotSpring.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.HotSpringRoomInfo;   import flash.display.Bitmap;   import flash.display.Sprite;   import hotSpring.event.HotSpringRoomListEvent;   import hotSpring.model.HotSpringRoomListModel;      public class RoomListItemView extends Sprite implements Disposeable   {                   private var _roomVO:HotSpringRoomInfo;            private var _selected:Boolean;            private var _model:HotSpringRoomListModel;            private var _itemBG:ScaleFrameImage;            private var _mcLock:Bitmap;            private var _lblRoomNumber:FilterFrameText;            private var _lblRoomName:FilterFrameText;            private var _lblCurCount:FilterFrameText;            private var _percentSinge:FilterFrameText;            private var _lblMaxCount:FilterFrameText;            public function RoomListItemView(model:HotSpringRoomListModel, roomVO:HotSpringRoomInfo) { super(); }
            private function initialize() : void { }
            private function initField() : void { }
            private function updateView() : void { }
            private function setEvent() : void { }
            private function roomUpdate(evt:HotSpringRoomListEvent) : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            public function get roomVO() : HotSpringRoomInfo { return null; }
            public function dispose() : void { }
   }}