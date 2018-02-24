package petsBag.event
{
   import flash.events.Event;
   
   public class UpdatePetInfoEvent extends Event
   {
      
      public static const PET_UNLOCK_UPDATE:String = "ptm_unlock_update";
      
      public static const UPDATE:String = "update";
      
      public static const SHOWPETFOOD:String = "showPetFood";
      
      public static const PETSBAG_OPENVIEW:String = "petsBagOpenView";
      
      public static const PETSBAG_HIDEVIEW:String = "petsBagHideView";
      
      public static const PETSADOPT_OPENVIEW:String = "petsAdoptOpenView";
       
      
      public var data:Object;
      
      public function UpdatePetInfoEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
   }
}
