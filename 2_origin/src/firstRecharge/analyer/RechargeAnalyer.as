package firstRecharge.analyer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import firstRecharge.data.RechargeData;
   
   public class RechargeAnalyer extends DataAnalyzer
   {
       
      
      public var goodsList:Vector.<RechargeData>;
      
      public function RechargeAnalyer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var rechargeData:* = null;
         goodsList = new Vector.<RechargeData>();
         var xml:XML = new XML(data);
         var len:int = xml.item.length();
         var xmllist:XMLList = xml..item;
         for(i = 0; i < xmllist.length(); )
         {
            rechargeData = new RechargeData();
            ObjectUtils.copyPorpertiesByXML(rechargeData,xmllist[i]);
            goodsList.push(rechargeData);
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
