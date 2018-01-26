package bombKing.data
{
   public class BKingStatueInfo
   {
       
      
      public var name:String;
      
      public var vipType:int;
      
      public var vipLevel:int;
      
      public var style:String;
      
      public var color:String;
      
      public var sex:Boolean;
      
      public var isAttest:Boolean;
      
      public var rank:int;
      
      public function BKingStatueInfo(){super();}
      
      public function get IsVIP() : Boolean{return false;}
   }
}
