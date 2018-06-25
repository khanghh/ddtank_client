package labyrinth.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class RankingAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function RankingAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var info:* = null;
         var i:int = 0;
         list = [];
         var xml:XML = new XML(data);
         var items:XMLList = xml..Item;
         if(xml.@value == "true")
         {
            for(i = 0; i < items.length(); )
            {
               info = new RankingInfo();
               ObjectUtils.copyPorpertiesByXML(info,items[i]);
               list.push(info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
