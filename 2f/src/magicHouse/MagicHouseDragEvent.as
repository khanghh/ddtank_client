package magicHouse
{
   import ddt.data.goods.ItemTemplateInfo;
   import flash.events.Event;
   
   public class MagicHouseDragEvent extends Event
   {
      
      public static const START_DARG:String = "startDarg";
      
      public static const STOP_DARG:String = "stopDarg";
       
      
      public var sourceInfo:ItemTemplateInfo;
      
      public function MagicHouseDragEvent(param1:ItemTemplateInfo, param2:String, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
   }
}
