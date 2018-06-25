package newOldPlayer
{
   import ddt.data.quest.QuestInfo;
   import ddt.events.TaskEvent;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import morn.core.handlers.Handler;
   import newOldPlayer.newOldPlayerUI.view.NewOldPlayerMainUI;
   import quest.TaskManager;
   
   public class NewOldPlayerMainFrame extends NewOldPlayerMainUI
   {
      
      private static const POWERTARGETID:int = 20;
      
      private static const MONEYTARGETID:int = 21;
      
      private static const LEVELTARGETID:int = 22;
      
      private static const ALIVETARGETID:int = 23;
      
      private static const targetIDArr:Array = [20,21,22,23];
       
      
      private var _curIndex:int = 0;
      
      public function NewOldPlayerMainFrame()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         closeBtn.clickHandler = new Handler(close);
         list_select.selectedIndex = 0;
         list_select.selectHandler = new Handler(select);
         update();
         TaskManager.instance.addEventListener("changed",__taskChange);
         updateTime();
      }
      
      private function updateTime() : void
      {
         var activeRemainTimeStr:String = ServerConfigManager.instance.OldPlayerActiveRemainTime;
         var activeTime:Number = int(activeRemainTimeStr) * 24 * 60 * 60 * 1000;
         var spendTime:Number = TimeManager.Instance.Now().time - NewOldPlayerManager.instance.changeZoneTime * 1000;
         var remainTime:Number = activeTime - spendTime;
         var remainHours:int = remainTime / 1000 / 60 / 60;
         if(remainHours >= 24)
         {
            hourImg.visible = false;
            dayImg.visible = true;
            remainCount.count = remainHours / 24;
         }
         else
         {
            dayImg.visible = false;
            hourImg.visible = true;
            remainCount.count = remainHours;
         }
      }
      
      private function __taskChange(e:TaskEvent) : void
      {
         var info:QuestInfo = e.info;
         if(targetIDArr.indexOf(info.Type) != -1)
         {
            update();
         }
      }
      
      private function update() : void
      {
         var taskArr:* = null;
         var questInfo:* = null;
         setVisibleByIndex(_curIndex);
         if(_curIndex != 4)
         {
            taskArr = TaskManager.instance.getAllQuestInfoByType(targetIDArr[_curIndex]);
            taskArr.sortOn("QuestID",16);
            taskView.setArr(taskArr);
            if(_curIndex == 3 && taskArr.length)
            {
               questInfo = taskArr[taskArr.length - 1];
               activeNum.text = String(questInfo.data.progress[0]);
            }
         }
      }
      
      private function select(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         _curIndex = index;
         update();
      }
      
      private function setVisibleByIndex(index:int) : void
      {
         taskView.visible = index == 4?false:true;
         desView.visible = index == 4?true:false;
         paopaoBox.visible = index == 3?true:false;
      }
      
      private function close() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override public function dispose() : void
      {
         TaskManager.instance.removeEventListener("changed",__taskChange);
         super.dispose();
      }
   }
}
