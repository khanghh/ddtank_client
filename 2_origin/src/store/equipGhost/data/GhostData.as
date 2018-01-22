package store.equipGhost.data
{
   public final class GhostData
   {
       
      
      private var _level:int;
      
      private var _mustGetTimes:int;
      
      private var _baseSuccessPro:int;
      
      private var _refrenceValue:int;
      
      private var _skillId:int;
      
      private var _attackAdd:int;
      
      private var _luckAdd:int;
      
      private var _defendAdd:int;
      
      private var _agilityAdd:int;
      
      private var _bagType:int;
      
      private var _place:int;
      
      private var _categoryid:int;
      
      public function GhostData()
      {
         super();
      }
      
      public function get skillId() : int
      {
         return _skillId;
      }
      
      public function get categoryID() : int
      {
         return _categoryid;
      }
      
      public function get agilityAdd() : int
      {
         return _agilityAdd;
      }
      
      public function get defendAdd() : int
      {
         return _defendAdd;
      }
      
      public function get luckAdd() : int
      {
         return _luckAdd;
      }
      
      public function get attackAdd() : int
      {
         return _attackAdd;
      }
      
      public function get refrenceValue() : int
      {
         return _refrenceValue;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function parseXML(param1:XML) : void
      {
         _level = parseInt(param1.@Level);
         _mustGetTimes = parseInt(param1.@MustGetTimes);
         _baseSuccessPro = parseInt(param1.@BaseSuccessPro);
         _refrenceValue = parseInt(param1.@RefrenceValue);
         _skillId = parseInt(param1.@SkillId);
         _attackAdd = parseInt(param1.@AttackAdd);
         _luckAdd = parseInt(param1.@LuckAdd);
         _defendAdd = parseInt(param1.@DefendAdd);
         _agilityAdd = parseInt(param1.@AgilityAdd);
         _bagType = parseInt(param1.@BagType);
         _place = parseInt(param1.@BagPlace);
         _categoryid = parseInt(param1.@CategoryId);
      }
      
      public function get baseSuccessPro() : int
      {
         return _baseSuccessPro;
      }
      
      public function get mustGetTimes() : int
      {
         return _mustGetTimes;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get bagType() : int
      {
         return _bagType;
      }
   }
}
