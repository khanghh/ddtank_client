package starling.errors
{
   public class AbstractClassError extends Error
   {
       
      
      public function AbstractClassError(message:* = "Cannot instantiate abstract class", id:* = 0)
      {
         super(message,id);
      }
   }
}
