package ddt.data
{
   import ddt.data.analyze.ExpericenceAnalyze;
   import ddt.manager.PlayerManager;
   
   public class Experience
   {
      
      public static var expericence:Array;
      
      public static var HP:Array;
      
      public static var MAX_LEVEL:int;
       
      
      public function Experience()
      {
         super();
      }
      
      public static function getExpPercent(level:int, gp:int) : Number
      {
         if(level == MAX_LEVEL)
         {
            return 0;
         }
         if(level == 1)
         {
            gp--;
         }
         return (gp - expericence[level - 1]) / (expericence[level] - expericence[level - 1]);
      }
      
      public static function getGrade(exp:Number) : int
      {
         var i:int = 0;
         var result:* = int(PlayerManager.Instance.Self.Grade);
         for(i = 0; i < expericence.length; )
         {
            if(exp >= expericence[MAX_LEVEL - 1])
            {
               result = int(MAX_LEVEL);
               break;
            }
            if(exp < expericence[i])
            {
               result = i;
               break;
            }
            if(exp <= 0)
            {
               result = 0;
               break;
            }
            i++;
         }
         return result;
      }
      
      public static function getBasicHP(level:int) : int
      {
         level = level >= MAX_LEVEL?MAX_LEVEL:level <= 1?1:level;
         return HP[level - 1];
      }
      
      public static function setup(analyzer:ExpericenceAnalyze) : void
      {
         expericence = analyzer.expericence;
         HP = analyzer.HP;
         MAX_LEVEL = analyzer.expericence.length;
      }
   }
}
