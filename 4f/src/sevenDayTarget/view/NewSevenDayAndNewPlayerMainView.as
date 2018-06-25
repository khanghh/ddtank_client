package sevenDayTarget.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.Event;   import sevenDayTarget.controller.NewSevenDayAndNewPlayerManager;   import sevenDayTarget.model.NewTargetQuestionInfo;      public class NewSevenDayAndNewPlayerMainView extends Frame   {                   private var _btnGroup:SelectedButtonGroup;            private var _sevenDayBtn:SelectedButton;            private var _newPlayerBtn:SelectedButton;            private var _sevenDayMainView:SevenDayTargetMainView;            private var _newPlayerRewardMainView:NewPlayerRewardMainView;            public function NewSevenDayAndNewPlayerMainView() { super(); }
            private function initView() : void { }
            private function __changeHandler(event:Event) : void { }
            public function show() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            public function todayInfo() : NewTargetQuestionInfo { return null; }
            override public function dispose() : void { }
   }}