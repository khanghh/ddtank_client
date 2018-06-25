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
      
      public function DiceController(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get Instance() : DiceController
      {
         if(_instance == null)
         {
            _instance = new DiceController();
         }
         return _instance;
      }
      
      public function set isFirst(value:Boolean) : void
      {
         _isFirst = value;
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
      
      public function set freeCount(value:int) : void
      {
         _model.freeCount = value;
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
      
      public function set rewardItems(value:Array) : void
      {
         _model.rewardItems = value;
      }
      
      public function setPopupNextRefreshWindow(value:Boolean) : void
      {
         if(value)
         {
            _model.popupAlert = _model.popupAlert | 1;
         }
         else
         {
            _model.popupAlert = _model.popupAlert & 14;
         }
      }
      
      public function setPopupNextStartWindow(value:Boolean) : void
      {
         if(value)
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
      
      public function set isPlayDownMovie(value:Boolean) : void
      {
         _model.isPlayDownMovie = value;
      }
      
      public function get isPlayDownMovie() : Boolean
      {
         return _model.isPlayDownMovie;
      }
      
      public function setDestinationCell(value:int) : void
      {
         var i:int = 0;
         var list:Array = _model.cellIDs;
         for(i = 0; i < list.length; )
         {
            if(list[i])
            {
               if(i != value)
               {
                  list[i].isDestination = false;
               }
               else
               {
                  list[i].isDestination = true;
               }
            }
            i++;
         }
      }
      
      public function set diceType(value:int) : void
      {
         _model.diceType = value;
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
      
      public function set LuckIntegralLevel(value:int) : void
      {
         _model.LuckIntegralLevel = value;
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
      
      public function set CurrentPosition(value:int) : void
      {
         _model.currentPosition = value;
      }
      
      public function setCellInfo() : void
      {
         _model.setCellInfo();
      }
      
      public function get AwardLevelInfo() : Array
      {
         return _model.levelInfo;
      }
      
      public function install(pkg:PackageIn) : void
      {
         initialize(pkg);
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
      
      private function initialize(pkg:PackageIn) : void
      {
         var _temp1:int = 0;
         var _temp2:int = 0;
         var _str:* = null;
         var i:int = 0;
         var j:int = 0;
         _model = new DiceModel();
         _model.freeCount = pkg.readInt();
         _model.refreshPrice = pkg.readInt();
         _model.commonDicePrice = pkg.readInt();
         _model.doubleDicePrice = pkg.readInt();
         _model.bigDicePrice = pkg.readInt();
         _model.smallDicePrice = pkg.readInt();
         _model.MAX_LEVEL = pkg.readInt();
         for(i = 0; i < _model.MAX_LEVEL; )
         {
            _temp1 = pkg.readInt();
            _temp2 = pkg.readInt();
            _str = "";
            for(j = 0; j < _temp2; )
            {
               _str = _str + ("," + pkg.readInt() + "|" + pkg.readInt());
               j++;
            }
            _str = _str.substring(1);
            _model.levelInfo[i] = new DiceAwardInfo(i + 1,_temp1,_str);
            i++;
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
      
      private function __onReceiveData(event:CrazyTankSocketEvent) : void
      {
         var temp_level:int = 0;
         var temp_luckintegral:int = 0;
         var pkg:PackageIn = event.pkg;
         _model.userFirstCell = pkg.readBoolean();
         _model.currentPosition = pkg.readInt() + 1;
         temp_level = pkg.readInt();
         temp_luckintegral = pkg.readInt();
         if(_isFirst)
         {
            _model.LuckIntegralLevel = temp_level;
            _isFirst = false;
         }
         if(DiceController.Instance.LuckIntegralLevel != temp_level + 1 || temp_level == -1 && temp_luckintegral < _model.LuckIntegral)
         {
            _model.LuckIntegralLevel = temp_level;
            _model.isPlayDownMovie = true;
            dispatchEvent(new DiceEvent("dice_level_changed"));
         }
         _model.LuckIntegral = temp_luckintegral;
         _model.freeCount = pkg.readInt();
         ReceiveListByPkg(pkg);
      }
      
      private function ReceiveListByPkg(pkg:PackageIn) : void
      {
         var cell:* = null;
         var bg:* = null;
         var shape:* = null;
         var info:* = null;
         var count:int = 0;
         var i:int = 0;
         var start:int = !!_model.userFirstCell?0:1;
         _model.removeAllItem();
         count = pkg.readInt() + start;
         _model.cellCount = pkg.readInt() + start;
         count = count - start;
         _model.setCellInfo();
         for(i = 0; i < count; )
         {
            bg = ComponentFactory.Instance.creat("asset.dice.bg" + (start + i + 1));
            shape = ComponentFactory.Instance.creat("asset.cell.mask" + (start + i));
            info = ItemManager.Instance.getTemplateById(pkg.readInt());
            cell = new DiceCell(bg,_model.cellPosition[i + start],info,shape);
            cell.position = pkg.readInt();
            cell.strengthLevel = pkg.readInt();
            cell.count = pkg.readInt();
            cell.validate = pkg.readInt();
            cell.isBind = pkg.readBoolean();
            _model.addCellItem(cell);
            i++;
         }
         dispatchEvent(new DiceEvent("dice_refresh_data"));
         dispatchEvent(new DiceEvent("showMainView"));
      }
      
      private function __receiveResult(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var proxy:Object = {};
         proxy.position = pkg.readInt() + 1;
         proxy.result = pkg.readInt();
         trace("点数：",proxy.result,"当前位置：",proxy.position - 1,"-----------------------------------");
         proxy.luckIntegral = pkg.readInt();
         proxy.level = pkg.readInt();
         proxy.freeCount = pkg.readInt();
         proxy.rewardItem = pkg.readUTF();
         if(DiceController.Instance.CurrentPosition != proxy.position)
         {
            DiceController.Instance.CurrentPosition = proxy.position;
         }
         _model.freeCount = proxy.freeCount;
         if(DiceController.Instance.LuckIntegralLevel != proxy.level + 1 || proxy.level == -1 && _model.LuckIntegral > proxy.luckIntegral)
         {
            _model.LuckIntegralLevel = proxy.level;
            _model.isPlayDownMovie = true;
            dispatchEvent(new DiceEvent("dice_level_changed"));
         }
         _model.LuckIntegral = proxy.luckIntegral;
         dispatchEvent(new DiceEvent("get_dice_result_data",proxy));
      }
   }
}
