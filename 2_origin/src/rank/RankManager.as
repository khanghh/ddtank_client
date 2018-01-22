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
      
      public function RankManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : RankManager
      {
         if(!_instance)
         {
            _instance = new RankManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         model = new RankModel();
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["rank"],onLoaded);
      }
      
      public function activityAwardComp(param1:RankingListAwardAnalyzer) : void
      {
         reweadDataList = param1.itemList;
         lastUpdateTime = param1.lastUpdateTime;
         _frame = ComponentFactory.Instance.creatCustomObject("rank.RankFrame");
         _frame.titleText = LanguageMgr.GetTranslation("ddt.rankFrame.title");
         _frame.init();
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function onLoaded() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("RankingListAwardList.xml?ran=" + Math.random()),5);
         _loc1_.loadErrorMessage = "RankingListAwardList";
         _loc1_.analyzer = new RankingListAwardAnalyzer(activityAwardComp);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      public function rankData(param1:Array, param2:int) : RankInfo
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:RankInfo = new RankInfo();
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc6_ = param1[_loc7_] as GiftBagInfo;
            _loc4_ = 0;
            while(_loc4_ < _loc6_.giftConditionArr.length)
            {
               _loc3_ = _loc6_.giftConditionArr[_loc4_] as GiftConditionInfo;
               if(_loc3_.conditionIndex == 0 && _loc3_.conditionValue == param2)
               {
                  _loc5_.beginIndex = _loc3_.conditionValue;
                  _loc5_.endIndex = _loc3_.remain1;
                  _loc5_.giftRewardArr = _loc6_.giftRewardArr.slice();
                  return _loc5_;
               }
               _loc4_++;
            }
            _loc7_++;
         }
         return _loc5_;
      }
      
      public function setCurrentInfo() : void
      {
         _frame.setRightView();
      }
   }
}
