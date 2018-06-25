package flowerGiving.views{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.events.Event;      public class FlowerGivingFrame extends Frame   {                   private var _hBox:HBox;            private var _mainPageBtn:SelectedButton;            private var _todayRankBtn:SelectedButton;            private var _yesRankBtn:SelectedButton;            private var _cumuRankBtn:SelectedButton;            private var _cumuGivingBtn:SelectedButton;            private var _btnGroup:SelectedButtonGroup;            private var _view;            private var currentIndex:int;            public function FlowerGivingFrame() { super(); }
            private function initView() : void { }
            private function addEvents() : void { }
            protected function __changeHandler(event:Event) : void { }
            private function removeEvents() : void { }
            private function _response(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}