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
      
      public function CardTemplateInfoManager(){super();}
      
      public static function get instance() : CardTemplateInfoManager{return null;}
      
      public function setup(param1:CardTemplateAnalyzer) : void{}
      
      public function getInfoByCardId(param1:String, param2:String) : CardTemplateInfo{return null;}
   }
}
