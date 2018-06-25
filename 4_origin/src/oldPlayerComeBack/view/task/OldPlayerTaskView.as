package oldPlayerComeBack.view.task
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.quest.QuestInfo;
   import flash.display.Sprite;
   import quest.TaskManager;
   
   public class OldPlayerTaskView extends Sprite implements Disposeable
   {
       
      
      private var _taskList:VBox;
      
      private const TASK_TYPE:int = 11;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _taskItem:OldPlayerTaskItem;
      
      public function OldPlayerTaskView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _taskList = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.taskView.taskContainer");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.taskView.scrollPanel");
         _scrollPanel.setView(_taskList);
         addChild(_scrollPanel);
         initTaskData();
      }
      
      private function initTaskData() : void
      {
         var tInfo:* = null;
         var i:int = 0;
         _taskList.clearAllChild();
         var taskInfo:Array = TaskManager.instance.getAllQuestInfoByType(11);
         if(taskInfo.length > 0)
         {
            for(i = 0; i < taskInfo.length; )
            {
               tInfo = taskInfo[i];
               addTaskItem(tInfo);
               i++;
            }
            sortTaskItem();
            _taskList.refreshChildPos();
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function addTaskItem(info:QuestInfo) : void
      {
         _taskItem = new OldPlayerTaskItem();
         _taskItem.info = info;
         _taskList.addChild(_taskItem);
      }
      
      public function updateTaskItem(info:QuestInfo) : void
      {
         var item:* = null;
         var i:int = 0;
         if(_taskList)
         {
            for(i = 0; i < _taskList.numChildren; )
            {
               item = _taskList.getChildAt(i) as OldPlayerTaskItem;
               if(info.QuestID == item.getInfo().QuestID)
               {
                  item.info = info;
                  break;
               }
               i++;
            }
            sortTaskItem();
         }
      }
      
      private function sortTaskItem() : void
      {
         var itemArr:* = null;
         if(_taskList)
         {
            itemArr = [];
            while(_taskList.numChildren > 0)
            {
               itemArr.push(_taskList.removeChildAt(0));
            }
            _taskList.removeAllChild();
            itemArr.sortOn("completeType");
            while(itemArr.length > 0)
            {
               _taskList.addChild(itemArr.shift());
            }
         }
      }
      
      public function dispose() : void
      {
         _taskItem = null;
         if(_taskList)
         {
            _taskList.disposeAllChildren();
            _taskList = null;
         }
         if(_scrollPanel)
         {
            _scrollPanel.removeChildren();
         }
         _scrollPanel = null;
      }
   }
}
