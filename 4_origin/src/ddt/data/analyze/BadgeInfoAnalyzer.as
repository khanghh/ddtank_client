package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.BadgeInfo;
   import flash.utils.Dictionary;
   
   public class BadgeInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function BadgeInfoAnalyzer(onCompleteCall:Function)
      {
         list = new Dictionary();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         var xmllist:XMLList = xml..item;
         var len:int = xmllist.length();
         for(i = 0; i < len; )
         {
            info = new BadgeInfo();
            ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
            list[info.BadgeID] = info;
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
