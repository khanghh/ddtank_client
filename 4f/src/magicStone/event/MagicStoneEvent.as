package magicStone.event
{
   import flash.events.Event;
   
   public class MagicStoneEvent extends Event
   {
      
      public static const MAGIC_STONE_OPENVIEW:String = "magicStoneOpenView";
      
      public static const LOAD_COMPLETE:String = "magicStoneLoadComplete";
      
      public static const MAGICSTONE_DISPOSE:String = "magicStoneDispose";
      
      public static const MAGIC_STONE_DOUBLESCORE:String = "magicStoneDoubleScore";
       
      
      public var info;
      
      public function MagicStoneEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
