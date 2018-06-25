package oldPlayerComeBack.view.task{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestDataInfo;   import ddt.data.quest.QuestInfo;   import ddt.events.TaskEvent;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import quest.TaskManager;      public class OldPlayerTaskFrame extends Frame   {                   private var _view:OldPlayerTaskView;            private var _bg:Bitmap;            public function OldPlayerTaskFrame() { super(); }
            override protected function init() : void { }
            private function initEVent() : void { }
            private function removeEvent() : void { }
            private function __taskChangedHandler(evt:TaskEvent) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}