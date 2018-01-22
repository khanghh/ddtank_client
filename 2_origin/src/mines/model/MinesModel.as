package mines.model
{
   import flash.events.EventDispatcher;
   import mines.analyzer.DropItemInfo;
   import mines.analyzer.EquipmentInfo;
   import mines.analyzer.ShopDropInfo;
   import mines.analyzer.ShopExchangeInfo;
   import mines.analyzer.ToolLevelInfo;
   
   public class MinesModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean;
      
      public var dropList:Vector.<DropItemInfo>;
      
      public var toolList:Vector.<ToolLevelInfo>;
      
      public var equipList:Vector.<EquipmentInfo>;
      
      public var shopDropList:Vector.<ShopDropInfo>;
      
      public var shopExchangeList:Vector.<ShopExchangeInfo>;
      
      public var digShowList:Array;
      
      public var isFull:Boolean = false;
      
      public var toolLevel:int;
      
      public var headLevel:int;
      
      public var clothLevel:int;
      
      public var weaponLevel:int;
      
      public var shieldLevel:int;
      
      private var _toolExp:int;
      
      private var _headExp:int;
      
      private var _clothExp:int;
      
      private var _weaponExp:int;
      
      private var _shieldExp:int;
      
      public function MinesModel()
      {
         dropList = new Vector.<DropItemInfo>();
         toolList = new Vector.<ToolLevelInfo>();
         equipList = new Vector.<EquipmentInfo>();
         digShowList = [];
         super();
      }
      
      public function get toolExp() : int
      {
         return _toolExp;
      }
      
      public function set toolExp(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _toolExp = param1;
         _loc3_ = 0;
         while(_loc3_ < toolList.length)
         {
            _loc2_ = toolList[_loc3_] as ToolLevelInfo;
            if(_toolExp >= _loc2_.exp)
            {
               toolLevel = _loc2_.level;
            }
            _loc3_++;
         }
      }
      
      public function get headExp() : int
      {
         return _headExp;
      }
      
      public function set headExp(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _headExp = param1;
         _loc3_ = 0;
         while(_loc3_ < equipList.length)
         {
            _loc2_ = equipList[_loc3_] as EquipmentInfo;
            if(_headExp >= _loc2_.headExp)
            {
               headLevel = _loc2_.level;
            }
            _loc3_++;
         }
      }
      
      public function get clothExp() : int
      {
         return _clothExp;
      }
      
      public function set clothExp(param1:int) : void
      {
         _clothExp = param1;
      }
      
      public function get weaponExp() : int
      {
         return _weaponExp;
      }
      
      public function set weaponExp(param1:int) : void
      {
         _weaponExp = param1;
      }
      
      public function get shieldExp() : int
      {
         return _shieldExp;
      }
      
      public function set shieldExp(param1:int) : void
      {
         _shieldExp = param1;
      }
      
      public function setEquipLevel() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < equipList.length)
         {
            _loc1_ = equipList[_loc2_] as EquipmentInfo;
            if(_headExp >= _loc1_.headExp)
            {
               headLevel = _loc1_.level;
            }
            if(_clothExp >= _loc1_.clothExp)
            {
               clothLevel = _loc1_.level;
            }
            if(_weaponExp >= _loc1_.swordExp)
            {
               weaponLevel = _loc1_.level;
            }
            if(_shieldExp >= _loc1_.shieldExp)
            {
               shieldLevel = _loc1_.level;
            }
            _loc2_++;
         }
      }
   }
}
