package wantstrong.data
{
   public class WantStrongContentInfo
   {
       
      
      private var _id:int;
      
      private var _title:String;
      
      private var _icoID:int;
      
      public function WantStrongContentInfo()
      {
         super();
      }
      
      public function get icoID() : int
      {
         return _icoID;
      }
      
      public function set icoID(value:int) : void
      {
         _icoID = value;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(value:String) : void
      {
         _title = value;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(value:int) : void
      {
         _id = value;
      }
   }
}
