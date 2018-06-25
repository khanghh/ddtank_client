package oldplayergetticket{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import road7th.comm.PackageIn;      public class GetTicketView extends Frame   {            private static var _getSuccess:Boolean = false;                   private var _bg:ScaleBitmapImage;            private var _textBg:Bitmap;            private var _bottomBtnBg:ScaleBitmapImage;            private var _captionTxt1:FilterFrameText;            private var _captionTxt2:FilterFrameText;            private var _captionTxt3:FilterFrameText;            private var _captionTxt4:FilterFrameText;            private var _rechargeTicketNum:FilterFrameText;            private var _tiepointNum:FilterFrameText;            private var _recvBtn:BaseButton;            public function GetTicketView() { super(); }
            private function initView() : void { }
            public function setViewData(info:Array) : void { }
            private function initEvent() : void { }
            protected function __onRecvBtnClick(event:MouseEvent) : void { }
            protected function __onGetTicket(event:PkgEvent) : void { }
            protected function __onAlertResponse(event:FrameEvent) : void { }
            public function show() : void { }
            private function removeEvent() : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            override public function dispose() : void { }
   }}