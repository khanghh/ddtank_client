package starling.scene.hall.event
{
   import starling.events.Event;
   
   public class NewHallEventStarling extends Event
   {
      
      public static const SHOWBUFFCONTROL:String = "showbuffcontrol";
      
      public static const UPDATETITLE:String = "newhallupdatetitle";
      
      public static const BTNCLICK:String = "newhallbtnclick";
      
      public static const PLAYERSHOW:String = "newhallplayershow";
      
      public static const UPDATETIPSINFO:String = "newhallsetplayertippos";
      
      public static const CANCELEMAILSHINE:String = "cancelemailshine";
      
      public static const SETSELFPLAYERPOS:String = "setselfplayerpos";
      
      public static const SHOWPETS:String = "showPets";
       
      
      public function NewHallEventStarling(param1:String, param2:Object = null){super(null,null,null);}
   }
}
