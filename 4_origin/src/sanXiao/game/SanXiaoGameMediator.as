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
      
      public function SanXiaoGameMediator(single:inner)
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
         var mapInfo:Array = SanXiaoManager.getInstance().mapInfo;
         if(mapInfo == null || mapInfo.length == 0)
         {
            _model.createNewMap();
            GameInSocketOut.sendSXCreateMap(_model.mapInfo());
         }
         else
         {
            _model.setMap(mapInfo);
         }
         var _loc4_:int = 0;
         var _loc3_:* = _timeUpdateList;
         for(var k in _timeUpdateList)
         {
            delete _timeUpdateList[k];
         }
         _boomListList = [];
         _fallListList = [];
         !_game.hasEventListener("enterFrame") && _game.addEventListener("enterFrame",onEF);
         _game.resetGame();
      }
      
      protected function onEF(e:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _timeUpdateList;
         for each(var fun in _timeUpdateList)
         {
            fun && fun();
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
      
      public function addTween($target:DisplayObject, $handler:Function) : void
      {
         _timeUpdateList[$target] = $handler;
      }
      
      public function removeTween($target:DisplayObject) : void
      {
      }
      
      public function get stepRemain() : Number
      {
         var __stepRemain:Number = SanXiaoManager.getInstance().stepRemain;
         if(__stepRemain <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("sanxiao.stepNoRemaining"));
         }
         return __stepRemain;
      }
      
      public function set curProp(value:int) : void
      {
      }
      
      public function checkProp($curPos:Pos) : void
      {
         $curPos = $curPos;
         onUsePropConfirm = function(frame:BaseAlerFrame):void
         {
            _moneyData.notShowAlertAgain = frame["isNoPrompt"];
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
      
      public function sendUseChangeColor(originalType:int, cellItemChangeToType:int) : void
      {
         GameInSocketOut.sendSXPropChangeColor(_moneyData.isBind,_moneyData.moneyNeeded,originalType,cellItemChangeToType);
      }
      
      public function sendBoomList($itemA:SXCellItem, $itemB:SXCellItem, boomList:Vector.<SXCellData>) : void
      {
         var i:int = 0;
         var _boomArr:Array = [];
         var _boomDic:Dictionary = new Dictionary();
         for(i = 1; i <= _model.typeCount; )
         {
            _boomDic[i] = [];
            i++;
         }
         var len:int = boomList.length;
         for(i = 0; i < len; )
         {
            (_boomDic[boomList[i].type] as Array).push(boomList[i].row,boomList[i].column);
            i++;
         }
         var _loc10_:int = 0;
         var _loc9_:* = _boomDic;
         for each(var arr in _boomDic)
         {
            if(arr.length > 0)
            {
               _boomArr.push(arr);
            }
         }
         if($itemA == null || $itemB == null)
         {
            _boomListList.push(-1,-1,-1,-1,_boomArr);
         }
         else
         {
            _boomListList.push($itemA.curPos.row,$itemA.curPos.column,$itemB.curPos.row,$itemB.curPos.column,_boomArr);
         }
         $itemA = null;
         $itemB = null;
         _boomArr = null;
         _boomDic = null;
      }
      
      public function sendFillList($list:Vector.<SXCellData>) : void
      {
         _fallListList.push($list);
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
      
      public function buyTimes(times:int, isBind:Boolean) : void
      {
         GameInSocketOut.sendSXBuyOneTimes(times,isBind);
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
