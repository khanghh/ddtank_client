package mainbutton
{
   public class MainButton
   {
       
      
      public var ID:String;
      
      private var _btnMark:int;
      
      private var _btnName:String;
      
      private var _btnServerVisable:int;
      
      private var _btnCompleteVisable:int;
      
      public var IsShow:Boolean;
      
      public function MainButton()
      {
         super();
      }
      
      public function get btnCompleteVisable() : int
      {
         return _btnCompleteVisable;
      }
      
      public function set btnCompleteVisable(value:int) : void
      {
         _btnCompleteVisable = value;
      }
      
      public function get btnServerVisable() : int
      {
         return _btnServerVisable;
      }
      
      public function set btnServerVisable(value:int) : void
      {
         _btnServerVisable = value;
      }
      
      public function get btnName() : String
      {
         return _btnName;
      }
      
      public function set btnName(value:String) : void
      {
         _btnName = value;
      }
      
      public function get btnMark() : int
      {
         return _btnMark;
      }
      
      public function set btnMark(value:int) : void
      {
         _btnMark = value;
      }
   }
}
