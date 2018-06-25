package particleSystem.events
{
   import flash.events.Event;
   
   public class ParticleEvent extends Event
   {
      
      public static const PARTICLE_LOADED:String = "particle_loaded";
       
      
      private var _id:String;
      
      public function ParticleEvent(type:String, id:String)
      {
         _id = id;
         super(type,false,false);
      }
      
      public function get ID() : String
      {
         return _id;
      }
   }
}
