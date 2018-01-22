package dragonBones.events
{
   import flash.errors.IllegalOperationError;
   import flash.events.EventDispatcher;
   
   [Event(name="sound",type="dragonBones.events.SoundEvent")]
   public final class SoundEventManager extends EventDispatcher
   {
      
      private static var _instance:SoundEventManager;
       
      
      public function SoundEventManager()
      {
         super();
         if(_instance)
         {
            throw new IllegalOperationError("Singleton already constructed!");
         }
      }
      
      public static function getInstance() : SoundEventManager
      {
         if(!_instance)
         {
            _instance = new SoundEventManager();
         }
         return _instance;
      }
   }
}
