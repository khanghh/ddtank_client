package kingDivision.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import kingDivision.data.KingDivisionAreaNameMessageInfo;
   
   public class AreaNameMessageAnalyze extends DataAnalyzer
   {
       
      
      public var _listDic:Dictionary;
      
      public function AreaNameMessageAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var dataArr:* = null;
         var i:int = 0;
         var itemInfo:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Info;
            _listDic = new Dictionary();
            dataArr = [];
            for(i = 0; i < xmllist.length(); )
            {
               itemInfo = new KingDivisionAreaNameMessageInfo();
               ObjectUtils.copyPorpertiesByXML(itemInfo,xmllist[i]);
               dataArr.push(itemInfo);
               i++;
            }
            var _loc9_:int = 0;
            var _loc8_:* = dataArr;
            for each(var dataInfo in dataArr)
            {
               if(!_listDic[dataInfo.AreaID])
               {
                  _listDic[dataInfo.AreaID] = [];
               }
               _listDic[dataInfo.AreaID].push(dataInfo.AreaName);
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
      
      public function get kingDivisionAreaNameDataDic() : Dictionary
      {
         return _listDic;
      }
   }
}
