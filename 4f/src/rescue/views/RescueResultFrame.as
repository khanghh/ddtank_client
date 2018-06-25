package rescue.views{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.ImgNumConverter;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import rescue.data.RescueResultInfo;      public class RescueResultFrame extends Frame   {                   private var _bg:Bitmap;            private var _sceneImg:Bitmap;            private var _scoreContainer:Sprite;            private var _scoreTxt:Sprite;            private var _hbox:HBox;            private var _star:Bitmap;            private var _winOrClose:Bitmap;            private var _submitBtn:TextButton;            public function RescueResultFrame() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            protected function __submitBtnClick(event:MouseEvent) : void { }
            public function setData(info:RescueResultInfo) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            private function removeEvents() : void { }
            override public function dispose() : void { }
   }}