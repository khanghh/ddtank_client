package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.GradeBoxInfo;
   import ddt.data.box.TimeBoxInfo;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   
   public class UserBoxInfoAnalyzer extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      private var _goodsList:XMLList;
      
      public var timeBoxList:DictionaryData;
      
      public var gradeBoxList:DictionaryData;
      
      public var boxTemplateID:Dictionary;
      
      public var CSMBoxList:DictionaryData;
      
      public function UserBoxInfoAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         _xml = new XML(data);
         if(_xml.@value == "true")
         {
            timeBoxList = new DictionaryData();
            gradeBoxList = new DictionaryData();
            boxTemplateID = new Dictionary();
            CSMBoxList = new DictionaryData();
            _goodsList = _xml..Item;
            parseShop();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      private function parseShop() : void
      {
         var i:int = 0;
         var type:int = 0;
         var timeInfo:* = null;
         var gradeInfo:* = null;
         var timeInfoI:* = null;
         var timeInfoII:* = null;
         var csmGoodListIds:* = null;
         for(i = 0; i < _goodsList.length(); )
         {
            type = _goodsList[i].@Type;
            switch(int(type))
            {
               case 0:
                  timeInfo = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(timeInfo,_goodsList[i]);
                  boxTemplateID[timeInfo.TemplateID] = timeInfo.TemplateID;
                  timeBoxList.add(timeInfo.ID,timeInfo);
                  break;
               case 1:
                  gradeInfo = new GradeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(gradeInfo,_goodsList[i]);
                  boxTemplateID[gradeInfo.TemplateID] = gradeInfo.TemplateID;
                  gradeBoxList.add(gradeInfo.ID,gradeInfo);
                  break;
               case 2:
                  timeInfoI = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(timeInfoI,_goodsList[i]);
                  boxTemplateID[timeInfoI.TemplateID] = timeInfoI.TemplateID;
                  break;
               default:
                  timeInfoI = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(timeInfoI,_goodsList[i]);
                  boxTemplateID[timeInfoI.TemplateID] = timeInfoI.TemplateID;
                  break;
               default:
                  timeInfoI = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(timeInfoI,_goodsList[i]);
                  boxTemplateID[timeInfoI.TemplateID] = timeInfoI.TemplateID;
                  break;
               default:
                  timeInfoI = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(timeInfoI,_goodsList[i]);
                  boxTemplateID[timeInfoI.TemplateID] = timeInfoI.TemplateID;
                  break;
               default:
                  timeInfoI = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(timeInfoI,_goodsList[i]);
                  boxTemplateID[timeInfoI.TemplateID] = timeInfoI.TemplateID;
                  break;
               default:
                  timeInfoI = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(timeInfoI,_goodsList[i]);
                  boxTemplateID[timeInfoI.TemplateID] = timeInfoI.TemplateID;
                  break;
               default:
                  timeInfoI = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(timeInfoI,_goodsList[i]);
                  boxTemplateID[timeInfoI.TemplateID] = timeInfoI.TemplateID;
                  break;
               default:
                  timeInfoI = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(timeInfoI,_goodsList[i]);
                  boxTemplateID[timeInfoI.TemplateID] = timeInfoI.TemplateID;
                  break;
               case 10:
                  timeInfoII = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(timeInfoII,_goodsList[i]);
                  if(CSMBoxList[timeInfoII.Level])
                  {
                     csmGoodListIds = CSMBoxList[timeInfoII.Level].goodListIds;
                  }
                  else
                  {
                     csmGoodListIds = [];
                  }
                  csmGoodListIds.push(timeInfoII.TemplateID);
                  CSMBoxList[timeInfoII.Level] = {
                     "goodListIds":csmGoodListIds,
                     "info":timeInfoII
                  };
                  boxTemplateID[timeInfoII.TemplateID] = timeInfoII.TemplateID;
            }
            i++;
         }
         onAnalyzeComplete();
      }
      
      private function getXML() : XML
      {
         var xml:XML = <Result value="true" message="Success!">
  <Item ID="1" Type="0" Level="20" Condition="15" TemplateID="1120090"/>
  <Item ID="2" Type="0" Level="20" Condition="40" TemplateID="1120091"/>
  <Item ID="3" Type="0" Level="20" Condition="60" TemplateID="1120092"/>
  <Item ID="4" Type="0" Level="20" Condition="75" TemplateID="1120093"/>
  <Item ID="6" Type="1" Level="4" Condition="1" TemplateID="1120071"/>
  <Item ID="7" Type="1" Level="5" Condition="1" TemplateID="1120072"/>
  <Item ID="8" Type="1" Level="8" Condition="1" TemplateID="1120073"/>
  <Item ID="9" Type="1" Level="10" Condition="1" TemplateID="1120074"/>
  <Item ID="10" Type="1" Level="11" Condition="1" TemplateID="1120075"/>
  <Item ID="11" Type="1" Level="12" Condition="1" TemplateID="1120076"/>
  <Item ID="12" Type="1" Level="15" Condition="1" TemplateID="1120077"/>
  <Item ID="13" Type="1" Level="20" Condition="1" TemplateID="1120078"/>
  <Item ID="14" Type="1" Level="4" Condition="0" TemplateID="1120081"/>
  <Item ID="15" Type="1" Level="5" Condition="0" TemplateID="1120082"/>
  <Item ID="16" Type="1" Level="8" Condition="0" TemplateID="1120083"/>
  <Item ID="17" Type="1" Level="10" Condition="0" TemplateID="1120084"/>
  <Item ID="18" Type="1" Level="11" Condition="0" TemplateID="1120085"/>
  <Item ID="19" Type="1" Level="12" Condition="0" TemplateID="1120086"/>
  <Item ID="20" Type="1" Level="15" Condition="0" TemplateID="1120087"/>
  <Item ID="21" Type="1" Level="20" Condition="0" TemplateID="1120088"/>
  <Item ID="14" Type="2" Level="4" Condition="0" TemplateID="112112"/>
  <Item ID="15" Type="2" Level="5" Condition="0" TemplateID="112113"/>
  <Item ID="16" Type="2" Level="8" Condition="0" TemplateID="112114"/>
  <Item ID="17" Type="2" Level="10" Condition="0" TemplateID="112115"/>
  <Item ID="18" Type="2" Level="11" Condition="0" TemplateID="112116"/>
  <Item ID="19" Type="2" Level="12" Condition="0" TemplateID="112117"/>
  <Item ID="20" Type="2" Level="15" Condition="0" TemplateID="112118"/>
 <Item ID="21" Type="2" Level="20" Condition="0" TemplateID="112119"/>
 <Item ID="21" Type="2" Level="20" Condition="0" TemplateID="112120"/>
</Result>
				;
         return xml;
      }
   }
}
