package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BallInfo;
   
   public class BallInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<BallInfo>;
      
      public function BallInfoAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         list = new Vector.<BallInfo>();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new BallInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               info.blastOutID = xmllist[i].@BombPartical;
               info.craterID = xmllist[i].@Crater;
               info.FlyingPartical = xmllist[i].@FlyingPartical;
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
