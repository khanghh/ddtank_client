package midAutumnWorshipTheMoon.model
{
   public class WorshipTheMoonAwardsBoxInfo
   {
       
      
      public var id:int;
      
      public var moonType:int;
      
      public function WorshipTheMoonAwardsBoxInfo(param1:int, param2:int)
      {
         super();
         moonType = param1;
         id = param2;
      }
      
      public static function getMoonName(param1:int) : String
      {
         switch(int(param1) - 1)
         {
            case 0:
               return "Trăng Non";
            case 1:
               return "Trăng Lưỡi Trai";
            case 2:
               return "Trăng Thượng Huyền";
            case 3:
               return "Trăng Hạ Huyền";
            case 4:
               return "Trăng Lưỡi Liềm";
            case 5:
               return "Trăng Tròn";
         }
      }
      
      public static function getCakeName(param1:int) : String
      {
         switch(int(param1) - 1)
         {
            case 0:
               return "Túi quà trăng non";
            case 1:
               return "Túi quà trăng lưỡi trai";
            case 2:
               return "Túi quà trăng thượng huyền";
            case 3:
               return "Túi quà trăng hạ huyền";
            case 4:
               return "Túi quà trăng lưỡi liềm";
            case 5:
               return "Quà Trăng Tròn";
         }
      }
   }
}
