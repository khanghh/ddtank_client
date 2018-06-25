package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorsePicCherishVo;
   
   public class HorsePicCherishAnalyzer extends DataAnalyzer
   {
       
      
      private var _horsePicCherishList:Vector.<HorsePicCherishVo>;
      
      public function HorsePicCherishAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var tmpVo:* = null;
         var xml:XML = new XML(data);
         _horsePicCherishList = new Vector.<HorsePicCherishVo>();
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               tmpVo = new HorsePicCherishVo();
               ObjectUtils.copyPorpertiesByXML(tmpVo,xmllist[i]);
               _horsePicCherishList.push(tmpVo);
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
      
      private function compareFunc(tmpA:HorsePicCherishVo, tmpB:HorsePicCherishVo) : int
      {
         if(tmpA.ID > tmpB.ID)
         {
            return 1;
         }
         if(tmpA.ID < tmpB.ID)
         {
            return -1;
         }
         return 0;
      }
      
      public function get horsePicCherishList() : Vector.<HorsePicCherishVo>
      {
         return _horsePicCherishList;
      }
   }
}
