package oldPlayerRegress.view.itemView.call{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import flash.geom.Point;   import oldPlayerRegress.RegressManager;   import road7th.comm.PackageIn;      public class CallView extends Frame   {                   private var _titleBg:Bitmap;            private var _bottomBtnBg:ScaleBitmapImage;            private var _titleImg:ScaleFrameImage;            private var _configBtn:SimpleBitmapButton;            private var _callInfo:FilterFrameText;            private var _inputBg:Scale9CornerImage;            private var _lookBtn:Bitmap;            private var _callLookupView:CallLookUpView;            public function CallView() { super(); }
            private function _init() : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __onCheck(event:PkgEvent) : void { }
            protected function __onMouseClick(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}