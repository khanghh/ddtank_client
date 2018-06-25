package Indiana.item{   import Indiana.model.IndianaData;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.TextEvent;      public class IndianaRecodeItem extends Sprite implements Disposeable   {                   private var _timeTxt:FilterFrameText;            private var _name:FilterFrameText;            private var _severName:FilterFrameText;            private var _timers:FilterFrameText;            private var _lookMa:FilterFrameText;            private var _info:IndianaData;            public function IndianaRecodeItem() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __linkHandler(e:TextEvent) : void { }
            public function set info(value:IndianaData) : void { }
            override public function get height() : Number { return 0; }
            public function dispose() : void { }
   }}