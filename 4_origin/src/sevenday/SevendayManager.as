package sevenday
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.loader.LoaderCreate;
   import ddt.manager.GameSocketOut;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import quest.TaskManager;
   import sevenday.view.SevendayMainFrame;
   
   public class SevendayManager extends EventDispatcher
   {
      
      public static const QUEST_LIST_1:Array = [3201,3202,3203,3204,3205,3206,3207];
      
      public static const QUEST_LIST_2:Array = [3208,3209,3210,3211,3212,3213,3214];
      
      private static var _instance:SevendayManager;
       
      
      private var _sevendaysocket:GameSocketOut;
      
      private var _time:Date;
      
      private var _day:int;
      
      private var _hour:int;
      
      private var _autoOpenViewState:int = 2;
      
      private var _frame:SevendayMainFrame;
      
      public function SevendayManager($inner:inner)
      {
         super(null);
      }
      
      public static function get instance() : SevendayManager
      {
         if(_instance == null)
         {
            _instance = new SevendayManager(new inner());
         }
         return _instance;
      }
      
      public function show() : void
      {
         _autoOpenViewState = 0;
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createConsortiaLoader());
         AssetModuleLoader.addModelLoader("sevenday",6);
         AssetModuleLoader.startCodeLoader(showFrame);
      }
      
      private function showFrame() : void
      {
         if(_frame == null)
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("seventdyas.frame");
            _frame.show();
         }
      }
      
      public function hideFrame() : void
      {
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
      }
      
      public function isNotAllAchieved(id:int = 0) : Boolean
      {
         var i:int = 0;
         var questInfo:* = null;
         var taskArr:Array = [];
         taskArr = SevendayManager.QUEST_LIST_1.concat(SevendayManager.QUEST_LIST_2);
         for(i = 0; i < taskArr.length; )
         {
            questInfo = TaskManager.instance.getQuestByID(taskArr[i]);
            if((questInfo.data || questInfo.isAchieved && !questInfo.isAvailable) && id != taskArr[i])
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function updateTime() : void
      {
         var bool:Boolean = false;
         var currentDate:Date = TimeManager.Instance.Now();
         var createDate:Date = PlayerManager.Instance.Self.createPlayerDate;
         var time:Number = currentDate.time - createDate.time;
         _day = time / 86400000;
         _hour = 24 - time % 86400000 / (86400000 / 24);
      }
      
      public function get isSevenday() : Boolean
      {
         return _day < 7;
      }
      
      public function get day() : int
      {
         return _day;
      }
      
      public function get hour() : int
      {
         return _hour;
      }
      
      public function checkAutoShow() : void
      {
         if(SevendayManager.instance.isSevenday && PlayerManager.Instance.Self.Grade >= 11)
         {
            show();
         }
      }
      
      public function checkIcon() : void
      {
         updateTime();
         var isShow:Boolean = isNotAllAchieved();
         if(isSevenday && isShow)
         {
            HallIconManager.instance.updateSwitchHandler("sevenday",true);
            if(_autoOpenViewState == 2 && PlayerManager.Instance.Self.Grade <= 11)
            {
               _autoOpenViewState = 0;
               show();
            }
         }
         else
         {
            HallIconManager.instance.updateSwitchHandler("sevenday",false);
         }
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
