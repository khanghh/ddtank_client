package ddt.view{   import com.pickgliss.layout.StageResizeUtils;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.DesktopManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.HelperDataModuleLoad;   import ddt.utils.PositionUtils;   import feedback.FeedbackManager;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.net.URLRequest;   import flash.net.navigateToURL;      public class DailyButtunBar extends Sprite implements Disposeable   {            private static var instance:DailyButtunBar;                   private var _inited:Boolean;            private var _vBox:VBox;            private var _downLoadClientBtn:SimpleBitmapButton;            private var _complainBtn:MovieImage;            private var _eyeBtn:ScaleFrameImage;            private var _hideFlag:Boolean = true;            private var _clickDate:Number = 0;            public function DailyButtunBar() { super(); }
            public static function get Insance() : DailyButtunBar { return null; }
            public function dispose() : void { }
            public function hide() : void { }
            public function initView() : void { }
            protected function __onEyeClick(event:MouseEvent) : void { }
            public function setEyeBtnFrame(id:int) : void { }
            private function __onActionClick(evt:MouseEvent) : void { }
            public function show() : void { }
            public function setComplainGlow(value:Boolean) : void { }
            private function __onComplainClick(event:MouseEvent) : void { }
            private function __complainShow() : void { }
            private function initEvent() : void { }
            private function __pathInfoChangeHandler(event:CEvent) : void { }
            private function checkFeedbackBtn() : void { }
            private function removeFeedbackBtn() : void { }
            private function checkDownLoadClientBtn() : void { }
            private function removeDownLoadClientBtn() : void { }
            private function removeEvent() : void { }
            public function set hideFlag(value:Boolean) : void { }
            public function get hideFlag() : Boolean { return false; }
   }}