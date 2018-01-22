package ddt.utils
{
   import flash.net.LocalConnection;
   
   public class MenoryUtil
   {
       
      
      public function MenoryUtil()
      {
         super();
      }
      
      public static function clearMenory() : void
      {
         try
         {
            new LocalConnection().connect("7roadDDTMenoryClearn");
            new LocalConnection().connect("7roadDDTMenoryClearn");
            return;
         }
         catch(error:Error)
         {
            trace(error);
            return;
         }
      }
   }
}
