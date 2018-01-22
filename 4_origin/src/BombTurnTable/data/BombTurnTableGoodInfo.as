package BombTurnTable.data
{
   public class BombTurnTableGoodInfo
   {
       
      
      private var _place:int;
      
      private var _templateId:int;
      
      private var _goodCount:int;
      
      private var _validDate:int;
      
      private var _sex:int;
      
      private var _isReceive:int;
      
      public function BombTurnTableGoodInfo()
      {
         super();
      }
      
      public function get isReceive() : int
      {
         return _isReceive;
      }
      
      public function set isReceive(param1:int) : void
      {
         _isReceive = param1;
      }
      
      public function get sex() : int
      {
         return _sex;
      }
      
      public function set sex(param1:int) : void
      {
         _sex = param1;
      }
      
      public function get validDate() : int
      {
         return _validDate;
      }
      
      public function set validDate(param1:int) : void
      {
         _validDate = param1;
      }
      
      public function get goodCount() : int
      {
         return _goodCount;
      }
      
      public function set goodCount(param1:int) : void
      {
         _goodCount = param1;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         _templateId = param1;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function set place(param1:int) : void
      {
         _place = param1;
      }
   }
}
