package mines.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class MinesDropAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<DropItemInfo>;
      
      public function MinesDropAnalyzer(onCompleteCall:Function)
      {
         list = new Vector.<DropItemInfo>();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var info:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            var _loc7_:int = 0;
            var _loc6_:* = xmllist;
            for each(var item in xmllist)
            {
               if(item.@PickAxeLevel == "5")
               {
                  info = new DropItemInfo();
                  ObjectUtils.copyPorpertiesByXML(info,item);
                  list.push(info);
               }
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
   }
}
