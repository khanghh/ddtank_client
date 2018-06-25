package dice.controller{   import com.pickgliss.ui.ComponentFactory;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.ItemManager;   import ddt.manager.SocketManager;   import dice.event.DiceEvent;   import dice.model.DiceModel;   import dice.vo.DiceAwardInfo;   import dice.vo.DiceCell;   import flash.display.MovieClip;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import road7th.comm.PackageIn;      [Event(name="dice_refresh_data",type="Dice.Event.DiceEvent")]   public class DiceController extends EventDispatcher   {            private static var _instance:DiceController;                   private var _model:DiceModel;            private var _isFirst:Boolean = true;            public function DiceController(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : DiceController { return null; }
            public function set isFirst(value:Boolean) : void { }
            public function get hasUsedFirstCell() : Boolean { return false; }
            public function get CELL_COUNT() : int { return 0; }
            public function get cellIDs() : Array { return null; }
            public function get MAX_LEVEL() : int { return 0; }
            public function get freeCount() : int { return 0; }
            public function set freeCount(value:int) : void { }
            public function get diceType() : int { return 0; }
            public function get commonDicePrice() : int { return 0; }
            public function get doubleDicePrice() : int { return 0; }
            public function get bigDicePrice() : int { return 0; }
            public function get smallDicePrice() : int { return 0; }
            public function get refreshPrice() : int { return 0; }
            public function get canPopupNextRefreshWindow() : Boolean { return false; }
            public function get canPopupNextStartWindow() : Boolean { return false; }
            public function get rewardItems() : Array { return null; }
            public function set rewardItems(value:Array) : void { }
            public function setPopupNextRefreshWindow(value:Boolean) : void { }
            public function setPopupNextStartWindow(value:Boolean) : void { }
            public function cannotPopupNextStartWindow() : void { }
            public function set isPlayDownMovie(value:Boolean) : void { }
            public function get isPlayDownMovie() : Boolean { return false; }
            public function setDestinationCell(value:int) : void { }
            public function set diceType(value:int) : void { }
            public function get LuckIntegralLevel() : int { return 0; }
            public function get canUseModel() : Boolean { return false; }
            public function set LuckIntegralLevel(value:int) : void { }
            public function get LuckIntegral() : int { return 0; }
            public function get cellPosition() : Array { return null; }
            public function get CurrentPosition() : int { return 0; }
            public function set CurrentPosition(value:int) : void { }
            public function setCellInfo() : void { }
            public function get AwardLevelInfo() : Array { return null; }
            public function install(pkg:PackageIn) : void { }
            public function unInstall() : void { }
            private function initialize(pkg:PackageIn) : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __onReceiveData(event:CrazyTankSocketEvent) : void { }
            private function ReceiveListByPkg(pkg:PackageIn) : void { }
            private function __receiveResult(event:CrazyTankSocketEvent) : void { }
   }}