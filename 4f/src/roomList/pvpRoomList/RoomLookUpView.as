package roomList.pvpRoomList{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;      public class RoomLookUpView extends Sprite implements Disposeable   {                   private var _hallType:int;            private var _bg:Scale9CornerImage;            private var _inputText:TextInput;            private var _lookup:Bitmap;            private var _enterBtn:TextButton;            private var _flushBtn:TextButton;            private var _dividingLine:Bitmap;            private var _updateClick:Function;            public function RoomLookUpView(func:Function, hallType:int) { super(); }
            private function init() : void { }
            private function initEvent() : void { }
            protected function __onKeyDown(event:KeyboardEvent) : void { }
            private function __updateClick(event:MouseEvent) : void { }
            protected function __onStageClick(event:MouseEvent) : void { }
            protected function __textClick(event:MouseEvent) : void { }
            protected function __onEnterBtnClick(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}