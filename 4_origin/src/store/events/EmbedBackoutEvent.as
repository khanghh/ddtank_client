package store.events
{
   import flash.events.Event;
   
   public class EmbedBackoutEvent extends Event
   {
      
      public static const EMBED_BACKOUT:String = "embedBackout";
      
      public static const EMBED_BACKOUT_DOWNITEM_OVER:String = "embedBackoutDownItemOver";
      
      public static const EMBED_BACKOUT_DOWNITEM_OUT:String = "embedBackoutDownItemOut";
      
      public static const EMBED_BACKOUT_DOWNITEM_DOWN:String = "embedBackoutDownItemDown";
       
      
      private var _cellID:int;
      
      private var _templateID:int;
      
      public function EmbedBackoutEvent(type:String, cellID:int, templateID:int, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         _cellID = cellID;
         _templateID = templateID;
      }
      
      public function get CellID() : int
      {
         return _cellID;
      }
      
      public function get TemplateID() : int
      {
         return _templateID;
      }
   }
}
