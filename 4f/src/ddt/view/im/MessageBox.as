package ddt.view.im{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.AssetModuleLoader;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import im.PresentRecordInfo;      public class MessageBox extends Sprite implements Disposeable   {                   private var _bg:ScaleBitmapImage;            private var _sign:Bitmap;            private var _title:FilterFrameText;            private var _cancelFlash:SimpleBitmapButton;            private var _vbox:VBox;            private var _item:Vector.<MessageBoxItem>;            public var overState:Boolean;            public function MessageBox() { super(); }
            private function initView() : void { }
            protected function __outHandler(event:MouseEvent) : void { }
            protected function __overHandler(event:MouseEvent) : void { }
            protected function __cancelFlashHandler(event:MouseEvent) : void { }
            public function set message(message:Vector.<PresentRecordInfo>) : void { }
            private function clearBox() : void { }
            protected function __itemDeleteHandler(event:Event) : void { }
            protected function __itemClickHandler(event:MouseEvent) : void { }
            private function showTeamChat() : void { }
            public function dispose() : void { }
   }}