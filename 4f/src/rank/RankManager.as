package rank
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.IEventDispatcher;
   import rank.analyzer.RankingListAwardAnalyzer;
   import rank.data.RankAwardInfo;
   import rank.data.RankInfo;
   import rank.model.RankModel;
   import rank.view.RankFrame;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftConditionInfo;
   
   public class RankManager extends CoreManager
   {
      
      private static var _instance:RankManager;
       
      
      private var _frame:RankFrame;
      
      public var model:RankModel;
      
      public var reweadDataList:Vector.<RankAwardInfo>;
      
      public var lastUpdateTime:String;
      
      public function RankManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : RankManager{return null;}
      
      public function setup() : void{}
      
      override protected function start() : void{}
      
      public function activityAwardComp(param1:RankingListAwardAnalyzer) : void{}
      
      private function onLoaded() : void{}
      
      public function rankData(param1:Array, param2:int) : RankInfo{return null;}
      
      public function setCurrentInfo() : void{}
   }
}
