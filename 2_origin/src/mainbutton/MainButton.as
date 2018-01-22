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
      
      public function set btnCompleteVisable(param1:int) : void
      {
         _btnCompleteVisable = param1;
      }
      
      public function get btnServerVisable() : int
      {
         return _btnServerVisable;
      }
      
      public function set btnServerVisable(param1:int) : void
      {
         _btnServerVisable = param1;
      }
      
      public function get btnName() : String
      {
         return _btnName;
      }
      
      public function set btnName(param1:String) : void
      {
         _btnName = param1;
      }
      
      public function get btnMark() : int
      {
         return _btnMark;
      }
      
      public function set btnMark(param1:int) : void
      {
         _btnMark = param1;
      }
   }
}
