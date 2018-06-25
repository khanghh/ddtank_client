package baglocked.phoneServiceFrames{   import baglocked.BagLockedController;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.MouseEvent;      public class DeleteConfirmFrame extends Frame   {            public static const MSN_MONEY:int = 50;                   private var _bagLockedController:BagLockedController;            private var _BG:ScaleBitmapImage;            private var _description:FilterFrameText;            private var _phoneNum:FilterFrameText;            private var _confirmTxt:FilterFrameText;            private var _confirmInput:TextInput;            private var _getConfirmBtn:TextButton;            private var _tips:FilterFrameText;            private var _nextBtn:TextButton;            private var type:int;            public function DeleteConfirmFrame() { super(); }
            public function init2(value:int) : void { }
            protected function __nextBtnClick(event:MouseEvent) : void { }
            protected function __getConfirmBtnClick(event:MouseEvent) : void { }
            protected function __alertGetConfirmNum(event:FrameEvent) : void { }
            private function _response(evt:FrameEvent) : void { }
            private function getConfirmMsn() : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            public function set bagLockedController(value:BagLockedController) : void { }
            public function show() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}