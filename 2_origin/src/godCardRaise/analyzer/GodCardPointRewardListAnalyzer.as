package godCardRaise.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import godCardRaise.info.GodCardPointRewardListInfo;
   
   public class GodCardPointRewardListAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<GodCardPointRewardListInfo>;
      
      public function GodCardPointRewardListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var list:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         _list = new Vector.<GodCardPointRewardListInfo>();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new GodCardPointRewardListInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _list.push(info);
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
      
      public function get list() : Vector.<GodCardPointRewardListInfo>
      {
         return _list;
      }
   }
}
