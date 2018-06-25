package farm.view.compose.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.events.BagEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class ComposeMoveScroll extends Sprite implements Disposeable   {                   private const SHOW_HOUSEITEM_COUNT:int = 5;            private var _currentShowIndex:int = 0;            private var _petsImgVec:Vector.<FarmHouseItem>;            private var _leftBtn:SimpleBitmapButton;            private var _rightBtn:SimpleBitmapButton;            private var _bag:BagInfo;            private var _hBox:HBox;            private var _start:int;            public function ComposeMoveScroll() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __bagUpdate(event:BagEvent) : void { }
            private function update() : void { }
            private function clearItem() : void { }
            private function __ClickHandler(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}