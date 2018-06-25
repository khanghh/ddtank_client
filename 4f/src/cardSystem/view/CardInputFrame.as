package cardSystem.view{   import cardSystem.CardManager;   import cardSystem.GrooveInfoManager;   import cardSystem.data.CardGrooveInfo;   import cardSystem.data.GrooveInfo;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.FocusEvent;   import flash.events.KeyboardEvent;      public class CardInputFrame extends BaseAlerFrame   {            public static const RESTRICT:String = "0-9";            public static const DEFAULT:String = "0";                   private var _alertInfo:AlertInfo;            private var _needSoulText:FilterFrameText;            private var _SellText:FilterFrameText;            private var _SellText1:FilterFrameText;            private var _SellText2:FilterFrameText;            private var _InputTxt:FilterFrameText;            private var _sellInputBg:Scale9CornerImage;            private var _place:int;            private var _cardtype:int;            public function CardInputFrame() { super(); }
            public function set place(vaule:int) : void { }
            public function set cardtype(value:int) : void { }
            private function setView() : void { }
            private function getNeedSoul(level:String = null) : int { return 0; }
            private function setEvent() : void { }
            private function removeEvent() : void { }
            private function _change(event:Event) : void { }
            private function __Response(event:FrameEvent) : void { }
            private function confirmSubmit() : void { }
            private function checkSoul() : void { }
            private function __keyDown(event:KeyboardEvent) : void { }
            private function __focusOut(event:FocusEvent) : void { }
            override public function dispose() : void { }
   }}