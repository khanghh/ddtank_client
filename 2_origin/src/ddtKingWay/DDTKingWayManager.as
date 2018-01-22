package ddtKingWay
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.TaskEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import ddtKingWay.analyzer.DDTKingWayData;
   import ddtKingWay.analyzer.DDTKingWayDataAnalyzer;
   import hallIcon.HallIconManager;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   
   public class DDTKingWayManager
   {
      
      public static const QUEST_LIST:Array = [3301,3302,3303,3304,3305];
      
      private static var _instance:DDTKingWayManager;
       
      
      private var _model:DictionaryData;
      
      private var _frame:Frame;
      
      public function DDTKingWayManager(param1:inner)
      {
         super();
      }
      
      public static function get instance() : DDTKingWayManager
      {
         if(_instance == null)
         {
            _instance = new DDTKingWayManager(new inner());
         }
         return _instance;
      }
      
      public function checkIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 30)
         {
            if(isShowIcon)
            {
               HallIconManager.instance.updateSwitchHandler("ddtKingWay",true);
            }
            else
            {
               HallIconManager.instance.updateSwitchHandler("ddtKingWay",false);
            }
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("ddtKingWay",true,30);
         }
      }
      
      public function setup() : void
      {
         TaskManager.instance.addEventListener("changed",__onQuestChange);
         PlayerManager.Instance.Self.addEventListener("propertychange",ddtKingWayIconShow);
      }
      
      protected function ddtKingWayIconShow(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"])
         {
            if(PlayerManager.Instance.Self.Grade >= 30)
            {
               checkIcon();
            }
         }
      }
      
      protected function __onQuestChange(param1:TaskEvent) : void
      {
         if(!isShowIcon && QUEST_LIST.indexOf(param1.info.Id))
         {
            checkIcon();
         }
      }
      
      public function analyzer(param1:DDTKingWayDataAnalyzer) : void
      {
         _model = param1.data;
      }
      
      public function get model() : DictionaryData
      {
         return _model;
      }
      
      private function getAllComplete() : Boolean
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _model;
         for each(var _loc2_ in _model)
         {
            _loc1_ = TaskManager.instance.getQuestByID(_loc2_.QuestID);
            if(_loc1_.data != null && !(_loc1_.isAchieved && !_loc1_.isAvailable) && checkOut(_loc1_,_loc2_))
            {
               return false;
            }
         }
         return true;
      }
      
      public function get isShowIcon() : Boolean
      {
         if(PlayerManager.Instance.Self.Grade >= 30 && PlayerManager.Instance.Self.Grade < 70 || PlayerManager.Instance.Self.Grade == 70 && !getAllComplete())
         {
            if(getIndexComplete(getPageIndexByGrade(PlayerManager.Instance.Self.Grade)))
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function getIndexComplete(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         _loc4_ = 0;
         while(_loc4_ <= param1)
         {
            _loc3_ = model[QUEST_LIST[_loc4_]];
            _loc2_ = TaskManager.instance.getQuestByID(_loc3_.QuestID);
            if(_loc2_.data != null && !(_loc2_.isAchieved && !_loc2_.isAvailable) && checkOut(_loc2_,_loc3_))
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function checkOut(param1:QuestInfo, param2:DDTKingWayData) : Boolean
      {
         if(TimeManager.Instance.NowTime() > param1.data.AddTiemsDate.getTime() + param2.Validay * 86400000)
         {
            return false;
         }
         return true;
      }
      
      public function getPageIndexByGrade(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         _loc2_ = 0;
         while(_loc2_ < QUEST_LIST.length)
         {
            _loc3_ = _model[QUEST_LIST[_loc2_]];
            if(_loc3_.AddRule <= param1)
            {
               _loc2_++;
               continue;
            }
            break;
         }
         return _loc2_ - 1;
      }
      
      private function showFrame() : void
      {
         if(_frame == null)
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("ddtKingWay.DDTKingWayMainView");
            LayerManager.Instance.addToLayer(_frame,3,false,1);
         }
      }
      
      public function show() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createConsortiaLoader());
         AssetModuleLoader.addModelLoader("ddtKingWay",6);
         AssetModuleLoader.startCodeLoader(showFrame);
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
         }
         _frame = null;
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
