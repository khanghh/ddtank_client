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
      
      public function DiceModel(param1:IEventDispatcher = null)
      {
         initialize();
         super(param1);
      }
      
      public function get rewardItems() : Array
      {
         return _rewardItems;
      }
      
      public function set rewardItems(param1:Array) : void
      {
         _rewardItems = param1;
      }
      
      public function get popupAlert() : int
      {
         return _popupAlert;
      }
      
      public function set popupAlert(param1:int) : void
      {
         _popupAlert = param1;
      }
      
      public function get isPlayDownMovie() : Boolean
      {
         return _isPlayDownMovie;
      }
      
      public function set isPlayDownMovie(param1:Boolean) : void
      {
         _isPlayDownMovie = param1;
      }
      
      public function get diceType() : int
      {
         return _diceType;
      }
      
      public function set diceType(param1:int) : void
      {
         _diceType = param1;
      }
      
      public function get levelInfo() : Array
      {
         return _levelInfo;
      }
      
      public function set levelInfo(param1:Array) : void
      {
         _levelInfo = param1;
      }
      
      public function get MAX_LEVEL() : int
      {
         return _MAX_LEVEL;
      }
      
      public function set MAX_LEVEL(param1:int) : void
      {
         _MAX_LEVEL = param1;
         _levelInfo = [];
      }
      
      public function get smallDicePrice() : int
      {
         return _smallDicePrice;
      }
      
      public function set smallDicePrice(param1:int) : void
      {
         _smallDicePrice = param1;
      }
      
      public function get bigDicePrice() : int
      {
         return _bigDicePrice;
      }
      
      public function set bigDicePrice(param1:int) : void
      {
         _bigDicePrice = param1;
      }
      
      public function get doubleDicePrice() : int
      {
         return _doubleDicePrice;
      }
      
      public function set doubleDicePrice(param1:int) : void
      {
         _doubleDicePrice = param1;
      }
      
      public function get commonDicePrice() : int
      {
         return _commonDicePrice;
      }
      
      public function set commonDicePrice(param1:int) : void
      {
         _commonDicePrice = param1;
      }
      
      public function get refreshPrice() : int
      {
         return _refreshPrice;
      }
      
      public function set refreshPrice(param1:int) : void
      {
         _refreshPrice = param1;
      }
      
      public function get freeCount() : int
      {
         return _freeCount;
      }
      
      public function set freeCount(param1:int) : void
      {
         if(_freeCount != param1)
         {
            if(param1 < 0)
            {
               param1 = 0;
            }
            _freeCount = param1;
            DiceController.Instance.dispatchEvent(new DiceEvent("dice_freeCount_changed"));
         }
      }
      
      public function get LuckIntegralLevel() : int
      {
         return _LuckIntegral_Level;
      }
      
      public function set LuckIntegralLevel(param1:int) : void
      {
         if(_LuckIntegral_Level != param1 + 1)
         {
            _LuckIntegral_Level = param1 + 1;
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
      
      public function set cellCount(param1:int) : void
      {
         _CELL_COUNT = param1;
         _cellItem = [];
         _cellPosition = [];
      }
      
      public function set userFirstCell(param1:Boolean) : void
      {
         _useFirstCell = param1;
      }
      
      private function initialize() : void
      {
      }
      
      public function setCellInfo() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _CELL_COUNT)
         {
            if(_cellPosition[_loc1_])
            {
               _cellPosition[_loc1_].dispose();
               _cellPosition[_loc1_] = null;
            }
            _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.dice.cellInfo." + (_loc1_ + 1));
            _cellPosition[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      public function get LuckIntegral() : int
      {
         return _LuckIntegral;
      }
      
      public function set LuckIntegral(param1:int) : void
      {
         if(_LuckIntegral != param1)
         {
            _LuckIntegral = param1;
         }
         DiceController.Instance.dispatchEvent(new DiceEvent("dice_luckintegral_changed"));
      }
      
      public function get currentPosition() : int
      {
         return _currentPosition;
      }
      
      public function set currentPosition(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 >= _CELL_COUNT)
         {
            param1 = _CELL_COUNT - 1;
         }
         if(param1 != DiceController.Instance.CurrentPosition)
         {
            _currentPosition = param1;
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
      
      public function addCellItem(param1:DiceCell) : void
      {
         _cellItem.push(param1);
      }
      
      public function removeCellItem(param1:int) : void
      {
         if(param1 < _cellItem.length)
         {
            if(_cellItem[param1])
            {
               _cellItem[param1].dispose();
            }
            _cellItem[param1] = null;
            _cellItem.splice(param1,1);
         }
      }
      
      public function removeAllItem() : void
      {
         var _loc1_:int = 0;
         if(_cellItem)
         {
            _loc1_ = _cellItem.length;
            while(_loc1_ > 0)
            {
               removeCellItem(_loc1_ - 1);
               _loc1_--;
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
