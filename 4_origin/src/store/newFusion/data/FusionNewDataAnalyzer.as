package store.newFusion.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class FusionNewDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Object;
      
      public function FusionNewDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var tmpVo:* = null;
         var tmpType:int = 0;
         var tmpArray:* = null;
         var xml:XML = new XML(data);
         _data = {};
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               tmpVo = new FusionNewVo();
               ObjectUtils.copyPorpertiesByXML(tmpVo,xmllist[i]);
               tmpType = xmllist[i].@FusionType;
               if(!_data[tmpType])
               {
                  _data[tmpType] = [];
               }
               tmpArray = _data[tmpType];
               tmpArray.push(tmpVo);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
