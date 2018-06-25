package oldPlayerComeBack.view.task{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import ddt.data.quest.QuestInfo;   import flash.display.Sprite;   import quest.TaskManager;      public class OldPlayerTaskView extends Sprite implements Disposeable   {                   private var _taskList:VBox;            private const TASK_TYPE:int = 11;            private var _scrollPanel:ScrollPanel;            private var _taskItem:OldPlayerTaskItem;            public function OldPlayerTaskView() { super(); }
            private function initView() : void { }
            private function initTaskData() : void { }
            private function addTaskItem(info:QuestInfo) : void { }
            public function updateTaskItem(info:QuestInfo) : void { }
            private function sortTaskItem() : void { }
            public function dispose() : void { }
   }}