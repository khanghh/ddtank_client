package battleGroud
{
   import battleGroud.data.BattlPrestigeData;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CeleTotalPrestigeAnalyer extends DataAnalyzer
   {
       
      
      public var battleDataList:Vector.<BattlPrestigeData>;
      
      public function CeleTotalPrestigeAnalyer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var battleData:* = null;
         battleDataList = new Vector.<BattlPrestigeData>();
         var xml:XML = new XML(data);
         var len:int = xml.item.length();
         var xmllist:XMLList = xml..Item;
         for(i = 0; i < xmllist.length(); )
         {
            battleData = new BattlPrestigeData();
            battleData.Numbers = i + 1;
            ObjectUtils.copyPorpertiesByXML(battleData,xmllist[i]);
            battleDataList.push(battleData);
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
