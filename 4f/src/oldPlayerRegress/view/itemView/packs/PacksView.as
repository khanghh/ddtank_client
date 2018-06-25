package oldPlayerRegress.view.itemView.packs{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import road7th.comm.PackageIn;      public class PacksView extends Frame   {                   private var _titleBg:Bitmap;            private var _packTitle:ScaleFrameImage;            private var _titleBgII:Bitmap;            private var _openPacks:ScaleFrameImage;            private var _bottomBtnBg:ScaleBitmapImage;            private var _getAwardBtn:BaseButton;            private var _packsBg:ScaleBitmapImage;            private var _packsSelect:ScaleFrameImage;            private var _btnArray:Array;            private var _recvArray:Array;            private var _packsGiftView:PacksGiftView;            private var _pakcsGiftData:Array;            private var _clickID:int = 0;            private var _dayNum:int = 0;            private var _pageID:int = 0;            private var _numID:int = 0;            public function PacksView() { super(); }
            private function __getPacksInfo(event:PkgEvent) : void { }
            private function _init() : void { }
            private function initData() : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __onGetAwardClick(event:MouseEvent) : void { }
            private function __onBtnClick(event:MouseEvent) : void { }
            public function show() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
            private function removeVariable() : void { }
            private function removeArray(array:Array) : void { }
   }}