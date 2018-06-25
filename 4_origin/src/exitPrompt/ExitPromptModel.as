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
      
      private function _returnList0Arr(arr:Array) : Array
      {
         var i:int = 0;
         var arr0:Array = [];
         for(i = 0; i < arr.length; )
         {
            arr0[i] = [];
            arr0[i][0] = QuestInfo(arr[i]).Title;
            if(QuestInfo(arr[i]).RepeatMax > 50)
            {
               arr0[i][1] = LanguageMgr.GetTranslation("ddt.exitPrompt.alotofTask");
            }
            else if(QuestInfo(arr[i]).RepeatMax == 1)
            {
               arr0[i][1] = "0/" + String(QuestInfo(arr[i]).RepeatMax);
            }
            else
            {
               arr0[i][1] = String(QuestInfo(arr[i]).RepeatMax - QuestInfo(arr[i]).data.repeatLeft) + "/" + String(QuestInfo(arr[i]).RepeatMax);
            }
            i++;
         }
         return arr0;
      }
      
      private function _returnList1Arr(arr:Array) : Array
      {
         var i:int = 0;
         var arr0:Array = [];
         for(i = 0; i < arr.length; )
         {
            arr0[i] = [];
            arr0[i][0] = QuestInfo(arr[i]).Title;
            if(QuestInfo(arr[i]).RepeatMax > 50)
            {
               arr0[i][1] = LanguageMgr.GetTranslation("ddt.exitPrompt.alotofTask");
            }
            else if(QuestInfo(arr[i]).RepeatMax == 1)
            {
               arr0[i][1] = "0/" + String(QuestInfo(arr[i]).RepeatMax);
            }
            else
            {
               arr0[i][1] = String(QuestInfo(arr[i]).RepeatMax - QuestInfo(arr[i]).data.repeatLeft) + "/" + String(QuestInfo(arr[i]).RepeatMax);
            }
            i++;
         }
         return arr0;
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
