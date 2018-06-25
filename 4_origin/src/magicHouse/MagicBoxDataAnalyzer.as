package magicHouse
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import magicHouse.magicBox.MagicBoxItemInfo;
   
   public class MagicBoxDataAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<MagicBoxItemInfo>;
      
      public function MagicBoxDataAnalyzer(onCompleteCall:Function)
      {
         list = new Vector.<MagicBoxItemInfo>();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var magicBoxItemInfo:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            var _loc7_:int = 0;
            var _loc6_:* = xmllist;
            for each(var item in xmllist)
            {
               magicBoxItemInfo = new MagicBoxItemInfo();
               ObjectUtils.copyPorpertiesByXML(magicBoxItemInfo,item);
               list.push(magicBoxItemInfo);
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeComplete();
         }
      }
   }
}
