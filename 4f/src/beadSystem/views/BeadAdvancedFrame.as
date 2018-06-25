package beadSystem.views{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.BagEvent;   import ddt.manager.BeadTemplateManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.Event;   import road7th.data.DictionaryData;      public class BeadAdvancedFrame extends Frame   {                   private var _currentIndex:int;            private var _normalBtn:SelectedButton;            private var _seniorBtn:SelectedButton;            private var _hBox:HBox;            private var _btnGroup:SelectedButtonGroup;            private var _view:BeadAdvancedView;            public function BeadAdvancedFrame() { super(); }
            protected function initView() : void { }
            protected function addEvent() : void { }
            private function __onBeadBagUpdate(evt:BagEvent) : void { }
            protected function removeEvent() : void { }
            private function _response(evt:FrameEvent) : void { }
            protected function __changeHandler(event:Event) : void { }
            protected function updateViewData(info:DictionaryData, tabIndex:int) : void { }
            public function update() : void { }
            override public function dispose() : void { }
   }}