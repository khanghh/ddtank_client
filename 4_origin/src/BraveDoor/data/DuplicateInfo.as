package BraveDoor.data
{
   public class DuplicateInfo
   {
       
      
      private var _id:int;
      
      private var _page:int;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _backStyle:String;
      
      private var _name:String;
      
      private var _filterString:String;
      
      public function DuplicateInfo()
      {
         super();
      }
      
      public function get filterString() : String
      {
         return _filterString;
      }
      
      public function set filterString(param1:String) : void
      {
         _filterString = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get backStyle() : String
      {
         return _backStyle;
      }
      
      public function set backStyle(param1:String) : void
      {
         _backStyle = param1;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function set y(param1:int) : void
      {
         _y = param1;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function set x(param1:int) : void
      {
         _x = param1;
      }
      
      public function get page() : int
      {
         return _page;
      }
      
      public function set page(param1:int) : void
      {
         _page = param1;
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
