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
      
      public function parseXML(xml:XML) : void
      {
         _level = parseInt(xml.@Level);
         _mustGetTimes = parseInt(xml.@MustGetTimes);
         _baseSuccessPro = parseInt(xml.@BaseSuccessPro);
         _refrenceValue = parseInt(xml.@RefrenceValue);
         _skillId = parseInt(xml.@SkillId);
         _attackAdd = parseInt(xml.@AttackAdd);
         _luckAdd = parseInt(xml.@LuckAdd);
         _defendAdd = parseInt(xml.@DefendAdd);
         _agilityAdd = parseInt(xml.@AgilityAdd);
         _bagType = parseInt(xml.@BagType);
         _place = parseInt(xml.@BagPlace);
         _categoryid = parseInt(xml.@CategoryId);
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
