package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class MovingNotificationAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function MovingNotificationAnalyzer(param1:Function)
      {
         list = [];
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:int = 0;
         list = String(param1).split("\r\n");
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            list[_loc2_] = list[_loc2_].replace("\\r","\r");
            list[_loc2_] = list[_loc2_].replace("\\n","\n");
            _loc2_++;
         }
         onAnalyzeComplete();
      }
   }
}
