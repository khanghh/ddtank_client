package dice.controller
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import dice.event.DiceEvent;
   import dice.model.DiceModel;
   import dice.vo.DiceAwardInfo;
   import dice.vo.DiceCell;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   
   [Event(name="dice_refresh_data",type="Dice.Event.DiceEvent")]
   public class DiceController extends EventDispatcher
   {
      
      private static var _instance:DiceController;
       
      
      private var _model:DiceModel;
      
      private var _isFirst:Boolean = true;
      
      public function DiceController(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : DiceController
      {
         if(_instance == null)
         {
            _instance = new DiceController();
         }
         return _instance;
      }
      
      public function set isFirst(param1:Boolean) : void
      {
         _isFirst = param1;
      }
      
      public function get hasUsedFirstCell() : Boolean
      {
         return _model.userFirstCell;
      }
      
      public function get CELL_COUNT() : int
      {
         return _model.CELL_COUNT;
      }
      
      public function get cellIDs() : Array
      {
         return _model.cellIDs;
      }
      
      public function get MAX_LEVEL() : int
      {
         return _model.MAX_LEVEL;
      }
      
      public function get freeCount() : int
      {
         return _model.freeCount;
      }
      
      public function set freeCount(param1:int) : void
      {
         _model.freeCount = param1;
      }
      
      public function get diceType() : int
      {
         return _model.diceType;
      }
      
      public function get commonDicePrice() : int
      {
         return _model.commonDicePrice;
      }
      
      public function get doubleDicePrice() : int
      {
         return _model.doubleDicePrice;
      }
      
      public function get bigDicePrice() : int
      {
         return _model.bigDicePrice;
      }
      
      public function get smallDicePrice() : int
      {
         return _model.smallDicePrice;
      }
      
      public function get refreshPrice() : int
      {
         return _model.refreshPrice;
      }
      
      public function get canPopupNextRefreshWindow() : Boolean
      {
         return (_model.popupAlert & 1) == 1;
      }
      
      public function get canPopupNextStartWindow() : Boolean
      {
         return (_model.popupAlert & 2) == 2;
      }
      
      public function get rewardItems() : Array
      {
         return _model.rewardItems;
      }
      
      public function set rewardItems(param1:Array) : void
      {
         _model.rewardItems = param1;
      }
      
      public function setPopupNextRefreshWindow(param1:Boolean) : void
      {
         if(param1)
         {
            _model.popupAlert = _model.popupAlert | 1;
         }
         else
         {
            _model.popupAlert = _model.popupAlert & 14;
         }
      }
      
      public function setPopupNextStartWindow(param1:Boolean) : void
      {
         if(param1)
         {
            _model.popupAlert = _model.popupAlert | 2;
         }
         else
         {
            _model.popupAlert = _model.popupAlert & 13;
         }
      }
      
      public function cannotPopupNextStartWindow() : void
      {
         _model.popupAlert = _model.popupAlert | 2;
      }
      
      public function set isPlayDownMovie(param1:Boolean) : void
      {
         _model.isPlayDownMovie = param1;
      }
      
      public function get isPlayDownMovie() : Boolean
      {
         return _model.isPlayDownMovie;
      }
      
      public function setDestinationCell(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = _model.cellIDs;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_])
            {
               if(_loc3_ != param1)
               {
                  _loc2_[_loc3_].isDestination = false;
               }
               else
               {
                  _loc2_[_loc3_].isDestination = true;
               }
            }
            _loc3_++;
         }
      }
      
      public function set diceType(param1:int) : void
      {
         _model.diceType = param1;
      }
      
      public function get LuckIntegralLevel() : int
      {
         return _model.LuckIntegralLevel;
      }
      
      public function get canUseModel() : Boolean
      {
         if(_model != null)
         {
            return true;
         }
         return false;
      }
      
      public function set LuckIntegralLevel(param1:int) : void
      {
         _model.LuckIntegralLevel = param1;
      }
      
      public function get LuckIntegral() : int
      {
         return _model.LuckIntegral;
      }
      
      public function get cellPosition() : Array
      {
         return _model.cellPosition;
      }
      
      public function get CurrentPosition() : int
      {
         return _model.currentPosition;
      }
      
      public function set CurrentPosition(param1:int) : void
      {
         _model.currentPosition = param1;
      }
      
      public function setCellInfo() : void
      {
         _model.setCellInfo();
      }
      
      public function get AwardLevelInfo() : Array
      {
         return _model.levelInfo;
      }
      
      public function install(param1:PackageIn) : void
      {
         initialize(param1);
         addEvent();
      }
      
      public function unInstall() : void
      {
         dispatchEvent(new DiceEvent("dice_active_close"));
         removeEvent();
         if(_model)
         {
            _model.dispose();
            _model = null;
         }
      }
      
      private function initialize(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _model = new DiceModel();
         _model.freeCount = param1.readInt();
         _model.refreshPrice = param1.readInt();
         _model.commonDicePrice = param1.readInt();
         _model.doubleDicePrice = param1.readInt();
         _model.bigDicePrice = param1.readInt();
         _model.smallDicePrice = param1.readInt();
         _model.MAX_LEVEL = param1.readInt();
         _loc6_ = 0;
         while(_loc6_ < _model.MAX_LEVEL)
         {
            _loc3_ = param1.readInt();
            _loc2_ = param1.readInt();
            _loc4_ = "";
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc4_ = _loc4_ + ("," + param1.readInt() + "|" + param1.readInt());
               _loc5_++;
            }
            _loc4_ = _loc4_.substring(1);
            _model.levelInfo[_loc6_] = new DiceAwardInfo(_loc6_ + 1,_loc3_,_loc4_);
            _loc6_++;
         }
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener("dice_receive_data",__onReceiveData);
         SocketManager.Instance.addEventListener("dice_receive_result",__receiveResult);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener("dice_receive_data",__onReceiveData);
         SocketManager.Instance.removeEventListener("dice_receive_result",__receiveResult);
      }
      
      private function __onReceiveData(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         _model.userFirstCell = _loc4_.readBoolean();
         _model.currentPosition = _loc4_.readInt() + 1;
         _loc3_ = _loc4_.readInt();
         _loc2_ = _loc4_.readInt();
         if(_isFirst)
         {
            _model.LuckIntegralLevel = _loc3_;
            _isFirst = false;
         }
         if(DiceController.Instance.LuckIntegralLevel != _loc3_ + 1 || _loc3_ == -1 && _loc2_ < _model.LuckIntegral)
         {
            _model.LuckIntegralLevel = _loc3_;
            _model.isPlayDownMovie = true;
            dispatchEvent(new DiceEvent("dice_level_changed"));
         }
         _model.LuckIntegral = _loc2_;
         _model.freeCount = _loc4_.readInt();
         ReceiveListByPkg(_loc4_);
      }
      
      private function ReceiveListByPkg(param1:PackageIn) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = !!_model.userFirstCell?0:1;
         _model.removeAllItem();
         _loc2_ = param1.readInt() + _loc3_;
         _model.cellCount = param1.readInt() + _loc3_;
         _loc2_ = _loc2_ - _loc3_;
         _model.setCellInfo();
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc5_ = ComponentFactory.Instance.creat("asset.dice.bg" + (_loc3_ + _loc7_ + 1));
            _loc6_ = ComponentFactory.Instance.creat("asset.cell.mask" + (_loc3_ + _loc7_));
            _loc8_ = ItemManager.Instance.getTemplateById(param1.readInt());
            _loc4_ = new DiceCell(_loc5_,_model.cellPosition[_loc7_ + _loc3_],_loc8_,_loc6_);
            _loc4_.position = param1.readInt();
            _loc4_.strengthLevel = param1.readInt();
            _loc4_.count = param1.readInt();
            _loc4_.validate = param1.readInt();
            _loc4_.isBind = param1.readBoolean();
            _model.addCellItem(_loc4_);
            _loc7_++;
         }
         dispatchEvent(new DiceEvent("dice_refresh_data"));
         dispatchEvent(new DiceEvent("showMainView"));
      }
      
      private function __receiveResult(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Object = {};
         _loc2_.position = _loc3_.readInt() + 1;
         _loc2_.result = _loc3_.readInt();
         trace("点数：",_loc2_.result,"当前位置：",_loc2_.position - 1,"-----------------------------------");
         _loc2_.luckIntegral = _loc3_.readInt();
         _loc2_.level = _loc3_.readInt();
         _loc2_.freeCount = _loc3_.readInt();
         _loc2_.rewardItem = _loc3_.readUTF();
         if(DiceController.Instance.CurrentPosition != _loc2_.position)
         {
            DiceController.Instance.CurrentPosition = _loc2_.position;
         }
         _model.freeCount = _loc2_.freeCount;
         if(DiceController.Instance.LuckIntegralLevel != _loc2_.level + 1 || _loc2_.level == -1 && _model.LuckIntegral > _loc2_.luckIntegral)
         {
            _model.LuckIntegralLevel = _loc2_.level;
            _model.isPlayDownMovie = true;
            dispatchEvent(new DiceEvent("dice_level_changed"));
         }
         _model.LuckIntegral = _loc2_.luckIntegral;
         dispatchEvent(new DiceEvent("get_dice_result_data",_loc2_));
      }
   }
}
