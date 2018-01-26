package roleRecharge.data
{
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class RoleRechargeInfo
   {
       
      
      private var _beginIndex:int;
      
      private var _endIndex:int;
      
      private var _giftRewardArr:Vector.<GiftRewardInfo>;
      
      public function RoleRechargeInfo(){super();}
      
      public function get giftRewardArr() : Vector.<GiftRewardInfo>{return null;}
      
      public function set giftRewardArr(param1:Vector.<GiftRewardInfo>) : void{}
      
      public function get beginIndex() : int{return 0;}
      
      public function set beginIndex(param1:int) : void{}
      
      public function get endIndex() : int{return 0;}
      
      public function set endIndex(param1:int) : void{}
   }
}
