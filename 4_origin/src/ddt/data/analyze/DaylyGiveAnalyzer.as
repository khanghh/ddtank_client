package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.DaylyGiveInfo;
   import flash.utils.Dictionary;
   
   public class DaylyGiveAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public var signAwardList:Array;
      
      public var signAwardCounts:Array;
      
      public var userAwardLog:int;
      
      public var awardLen:int;
      
      private var _xml:XML;
      
      private var _awardDic:Dictionary;
      
      public var signPetInfo:Array;
      
      public function DaylyGiveAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         _xml = new XML(data);
         list = [];
         signAwardList = [];
         signPetInfo = [];
         _awardDic = new Dictionary(true);
         signAwardCounts = [];
         if(_xml.@value == "true")
         {
            xmllist = _xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               if(xmllist[i].@GetWay == 0)
               {
                  info = new DaylyGiveInfo();
                  ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
                  list.push(info);
               }
               else if(xmllist[i].@GetWay == 4)
               {
                  info = new DaylyGiveInfo();
                  ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
                  signAwardList.push(info);
                  if(!_awardDic[xmllist[i].@AwardDays])
                  {
                     _awardDic[xmllist[i].@AwardDays] = true;
                     signAwardCounts.push(xmllist[i].@AwardDays);
                  }
               }
               else if(xmllist[i].@GetWay == 11)
               {
                  info = new DaylyGiveInfo();
                  ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
                  signPetInfo.push(info);
               }
               i++;
            }
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
