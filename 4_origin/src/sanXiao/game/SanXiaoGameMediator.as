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
      
      public function SanXiaoGameMediator(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : SanXiaoGameMediator
      {
         if(!instance)
         {
            instance = new SanXiaoGameMediator(new inner());
         }
         return instance;
      }
      
      public function getGameView() : SXGame
      {
         if(!_model)
         {
            _model = new SXModel();
         }
         if(!_manager)
         {
            _manager = SanXiaoManager.getInstance();
         }
         _moneyData || new ConfirmAlertData();
         _nameStrings = ["",LanguageMgr.GetTranslation("sanxiao.propName.crossBomb"),LanguageMgr.GetTranslation("sanxiao.propName.squareBomb"),LanguageMgr.GetTranslation("sanxiao.propName.clearColor"),LanguageMgr.GetTranslation("sanxiao.propName.changeColor")];
         _model.initMap();
         _timeUpdateList = new Dictionary();
         _game = new SXGame();
         return _game;
      }
      
      public function killGame() : void
      {
         _game.removeEventListener("enterFrame",onEF);
         ObjectUtils.disposeObject(_game);
         _timeUpdateList = null;
         _game = null;
         _model = null;
         _nameStrings.length = 0;
         _nameStrings = null;
      }
      
      public function startGame() : void
      {
         if(_model == null || _game == null)
         {
            return;
         }
         startAnimation();
         var _loc1_:Array = SanXiaoManager.getInstance().mapInfo;
         if(_loc1_ == null || _loc1_.length == 0)
         {
            _model.createNewMap();
            GameInSocketOut.sendSXCreateMap(_model.mapInfo());
         }
         else
         {
            _model.setMap(_loc1_);
         }
         var _loc4_:int = 0;
         var _loc3_:* = _timeUpdateList;
         for(var _loc2_ in _timeUpdateList)
         {
            delete _timeUpdateList[_loc2_];
         }
         _boomListList = [];
         _fallListList = [];
         !_game.hasEventListener("enterFrame") && _game.addEventListener("enterFrame",onEF);
         _game.resetGame();
      }
      
      protected function onEF(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _timeUpdateList;
         for each(var _loc2_ in _timeUpdateList)
         {
            _loc2_ && _loc2_();
         }
      }
      
      public function createNewMap() : void
      {
         _model.createNewMap();
         GameInSocketOut.sendSXCreateMap(_model.mapInfo());
         _game.resetGame();
      }
      
      public function startAnimation() : void
      {
         SanXiaoController.getInstance().lockFrame();
      }
      
      public function stopAnimation() : void
      {
         SanXiaoController.getInstance().unLockFrame();
      }
      
      public function addTween(param1:DisplayObject, param2:Function) : void
      {
         _timeUpdateList[param1] = param2;
      }
      
      public function removeTween(param1:DisplayObject) : void
      {
      }
      
      public function get stepRemain() : Number
      {
         var _loc1_:Number = SanXiaoManager.getInstance().stepRemain;
         if(_loc1_ <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("sanxiao.stepNoRemaining"));
         }
         return _loc1_;
      }
      
      public function set curProp(param1:int) : void
      {
      }
      
      public function checkProp(param1:Pos) : void
      {
         $curPos = param1;
         onUsePropConfirm = function(param1:BaseAlerFrame):void
         {
            _moneyData.notShowAlertAgain = param1["isNoPrompt"];
         };
         onUsePropCheckOut = function():void
         {
            _moneyData.isBind = CheckMoneyUtils.instance.isBind;
            _game.checkProp($curPos);
         };
         onUsePropCancel = function():void
         {
            _moneyData.notShowAlertAgain = false;
         };
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var __curProp:int = _model.curProp;
         var __score:String = SanXiaoManager.getInstance().getPropScore(__curProp);
         var __name:String = _nameStrings[__curProp];
         _moneyData.moneyNeeded = int(SanXiaoManager.getInstance().getPropCurPrice(__curProp));
         var _loc3_:* = _moneyData.notShowAlertAgain;
         if(true !== _loc3_)
         {
            if(false === _loc3_)
            {
               var msg:String = LanguageMgr.GetTranslation("sanxiao.buyPropConfirm",_moneyData.moneyNeeded,__name);
               HelperBuyAlert.getInstance().alert(msg,_moneyData,"SimpleAlertWithNotShowAgain",onUsePropCheckOut,onUsePropConfirm,onUsePropCancel,1);
            }
         }
         else
         {
            CheckMoneyUtils.instance.checkMoney(_moneyData.isBind,_moneyData.moneyNeeded,onUsePropCheckOut,onUsePropCancel);
         }
      }
      
      public function sendUseCrossBomb() : void
      {
         GameInSocketOut.sendSXPropCrossBomb(_moneyData.isBind,_moneyData.moneyNeeded);
      }
      
      public function sendUseSquareBomb() : void
      {
         GameInSocketOut.sendSXPropSquareBomb(_moneyData.isBind,_moneyData.moneyNeeded);
      }
      
      public function sendUseClearColor() : void
      {
         GameInSocketOut.sendSXPropClearColor(_moneyData.isBind,_moneyData.moneyNeeded);
      }
      
      public function sendUseChangeColor(param1:int, param2:int) : void
      {
         GameInSocketOut.sendSXPropChangeColor(_moneyData.isBind,_moneyData.moneyNeeded,param1,param2);
      }
      
      public function sendBoomList(param1:SXCellItem, param2:SXCellItem, param3:Vector.<SXCellData>) : void
      {
         var _loc8_:int = 0;
         var _loc4_:Array = [];
         var _loc7_:Dictionary = new Dictionary();
         _loc8_ = 1;
         while(_loc8_ <= _model.typeCount)
         {
            _loc7_[_loc8_] = [];
            _loc8_++;
         }
         var _loc6_:int = param3.length;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            (_loc7_[param3[_loc8_].type] as Array).push(param3[_loc8_].row,param3[_loc8_].column);
            _loc8_++;
         }
         var _loc10_:int = 0;
         var _loc9_:* = _loc7_;
         for each(var _loc5_ in _loc7_)
         {
            if(_loc5_.length > 0)
            {
               _loc4_.push(_loc5_);
            }
         }
         if(param1 == null || param2 == null)
         {
            _boomListList.push(-1,-1,-1,-1,_loc4_);
         }
         else
         {
            _boomListList.push(param1.curPos.row,param1.curPos.column,param2.curPos.row,param2.curPos.column,_loc4_);
         }
         param1 = null;
         param2 = null;
         _loc4_ = null;
         _loc7_ = null;
      }
      
      public function sendFillList(param1:Vector.<SXCellData>) : void
      {
         _fallListList.push(param1);
      }
      
      public function sendHitsEnd() : void
      {
         while(_boomListList.length > 0)
         {
            GameInSocketOut.sendSXBoom(_boomListList.shift(),_boomListList.shift(),_boomListList.shift(),_boomListList.shift(),_boomListList.shift());
            GameInSocketOut.sendSXFillCellList(_fallListList.shift());
         }
         _boomListList.length = 0;
         _fallListList.length = 0;
         GameInSocketOut.sendSXHitsEnd();
      }
      
      public function buyTimes(param1:int, param2:Boolean) : void
      {
         GameInSocketOut.sendSXBuyOneTimes(param1,param2);
      }
      
      public function get model() : SXModel
      {
         return _model;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
