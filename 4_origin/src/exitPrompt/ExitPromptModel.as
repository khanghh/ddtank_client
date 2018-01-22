package exitPrompt
{
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import email.MailManager;
   import quest.TaskManager;
   
   public class ExitPromptModel
   {
       
      
      private var _list0Arr:Array;
      
      private var _list1Arr:Array;
      
      private var _list2Num:int;
      
      public function ExitPromptModel()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         _list0Arr = [];
         _list1Arr = [];
         if(TaskManager.instance.getAvailableQuests(2).list && TaskManager.instance.getAvailableQuests(3).list)
         {
            _list0Arr = _returnList0Arr(TaskManager.instance.getAvailableQuests(2).list);
            _list1Arr = _returnList1Arr(TaskManager.instance.getAvailableQuests(3).list);
         }
         if(MailManager.Instance.Model && MailManager.Instance.Model.noReadMails)
         {
            _list2Num = MailManager.Instance.Model.noReadMails.length;
         }
      }
      
      private function _returnList0Arr(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_] = [];
            _loc2_[_loc3_][0] = QuestInfo(param1[_loc3_]).Title;
            if(QuestInfo(param1[_loc3_]).RepeatMax > 50)
            {
               _loc2_[_loc3_][1] = LanguageMgr.GetTranslation("ddt.exitPrompt.alotofTask");
            }
            else if(QuestInfo(param1[_loc3_]).RepeatMax == 1)
            {
               _loc2_[_loc3_][1] = "0/" + String(QuestInfo(param1[_loc3_]).RepeatMax);
            }
            else
            {
               _loc2_[_loc3_][1] = String(QuestInfo(param1[_loc3_]).RepeatMax - QuestInfo(param1[_loc3_]).data.repeatLeft) + "/" + String(QuestInfo(param1[_loc3_]).RepeatMax);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function _returnList1Arr(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_] = [];
            _loc2_[_loc3_][0] = QuestInfo(param1[_loc3_]).Title;
            if(QuestInfo(param1[_loc3_]).RepeatMax > 50)
            {
               _loc2_[_loc3_][1] = LanguageMgr.GetTranslation("ddt.exitPrompt.alotofTask");
            }
            else if(QuestInfo(param1[_loc3_]).RepeatMax == 1)
            {
               _loc2_[_loc3_][1] = "0/" + String(QuestInfo(param1[_loc3_]).RepeatMax);
            }
            else
            {
               _loc2_[_loc3_][1] = String(QuestInfo(param1[_loc3_]).RepeatMax - QuestInfo(param1[_loc3_]).data.repeatLeft) + "/" + String(QuestInfo(param1[_loc3_]).RepeatMax);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get list0Arr() : Array
      {
         return _list0Arr;
      }
      
      public function get list1Arr() : Array
      {
         return _list1Arr;
      }
      
      public function get list2Num() : int
      {
         return _list2Num;
      }
   }
}
