package store
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import store.analyze.StrengthenDataAnalyzer;
   import store.events.StoreIIEvent;
   
   public class StrengthDataManager extends EventDispatcher
   {
      
      private static var _instance:StrengthDataManager;
      
      public static const FUSIONFINISH:String = "fusionFinish";
       
      
      public var _strengthData:Vector.<Dictionary>;
      
      public var autoFusion:Boolean;
      
      public function StrengthDataManager(param1:IEventDispatcher = null)
      {
         super(param1);
         loadStrengthenLevel();
      }
      
      public static function get instance() : StrengthDataManager
      {
         if(_instance == null)
         {
            _instance = new StrengthDataManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
      }
      
      private function loadStrengthenLevel() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ItemStrengthenData.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("store.view.fusion.LoadStrengthenListError");
         _loc1_.analyzer = new StrengthenDataAnalyzer(__searchResult);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function __searchResult(param1:StrengthenDataAnalyzer) : void
      {
         _strengthData = param1._strengthData;
      }
      
      public function getRecoverDongAddition(param1:int, param2:int) : Number
      {
         return _strengthData[param2][param1];
      }
      
      public function fusionFinish() : void
      {
         dispatchEvent(new Event("fusionFinish"));
      }
      
      public function exaltFinish() : void
      {
         dispatchEvent(new StoreIIEvent("exaltFinish"));
      }
      
      public function exaltFail(param1:int = 0) : void
      {
         dispatchEvent(new StoreIIEvent("exaltFail",param1));
      }
   }
}
