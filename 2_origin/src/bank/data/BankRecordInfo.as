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
      
      public function set tempId(param1:int) : void
      {
         _tempId = param1;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function set userId(param1:int) : void
      {
         _userId = param1;
      }
      
      public function get Amount() : int
      {
         return _Amount;
      }
      
      public function set Amount(param1:int) : void
      {
         _Amount = param1;
      }
      
      public function get begainTime() : Date
      {
         return _begainTime;
      }
      
      public function set begainTime(param1:Date) : void
      {
         _begainTime = param1;
      }
      
      public function get bankId() : int
      {
         return _bankId;
      }
      
      public function set bankId(param1:int) : void
      {
         _bankId = param1;
      }
   }
}
