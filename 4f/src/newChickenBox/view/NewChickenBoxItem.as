package newChickenBox.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import newChickenBox.data.NewChickenBoxGoodsTempInfo;      public class NewChickenBoxItem extends Sprite   {                   private var _bg:MovieClip;            private var _cell:NewChickenBoxCell;            private var _position:int;            public var info:NewChickenBoxGoodsTempInfo;            protected var _filterString:String;            protected var _frameFilter:Array;            protected var _currentFrameIndex:int = 1;            protected var _tbxCount:FilterFrameText;            public function NewChickenBoxItem(cell:NewChickenBoxCell, bg:MovieClip) { super(); }
            public function countTextShowIf() : void { }
            public function updateCount() : void { }
            public function setBg(state:int) : void { }
            public function dispose() : void { }
            public function set filterString(value:String) : void { }
            public function get frameFilter() : Array { return null; }
            public function set frameFilter(value:Array) : void { }
            private function alphaItem(e:Event) : void { }
            private function showItem(e:Event) : void { }
            private function hideItem(e:Event) : void { }
            public function get cell() : NewChickenBoxCell { return null; }
            public function set cell(value:NewChickenBoxCell) : void { }
            public function get bg() : MovieClip { return null; }
            public function set bg(value:MovieClip) : void { }
            public function get position() : int { return 0; }
            public function set position(value:int) : void { }
            public function setFrame(frameIndex:int) : void { }
            private function __onMouseRollout(event:MouseEvent) : void { }
            private function __onMouseRollover(event:MouseEvent) : void { }
            protected function addEvent() : void { }
            protected function removeEvent() : void { }
   }}