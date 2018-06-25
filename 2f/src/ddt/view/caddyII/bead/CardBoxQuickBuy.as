package ddt.view.caddyII.bead{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.Event;      public class CardBoxQuickBuy extends BaseAlerFrame   {                   private var _item:QuickBuyItem;            private var _font1:Image;            private var _font2:Image;            private var _moneyBG:Image;            private var _moneyTxt:FilterFrameText;            private var _money:int;            public function CardBoxQuickBuy() { super(); }
            private function initView() : void { }
            private function removeEvent() : void { }
            private function initEvent() : void { }
            private function _numberChange(e:Event) : void { }
            private function _numberEnter(e:Event) : void { }
            private function _numberClose(e:Event) : void { }
            public function set money(value:int) : void { }
            public function get money() : int { return 0; }
            private function _response(e:FrameEvent) : void { }
            private function _showTip() : void { }
            private function buy() : void { }
            private function _responseI(e:FrameEvent) : void { }
            override public function dispose() : void { }
   }}