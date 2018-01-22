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
      
      public function DragonBoatActiveInfo(){super();}
      
      public function get beginTimeDate() : Date{return null;}
      
      public function set BeginTime(param1:String) : void{}
      
      public function get endTimeDate() : Date{return null;}
      
      public function set EndTime(param1:String) : void{}
      
      public function get normalScore() : int{return 0;}
      
      public function set AddPropertyByMoney(param1:String) : void{}
      
      public function get highScore() : int{return 0;}
      
      public function set AddPropertyByProp(param1:String) : void{}
   }
}
