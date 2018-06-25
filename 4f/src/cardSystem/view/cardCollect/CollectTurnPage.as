package cardSystem.view.cardCollect{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class CollectTurnPage extends Sprite implements Disposeable   {                   private var _backGround:MovieImage;            private var _pageBg:Scale9CornerImage;            private var _preBtn:BaseButton;            private var _nextBtn:BaseButton;            private var _pageText:FilterFrameText;            private var _maxPage:int;            private var _presentPage:int;            public function CollectTurnPage() { super(); }
            public function set maxPage(value:int) : void { }
            public function set page(value:int) : void { }
            public function get page() : int { return 0; }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            protected function __prePage(event:MouseEvent) : void { }
            protected function __nextPage(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}