package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class MovingNotificationAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function MovingNotificationAnalyzer(onCompleteCall:Function)
      {
         list = [];
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         list = String(data).split("\r\n");
         for(i = 0; i < list.length; )
         {
            list[i] = list[i].replace("\\r","\r");
            list[i] = list[i].replace("\\n","\n");
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
