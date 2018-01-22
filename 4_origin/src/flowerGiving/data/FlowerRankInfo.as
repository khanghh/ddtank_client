package flowerGiving.data
{
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class FlowerRankInfo
   {
       
      
      public var place:int;
      
      public var name:String;
      
      public var num:int;
      
      public var vipLvl:int;
      
      public var rewardVec:Vector.<GiftRewardInfo>;
      
      public function FlowerRankInfo()
      {
         super();
      }
      
      public function get isVIP() : Boolean
      {
         return vipLvl >= 1;
      }
   }
}
