package oldPlayerRegress.view.itemView{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import oldPlayerRegress.RegressManager;   import road7th.comm.PackageIn;      public class AreaView extends Frame   {                   private var _titleBg:Bitmap;            private var _bottomBtnBg:ScaleBitmapImage;            private var _titleImg:ScaleFrameImage;            private var _areaInfo:FilterFrameText;            private var _areaInfoItem:FilterFrameText;            private var _getMoney:FilterFrameText;            private var _applyBtn:SimpleBitmapButton;            public function AreaView() { super(); }
            private function _init() : void { }
            private function initView() : void { }
            public function show() : void { }
            private function initEvent() : void { }
            protected function __onMouseClickApply(event:MouseEvent) : void { }
            protected function __onApplyPacks(event:CrazyTankSocketEvent) : void { }
            protected function __getNewAreaMoney(event:PkgEvent) : void { }
            protected function __onApplyEnable(event:CrazyTankSocketEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}