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
      
      public function addNew(param1:QuestInfo) : void
      {
         _newQuestArray.push(param1);
      }
      
      public function addCompleted(param1:QuestInfo) : void
      {
         _completedQuestArray.push(param1);
      }
      
      public function addQuest(param1:QuestInfo) : void
      {
         _questArray.push(param1);
      }
      
      public function get list() : Array
      {
         return _completedQuestArray.concat(_newQuestArray.concat(_questArray));
      }
      
      public function get haveNew() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _newQuestArray;
         for each(var _loc1_ in _newQuestArray)
         {
            if(_loc1_.data && _loc1_.data.isNew)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get haveRecommend() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < list.length)
         {
            if(list[_loc1_].StarLev == 1)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function get haveClickedNew() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _newQuestArray;
         for each(var _loc1_ in _newQuestArray)
         {
            if(_loc1_ == TaskManager.instance.currentNewQuest)
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
