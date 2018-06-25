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
      
      public function set count(value:int) : void
      {
         _count = value;
      }
      
      public function get templateID() : String
      {
         return _templateID;
      }
      
      public function set templateID(value:String) : void
      {
         _templateID = value;
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
