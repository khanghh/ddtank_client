package gypsyShop.ui.confirmAlertFrame{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.MouseEvent;      public class ConfirmFrameHonourWithNotShowCheckAlert extends Frame   {            public static const OK:String = "ok";            public static const CANCEL:String = "cancel";                   private var _itemInfo:InventoryItemInfo;            private var _confirm:TextButton;            private var _cancel:TextButton;            private var _detailText:FilterFrameText;            private var _scb:SelectedCheckButton;            private var _titleTxt:String;            private var _detail:String;            private var _needHonour:int;            private var _onNotShowAgain:Function;            private var _onComfirm:Function;            public function ConfirmFrameHonourWithNotShowCheckAlert() { super(); }
            protected function __confirmhandler(event:MouseEvent) : void { }
            protected function __cancelHandler(event:MouseEvent) : void { }
            protected function __responseHandler(event:FrameEvent) : void { }
            private function ok() : void { }
            private function cancel() : void { }
            public function initView() : void { }
            public function get isNoPrompt() : Boolean { return false; }
            public function set selectedCheckButton(value:SelectedCheckButton) : void { }
            override public function dispose() : void { }
            public function set needHonour(value:int) : void { }
            public function set detail(value:String) : void { }
            public function set onNotShowAgain(value:Function) : void { }
            public function set onComfirm(value:Function) : void { }
            public function set titleTxt(value:String) : void { }
   }}