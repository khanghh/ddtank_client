package sevenday
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.loader.LoaderCreate;
   import ddt.loader.StartupResourceLoader;
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
      
      private var _autoOpenViewState:int = 1;
      
      private var _frame:SevendayMainFrame;
      
      public function SevendayManager(param1:inner)
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
      
      public function isNotAllAchieved(param1:int = 0) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = [];
         _loc2_ = SevendayManager.QUEST_LIST_1.concat(SevendayManager.QUEST_LIST_2);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = TaskManager.instance.getQuestByID(_loc2_[_loc4_]);
            if((_loc3_.data || _loc3_.isAchieved && !_loc3_.isAvailable) && param1 != _loc2_[_loc4_])
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      private function updateTime() : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc4_:Date = PlayerManager.Instance.Self.createPlayerDate;
         var _loc1_:Number = _loc2_.time - _loc4_.time;
         _day = _loc1_ / 86400000;
         _hour = 24 - _loc1_ % 86400000 / (86400000 / 24);
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
      
      public function getQuestComplete() : Boolean
      {
         return true;
      }
      
      public function setup() : void
      {
         if(_autoOpenViewState == 0)
         {
            return;
         }
         _autoOpenViewState = 0;
         if(StartupResourceLoader.firstEnterHall || PlayerManager.Instance.Self.LastDate.day != TimeManager.Instance.Now().day)
         {
            _autoOpenViewState = 2;
         }
      }
      
      public function checkAutoShow() : void
      {
         if(SevendayManager.instance.isSevenday && PlayerManager.Instance.Self.Grade >= 11)
         {
            _autoOpenViewState = 2;
         }
      }
      
      public function checkIcon() : void
      {
         updateTime();
         var _loc1_:Boolean = isNotAllAchieved();
         if(isSevenday && _loc1_)
         {
            HallIconManager.instance.updateSwitchHandler("sevenday",true);
            if(_autoOpenViewState == 2)
            {
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
