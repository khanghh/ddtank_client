package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.store.FineSuitVo;
   import road7th.data.DictionaryData;
   
   public class FineSuitAnalyze extends DataAnalyzer
   {
       
      
      private var _list:DictionaryData;
      
      private var _data:DictionaryData;
      
      private var _materialIDList:Array;
      
      public function FineSuitAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var zero:* = null;
         var xml:XML = new XML(data);
         _list = new DictionaryData();
         _data = new DictionaryData();
         _materialIDList = [];
         if(xml.@value == "true")
         {
            xmllist = xml..SetsBuildTemp;
            if(xmllist.length() > 0)
            {
               for(i = 0; i < xmllist.length(); )
               {
                  info = new FineSuitVo();
                  info.level = xmllist[i].@Level;
                  info.type = xmllist[i].@SetsType;
                  info.materialID = xmllist[i].@UseItemTemplate;
                  info.exp = xmllist[i].@Exp;
                  info.Defence = xmllist[i].@DefenceGrow;
                  info.hp = xmllist[i].@BloodGrow;
                  info.Luck = xmllist[i].@LuckGrow;
                  info.Agility = xmllist[i].@AgilityGrow;
                  info.MagicDefence = xmllist[i].@MagicDefenceGrow;
                  info.Armor = xmllist[i].@GuardGrow;
                  _list.add(info.level,info);
                  if(i % 14 == 0)
                  {
                     _materialIDList.push(info.materialID);
                  }
                  addData(info);
                  i++;
               }
               zero = new FineSuitVo();
               zero.materialID = _list["1"].materialID;
               _list.add("0",zero);
               onAnalyzeComplete();
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
      
      private function addData(info:FineSuitVo) : void
      {
         var data:* = null;
         var level:int = info.level % 14 == 0?14:Number(info.level % 14);
         var allVo:FineSuitVo = new FineSuitVo();
         if(!_data.hasKey(info.type))
         {
            data = new DictionaryData();
            _data.add(info.type,data);
            ObjectUtils.copyProperties(allVo,info);
            data.add("all",allVo);
         }
         else
         {
            data = _data[info.type];
            allVo = data["all"] as FineSuitVo;
            allVo.Defence = allVo.Defence + info.Defence;
            allVo.hp = allVo.hp + info.hp;
            allVo.Luck = allVo.Luck + info.Luck;
            allVo.Agility = allVo.Agility + info.Agility;
            allVo.MagicDefence = allVo.MagicDefence + info.MagicDefence;
            allVo.Armor = allVo.Armor + info.Armor;
         }
         data.add(level,info);
      }
      
      public function get list() : DictionaryData
      {
         return _list;
      }
      
      public function get materialIDList() : Array
      {
         return _materialIDList;
      }
      
      public function get tipsData() : DictionaryData
      {
         return _data;
      }
   }
}
