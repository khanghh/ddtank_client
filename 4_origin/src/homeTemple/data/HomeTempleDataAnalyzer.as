package homeTemple.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import homeTemple.HomeTempleController;
   
   public class HomeTempleDataAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      private var _xml:XML;
      
      public function HomeTempleDataAnalyzer(onCompleteCall:Function)
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
            list = new Dictionary();
            xmllist = _xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new HomeTempleModel();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               list[info.Level] = info;
               i++;
            }
            HomeTempleController.MAXLEVEL = xmllist.length() - 1;
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
