package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SocketManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import im.CustomInfo;      public class FriendGroupTItem extends Sprite implements Disposeable   {                   private var _text:FilterFrameText;            private var _bg:Bitmap;            private var _info:CustomInfo;            private var _nickName:String;            public function FriendGroupTItem() { super(); }
            private function initView() : void { }
            public function set info(info:CustomInfo) : void { }
            public function set NickName(str:String) : void { }
            protected function __overHandler(event:MouseEvent) : void { }
            protected function __outHandler(event:MouseEvent) : void { }
            protected function __clickHandler(event:MouseEvent) : void { }
            override public function get height() : Number { return 0; }
            public function dispose() : void { }
   }}