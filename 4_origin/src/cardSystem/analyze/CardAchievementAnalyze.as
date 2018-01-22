package cardSystem.analyze
{
   import cardSystem.data.CardAchievementInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class CardAchievementAnalyze extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function CardAchievementAnalyze(param1:Function)
      {
         super(param1);
         _data = new DictionaryData();
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new CardAchievementInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _loc4_.attack = _loc3_[_loc5_].@AddAttack;
               _loc4_.MaxHp = _loc3_[_loc5_].@AddBlood;
               _loc4_.damage = _loc3_[_loc5_].@AddDamage;
               _loc4_.defence = _loc3_[_loc5_].@AddDefend;
               _loc4_.recovery = _loc3_[_loc5_].@AddGuard;
               _loc4_.luck = _loc3_[_loc5_].@AddLucky;
               _loc4_.magicAttack = _loc3_[_loc5_].@AddMagicAttack;
               _loc4_.magicDefend = _loc3_[_loc5_].@AddMagicDefend;
               _data.add(_loc4_.AchievementID,_loc4_);
               _loc5_++;
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
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
