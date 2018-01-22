package campbattle.data
{
   public class RoleData
   {
       
      
      public var type:int;
      
      public var name:String;
      
      public var team:int;
      
      public var baseURl:String;
      
      public var posX:int;
      
      public var posY:int;
      
      public var zoneID:int;
      
      public var stateType:int;
      
      public var isCapture:Boolean;
      
      public var timerCount:int;
      
      public var isVip:Boolean;
      
      public var vipLev:int;
      
      public var isDead:Boolean;
      
      public var ID:int;
      
      public var Sex:Boolean;
      
      public var MountsType:int = 0;
      
      public function RoleData(){super();}
      
      public function get IsMounts() : Boolean{return false;}
   }
}
