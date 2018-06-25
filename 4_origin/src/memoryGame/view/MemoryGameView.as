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
      
      public function MemoryGameView(view:MemoryGameFrame)
      {
         super();
         init();
         initCell();
         initReward();
         initEvent();
         _frame = view;
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
      
      private function __timeRemainHandler(evt:Event) : void
      {
         if(_dayText)
         {
            _dayText.text = getTimeRemainStr();
         }
      }
      
      private function getTimeRemainStr() : String
      {
         var tempTime:Number = (MemoryGameManager.instance.endDate.time - TimeManager.Instance.Now().time) / 1000;
         var timeArr:Array = DateUtils.dateTimeRemainArr(tempTime);
         return LanguageMgr.GetTranslation("tank.timeRemain.msg1",timeArr[0],timeArr[1],timeArr[2]);
      }
      
      private function initCell() : void
      {
         var i:int = 0;
         var cell:* = null;
         _cellList = new DictionaryData();
         for(i = 0; i < 16; )
         {
            cell = new MemoryGameCell(i + 1);
            _cellContainer.addChild(cell);
            cell.x = i % 4 * 96;
            cell.y = int(i / 4) * 96;
            _cellList.add(i + 1,cell);
            i++;
         }
      }
      
      private function initReward() : void
      {
         var i:int = 0;
         var cell:* = null;
         _rewardList = new DictionaryData();
         for(i = 0; i < 8; )
         {
            cell = new MemoryGameRewardCell();
            cell.x = i % 4 * 74;
            cell.y = int(i / 4) * 80;
            _rewardContainer.addChild(cell);
            _rewardList.add(i,cell);
            i++;
         }
      }
      
      private function __onGameInfo(e:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         MemoryGameManager.instance.count = e.pkg.readInt();
         MemoryGameManager.instance.score = e.pkg.readInt();
         if(_frame)
         {
            _frame.shopViewUpdate();
         }
         updateText();
         var len:int = e.pkg.readInt();
         _infoList.splice(0,_infoList.length);
         for(i = 0; i < len; )
         {
            info = new MemoryGameInfo();
            info.TemplateID = e.pkg.readInt();
            info.count = e.pkg.readInt();
            info.place1 = e.pkg.readInt();
            info.place2 = e.pkg.readInt();
            info.isGet = e.pkg.readBoolean();
            info.show1 = e.pkg.readBoolean();
            info.show2 = e.pkg.readBoolean();
            _infoList.push(info);
            i++;
         }
         var isReset:Boolean = e.pkg.readBoolean();
         MemoryGameManager.instance.getRewardList.clear();
         len = e.pkg.readInt();
         for(i = 0; i < len; )
         {
            MemoryGameManager.instance.getRewardList.add(e.pkg.readInt(),true);
            i++;
         }
         update(isReset);
         if(!isReset)
         {
            gameReset();
         }
      }
      
      private function update(isReset:Boolean) : void
      {
         var i:int = 0;
         var cell:* = null;
         var id:int = 0;
         var count:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = _cellList;
         for each(var item in _cellList)
         {
            item.closeDefault();
         }
         for(i = 0; i < _infoList.length; )
         {
            cell = _rewardList[i] as MemoryGameRewardCell;
            id = _infoList[i].TemplateID;
            count = _infoList[i].count;
            cell.info = ItemManager.Instance.getTemplateById(id);
            cell.setCount(count);
            cell.isGain = _infoList[i].isGet;
            if(isReset)
            {
               cell.playAction();
            }
            if(_infoList[i].isGet)
            {
               _cellList[_infoList[i].place1].openDefault(id,count);
               _cellList[_infoList[i].place2].openDefault(id,count);
            }
            else
            {
               if(_infoList[i].show1)
               {
                  _cellList[_infoList[i].place1].openDefault(id,count);
               }
               if(_infoList[i].show2)
               {
                  _cellList[_infoList[i].place2].openDefault(id,count);
               }
            }
            i++;
         }
      }
      
      private function __onGameTurnover(e:PkgEvent) : void
      {
         var i:int = 0;
         var TemplateID:int = 0;
         var count:int = 0;
         var index:int = 0;
         var isOpen:Boolean = false;
         var isGet:Boolean = false;
         var cell:* = null;
         _closeList = [];
         MemoryGameManager.instance.count = e.pkg.readInt();
         MemoryGameManager.instance.score = e.pkg.readInt();
         updateText();
         var len:int = e.pkg.readInt();
         for(i = 0; i < len; )
         {
            TemplateID = e.pkg.readInt();
            count = e.pkg.readInt();
            index = e.pkg.readInt();
            isOpen = e.pkg.readBoolean();
            isGet = e.pkg.readBoolean();
            cell = _cellList[index] as MemoryGameCell;
            cell.open(TemplateID,count);
            if(isGet && i == 0)
            {
               rewardIsGet(TemplateID,count);
               gameReset();
            }
            else if(!isOpen)
            {
               _closeList.push(cell);
            }
            i++;
         }
         if(_closeList.length >= 2)
         {
            MemoryGameManager.instance.turning = true;
            addEventListener("enterFrame",__onEnter);
         }
      }
      
      private function __onEnter(e:Event) : void
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
               var i:int = 0;
               for(i = 0; i < _closeList.length; )
               {
                  _closeList[i].close();
                  i++;
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
         for each(var cell in _rewardList)
         {
            if(!cell.isGain)
            {
               return;
            }
         }
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("memoryGame.gameover"),LanguageMgr.GetTranslation("ok"),"",false,true,true,2,null,"SimpleAlert",60,false);
         frame.addEventListener("response",onResponse);
      }
      
      private function onResponse(e:FrameEvent) : void
      {
         var frame:* = null;
         if(MemoryGameManager.instance.playActionAllComplete() && !MemoryGameManager.instance.turning)
         {
            frame = e.currentTarget as BaseAlerFrame;
            frame.removeEventListener("response",onResponse);
            SocketManager.Instance.out.sendMemoryGameReset(true,true);
            frame.dispose();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.notClose"));
         }
      }
      
      private function rewardIsGet(TemplateID:int, count:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _rewardList;
         for each(var cell in _rewardList)
         {
            if(cell.info.TemplateID == TemplateID && cell.getCount() == count)
            {
               cell.isGain = true;
            }
         }
      }
      
      private function __onResetClick(e:MouseEvent) : void
      {
         var monery:int = 0;
         var frame:* = null;
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
            monery = ServerConfigManager.instance.memoryGameResetMoney();
            frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("memoryGame.resetTips",monery),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
            frame.addEventListener("response",onResetConfirmResponse);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.notClose"));
         }
      }
      
      private function onResetConfirmResponse(e:FrameEvent) : void
      {
         e = e;
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
      
      private function __onBuyClick(e:MouseEvent) : void
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
         var frame:MemoryGameBuyView = ComponentFactory.Instance.creatComponentByStylename("memroyGame.MemoryGameBuyView");
         frame.show();
      }
      
      private function __onGameBuy(e:PkgEvent) : void
      {
         MemoryGameManager.instance.count = e.pkg.readInt();
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
