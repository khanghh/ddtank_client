package fightLib
{
   import fightLib.script.BaseScript;
   import flash.events.EventDispatcher;
   
   public class FightLibControl extends EventDispatcher
   {
      
      private static var _ins:FightLibControl;
       
      
      public var lastFightLibMission:String;
      
      private var _script:BaseScript;
      
      public function FightLibControl(param1:SingletonFocer){super();}
      
      public static function get Instance() : FightLibControl{return null;}
      
      public function get script() : BaseScript{return null;}
      
      public function set script(param1:BaseScript) : void{}
   }
}

class SingletonFocer
{
    
   
   function SingletonFocer(){super();}
}
