package gypsyShop.ui.confirmAlertFrame{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import gypsyShop.model.GypsyPurchaseModel;      public class ConfirmFrameWithNotShowCheckManager   {                   private var _confirmFrame:ConfirmWithNotShowCheckAlert;            private var _frameType:String;            private var _needMoney:int;            private var _title:String = "";            private var _detail:String = "";            private var _onNotShowAgain:Function;            private var _isBind:Function;            private var _onComfirm:Function;            public function ConfirmFrameWithNotShowCheckManager() { super(); }
            public function set detail(value:String) : void { }
            public function set title(value:String) : void { }
            public function set frameType(value:String) : void { }
            public function set needMoney(value:int) : void { }
            public function set onNotShowAgain(value:Function) : void { }
            public function set isBind(value:Function) : void { }
            public function set onComfirm(value:Function) : void { }
            public function alert() : BaseAlerFrame { return null; }
            private function comfirmHandler(event:FrameEvent) : void { }
            private function reConfirmHandler(evt:FrameEvent) : void { }
   }}