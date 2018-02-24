package starling.display.sceneCharacter.event
{
   import starling.events.Event;
   
   public class SceneCharacterEvent extends Event
   {
      
      public static const CHARACTER_MOVEMENT:String = "characterMovement";
      
      public static const CHARACTER_ARRIVED_NEXT_STEP:String = "characterArrivedNextStep";
      
      public static const CHARACTER_ACTION_CHANGE:String = "characterActionChange";
      
      public static const CHARACTER_DIRECTION_CHANGE:String = "characterDirectionChange";
       
      
      public function SceneCharacterEvent(param1:String, param2:Object = null){super(null,null,null);}
   }
}
