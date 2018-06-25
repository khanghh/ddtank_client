package ddt.view.chat{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.IconButton;   import com.pickgliss.ui.image.Image;   import ddt.manager.IMManager;   import flash.events.MouseEvent;      public class ChatTransregionalNamePanel extends ChatBasePanel   {                   private var _bg:Image;            private var _blackListBtn:IconButton;            private var _name:String;            public function ChatTransregionalNamePanel() { super(); }
            override protected function init() : void { }
            override protected function initEvent() : void { }
            public function set NickName(value:String) : void { }
            public function get NickName() : String { return null; }
            protected function __onblackList(event:MouseEvent) : void { }
            public function getHight() : int { return 0; }
            override protected function removeEvent() : void { }
   }}