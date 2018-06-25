package pyramid.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.PyramidSystemItemsInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.PyramidEvent;   import ddt.manager.PyramidManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;      public class PyramidCard extends Sprite implements Disposeable   {                   private var _openCardMovie:MovieClip;            private var _cell:PyramidCell;            public var index:String;            private var _state:int = 0;            private var _openMovieState:int = 0;            public function PyramidCard() { super(); }
            private function mouseMode(bool:Boolean) : void { }
            private function initEvent() : void { }
            private function initData() : void { }
            private function playOpenCardMovie() : void { }
            private function playCloseCardMovie() : void { }
            private function __enterFrame(event:Event) : void { }
            public function cardState(type:int, itemInfo:PyramidSystemItemsInfo = null) : void { }
            private function cellInfo(itemInfo:PyramidSystemItemsInfo) : void { }
            public function get state() : int { return 0; }
            public function reset() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}