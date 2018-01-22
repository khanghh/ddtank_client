package cardSystem.data
{
   public class CardGrooveInfo
   {
       
      
      public var cardinfo:CardInfo;
      
      public var Level:String;
      
      public var Type:String;
      
      public var Exp:String;
      
      public var Attack:String;
      
      public var Defend:String;
      
      public var Agility:String;
      
      public var Lucky:String;
      
      public var Damage:String;
      
      public var Guard:String;
      
      private var _cardInfo:CardInfo;
      
      public function CardGrooveInfo()
      {
         super();
      }
      
      public function set cardInfo(param1:CardInfo) : void
      {
         _cardInfo = param1;
      }
      
      public function get cardInfo() : CardInfo
      {
         return _cardInfo;
      }
   }
}
