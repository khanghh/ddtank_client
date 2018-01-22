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
      
      public function UserBoxInfoAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         _xml = new XML(param1);
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
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc2_:* = null;
         _loc7_ = 0;
         while(_loc7_ < _goodsList.length())
         {
            _loc5_ = _goodsList[_loc7_].@Type;
            switch(int(_loc5_))
            {
               case 0:
                  _loc1_ = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc1_,_goodsList[_loc7_]);
                  boxTemplateID[_loc1_.TemplateID] = _loc1_.TemplateID;
                  timeBoxList.add(_loc1_.ID,_loc1_);
                  break;
               case 1:
                  _loc4_ = new GradeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc4_,_goodsList[_loc7_]);
                  boxTemplateID[_loc4_.TemplateID] = _loc4_.TemplateID;
                  gradeBoxList.add(_loc4_.ID,_loc4_);
                  break;
               case 2:
                  _loc3_ = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_goodsList[_loc7_]);
                  boxTemplateID[_loc3_.TemplateID] = _loc3_.TemplateID;
                  break;
               default:
                  _loc3_ = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_goodsList[_loc7_]);
                  boxTemplateID[_loc3_.TemplateID] = _loc3_.TemplateID;
                  break;
               default:
                  _loc3_ = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_goodsList[_loc7_]);
                  boxTemplateID[_loc3_.TemplateID] = _loc3_.TemplateID;
                  break;
               default:
                  _loc3_ = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_goodsList[_loc7_]);
                  boxTemplateID[_loc3_.TemplateID] = _loc3_.TemplateID;
                  break;
               default:
                  _loc3_ = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_goodsList[_loc7_]);
                  boxTemplateID[_loc3_.TemplateID] = _loc3_.TemplateID;
                  break;
               default:
                  _loc3_ = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_goodsList[_loc7_]);
                  boxTemplateID[_loc3_.TemplateID] = _loc3_.TemplateID;
                  break;
               default:
                  _loc3_ = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_goodsList[_loc7_]);
                  boxTemplateID[_loc3_.TemplateID] = _loc3_.TemplateID;
                  break;
               default:
                  _loc3_ = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_goodsList[_loc7_]);
                  boxTemplateID[_loc3_.TemplateID] = _loc3_.TemplateID;
                  break;
               case 10:
                  _loc6_ = new TimeBoxInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc6_,_goodsList[_loc7_]);
                  if(CSMBoxList[_loc6_.Level])
                  {
                     _loc2_ = CSMBoxList[_loc6_.Level].goodListIds;
                  }
                  else
                  {
                     _loc2_ = [];
                  }
                  _loc2_.push(_loc6_.TemplateID);
                  CSMBoxList[_loc6_.Level] = {
                     "goodListIds":_loc2_,
                     "info":_loc6_
                  };
                  boxTemplateID[_loc6_.TemplateID] = _loc6_.TemplateID;
            }
            _loc7_++;
         }
         onAnalyzeComplete();
      }
      
      private function getXML() : XML
      {
         var _loc1_:XML = <Result value="true" message="Success!">
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
         return _loc1_;
      }
   }
}
