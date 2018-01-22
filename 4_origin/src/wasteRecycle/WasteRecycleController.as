package wasteRecycle
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.ServerConfigManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.EventDispatcher;
   import wasteRecycle.data.WasteRecycleAnalyzer;
   import wasteRecycle.data.WasteRecycleModel;
   import wasteRecycle.view.WasteRecycleFrame;
   import wasteRecycle.view.WasteRecycleHelperFrame;
   
   public class WasteRecycleController extends EventDispatcher
   {
      
      private static var _instance:WasteRecycleController;
       
      
      private var _model:WasteRecycleModel;
      
      private var _isPlay:Boolean;
      
      public function WasteRecycleController()
      {
         super();
         _model = new WasteRecycleModel();
         _model.lotteryScore = ServerConfigManager.instance.wasteRecycleLotteryScore;
         _model.lotteryLimitScore = ServerConfigManager.instance.wasteRecycleLimit;
      }
      
      public static function get instance() : WasteRecycleController
      {
         if(!_instance)
         {
            _instance = new WasteRecycleController();
         }
         return _instance;
      }
      
      private function initAwardList() : void
      {
         var _loc3_:* = null;
         var _loc1_:* = undefined;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(_model.trophyList == null)
         {
            _loc3_ = ServerConfigManager.instance.wasteRecycleAwardIdList;
            _loc1_ = new Vector.<InventoryItemInfo>();
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc2_ = _loc3_[_loc5_].split(",");
               _loc4_ = ItemManager.fillByID(int(_loc2_[0]));
               _loc4_.IsBinds = true;
               _loc4_.Count = int(_loc2_[1]);
               _loc1_.push(_loc4_);
               _loc5_++;
            }
            _model.trophyList = _loc1_;
         }
      }
      
      public function showView() : void
      {
         initAwardList();
         new HelperDataModuleLoad().loadDataModule([createLoader()],function():void
         {
            new HelperUIModuleLoad().loadUIModule(["wasteRecycle","ddtbagandinfo","ddtbead"],loadComplete);
         });
      }
      
      private function loadComplete() : void
      {
         var _loc1_:WasteRecycleFrame = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.WasteRecycleFrame");
         _loc1_.show();
      }
      
      private function createLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("RecycleActivityInfo.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.wasteRecycle.loadDataFail");
         _loc1_.analyzer = new WasteRecycleAnalyzer(onDataComplete);
         return _loc1_;
      }
      
      private function onDataComplete(param1:WasteRecycleAnalyzer) : void
      {
         _model.data = param1.data;
      }
      
      public function get model() : WasteRecycleModel
      {
         return _model;
      }
      
      public function set isPlay(param1:Boolean) : void
      {
         _isPlay = param1;
      }
      
      public function get isPlay() : Boolean
      {
         return _isPlay;
      }
      
      public function openHelpFram() : void
      {
         var _loc1_:WasteRecycleHelperFrame = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.helperFrame");
         _loc1_.show();
      }
   }
}
