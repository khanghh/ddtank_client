package tofflist.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import tofflist.data.RankInfo;
   
   public class RankInfoAnalyz extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      public var info:RankInfo;
      
      public function RankInfoAnalyz(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         _xml = new XML(data);
         if(_xml.@value == "true")
         {
            xmllist = XML(_xml)..Item;
            info = new RankInfo();
            ObjectUtils.copyPorpertiesByXML(info,xmllist[0]);
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
