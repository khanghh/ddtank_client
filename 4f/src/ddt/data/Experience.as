package ddt.data{   import ddt.data.analyze.ExpericenceAnalyze;   import ddt.manager.PlayerManager;      public class Experience   {            public static var expericence:Array;            public static var HP:Array;            public static var MAX_LEVEL:int;                   public function Experience() { super(); }
            public static function getExpPercent(level:int, gp:int) : Number { return 0; }
            public static function getGrade(exp:Number) : int { return 0; }
            public static function getBasicHP(level:int) : int { return 0; }
            public static function setup(analyzer:ExpericenceAnalyze) : void { }
   }}