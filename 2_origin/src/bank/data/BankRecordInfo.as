package bank.data
{
   public class BankRecordInfo
   {
       
      
      private var _bankId:int;
      
      private var _tempId:int;
      
      private var _begainTime:Date;
      
      private var _Amount:int;
      
      private var _userId:int;
      
      public function BankRecordInfo()
      {
         super();
      }
      
      public function get tempId() : int
      {
         return _tempId;
      }
      
      public function set tempId(value:int) : void
      {
         _tempId = value;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function set userId(value:int) : void
      {
         _userId = value;
      }
      
      public function get Amount() : int
      {
         return _Amount;
      }
      
      public function set Amount(value:int) : void
      {
         _Amount = value;
      }
      
      public function get begainTime() : Date
      {
         return _begainTime;
      }
      
      public function set begainTime(value:Date) : void
      {
         _begainTime = value;
      }
      
      public function get bankId() : int
      {
         return _bankId;
      }
      
      public function set bankId(value:int) : void
      {
         _bankId = value;
      }
   }
}
