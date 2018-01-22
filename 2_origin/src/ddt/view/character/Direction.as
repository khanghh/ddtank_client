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
      
      public function Direction(param1:int, param2:String)
      {
         super();
         this.num = param1;
         this.comment = param2;
      }
      
      public static function getDirection(param1:String) : Direction
      {
         if(param1.indexOf("5") > -1)
         {
            return TOP;
         }
         if(param1.indexOf("8") > -1)
         {
            return TOP_RIGHT;
         }
         if(param1.indexOf("7") > -1)
         {
            return RIGHT;
         }
         if(param1.indexOf("6") > -1)
         {
            return RIGHT_BUTTOM;
         }
         if(param1.indexOf("1") > -1)
         {
            return BUTTOM;
         }
         if(param1.indexOf("2") > -1)
         {
            return BUTTOM_LEFT;
         }
         if(param1.indexOf("3") > -1)
         {
            return LEFT;
         }
         if(param1.indexOf("4") > -1)
         {
            return LEFT_TOP;
         }
         return null;
      }
      
      public static function getDirectionFromAngle(param1:Number) : Direction
      {
         if(param1 < 0)
         {
            param1 = param1 + 3.14159265358979 * 2;
         }
         var _loc2_:Number = param1 / 3.14159265358979 * 180;
         if(_loc2_ >= 359 || _loc2_ < 1)
         {
            return RIGHT;
         }
         if(_loc2_ >= 1 && _loc2_ < 89)
         {
            return RIGHT_BUTTOM;
         }
         if(_loc2_ >= 89 && _loc2_ < 91)
         {
            return BUTTOM;
         }
         if(_loc2_ >= 91 && _loc2_ < 179)
         {
            return BUTTOM_LEFT;
         }
         if(_loc2_ >= 179 && _loc2_ < 181)
         {
            return LEFT;
         }
         if(_loc2_ >= 181 && _loc2_ < 269)
         {
            return LEFT_TOP;
         }
         if(_loc2_ >= 269 && _loc2_ < 271)
         {
            return TOP;
         }
         return TOP_RIGHT;
      }
      
      public static function getDirectionByNumber(param1:Number) : Direction
      {
         var _loc2_:* = param1;
         if(1 !== _loc2_)
         {
            if(2 !== _loc2_)
            {
               if(3 !== _loc2_)
               {
                  if(4 !== _loc2_)
                  {
                     if(5 !== _loc2_)
                     {
                        if(6 !== _loc2_)
                        {
                           if(7 !== _loc2_)
                           {
                              return TOP_RIGHT;
                           }
                           return RIGHT;
                        }
                        return RIGHT_BUTTOM;
                     }
                     return TOP;
                  }
                  return LEFT_TOP;
               }
               return LEFT;
            }
            return BUTTOM_LEFT;
         }
         return BUTTOM;
      }
      
      public function getNum() : int
      {
         return num;
      }
      
      public function toString() : String
      {
         return comment;
      }
      
      public function getHeading() : Number
      {
         switch(int(this.num) - 1)
         {
            case 0:
               return 3.14159265358979 / 2;
            case 1:
               return 2.35619449019235;
            case 2:
               return 3.14159265358979;
            case 3:
               return 3.92699081698724;
            case 4:
               return 4.71238898038469;
            case 5:
               return 0.785398163397448;
            case 6:
               return 0;
            case 7:
               return 5.49778714378214;
         }
      }
   }
}
