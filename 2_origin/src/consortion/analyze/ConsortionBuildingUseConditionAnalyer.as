package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaAssetLevelOffer;
   
   public class ConsortionBuildingUseConditionAnalyer extends DataAnalyzer
   {
       
      
      public var useConditionList:Vector.<ConsortiaAssetLevelOffer>;
      
      public function ConsortionBuildingUseConditionAnalyer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var offer:* = null;
         useConditionList = new Vector.<ConsortiaAssetLevelOffer>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = XML(xml)..Item;
            for(i = 0; i < xmllist.length(); )
            {
               offer = new ConsortiaAssetLevelOffer();
               ObjectUtils.copyPorpertiesByXML(offer,xmllist[i]);
               useConditionList.push(offer);
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
