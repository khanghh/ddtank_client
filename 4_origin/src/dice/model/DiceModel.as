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
      
      public function DiceModel(target:IEventDispatcher = null)
      {
         initialize();
         super(target);
      }
      
      public function get rewardItems() : Array
      {
         return _rewardItems;
      }
      
      public function set rewardItems(value:Array) : void
      {
         _rewardItems = value;
      }
      
      public function get popupAlert() : int
      {
         return _popupAlert;
      }
      
      public function set popupAlert(value:int) : void
      {
         _popupAlert = value;
      }
      
      public function get isPlayDownMovie() : Boolean
      {
         return _isPlayDownMovie;
      }
      
      public function set isPlayDownMovie(value:Boolean) : void
      {
         _isPlayDownMovie = value;
      }
      
      public function get diceType() : int
      {
         return _diceType;
      }
      
      public function set diceType(value:int) : void
      {
         _diceType = value;
      }
      
      public function get levelInfo() : Array
      {
         return _levelInfo;
      }
      
      public function set levelInfo(value:Array) : void
      {
         _levelInfo = value;
      }
      
      public function get MAX_LEVEL() : int
      {
         return _MAX_LEVEL;
      }
      
      public function set MAX_LEVEL(value:int) : void
      {
         _MAX_LEVEL = value;
         _levelInfo = [];
      }
      
      public function get smallDicePrice() : int
      {
         return _smallDicePrice;
      }
      
      public function set smallDicePrice(value:int) : void
      {
         _smallDicePrice = value;
      }
      
      public function get bigDicePrice() : int
      {
         return _bigDicePrice;
      }
      
      public function set bigDicePrice(value:int) : void
      {
         _bigDicePrice = value;
      }
      
      public function get doubleDicePrice() : int
      {
         return _doubleDicePrice;
      }
      
      public function set doubleDicePrice(value:int) : void
      {
         _doubleDicePrice = value;
      }
      
      public function get commonDicePrice() : int
      {
         return _commonDicePrice;
      }
      
      public function set commonDicePrice(value:int) : void
      {
         _commonDicePrice = value;
      }
      
      public function get refreshPrice() : int
      {
         return _refreshPrice;
      }
      
      public function set refreshPrice(value:int) : void
      {
         _refreshPrice = value;
      }
      
      public function get freeCount() : int
      {
         return _freeCount;
      }
      
      public function set freeCount(value:int) : void
      {
         if(_freeCount != value)
         {
            if(value < 0)
            {
               value = 0;
            }
            _freeCount = value;
            DiceController.Instance.dispatchEvent(new DiceEvent("dice_freeCount_changed"));
         }
      }
      
      public function get LuckIntegralLevel() : int
      {
         return _LuckIntegral_Level;
      }
      
      public function set LuckIntegralLevel(value:int) : void
      {
         if(_LuckIntegral_Level != value + 1)
         {
            _LuckIntegral_Level = value + 1;
         }
      }
      
      public function get CELL_COUNT() : int
      {
         return _CELL_COUNT;
      }
      
      public function get userFirstCell() : Boolean
      {
         return _useFirstCell;
      }
      
      public function set cellCount(value:int) : void
      {
         _CELL_COUNT = value;
         _cellItem = [];
         _cellPosition = [];
      }
      
      public function set userFirstCell(value:Boolean) : void
      {
         _useFirstCell = value;
      }
      
      private function initialize() : void
      {
      }
      
      public function setCellInfo() : void
      {
         var info:* = null;
         var i:int = 0;
         for(i = 0; i < _CELL_COUNT; )
         {
            if(_cellPosition[i])
            {
               _cellPosition[i].dispose();
               _cellPosition[i] = null;
            }
            info = ComponentFactory.Instance.creatCustomObject("asset.dice.cellInfo." + (i + 1));
            _cellPosition[i] = info;
            i++;
         }
      }
      
      public function get LuckIntegral() : int
      {
         return _LuckIntegral;
      }
      
      public function set LuckIntegral(value:int) : void
      {
         if(_LuckIntegral != value)
         {
            _LuckIntegral = value;
         }
         DiceController.Instance.dispatchEvent(new DiceEvent("dice_luckintegral_changed"));
      }
      
      public function get currentPosition() : int
      {
         return _currentPosition;
      }
      
      public function set currentPosition(value:int) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         else if(value >= _CELL_COUNT)
         {
            value = _CELL_COUNT - 1;
         }
         if(value != DiceController.Instance.CurrentPosition)
         {
            _currentPosition = value;
            DiceController.Instance.dispatchEvent(new DiceEvent("dice_position_changed"));
         }
      }
      
      public function get cellIDs() : Array
      {
         return _cellItem;
      }
      
      public function get cellPosition() : Array
      {
         return _cellPosition;
      }
      
      public function addCellItem(cellValue:DiceCell) : void
      {
         _cellItem.push(cellValue);
      }
      
      public function removeCellItem(index:int) : void
      {
         if(index < _cellItem.length)
         {
            if(_cellItem[index])
            {
               _cellItem[index].dispose();
            }
            _cellItem[index] = null;
            _cellItem.splice(index,1);
         }
      }
      
      public function removeAllItem() : void
      {
         var i:int = 0;
         if(_cellItem)
         {
            for(i = _cellItem.length; i > 0; )
            {
               removeCellItem(i - 1);
               i--;
            }
         }
      }
      
      public function dispose() : void
      {
         _cellItem = null;
         _cellPosition = null;
      }
   }
}
