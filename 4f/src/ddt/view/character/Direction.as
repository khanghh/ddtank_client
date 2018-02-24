package ddt.view.character
{
   public class Direction
   {
      
      private static const TOP_PATH:String = "5";
      
      private static const TOP_RIGHT_PATH:String = "8";
      
      private static const RIGHT_PATH:String = "7";
      
      private static const RIGHT_BUTTOM_PATH:String = "6";
      
      private static const BUTTOM_PATH:String = "1";
      
      private static const BUTTOM_LEFT_PATH:String = "2";
      
      private static const LEFT_PATH:String = "3";
      
      private static const LEFT_TOP_PATH:String = "4";
      
      public static const TOP:Direction = new Direction(5,"Direction:TOP");
      
      public static const TOP_RIGHT:Direction = new Direction(8,"Direction:TOP_RIGHT");
      
      public static const RIGHT:Direction = new Direction(7,"Direction:RIGHT");
      
      public static const RIGHT_BUTTOM:Direction = new Direction(6,"Direction:RIGHT_BUTTOM");
      
      public static const BUTTOM:Direction = new Direction(1,"Direction:BUTTOM");
      
      public static const BUTTOM_LEFT:Direction = new Direction(2,"Direction:BUTTOM_LEFT");
      
      public static const LEFT:Direction = new Direction(3,"Direction:LEFT");
      
      public static const LEFT_TOP:Direction = new Direction(4,"Direction:LEFT_TOP");
       
      
      private var num:int;
      
      private var comment:String;
      
      public function Direction(param1:int, param2:String){super();}
      
      public static function getDirection(param1:String) : Direction{return null;}
      
      public static function getDirectionFromAngle(param1:Number) : Direction{return null;}
      
      public static function getDirectionByNumber(param1:Number) : Direction{return null;}
      
      public function getNum() : int{return 0;}
      
      public function toString() : String{return null;}
      
      public function getHeading() : Number{return 0;}
   }
}
