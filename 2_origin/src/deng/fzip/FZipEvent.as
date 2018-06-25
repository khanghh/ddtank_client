package deng.fzip
{
   import flash.events.Event;
   
   public class FZipEvent extends Event
   {
      
      public static const FILE_LOADED:String = "fileLoaded";
       
      
      public var file:FZipFile;
      
      public function FZipEvent(type:String, file:FZipFile = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         this.file = file;
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new FZipEvent(type,file,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return "[FZipEvent type=\"" + type + "\" filename=\"" + file.filename + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + "]";
      }
   }
}
