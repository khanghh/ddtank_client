package cardSystem
{
   import cardSystem.analyze.CardTemplateAnalyzer;
   import cardSystem.data.CardTemplateInfo;
   import flash.utils.Dictionary;
   
   public class CardTemplateInfoManager
   {
      
      private static var _instance:CardTemplateInfoManager;
       
      
      public var isShowBuyFrameSelectedCheck:Boolean = true;
      
      public var isBuyCardsSoul:Boolean = false;
      
      private var _cardtemplateList:Dictionary;
      
      public function CardTemplateInfoManager()
      {
         super();
         _cardtemplateList = new Dictionary();
      }
      
      public static function get instance() : CardTemplateInfoManager
      {
         if(_instance == null)
         {
            _instance = new CardTemplateInfoManager();
         }
         return _instance;
      }
      
      public function setup(param1:CardTemplateAnalyzer) : void
      {
         _cardtemplateList = param1.list;
      }
      
      public function getInfoByCardId(param1:String, param2:String) : CardTemplateInfo
      {
         return _cardtemplateList[param1 + "," + param2];
      }
   }
}
