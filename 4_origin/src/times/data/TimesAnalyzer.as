package times.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class TimesAnalyzer extends DataAnalyzer
   {
       
      
      public var webPath:String;
      
      public var edition:int;
      
      public var editor:String;
      
      public var nextDate:String;
      
      public var smallPicInfos:Vector.<TimesPicInfo>;
      
      public var bigPicInfos:Vector.<TimesPicInfo>;
      
      public var contentInfos:Array;
      
      public function TimesAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var info:* = null;
         var i:int = 0;
         var info1:* = null;
         var k:int = 0;
         var info2:* = null;
         smallPicInfos = new Vector.<TimesPicInfo>();
         bigPicInfos = new Vector.<TimesPicInfo>();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            webPath = xml.@webPath;
            edition = xml.@edition;
            editor = xml.@editor;
            nextDate = xml.@nextDate;
            var _loc9_:* = xml..item;
            var _loc10_:int = 0;
            var _loc12_:* = new XMLList("");
            xmllist = xml..item.(@type == "small");
            for(i = 0; i < xmllist.length(); )
            {
               info = new TimesPicInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               smallPicInfos.push(info);
               i++;
            }
            var _loc13_:* = xml..item;
            var _loc14_:int = 0;
            _loc9_ = new XMLList("");
            xmllist = xml..item.(@type == "big");
            for(i = 0; i < xmllist.length(); )
            {
               info1 = new TimesPicInfo();
               ObjectUtils.copyPorpertiesByXML(info1,xmllist[i]);
               bigPicInfos.push(info1);
               i++;
            }
            contentInfos = [];
            for(k = 0; k < 4; )
            {
               var _loc15_:* = xml..item;
               var _loc16_:int = 0;
               _loc12_ = new XMLList("");
               xmllist = xml..item.(@type == "category" + String(k));
               contentInfos.push(new Vector.<TimesPicInfo>());
               for(i = 0; i < xmllist.length(); )
               {
                  info2 = new TimesPicInfo();
                  ObjectUtils.copyPorpertiesByXML(info2,xmllist[i]);
                  info2.category = k;
                  info2.page = i;
                  contentInfos[k].push(info2);
                  i++;
               }
               k++;
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
