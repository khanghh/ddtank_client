package ddtBuried.views{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.data.quest.QuestInfo;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class TaskTrackInfoView extends Sprite   {                   private var _treasure:ScaleFrameImage;            private var _taskTitle:FilterFrameText;            private var _taskInfo:FilterFrameText;            private var _taskBtn:BaseButton;            private var _func:Function;            private var _info:QuestInfo;            public function TaskTrackInfoView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __textClickHandle(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function taskBtnRect() : void { }
            public function dispose() : void { }
            public function get taskTitle() : FilterFrameText { return null; }
            public function set taskTitle(value:FilterFrameText) : void { }
            public function get taskInfo() : FilterFrameText { return null; }
            public function set taskInfo(value:FilterFrameText) : void { }
            public function set info(value:QuestInfo) : void { }
            public function get info() : QuestInfo { return null; }
            public function get func() : Function { return null; }
            public function set func(value:Function) : void { }
   }}