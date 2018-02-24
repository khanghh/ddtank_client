package dice.model
{
   import com.pickgliss.ui.ComponentFactory;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import dice.vo.DiceCell;
   import dice.vo.DiceCellInfo;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class DiceModel extends EventDispatcher
   {
       
      
      private var _CELL_COUNT:int = 20;
      
      private var _popupAlert:int = 12;
      
      private var _diceType:int = 0;
      
      private var _freeCount:int = 0;
      
      private var _refreshPrice:int;
      
      private var _commonDicePrice:int;
      
      private var _doubleDicePrice:int;
      
      private var _bigDicePrice:int;
      
      private var _smallDicePrice:int;
      
      private var _MAX_LEVEL:int = 5;
      
      private var _levelInfo:Array;
      
      private var _LuckIntegral_Level:int = 0;
      
      private var _LuckIntegral:int = 0;
      
      private var _currentPosition:int = 0;
      
      private var _cellItem:Array;
      
      private var _cellPosition:Array;
      
      private var _useFirstCell:Boolean = false;
      
      private var _isPlayDownMovie:Boolean = false;
      
      private var _rewardItems:Array;
      
      public function DiceModel(param1:IEventDispatcher = null){super(null);}
      
      public function get rewardItems() : Array{return null;}
      
      public function set rewardItems(param1:Array) : void{}
      
      public function get popupAlert() : int{return 0;}
      
      public function set popupAlert(param1:int) : void{}
      
      public function get isPlayDownMovie() : Boolean{return false;}
      
      public function set isPlayDownMovie(param1:Boolean) : void{}
      
      public function get diceType() : int{return 0;}
      
      public function set diceType(param1:int) : void{}
      
      public function get levelInfo() : Array{return null;}
      
      public function set levelInfo(param1:Array) : void{}
      
      public function get MAX_LEVEL() : int{return 0;}
      
      public function set MAX_LEVEL(param1:int) : void{}
      
      public function get smallDicePrice() : int{return 0;}
      
      public function set smallDicePrice(param1:int) : void{}
      
      public function get bigDicePrice() : int{return 0;}
      
      public function set bigDicePrice(param1:int) : void{}
      
      public function get doubleDicePrice() : int{return 0;}
      
      public function set doubleDicePrice(param1:int) : void{}
      
      public function get commonDicePrice() : int{return 0;}
      
      public function set commonDicePrice(param1:int) : void{}
      
      public function get refreshPrice() : int{return 0;}
      
      public function set refreshPrice(param1:int) : void{}
      
      public function get freeCount() : int{return 0;}
      
      public function set freeCount(param1:int) : void{}
      
      public function get LuckIntegralLevel() : int{return 0;}
      
      public function set LuckIntegralLevel(param1:int) : void{}
      
      public function get CELL_COUNT() : int{return 0;}
      
      public function get userFirstCell() : Boolean{return false;}
      
      public function set cellCount(param1:int) : void{}
      
      public function set userFirstCell(param1:Boolean) : void{}
      
      private function initialize() : void{}
      
      public function setCellInfo() : void{}
      
      public function get LuckIntegral() : int{return 0;}
      
      public function set LuckIntegral(param1:int) : void{}
      
      public function get currentPosition() : int{return 0;}
      
      public function set currentPosition(param1:int) : void{}
      
      public function get cellIDs() : Array{return null;}
      
      public function get cellPosition() : Array{return null;}
      
      public function addCellItem(param1:DiceCell) : void{}
      
      public function removeCellItem(param1:int) : void{}
      
      public function removeAllItem() : void{}
      
      public function dispose() : void{}
   }
}
