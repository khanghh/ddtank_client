package roleRecharge.data
{
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class RoleRechargeInfo
   {
       
      
      private var _beginIndex:int;
      
      private var _endIndex:int;
      
      private var _giftRewardArr:Vector.<GiftRewardInfo>;
      
      public function RoleRechargeInfo()
      {
         super();
      }
      
      public function get giftRewardArr() : Vector.<GiftRewardInfo>
      {
         return _giftRewardArr;
      }
      
      public function set giftRewardArr(value:Vector.<GiftRewardInfo>) : void
      {
         _giftRewardArr = value;
      }
      
      public function get beginIndex() : int
      {
         return _beginIndex;
      }
      
      public function set beginIndex(value:int) : void
      {
         _beginIndex = value;
      }
      
      public function get endIndex() : int
      {
         return _endIndex;
      }
      
      public function set endIndex(value:int) : void
      {
         _endIndex = value;
      }
   }
}
