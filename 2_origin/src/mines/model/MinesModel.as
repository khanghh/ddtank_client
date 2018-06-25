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
      
      public function set toolExp(value:int) : void
      {
         var i:int = 0;
         var info:* = null;
         _toolExp = value;
         for(i = 0; i < toolList.length; )
         {
            info = toolList[i] as ToolLevelInfo;
            if(_toolExp >= info.exp)
            {
               toolLevel = info.level;
            }
            i++;
         }
      }
      
      public function get headExp() : int
      {
         return _headExp;
      }
      
      public function set headExp(value:int) : void
      {
         var i:int = 0;
         var info:* = null;
         _headExp = value;
         for(i = 0; i < equipList.length; )
         {
            info = equipList[i] as EquipmentInfo;
            if(_headExp >= info.headExp)
            {
               headLevel = info.level;
            }
            i++;
         }
      }
      
      public function get clothExp() : int
      {
         return _clothExp;
      }
      
      public function set clothExp(value:int) : void
      {
         _clothExp = value;
      }
      
      public function get weaponExp() : int
      {
         return _weaponExp;
      }
      
      public function set weaponExp(value:int) : void
      {
         _weaponExp = value;
      }
      
      public function get shieldExp() : int
      {
         return _shieldExp;
      }
      
      public function set shieldExp(value:int) : void
      {
         _shieldExp = value;
      }
      
      public function setEquipLevel() : void
      {
         var i:int = 0;
         var info:* = null;
         for(i = 0; i < equipList.length; )
         {
            info = equipList[i] as EquipmentInfo;
            if(_headExp >= info.headExp)
            {
               headLevel = info.level;
            }
            if(_clothExp >= info.clothExp)
            {
               clothLevel = info.level;
            }
            if(_weaponExp >= info.swordExp)
            {
               weaponLevel = info.level;
            }
            if(_shieldExp >= info.shieldExp)
            {
               shieldLevel = info.level;
            }
            i++;
         }
      }
   }
}
