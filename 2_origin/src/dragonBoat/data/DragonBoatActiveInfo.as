package dragonBoat.data
{
   import road7th.utils.DateUtils;
   
   public class DragonBoatActiveInfo
   {
       
      
      public var ActiveID:int;
      
      private var _beginTimeDate:Date;
      
      private var _endTimeDate:Date;
      
      public var LimitGrade:int;
      
      private var _normalScore:int;
      
      private var _highScore:int;
      
      public var MinScore:int;
      
      public function DragonBoatActiveInfo()
      {
         super();
      }
      
      public function get beginTimeDate() : Date
      {
         return !!_beginTimeDate?_beginTimeDate:new Date();
      }
      
      public function set BeginTime(param1:String) : void
      {
         _beginTimeDate = DateUtils.decodeDated(param1);
      }
      
      public function get endTimeDate() : Date
      {
         return !!_endTimeDate?_endTimeDate:new Date();
      }
      
      public function set EndTime(param1:String) : void
      {
         _endTimeDate = DateUtils.decodeDated(param1);
      }
      
      public function get normalScore() : int
      {
         return _normalScore;
      }
      
      public function set AddPropertyByMoney(param1:String) : void
      {
         var _loc2_:String = param1.split(":")[1];
         _normalScore = _loc2_.split(",")[1];
      }
      
      public function get highScore() : int
      {
         return _highScore;
      }
      
      public function set AddPropertyByProp(param1:String) : void
      {
         var _loc2_:String = param1.split(":")[1];
         _highScore = _loc2_.split(",")[1];
      }
   }
}
