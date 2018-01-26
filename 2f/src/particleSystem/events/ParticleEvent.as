package particleSystem.events
{
   import flash.events.Event;
   
   public class ParticleEvent extends Event
   {
      
      public static const PARTICLE_LOADED:String = "particle_loaded";
       
      
      private var _id:String;
      
      public function ParticleEvent(param1:String, param2:String){super(null,null,null);}
      
      public function get ID() : String{return null;}
   }
}
