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
      
      public function RankManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function activityAwardComp(data:RankingListAwardAnalyzer) : void
      {
         reweadDataList = data.itemList;
         lastUpdateTime = data.lastUpdateTime;
         _frame = ComponentFactory.Instance.creatCustomObject("rank.RankFrame");
         _frame.titleText = LanguageMgr.GetTranslation("ddt.rankFrame.title");
         _frame.init();
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function onLoaded() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("RankingListAwardList.xml?ran=" + Math.random()),5);
         loader.loadErrorMessage = "RankingListAwardList";
         loader.analyzer = new RankingListAwardAnalyzer(activityAwardComp);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      public function rankData(arr:Array, index:int) : RankInfo
      {
         var i:int = 0;
         var info:* = null;
         var j:int = 0;
         var conInfo:* = null;
         var rankInfo:RankInfo = new RankInfo();
         for(i = 0; i < arr.length; )
         {
            info = arr[i] as GiftBagInfo;
            for(j = 0; j < info.giftConditionArr.length; )
            {
               conInfo = info.giftConditionArr[j] as GiftConditionInfo;
               if(conInfo.conditionIndex == 0 && conInfo.conditionValue == index)
               {
                  rankInfo.beginIndex = conInfo.conditionValue;
                  rankInfo.endIndex = conInfo.remain1;
                  rankInfo.giftRewardArr = info.giftRewardArr.slice();
                  return rankInfo;
               }
               j++;
            }
            i++;
         }
         return rankInfo;
      }
      
      public function setCurrentInfo() : void
      {
         _frame.setRightView();
      }
   }
}
