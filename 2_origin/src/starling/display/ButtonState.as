package starling.display
{
   import starling.errors.AbstractClassError;
   
   public class ButtonState
   {
      
      public static const UP:String = "up";
      
      public static const DOWN:String = "down";
      
      public static const OVER:String = "over";
      
      public static const DISABLED:String = "disabled";
       
      
      public function ButtonState()
      {
         super();
         throw new AbstractClassError();
      }
   }
}
