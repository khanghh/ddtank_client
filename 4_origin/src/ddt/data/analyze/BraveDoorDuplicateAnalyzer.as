package ddt.data.analyze
{
   import BraveDoor.data.BraveDoorDuplicateInfo;
   import BraveDoor.data.DuplicateInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BraveDoorDuplicateAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<BraveDoorDuplicateInfo>;
      
      private var _maps:XML;
      
      private var _xml:XML;
      
      public function BraveDoorDuplicateAnalyzer(onCompleteCall:Function)
      {
         list = new Vector.<BraveDoorDuplicateInfo>();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var itemList:* = null;
         var info:* = null;
         var dupInfo:* = null;
         var j:int = 0;
         _xml = new XML(data);
         var xmllist:XMLList = _xml..map;
         var len:int = xmllist.length();
         var _loc10_:int = 0;
         var _loc9_:* = xmllist;
         for each(var xml in xmllist)
         {
            info = new BraveDoorDuplicateInfo();
            initMap(info,xml);
            itemList = xml..item;
            for(j = 0; j < itemList.length(); )
            {
               dupInfo = new DuplicateInfo();
               ObjectUtils.copyPorpertiesByXML(dupInfo,itemList[j]);
               info.addDuplicateInfo(dupInfo);
               j++;
            }
            list[info.page] = info;
         }
         onAnalyzeComplete();
      }
      
      protected function initMap(info:BraveDoorDuplicateInfo, xml:XML) : void
      {
         ObjectUtils.copyPorpertiesByXML(info,xml);
      }
   }
}
