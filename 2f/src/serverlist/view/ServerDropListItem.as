package serverlist.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.data.ServerInfo;   import ddt.manager.ServerManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class ServerDropListItem extends Sprite   {                   private var _info:ServerInfo;            protected var _text:FilterFrameText;            public function ServerDropListItem() { super(); }
            protected function initView() : void { }
            public function set info(value:ServerInfo) : void { }
            private function __onClick(e:MouseEvent) : void { }
            private function __onMouseOver(e:MouseEvent) : void { }
            private function __onMouseOut(e:MouseEvent) : void { }
   }}