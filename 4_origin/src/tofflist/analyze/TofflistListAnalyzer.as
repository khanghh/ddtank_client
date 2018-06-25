package tofflist.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.describeType;
   import tofflist.data.TofflistConsortiaData;
   import tofflist.data.TofflistConsortiaInfo;
   import tofflist.data.TofflistListData;
   import tofflist.data.TofflistPlayerInfo;
   
   public class TofflistListAnalyzer extends DataAnalyzer
   {
       
      
      public var data:TofflistListData;
      
      private var _xml:XML;
      
      public function TofflistListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var _tempInfo:* = null;
         var _xmlInfo:* = null;
         var i:int = 0;
         var info:* = null;
         var tcInfo:* = null;
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
               info = new TofflistConsortiaData();
               tcInfo = new TofflistConsortiaInfo();
               ObjectUtils.copyPorpertiesByXML(tcInfo,xmllist[i]);
               info.consortiaInfo = tcInfo;
               if(xmllist[i].children().length() > 0)
               {
                  p = new TofflistPlayerInfo();
                  p.beginChanges();
                  ObjectUtils.copyPorpertiesByXML(p,xmllist[i].Item[0]);
                  p.commitChanges();
                  info.playerInfo = p;
                  list.push(info);
               }
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
