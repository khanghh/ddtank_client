package cardSystem
{
   import cardSystem.data.CardGrooveInfo;
   import ddt.data.analyze.CardGrooveEventAnalyzer;
   import flash.utils.Dictionary;
   
   public class GrooveInfoManager
   {
      
      private static var _instance:GrooveInfoManager;
       
      
      private var _grooveList:Dictionary;
      
      public function GrooveInfoManager()
      {
         super();
         _grooveList = new Dictionary();
      }
      
      public static function get instance() : GrooveInfoManager
      {
         if(_instance == null)
         {
            _instance = new GrooveInfoManager();
         }
         return _instance;
      }
      
      public function setup(param1:CardGrooveEventAnalyzer) : void
      {
         _grooveList = param1.list;
      }
      
      public function getInfoByLevel(param1:String, param2:String) : CardGrooveInfo
      {
         return _grooveList[param1 + "," + param2];
      }
   }
}
