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
      
      public function QuestItemReward(id:int, count:Array, optional:String, isBind:String = "true")
      {
         super();
         _itemID = id;
         _count = count;
         if(optional == "true")
         {
            _isOptional = 1;
         }
         else
         {
            _isOptional = 0;
         }
         if(isBind == "true")
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
      
      public function set time(time:int) : void
      {
         _time = time;
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
