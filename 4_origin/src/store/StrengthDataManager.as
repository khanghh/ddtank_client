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
      
      public function StrengthDataManager(target:IEventDispatcher = null)
      {
         super(target);
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
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ItemStrengthenData.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("store.view.fusion.LoadStrengthenListError");
         loader.analyzer = new StrengthenDataAnalyzer(__searchResult);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __searchResult(action:StrengthenDataAnalyzer) : void
      {
         _strengthData = action._strengthData;
      }
      
      public function getRecoverDongAddition(TempID:int, strengthenLevel:int) : Number
      {
         return _strengthData[strengthenLevel][TempID];
      }
      
      public function fusionFinish() : void
      {
         dispatchEvent(new Event("fusionFinish"));
      }
      
      public function exaltFinish() : void
      {
         dispatchEvent(new StoreIIEvent("exaltFinish"));
      }
      
      public function exaltFail(lucky:int = 0) : void
      {
         dispatchEvent(new StoreIIEvent("exaltFail",lucky));
      }
   }
}
