package ddt.manager
{
   import ddt.data.analyze.WeaponBallInfoAnalyze;
   import flash.utils.Dictionary;
   
   public class WeaponBallManager
   {
      
      private static var bobms:Dictionary;
       
      
      public function WeaponBallManager()
      {
         super();
      }
      
      public static function setup(action:WeaponBallInfoAnalyze) : void
      {
         bobms = action.bombs;
      }
      
      public static function getWeaponBallInfo(id:int) : Array
      {
         return bobms[id];
      }
   }
}
