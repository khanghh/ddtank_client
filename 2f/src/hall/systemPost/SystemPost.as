package hall.systemPost{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.manager.SystemPostManager;   import flash.display.Bitmap;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import hall.event.NewHallEvent;      public class SystemPost extends Sprite implements Disposeable   {                   private var _indentationBtn:SelectedButton;            private var _postSprite:Sprite;            private var _postBg:Bitmap;            private var _currItem:SystemPostItem;            public function SystemPost() { super(); }
            private function initMask() : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function initData() : void { }
            protected function __onReceivePost(event:Event) : void { }
            private function addListItem(msg:String, type:int) : void { }
            protected function __onMouseClick(event:MouseEvent) : void { }
            protected function __onIndentationClick(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}