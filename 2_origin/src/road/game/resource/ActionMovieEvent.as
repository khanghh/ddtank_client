package road.game.resource
{
   import flash.events.Event;
   
   public class ActionMovieEvent extends Event
   {
      
      public static const ACTION_START:String = "actionStart";
      
      public static const ACTION_END:String = "actionEnd";
      
      public static const EFFECT:String = "effect";
       
      
      private var _source:ActionMovie;
      
      private var _data:Object;
      
      public function ActionMovieEvent(type:String, data:Object = null)
      {
         super(type);
         if(data)
         {
            _data = data;
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get source() : ActionMovie
      {
         return super.target as ActionMovie;
      }
   }
}
