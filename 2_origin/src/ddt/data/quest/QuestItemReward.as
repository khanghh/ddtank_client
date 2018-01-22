package ddt.data.quest
{
   public class QuestItemReward
   {
       
      
      private var _selectGroup:int;
      
      private var _itemID:int;
      
      private var _count:Array;
      
      private var _isOptional:int;
      
      private var _time:int;
      
      private var _StrengthenLevel:int;
      
      private var _AttackCompose:int;
      
      private var _DefendCompose:int;
      
      private var _AgilityCompose:int;
      
      private var _LuckCompose:int;
      
      private var _isBind:Boolean;
      
      public var AttackCompose:int;
      
      public var DefendCompose:int;
      
      public var LuckCompose:int;
      
      public var AgilityCompose:int;
      
      public var StrengthenLevel:int;
      
      public var IsCount:Boolean;
      
      public var MagicAttack:int;
      
      public var MagicDefence:int;
      
      public function QuestItemReward(param1:int, param2:Array, param3:String, param4:String = "true")
      {
         super();
         _itemID = param1;
         _count = param2;
         if(param3 == "true")
         {
            _isOptional = 1;
         }
         else
         {
            _isOptional = 0;
         }
         if(param4 == "true")
         {
            _isBind = true;
         }
         else
         {
            _isBind = false;
         }
      }
      
      public function get count() : Array
      {
         return _count;
      }
      
      public function get itemID() : int
      {
         return _itemID;
      }
      
      public function set time(param1:int) : void
      {
         _time = param1;
      }
      
      public function get time() : int
      {
         return _time;
      }
      
      public function get ValidateTime() : Number
      {
         return _time;
      }
      
      public function get isOptional() : int
      {
         return _isOptional;
      }
      
      public function get isBind() : Boolean
      {
         return _isBind;
      }
   }
}
