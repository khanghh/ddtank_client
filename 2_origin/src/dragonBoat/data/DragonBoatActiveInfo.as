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
      
      public function set BeginTime(value:String) : void
      {
         _beginTimeDate = DateUtils.decodeDated(value);
      }
      
      public function get endTimeDate() : Date
      {
         return !!_endTimeDate?_endTimeDate:new Date();
      }
      
      public function set EndTime(value:String) : void
      {
         _endTimeDate = DateUtils.decodeDated(value);
      }
      
      public function get normalScore() : int
      {
         return _normalScore;
      }
      
      public function set AddPropertyByMoney(value:String) : void
      {
         var tmp:String = value.split(":")[1];
         _normalScore = tmp.split(",")[1];
      }
      
      public function get highScore() : int
      {
         return _highScore;
      }
      
      public function set AddPropertyByProp(value:String) : void
      {
         var tmp:String = value.split(":")[1];
         _highScore = tmp.split(",")[1];
      }
   }
}
