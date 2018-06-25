package deng.fzip
{
   import flash.events.Event;
   
   public class FZipErrorEvent extends Event
   {
      
      public static const PARSE_ERROR:String = "parseError";
       
      
      public var text:String;
      
      public function FZipErrorEvent(type:String, text:String = "", bubbles:Boolean = false, cancelable:Boolean = false)
      {
         this.text = text;
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new FZipErrorEvent(type,text,bubbles,cancelable);
      }
   }
}
