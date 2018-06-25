package morn.core.components{   import flash.display.DisplayObject;   import flash.display.Graphics;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Rectangle;   import morn.editor.core.IContent;      public class Panel extends Box implements IContent   {                   protected var _content:Box;            protected var _vScrollBar:VScrollBar;            protected var _hScrollBar:HScrollBar;            public function Panel() { super(); }
            override protected function createChildren() : void { }
            override public function addChild(child:DisplayObject) : DisplayObject { return null; }
            private function onResize(e:Event) : void { }
            override public function addChildAt(child:DisplayObject, index:int) : DisplayObject { return null; }
            override public function removeChild(child:DisplayObject) : DisplayObject { return null; }
            override public function removeChildAt(index:int) : DisplayObject { return null; }
            override public function removeAllChild(except:DisplayObject = null) : void { }
            override public function getChildAt(index:int) : DisplayObject { return null; }
            override public function getChildByName(name:String) : DisplayObject { return null; }
            override public function getChildIndex(child:DisplayObject) : int { return 0; }
            override public function get numChildren() : int { return 0; }
            private function changeScroll() : void { }
            private function get contentWidth() : Number { return 0; }
            private function get contentHeight() : Number { return 0; }
            private function setContentSize(width:Number, height:Number) : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            public function get vScrollBarSkin() : String { return null; }
            public function set vScrollBarSkin(value:String) : void { }
            public function get hScrollBarSkin() : String { return null; }
            public function set hScrollBarSkin(value:String) : void { }
            public function get vScrollBar() : ScrollBar { return null; }
            public function get hScrollBar() : ScrollBar { return null; }
            public function get content() : Sprite { return null; }
            protected function onScrollBarChange(e:Event) : void { }
            override public function commitMeasure() : void { }
            public function scrollTo(x:Number = 0, y:Number = 0) : void { }
            public function refresh() : void { }
            override public function dispose() : void { }
   }}