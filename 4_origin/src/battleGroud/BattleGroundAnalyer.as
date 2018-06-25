package battleGroud
{
   import battleGroud.data.BatlleData;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BattleGroundAnalyer extends DataAnalyzer
   {
       
      
      public var battleDataList:Array;
      
      public function BattleGroundAnalyer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var rechargeData:* = null;
         battleDataList = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               rechargeData = new BatlleData();
               ObjectUtils.copyPorpertiesByXML(rechargeData,xmllist[i]);
               battleDataList.push(rechargeData);
               i++;
            }
            battleDataList.sortOn("Level",16);
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
   }
}
