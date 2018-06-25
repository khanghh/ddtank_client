package store.godRefining.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.events.BagEvent;   import ddt.events.CEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import store.godRefining.GodRefiningManager;      public class GodRefiningView extends Sprite implements Disposeable   {                   private var _tabVbox:VBox;            private var _btnGroup:SelectedButtonGroup;            private var _fineQuenchBtn:SelectedButton;            private var _composeBtn:SelectedButton;            private var _resetBtn:SelectedButton;            private var _contentBg:DisplayObject;            private var _fineQuenchView:GodRefiningFineQuenchView;            private var _composeView:GodRefiningComposeView;            private var _resetView:GodRefiningResetView;            private var _rightView:GodRefiningRightView;            private var currentPanel;            public function GodRefiningView() { super(); }
            private function init() : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __tabChangeHandler(event:Event) : void { }
            private function __updateStoreBag(evt:BagEvent) : void { }
            private function updateBag(evt:BagEvent) : void { }
            private function __quitStartDrag(event:CEvent) : void { }
            private function __quitStopDrag(event:CEvent) : void { }
            private function __equipDoubleClickMove(event:CEvent) : void { }
            private function __propDoubleClickMove(event:CEvent) : void { }
            public function updateView() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}