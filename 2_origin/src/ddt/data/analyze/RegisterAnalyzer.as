package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class RegisterAnalyzer extends DataAnalyzer
   {
       
      
      public function RegisterAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:XML = new XML(param1);
         var _loc2_:String = _loc3_.@value;
         message = _loc3_.@message;
         if(_loc2_ == "true")
         {
            onAnalyzeComplete();
         }
         else
         {
            onAnalyzeError();
         }
      }
   }
}
