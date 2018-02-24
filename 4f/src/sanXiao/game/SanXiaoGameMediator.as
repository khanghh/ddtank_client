package sanXiao.game
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.HelperBuyAlert;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import sanXiao.SanXiaoController;
   import sanXiao.SanXiaoManager;
   import sanXiao.model.Pos;
   import sanXiao.model.SXCellData;
   import sanXiao.model.SXModel;
   
   public class SanXiaoGameMediator extends EventDispatcher
   {
      
      private static var instance:SanXiaoGameMediator;
       
      
      private var _game:SXGame;
      
      private var _model:SXModel;
      
      private var _manager:SanXiaoManager;
      
      private var _boomListList:Array;
      
      private var _fallListList:Array;
      
      private var _nameStrings:Array;
      
      private var _timeUpdateList:Dictionary;
      
      private var _moneyData:ConfirmAlertData;
      
      public function SanXiaoGameMediator(param1:inner){super();}
      
      public static function getInstance() : SanXiaoGameMediator{return null;}
      
      public function getGameView() : SXGame{return null;}
      
      public function killGame() : void{}
      
      public function startGame() : void{}
      
      protected function onEF(param1:Event) : void{}
      
      public function createNewMap() : void{}
      
      public function startAnimation() : void{}
      
      public function stopAnimation() : void{}
      
      public function addTween(param1:DisplayObject, param2:Function) : void{}
      
      public function removeTween(param1:DisplayObject) : void{}
      
      public function get stepRemain() : Number{return 0;}
      
      public function set curProp(param1:int) : void{}
      
      public function checkProp(param1:Pos) : void{}
      
      public function sendUseCrossBomb() : void{}
      
      public function sendUseSquareBomb() : void{}
      
      public function sendUseClearColor() : void{}
      
      public function sendUseChangeColor(param1:int, param2:int) : void{}
      
      public function sendBoomList(param1:SXCellItem, param2:SXCellItem, param3:Vector.<SXCellData>) : void{}
      
      public function sendFillList(param1:Vector.<SXCellData>) : void{}
      
      public function sendHitsEnd() : void{}
      
      public function buyTimes(param1:int, param2:Boolean) : void{}
      
      public function get model() : SXModel{return null;}
   }
}

class inner
{
    
   
   function inner(){super();}
}
