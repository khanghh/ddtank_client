package ddt.data
{
   import ddt.data.analyze.ExpericenceAnalyze;
   import ddt.manager.PlayerManager;
   
   public class Experience
   {
      
      public static var expericence:Array;
      
      public static var HP:Array;
      
      public static var MAX_LEVEL:int;
       
      
      public function Experience(){super();}
      
      public static function getExpPercent(param1:int, param2:int) : Number{return 0;}
      
      public static function getGrade(param1:Number) : int{return 0;}
      
      public static function getBasicHP(param1:int) : int{return 0;}
      
      public static function setup(param1:ExpericenceAnalyze) : void{}
   }
}
