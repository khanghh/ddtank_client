package cardSystem
{
   import flash.events.Event;
   
   public class CardSystemEvent extends Event
   {
      
      public static const CARDVIEW_OPEN:String = "bagViewOpen";
      
      public static const CARD_EQUIP_VIEW_COMPLETE:String = "bagEquipViewComplete";
      
      public static const CARD_BAG_VIEW_COMPLETE:String = "bagBagViewComplete";
      
      public static const VIEW_DISPOSE:String = "viewDispose";
      
      public static const CARD_ACHIEVEMENT_UPDATE:String = "cardachievementupdate";
       
      
      public var info;
      
      public var flag:Boolean;
      
      public function CardSystemEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
