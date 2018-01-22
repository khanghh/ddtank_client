package BombTurnTable.view.quality
{
   import BombTurnTable.TurnTableHandlerControl;
   import BombTurnTable.data.BombTurnTableGoodInfo;
   import BombTurnTable.data.BombTurnTableInfo;
   import BombTurnTable.event.TurnTableEvent;
   import BombTurnTable.view.LotteryPointer;
   import BombTurnTable.view.TurnTableGoodCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import road7th.data.DictionaryData;
   
   public class BaseTurnTable extends Sprite implements Disposeable
   {
       
      
      protected var _curLevel:int;
      
      private var _turnTableHandlerCon:TurnTableHandlerControl;
      
      protected var _bgBorder:Bitmap;
      
      protected var _bg:Bitmap;
      
      protected var _lotteryBtn:LotteryPointer;
      
      protected var _explanationTxt:FilterFrameText;
      
      protected var _lotteryTicket:FilterFrameText;
      
      protected var _turnTableCon:Sprite;
      
      protected var _goodsItem:DictionaryData;
      
      protected var _goodsData:BombTurnTableInfo;
      
      protected var _goodsPoint:Array;
      
      protected var _goodsRotation:Array;
      
      protected var _specialGoodsID:Array;
      
      protected var _selectEffPoint:Array;
      
      protected var _selectEffRotation:Array;
      
      protected var _selectMc:MovieClip;
      
      protected var _curStatus:int = 1;
      
      private var _temCell:TurnTableGoodCell;
      
      private var intervalId:uint;
      
      private var delay:Number = 1000;
      
      public function BaseTurnTable(param1:int){super();}
      
      protected function initView() : void{}
      
      protected function updateLayout() : void{}
      
      protected function initEvent() : void{}
      
      public function get lotteryBtn() : LotteryPointer{return null;}
      
      protected function clickLottery_Handler(param1:TurnTableEvent) : void{}
      
      public function updateAwardGood(param1:BombTurnTableInfo) : void{}
      
      public function updateLotteryTicket(param1:int) : void{}
      
      protected function lotteryComplate_Handler(param1:int) : void{}
      
      public function myDelayedFunction() : void{}
      
      public function startLottery(param1:int) : void{}
      
      public function get turnTable() : Sprite{return null;}
      
      protected function get bgBorResource() : String{return null;}
      
      protected function get bgResource() : String{return null;}
      
      public function get quality() : int{return 0;}
      
      public function get level() : int{return 0;}
      
      public function clear() : void{}
      
      public function dispose() : void{}
   }
}
