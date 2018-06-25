package dragonBoat.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import dragonBoat.data.DragonBoatActiveInfo;
   import dragonBoat.data.DragonBoatAwardInfo;
   
   public class DragonBoatActiveDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DragonBoatActiveInfo;
      
      private var _dataList:Array;
      
      private var _dataListSelf:Array;
      
      private var _dataListOther:Array;
      
      public function DragonBoatActiveDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var awardInfo:* = null;
         var xml:XML = new XML(data);
         _data = new DragonBoatActiveInfo();
         _dataList = [];
         _dataListSelf = [];
         _dataListOther = [];
         if(xml.@value == "true")
         {
            xmllist = xml..Active;
            i = 0;
            if(i < xmllist.length())
            {
               ObjectUtils.copyPorpertiesByXML(_data,xmllist[i]);
            }
            xmllist = xml..ActiveExp;
            for(i = 0; i < xmllist.length(); )
            {
               if(xmllist[i].@ActiveID == _data.ActiveID.toString())
               {
                  _dataList.push(int(xmllist[i].@Exp));
               }
               i++;
            }
            _dataList.sort(16);
            xmllist = xml..ActiveAward;
            for(i = 0; i < xmllist.length(); )
            {
               if(xmllist[i].@ActiveID == _data.ActiveID.toString())
               {
                  awardInfo = new DragonBoatAwardInfo();
                  ObjectUtils.copyPorpertiesByXML(awardInfo,xmllist[i]);
                  if(xmllist[i].@IsArea == "1")
                  {
                     _dataListSelf.push(awardInfo);
                  }
                  else
                  {
                     _dataListOther.push(awardInfo);
                  }
               }
               i++;
            }
            _dataListSelf.sortOn("RandID",16);
            _dataListOther.sortOn("RandID",16);
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get data() : DragonBoatActiveInfo
      {
         return _data;
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
      
      public function get dataListSelf() : Array
      {
         return _dataListSelf;
      }
      
      public function get dataListOther() : Array
      {
         return _dataListOther;
      }
   }
}
