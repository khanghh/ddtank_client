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
      
      public function set filterString(value:String) : void
      {
         _filterString = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get backStyle() : String
      {
         return _backStyle;
      }
      
      public function set backStyle(value:String) : void
      {
         _backStyle = value;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function set y(value:int) : void
      {
         _y = value;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function set x(value:int) : void
      {
         _x = value;
      }
      
      public function get page() : int
      {
         return _page;
      }
      
      public function set page(value:int) : void
      {
         _page = value;
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
