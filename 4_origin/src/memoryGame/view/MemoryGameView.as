package memoryGame.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import memoryGame.MemoryGameManager;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class MemoryGameView extends Sprite implements Disposeable
   {
       
      
      private const MAX_CELL:int = 16;
      
      private var _bg:Bitmap;
      
      private var _openCountText:FilterFrameText;
      
      private var _dayText:FilterFrameText;
      
      private var _timeRemainTimer:TimerJuggler;
      
      private var _scoreText:FilterFrameText;
      
      private var _cellList:DictionaryData;
      
      private var _cellContainer:Sprite;
      
      private var _rewardList:DictionaryData;
      
      private var _rewardContainer:Sprite;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _resetBtn:SimpleBitmapButton;
      
      private var _frame:MemoryGameFrame;
      
      private var _infoList:Vector.<MemoryGameInfo>;
      
      private var _closeList:Array;
      
      public function MemoryGameView(param1:MemoryGameFrame)
      {
         super();
         init();
         initCell();
         initReward();
         initEvent();
         _frame = param1;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.memoryGame.view.bg");
         addChild(_bg);
         _cellContainer = new Sprite();
         PositionUtils.setPos(_cellContainer,"memoryGame.cellContainerPos");
         addChild(_cellContainer);
         _rewardContainer = new Sprite();
         PositionUtils.setPos(_rewardContainer,"memoryGame.rewardContainerPos");
         addChild(_rewardContainer);
         _openCountText = ComponentFactory.Instance.creatComponentByStylename("memoryGame.openCountText");
         addChild(_openCountText);
         _dayText = ComponentFactory.Instance.creatComponentByStylename("memoryGame.dayText");
         _dayText.text = getTimeRemainStr();
         addChild(_dayText);
         _timeRemainTimer = TimerManager.getInstance().addTimerJuggler(10000);
         _timeRemainTimer.addEventListener("timer",__timeRemainHandler);
         _timeRemainTimer.start();
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("memoryGame.scoreText");
         addChild(_scoreText);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("memoryGame.buyBtn");
         addChild(_buyBtn);
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("memoryGame.resetBtn");
         addChild(_resetBtn);
         _infoList = new Vector.<MemoryGameInfo>();
      }
      
      private function __timeRemainHandler(param1:Event) : void
      {
         if(_dayText)
         {
            _dayText.text = getTimeRemainStr();
         }
      }
      
      private function getTimeRemainStr() : String
      {
         var _loc2_:Number = (MemoryGameManager.instance.endDate.time - TimeManager.Instance.Now().time) / 1000;
         var _loc1_:Array = DateUtils.dateTimeRemainArr(_loc2_);
         return LanguageMgr.GetTranslation("tank.timeRemain.msg1",_loc1_[0],_loc1_[1],_loc1_[2]);
      }
      
      private function initCell() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cellList = new DictionaryData();
         _loc2_ = 0;
         while(_loc2_ < 16)
         {
            _loc1_ = new MemoryGameCell(_loc2_ + 1);
            _cellContainer.addChild(_loc1_);
            _loc1_.x = _loc2_ % 4 * 96;
            _loc1_.y = int(_loc2_ / 4) * 96;
            _cellList.add(_loc2_ + 1,_loc1_);
            _loc2_++;
         }
      }
      
      private function initReward() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _rewardList = new DictionaryData();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new MemoryGameRewardCell();
            _loc1_.x = _loc2_ % 4 * 74;
            _loc1_.y = int(_loc2_ / 4) * 80;
            _rewardContainer.addChild(_loc1_);
            _rewardList.add(_loc2_,_loc1_);
            _loc2_++;
         }
      }
      
      private function __onGameInfo(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         MemoryGameManager.instance.count = param1.pkg.readInt();
         MemoryGameManager.instance.score = param1.pkg.readInt();
         if(_frame)
         {
            _frame.shopViewUpdate();
         }
         updateText();
         var _loc2_:int = param1.pkg.readInt();
         _infoList.splice(0,_infoList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new MemoryGameInfo();
            _loc4_.TemplateID = param1.pkg.readInt();
            _loc4_.count = param1.pkg.readInt();
            _loc4_.place1 = param1.pkg.readInt();
            _loc4_.place2 = param1.pkg.readInt();
            _loc4_.isGet = param1.pkg.readBoolean();
            _loc4_.show1 = param1.pkg.readBoolean();
            _loc4_.show2 = param1.pkg.readBoolean();
            _infoList.push(_loc4_);
            _loc5_++;
         }
         var _loc3_:Boolean = param1.pkg.readBoolean();
         MemoryGameManager.instance.getRewardList.clear();
         _loc2_ = param1.pkg.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            MemoryGameManager.instance.getRewardList.add(param1.pkg.readInt(),true);
            _loc5_++;
         }
         update(_loc3_);
         if(!_loc3_)
         {
            gameReset();
         }
      }
      
      private function update(param1:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = _cellList;
         for each(var _loc5_ in _cellList)
         {
            _loc5_.closeDefault();
         }
         _loc6_ = 0;
         while(_loc6_ < _infoList.length)
         {
            _loc4_ = _rewardList[_loc6_] as MemoryGameRewardCell;
            _loc2_ = _infoList[_loc6_].TemplateID;
            _loc3_ = _infoList[_loc6_].count;
            _loc4_.info = ItemManager.Instance.getTemplateById(_loc2_);
            _loc4_.setCount(_loc3_);
            _loc4_.isGain = _infoList[_loc6_].isGet;
            if(param1)
            {
               _loc4_.playAction();
            }
            if(_infoList[_loc6_].isGet)
            {
               _cellList[_infoList[_loc6_].place1].openDefault(_loc2_,_loc3_);
               _cellList[_infoList[_loc6_].place2].openDefault(_loc2_,_loc3_);
            }
            else
            {
               if(_infoList[_loc6_].show1)
               {
                  _cellList[_infoList[_loc6_].place1].openDefault(_loc2_,_loc3_);
               }
               if(_infoList[_loc6_].show2)
               {
                  _cellList[_infoList[_loc6_].place2].openDefault(_loc2_,_loc3_);
               }
            }
            _loc6_++;
         }
      }
      
      private function __onGameTurnover(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc4_:* = null;
         _closeList = [];
         MemoryGameManager.instance.count = param1.pkg.readInt();
         MemoryGameManager.instance.score = param1.pkg.readInt();
         updateText();
         var _loc7_:int = param1.pkg.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc7_)
         {
            _loc5_ = param1.pkg.readInt();
            _loc3_ = param1.pkg.readInt();
            _loc2_ = param1.pkg.readInt();
            _loc8_ = param1.pkg.readBoolean();
            _loc6_ = param1.pkg.readBoolean();
            _loc4_ = _cellList[_loc2_] as MemoryGameCell;
            _loc4_.open(_loc5_,_loc3_);
            if(_loc6_ && _loc9_ == 0)
            {
               rewardIsGet(_loc5_,_loc3_);
               gameReset();
            }
            else if(!_loc8_)
            {
               _closeList.push(_loc4_);
            }
            _loc9_++;
         }
         if(_closeList.length >= 2)
         {
            MemoryGameManager.instance.turning = true;
            addEventListener("enterFrame",__onEnter);
         }
      }
      
      private function __onEnter(param1:Event) : void
      {
         if(MemoryGameManager.instance.playOpenAllComplete())
         {
            removeEventListener("enterFrame",__onEnter);
            closeAction();
         }
      }
      
      private function closeAction() : void
      {
         if(_closeList.length)
         {
            var timeout:int = setTimeout(function():void
            {
               var _loc1_:int = 0;
               _loc1_ = 0;
               while(_loc1_ < _closeList.length)
               {
                  _closeList[_loc1_].close();
                  _loc1_++;
               }
               MemoryGameManager.instance.turning = false;
               _closeList.splice(0,_closeList.length);
            },1000);
         }
      }
      
      public function gameReset() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _rewardList;
         for each(var _loc2_ in _rewardList)
         {
            if(!_loc2_.isGain)
            {
               return;
            }
         }
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("memoryGame.gameover"),LanguageMgr.GetTranslation("ok"),"",false,true,true,2,null,"SimpleAlert",60,false);
         _loc1_.addEventListener("response",onResponse);
      }
      
      private function onResponse(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         if(MemoryGameManager.instance.playActionAllComplete() && !MemoryGameManager.instance.turning)
         {
            _loc2_ = param1.currentTarget as BaseAlerFrame;
            _loc2_.removeEventListener("response",onResponse);
            SocketManager.Instance.out.sendMemoryGameReset(true,true);
            _loc2_.dispose();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.notClose"));
         }
      }
      
      private function rewardIsGet(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _rewardList;
         for each(var _loc3_ in _rewardList)
         {
            if(_loc3_.info.TemplateID == param1 && _loc3_.getCount() == param2)
            {
               _loc3_.isGain = true;
            }
         }
      }
      
      private function __onResetClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!MemoryGameManager.instance.isValid)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.activityTips"));
            return;
         }
         if(MemoryGameManager.instance.playActionAllComplete() && !MemoryGameManager.instance.turning)
         {
            _loc3_ = ServerConfigManager.instance.memoryGameResetMoney();
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("memoryGame.resetTips",_loc3_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
            _loc2_.addEventListener("response",onResetConfirmResponse);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.notClose"));
         }
      }
      
      private function onResetConfirmResponse(param1:FrameEvent) : void
      {
         e = param1;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",onResetConfirmResponse);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,ServerConfigManager.instance.memoryGameResetMoney(),function():void
            {
               SocketManager.Instance.out.sendMemoryGameReset(CheckMoneyUtils.instance.isBind);
            });
         }
         frame.dispose();
      }
      
      private function __onBuyClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!MemoryGameManager.instance.isValid)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.activityTips"));
            return;
         }
         var _loc2_:MemoryGameBuyView = ComponentFactory.Instance.creatComponentByStylename("memroyGame.MemoryGameBuyView");
         _loc2_.show();
      }
      
      private function __onGameBuy(param1:PkgEvent) : void
      {
         MemoryGameManager.instance.count = param1.pkg.readInt();
         updateText();
      }
      
      private function updateText() : void
      {
         _openCountText.text = MemoryGameManager.instance.count.toString();
         _scoreText.text = MemoryGameManager.instance.score.toString();
      }
      
      private function initEvent() : void
      {
         _buyBtn.addEventListener("click",__onBuyClick);
         _resetBtn.addEventListener("click",__onResetClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,11),__onGameInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,12),__onGameTurnover);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,14),__onGameBuy);
      }
      
      private function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",__onBuyClick);
         _resetBtn.removeEventListener("click",__onResetClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(329,11),__onGameInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(329,12),__onGameTurnover);
         SocketManager.Instance.removeEventListener(PkgEvent.format(329,14),__onGameBuy);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _timeRemainTimer.stop();
         _timeRemainTimer.removeEventListener("timer",__timeRemainHandler);
         TimerManager.getInstance().removeJugglerByTimer(_timeRemainTimer);
         _timeRemainTimer = null;
         ObjectUtils.disposeAllChildren(_cellContainer);
         ObjectUtils.disposeAllChildren(_rewardContainer);
         _cellList.clear();
         _rewardList.clear();
         ObjectUtils.disposeAllChildren(this);
         _infoList.splice(0,_infoList.length);
         _infoList = null;
         _bg = null;
         _cellContainer = null;
         _rewardContainer = null;
         _cellList = null;
         _rewardList = null;
         _frame = null;
      }
   }
}

class MemoryGameInfo
{
    
   
   public var TemplateID:int;
   
   public var count:int;
   
   public var place1:int;
   
   public var place2:int;
   
   public var isGet:Boolean;
   
   public var show1:Boolean;
   
   public var show2:Boolean;
   
   function MemoryGameInfo()
   {
      super();
   }
}
