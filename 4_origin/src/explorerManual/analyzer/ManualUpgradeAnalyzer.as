package explorerManual.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import explorerManual.data.model.ManualUpgradeInfo;
   
   public class ManualUpgradeAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Array;
      
      public function ManualUpgradeAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var tmpVo:* = null;
         _data = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               tmpVo = new ManualUpgradeInfo();
               ObjectUtils.copyPorpertiesByXML(tmpVo,xmllist[i]);
               _data.push(tmpVo);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
         _data = null;
      }
      
      public function get data() : Array
      {
         return _data;
      }
   }
}
