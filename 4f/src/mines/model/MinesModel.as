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
      
      public function MinesModel(){super();}
      
      public function get toolExp() : int{return 0;}
      
      public function set toolExp(param1:int) : void{}
      
      public function get headExp() : int{return 0;}
      
      public function set headExp(param1:int) : void{}
      
      public function get clothExp() : int{return 0;}
      
      public function set clothExp(param1:int) : void{}
      
      public function get weaponExp() : int{return 0;}
      
      public function set weaponExp(param1:int) : void{}
      
      public function get shieldExp() : int{return 0;}
      
      public function set shieldExp(param1:int) : void{}
      
      public function setEquipLevel() : void{}
   }
}
