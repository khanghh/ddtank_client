package magicHouse.magicCollection{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.NumberSelecter;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.Event;   import flash.events.MouseEvent;   import magicHouse.MagicHouseModel;      public class MagicHouseMagicPotionSelectFrame extends Frame   {                   private var _numberSelecter:NumberSelecter;            private var _countTxt:FilterFrameText;            private var _needPotionTipTxt:FilterFrameText;            private var _okBtn:TextButton;            private var _cancelBtn:TextButton;            private var _count:int;            private var _type:int;            public function MagicHouseMagicPotionSelectFrame() { super(); }
            private function initView() : void { }
            private function _update() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function selectHandler(e:Event) : void { }
            private function __okBtnHandler(e:MouseEvent) : void { }
            private function __cancelBtnHandler(e:MouseEvent) : void { }
            private function _response(e:FrameEvent) : void { }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
            override public function dispose() : void { }
   }}