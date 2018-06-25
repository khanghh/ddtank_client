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
      
      public function DDTKingWayManager($inner:inner)
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
      
      protected function ddtKingWayIconShow(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Grade"])
         {
            if(PlayerManager.Instance.Self.Grade >= 30)
            {
               checkIcon();
            }
         }
      }
      
      protected function __onQuestChange(event:TaskEvent) : void
      {
         if(!isShowIcon && QUEST_LIST.indexOf(event.info.Id))
         {
            checkIcon();
         }
      }
      
      public function analyzer(analyzer:DDTKingWayDataAnalyzer) : void
      {
         _model = analyzer.data;
      }
      
      public function get model() : DictionaryData
      {
         return _model;
      }
      
      private function getAllComplete() : Boolean
      {
         var questInfo:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _model;
         for each(var info in _model)
         {
            questInfo = TaskManager.instance.getQuestByID(info.QuestID);
            if(questInfo.data != null && !(questInfo.isAchieved && !questInfo.isAvailable) && checkOut(questInfo,info))
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
      
      public function getIndexComplete(index:int) : Boolean
      {
         var i:int = 0;
         var info:* = null;
         var questInfo:* = null;
         for(i = 0; i <= index; )
         {
            info = model[QUEST_LIST[i]];
            questInfo = TaskManager.instance.getQuestByID(info.QuestID);
            if(questInfo.data != null && !(questInfo.isAchieved && !questInfo.isAvailable) && checkOut(questInfo,info))
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function checkOut(questInfo:QuestInfo, info:DDTKingWayData) : Boolean
      {
         if(TimeManager.Instance.NowTime() > questInfo.data.AddTiemsDate.getTime() + info.Validay * 86400000)
         {
            return false;
         }
         return true;
      }
      
      public function getPageIndexByGrade(grade:int) : int
      {
         var index:int = 0;
         var data:* = null;
         for(index = 0; index < QUEST_LIST.length; )
         {
            data = _model[QUEST_LIST[index]];
            if(data.AddRule <= grade)
            {
               index++;
               continue;
            }
            break;
         }
         return index - 1;
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
