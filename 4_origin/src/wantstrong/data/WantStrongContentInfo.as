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
      
      public function set icoID(param1:int) : void
      {
         _icoID = param1;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
   }
}
