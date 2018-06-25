package uiUtils{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.MouseEvent;      public class SelectPageUI extends Component   {            public static const FirstBtn:String = "firstBtn";            public static const PrevBtn:String = "prevBtn";            public static const NextBtn:String = "nextBtn";            public static const LastBtn:String = "lastBtn";            public static const P_FirstBtn:String = "firstBtn";            public static const P_PrevBtn:String = "prevBtn";            public static const P_NextBtn:String = "nextBtn";            public static const P_LastBtn:String = "lastBtn";            public static const P_PageText:String = "pageText";            public static const P_pageImage:String = "pageImage";            public static const P_spacing:String = "spacing";                   private const MIN_PAGE:int = 1;            private var _currentPage:int = 1;            private var _maxPage:int;            protected var _firstBtnStyle:String = "core.uiUtils.firstPageBtn";            protected var _prevBtnStyle:String = "core.uiUtils.prevPageBtn";            protected var _nextBtnStyle:String = "core.uiUtils.nextPageBtn";            protected var _lastBtnStyle:String = "core.uiUtils.lastPageBtn";            protected var _pageTextStyle:String = "core.uiUtils.pageText";            protected var _pageImageStyle:String = "core.uiUtils.pageImage";            protected var _firstBtn:SimpleBitmapButton;            protected var _prevBtn:SimpleBitmapButton;            protected var _nextBtn:SimpleBitmapButton;            protected var _lastBtn:SimpleBitmapButton;            protected var _pageText:FilterFrameText;            protected var _pageImage:Image;            protected var _isLoop:Boolean;            protected var _clickBtnType:String;            protected var _spacing:int = 0;            public function SelectPageUI() { super(); }
            override protected function addChildren() : void { }
            public function set maxPage(value:int) : void { }
            public function set firstButtonStyle(value:String) : void { }
            public function set prevButtonStyle(value:String) : void { }
            public function set nextButtonStyle(value:String) : void { }
            public function set lastButtonStyle(value:String) : void { }
            public function set pageTextStyle(value:String) : void { }
            public function set pageImageStyle(value:String) : void { }
            public function set spacing(value:int) : void { }
            public function get spacing() : int { return 0; }
            private function __onClick(e:MouseEvent) : void { }
            protected function updatePage() : void { }
            public function get clickBtnType() : String { return null; }
            public function get maxPage() : int { return 0; }
            override protected function onProppertiesUpdate() : void { }
            public function arrange() : void { }
            public function set currentPage(value:int) : void { }
            public function get currentPage() : int { return 0; }
            public function get isLoop() : Boolean { return false; }
            public function set isLoop(value:Boolean) : void { }
            public function set isSimple(value:Boolean) : void { }
            public function set isDefault(value:Boolean) : void { }
            private function getCurrentPageViewToString() : String { return null; }
            public function get firstBtn() : SimpleBitmapButton { return null; }
            public function get prevBtn() : SimpleBitmapButton { return null; }
            public function get nextBtn() : SimpleBitmapButton { return null; }
            public function get lastBtn() : SimpleBitmapButton { return null; }
            protected function disposeFirstBtn() : void { }
            protected function disposePrevBtn() : void { }
            protected function disposeNextBtn() : void { }
            protected function disposeLastBtn() : void { }
            protected function disposePageText() : void { }
            protected function disposePageImage() : void { }
            override public function dispose() : void { }
   }}