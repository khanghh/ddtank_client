package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortionSkillInfo;
   
   public class ConsortionSkillInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var skillInfoList:Vector.<ConsortionSkillInfo>;
      
      public function ConsortionSkillInfoAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         skillInfoList = new Vector.<ConsortionSkillInfo>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = XML(xml)..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new ConsortionSkillInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               skillInfoList.push(info);
               i++;
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
   }
}
