package bombKing.data
{
   public class BKingRankInfo
   {
       
      
      public var userId:int;
      
      public var areaId:int;
      
      public var place:int;
      
      public var name:String;
      
      public var areaName:String;
      
      public var num:int;
      
      public var vipType:int;
      
      public var vipLvl:int;
      
      public function BKingRankInfo()
      {
         super();
      }
      
      public function get isVIP() : Boolean
      {
         return vipType >= 1;
      }
   }
}
