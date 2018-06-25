package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.CateCoryInfo;
   
   public class GoodCategoryAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<CateCoryInfo>;
      
      private var _xml:XML;
      
      public function GoodCategoryAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         _xml = new XML(data);
         if(_xml.@value == "true")
         {
            list = new Vector.<CateCoryInfo>();
            xmllist = _xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new CateCoryInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               list.push(info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
         }
      }
   }
}
