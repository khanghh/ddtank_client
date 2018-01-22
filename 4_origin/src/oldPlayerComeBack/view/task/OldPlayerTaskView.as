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
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _taskList.clearAllChild();
         var _loc3_:Array = TaskManager.instance.getAllQuestInfoByType(11);
         if(_loc3_.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               _loc1_ = _loc3_[_loc2_];
               addTaskItem(_loc1_);
               _loc2_++;
            }
            sortTaskItem();
            _taskList.refreshChildPos();
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function addTaskItem(param1:QuestInfo) : void
      {
         _taskItem = new OldPlayerTaskItem();
         _taskItem.info = param1;
         _taskList.addChild(_taskItem);
      }
      
      public function updateTaskItem(param1:QuestInfo) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(_taskList)
         {
            _loc3_ = 0;
            while(_loc3_ < _taskList.numChildren)
            {
               _loc2_ = _taskList.getChildAt(_loc3_) as OldPlayerTaskItem;
               if(param1.QuestID == _loc2_.getInfo().QuestID)
               {
                  _loc2_.info = param1;
                  break;
               }
               _loc3_++;
            }
            sortTaskItem();
         }
      }
      
      private function sortTaskItem() : void
      {
         var _loc1_:* = null;
         if(_taskList)
         {
            _loc1_ = [];
            while(_taskList.numChildren > 0)
            {
               _loc1_.push(_taskList.removeChildAt(0));
            }
            _taskList.removeAllChild();
            _loc1_.sortOn("completeType");
            while(_loc1_.length > 0)
            {
               _taskList.addChild(_loc1_.shift());
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
