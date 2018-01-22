package oldPlayerComeBack.data
{
   public class AwardItemInfo
   {
       
      
      private var _place:int;
      
      private var _templateID:String;
      
      private var _count:int;
      
      public function AwardItemInfo()
      {
         super();
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
      }
      
      public function get templateID() : String
      {
         return _templateID;
      }
      
      public function set templateID(param1:String) : void
      {
         _templateID = param1;
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
