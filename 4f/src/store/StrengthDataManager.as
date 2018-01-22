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
      
      public function StrengthDataManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : StrengthDataManager{return null;}
      
      public function setup() : void{}
      
      private function loadStrengthenLevel() : void{}
      
      private function __searchResult(param1:StrengthenDataAnalyzer) : void{}
      
      public function getRecoverDongAddition(param1:int, param2:int) : Number{return 0;}
      
      public function fusionFinish() : void{}
      
      public function exaltFinish() : void{}
      
      public function exaltFail(param1:int = 0) : void{}
   }
}
