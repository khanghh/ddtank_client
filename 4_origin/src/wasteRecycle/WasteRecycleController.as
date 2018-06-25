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
         var list:* = null;
         var infoList:* = undefined;
         var i:int = 0;
         var data:* = null;
         var info:* = null;
         if(_model.trophyList == null)
         {
            list = ServerConfigManager.instance.wasteRecycleAwardIdList;
            infoList = new Vector.<InventoryItemInfo>();
            for(i = 0; i < list.length; )
            {
               data = list[i].split(",");
               info = ItemManager.fillByID(int(data[0]));
               info.IsBinds = true;
               info.Count = int(data[1]);
               infoList.push(info);
               i++;
            }
            _model.trophyList = infoList;
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
         var frame:WasteRecycleFrame = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.WasteRecycleFrame");
         frame.show();
      }
      
      private function createLoader() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("RecycleActivityInfo.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.wasteRecycle.loadDataFail");
         loader.analyzer = new WasteRecycleAnalyzer(onDataComplete);
         return loader;
      }
      
      private function onDataComplete(analyzer:WasteRecycleAnalyzer) : void
      {
         _model.data = analyzer.data;
      }
      
      public function get model() : WasteRecycleModel
      {
         return _model;
      }
      
      public function set isPlay(value:Boolean) : void
      {
         _isPlay = value;
      }
      
      public function get isPlay() : Boolean
      {
         return _isPlay;
      }
      
      public function openHelpFram() : void
      {
         var frame:WasteRecycleHelperFrame = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.helperFrame");
         frame.show();
      }
   }
}
