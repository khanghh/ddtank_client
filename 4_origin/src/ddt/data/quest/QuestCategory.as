package ddt.data.quest
{
   import quest.TaskManager;
   
   public class QuestCategory
   {
       
      
      private var _completedQuestArray:Array;
      
      private var _newQuestArray:Array;
      
      private var _questArray:Array;
      
      public function QuestCategory()
      {
         super();
         _completedQuestArray = [];
         _newQuestArray = [];
         _questArray = [];
      }
      
      public function addNew(questInfo:QuestInfo) : void
      {
         _newQuestArray.push(questInfo);
      }
      
      public function addCompleted(questInfo:QuestInfo) : void
      {
         _completedQuestArray.push(questInfo);
      }
      
      public function addQuest(questInfo:QuestInfo) : void
      {
         _questArray.push(questInfo);
      }
      
      public function get list() : Array
      {
         return _completedQuestArray.concat(_newQuestArray.concat(_questArray));
      }
      
      public function get haveNew() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _newQuestArray;
         for each(var info in _newQuestArray)
         {
            if(info.data && info.data.isNew)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get haveRecommend() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < list.length; )
         {
            if(list[i].StarLev == 1)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function get haveClickedNew() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _newQuestArray;
         for each(var info in _newQuestArray)
         {
            if(info == TaskManager.instance.currentNewQuest)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get haveCompleted() : Boolean
      {
         return _completedQuestArray.length > 0;
      }
      
      public function get completedQuestArray() : Array
      {
         return _completedQuestArray.concat();
      }
      
      public function get unCompleteQuestArray() : Array
      {
         return _newQuestArray.concat(_questArray);
      }
   }
}
