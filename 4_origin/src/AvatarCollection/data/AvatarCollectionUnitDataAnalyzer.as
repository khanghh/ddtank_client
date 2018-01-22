package AvatarCollection.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.data.DictionaryData;
   
   public class AvatarCollectionUnitDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _maleUnitDic:DictionaryData;
      
      private var _femaleUnitDic:DictionaryData;
      
      private var _weaponUnitDic:DictionaryData;
      
      public function AvatarCollectionUnitDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         _maleUnitDic = new DictionaryData();
         _femaleUnitDic = new DictionaryData();
         _weaponUnitDic = new DictionaryData();
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new AvatarCollectionUnitVo();
               _loc2_.id = _loc4_[_loc5_].@ID;
               _loc2_.sex = _loc4_[_loc5_].@Sex;
               _loc2_.name = _loc4_[_loc5_].@Name;
               _loc2_.Attack = _loc4_[_loc5_].@Attack;
               _loc2_.Defence = _loc4_[_loc5_].@Defend;
               _loc2_.Agility = _loc4_[_loc5_].@Agility;
               _loc2_.Luck = _loc4_[_loc5_].@Luck;
               _loc2_.Damage = _loc4_[_loc5_].@Damage;
               _loc2_.Guard = _loc4_[_loc5_].@Guard;
               _loc2_.Blood = _loc4_[_loc5_].@Blood;
               _loc2_.needHonor = _loc4_[_loc5_].@Cost;
               _loc2_.Type = _loc4_[_loc5_].@Type;
               if(_loc2_.Type == 1)
               {
                  if(_loc2_.sex == 1)
                  {
                     _maleUnitDic.add(_loc2_.id,_loc2_);
                  }
                  else
                  {
                     _femaleUnitDic.add(_loc2_.id,_loc2_);
                  }
               }
               else if(_loc2_.Type == 2)
               {
                  _weaponUnitDic.add(_loc2_.id,_loc2_);
               }
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
         }
      }
      
      public function get maleUnitDic() : DictionaryData
      {
         return _maleUnitDic;
      }
      
      public function get femaleUnitDic() : DictionaryData
      {
         return _femaleUnitDic;
      }
      
      public function get weaponUnitDic() : DictionaryData
      {
         return _weaponUnitDic;
      }
   }
}
