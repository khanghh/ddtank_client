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
      
      public function set isReceive(value:int) : void
      {
         _isReceive = value;
      }
      
      public function get sex() : int
      {
         return _sex;
      }
      
      public function set sex(value:int) : void
      {
         _sex = value;
      }
      
      public function get validDate() : int
      {
         return _validDate;
      }
      
      public function set validDate(value:int) : void
      {
         _validDate = value;
      }
      
      public function get goodCount() : int
      {
         return _goodCount;
      }
      
      public function set goodCount(value:int) : void
      {
         _goodCount = value;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(value:int) : void
      {
         _templateId = value;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function set place(value:int) : void
      {
         _place = value;
      }
   }
}
