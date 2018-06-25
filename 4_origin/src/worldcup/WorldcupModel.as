package worldcup
{
   import flash.events.EventDispatcher;
   
   public class WorldcupModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean;
      
      private var _state:int;
      
      public var promotionCountry:Array;
      
      public var returnRate:int = 0;
      
      public var supportCountry:int = 0;
      
      public var selectCountry:int = 0;
      
      public var totalRecharge:int;
      
      public var awardIndex:int;
      
      public var countryList:Array;
      
      public function WorldcupModel()
      {
         promotionCountry = [];
         countryList = [[8,32,22,13],[3,9,29,24],[7,27,14,17],[4,18,16,26],[2,15,19,25],[1,12,20,31],[5,30,21,10],[6,23,11,28]];
         super();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(value:int) : void
      {
         _state = value;
         if(_state != 1 && _state != 5)
         {
            isOpen = true;
         }
         else
         {
            isOpen = false;
         }
      }
   }
}
