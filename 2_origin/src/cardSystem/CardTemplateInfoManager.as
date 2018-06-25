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
      
      public function setup(analyzer:CardTemplateAnalyzer) : void
      {
         _cardtemplateList = analyzer.list;
      }
      
      public function getInfoByCardId(key:String, type:String) : CardTemplateInfo
      {
         return _cardtemplateList[key + "," + type];
      }
   }
}
