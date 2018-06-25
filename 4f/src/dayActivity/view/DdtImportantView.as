package dayActivity.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class DdtImportantView extends Sprite implements Disposeable   {                   private var _prePageBtn:SimpleBitmapButton;            private var _nextPageBtn:SimpleBitmapButton;            private var _contentView:Bitmap;            private var _currentIndex:int = 0;            private var _sumIndex:int = 18;            private var _scrollPanel:ScrollPanel;            private var _hBox:HBox;            private var _contentViewVector:Vector.<Bitmap>;            public function DdtImportantView() { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            protected function __overHandler(event:MouseEvent) : void { }
            protected function __outHandler(event:MouseEvent) : void { }
            protected function __leftPageHandler(event:MouseEvent) : void { }
            private function prePage() : void { }
            private function nextPage() : void { }
            protected function __rightPageHandler(event:MouseEvent) : void { }
            public function get currentIndex() : int { return 0; }
            public function set currentIndex(value:int) : void { }
            private function disposeContentView() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}