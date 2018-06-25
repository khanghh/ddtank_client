package tofflist.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.describeType;
   import tofflist.data.TofflistListData;
   import tofflist.data.TofflistPlayerInfo;
   
   public class TofflistListTwoAnalyzer extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      public var data:TofflistListData;
      
      public function TofflistListTwoAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var _tempInfo:* = null;
         var _xmlInfo:* = null;
         var i:int = 0;
         var p:* = null;
         _xml = new XML(data);
         var list:Array = [];
         this.data = new TofflistListData();
         this.data.lastUpdateTime = _xml.@date;
         if(_xml.@value == "true")
         {
            xmllist = XML(_xml)..Item;
            _tempInfo = new TofflistPlayerInfo();
            _xmlInfo = describeType(_tempInfo);
            for(i = 0; i < xmllist.length(); )
            {
               p = new TofflistPlayerInfo();
               p.beginChanges();
               ObjectUtils.copyPorpertiesByXML(p,xmllist[i]);
               p.commitChanges();
               list.push(p);
               i++;
            }
            this.data.list = list;
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
