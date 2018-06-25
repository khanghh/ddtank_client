package fightLib
{
   import fightLib.script.BaseScript;
   import flash.events.EventDispatcher;
   
   public class FightLibControl extends EventDispatcher
   {
      
      private static var _ins:FightLibControl;
       
      
      public var lastFightLibMission:String;
      
      private var _script:BaseScript;
      
      public function FightLibControl(singletonFocer:SingletonFocer)
      {
         super();
      }
      
      public static function get Instance() : FightLibControl
      {
         if(_ins == null)
         {
            _ins = new FightLibControl(new SingletonFocer());
         }
         return _ins;
      }
      
      public function get script() : BaseScript
      {
         return _script;
      }
      
      public function set script(value:BaseScript) : void
      {
         _script = value;
      }
   }
}

class SingletonFocer
{
    
   
   function SingletonFocer()
   {
      super();
   }
}
