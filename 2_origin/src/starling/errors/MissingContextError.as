package starling.errors
{
   public class MissingContextError extends Error
   {
       
      
      public function MissingContextError(message:* = "Starling context is missing", id:* = 0)
      {
         super(message,id);
      }
   }
}
