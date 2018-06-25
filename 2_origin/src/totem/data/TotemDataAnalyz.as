package totem.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class TotemDataAnalyz extends DataAnalyzer
   {
       
      
      private var _dataList:Object;
      
      private var _dataList2:Object;
      
      public function TotemDataAnalyz(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         _dataList = {};
         _dataList2 = {};
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new TotemDataVo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _dataList[info.ID] = info;
               _dataList2[info.Point] = info;
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
      }
      
      public function get dataList() : Object
      {
         return _dataList;
      }
      
      public function get dataList2() : Object
      {
         return _dataList2;
      }
   }
}
