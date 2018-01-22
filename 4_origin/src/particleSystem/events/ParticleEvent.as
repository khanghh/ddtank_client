package particleSystem.events
{
   import flash.events.Event;
   
   public class ParticleEvent extends Event
   {
      
      public static const PARTICLE_LOADED:String = "particle_loaded";
       
      
      private var _id:String;
      
      public function ParticleEvent(param1:String, param2:String)
      {
         _id = param2;
         super(param1,false,false);
      }
      
      public function get ID() : String
      {
         return _id;
      }
   }
}
