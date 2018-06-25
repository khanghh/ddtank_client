package tofflist.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.describeType;
   import team.model.TeamRankInfo;
   import tofflist.data.TofflistListData;
   import tofflist.data.TofflistPlayerInfo;
   
   public class TofflistListThirdAnalyzer extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      public var data:TofflistListData;
      
      public function TofflistListThirdAnalyzer(onCompleteCall:Function)
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
               p = new TeamRankInfo();
               ObjectUtils.copyPorpertiesByXML(p,xmllist[i]);
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
