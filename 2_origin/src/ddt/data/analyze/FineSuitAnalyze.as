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
      
      public function FineSuitAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         _list = new DictionaryData();
         _data = new DictionaryData();
         _materialIDList = [];
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..SetsBuildTemp;
            if(_loc3_.length() > 0)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc3_.length())
               {
                  _loc5_ = new FineSuitVo();
                  _loc5_.level = _loc3_[_loc6_].@Level;
                  _loc5_.type = _loc3_[_loc6_].@SetsType;
                  _loc5_.materialID = _loc3_[_loc6_].@UseItemTemplate;
                  _loc5_.exp = _loc3_[_loc6_].@Exp;
                  _loc5_.Defence = _loc3_[_loc6_].@DefenceGrow;
                  _loc5_.hp = _loc3_[_loc6_].@BloodGrow;
                  _loc5_.Luck = _loc3_[_loc6_].@LuckGrow;
                  _loc5_.Agility = _loc3_[_loc6_].@AgilityGrow;
                  _loc5_.MagicDefence = _loc3_[_loc6_].@MagicDefenceGrow;
                  _loc5_.Armor = _loc3_[_loc6_].@GuardGrow;
                  _list.add(_loc5_.level,_loc5_);
                  if(_loc6_ % 14 == 0)
                  {
                     _materialIDList.push(_loc5_.materialID);
                  }
                  addData(_loc5_);
                  _loc6_++;
               }
               _loc4_ = new FineSuitVo();
               _loc4_.materialID = _list["1"].materialID;
               _list.add("0",_loc4_);
               onAnalyzeComplete();
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      private function addData(param1:FineSuitVo) : void
      {
         var _loc4_:* = null;
         var _loc2_:int = param1.level % 14 == 0?14:Number(param1.level % 14);
         var _loc3_:FineSuitVo = new FineSuitVo();
         if(!_data.hasKey(param1.type))
         {
            _loc4_ = new DictionaryData();
            _data.add(param1.type,_loc4_);
            ObjectUtils.copyProperties(_loc3_,param1);
            _loc4_.add("all",_loc3_);
         }
         else
         {
            _loc4_ = _data[param1.type];
            _loc3_ = _loc4_["all"] as FineSuitVo;
            _loc3_.Defence = _loc3_.Defence + param1.Defence;
            _loc3_.hp = _loc3_.hp + param1.hp;
            _loc3_.Luck = _loc3_.Luck + param1.Luck;
            _loc3_.Agility = _loc3_.Agility + param1.Agility;
            _loc3_.MagicDefence = _loc3_.MagicDefence + param1.MagicDefence;
            _loc3_.Armor = _loc3_.Armor + param1.Armor;
         }
         _loc4_.add(_loc2_,param1);
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
