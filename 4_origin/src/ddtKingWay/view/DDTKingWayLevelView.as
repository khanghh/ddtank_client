package ddtKingWay.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.events.TaskEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddtKingWay.DDTKingWayManager;
   import ddtKingWay.analyzer.DDTKingWayData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import quest.TaskManager;
   
   public class DDTKingWayLevelView extends Sprite implements Disposeable
   {
       
      
      private const COUNT:int = 4;
      
      private var _remainingTimeTextBg:FilterFrameText;
      
      private var _remainingTimeText1:FilterFrameText;
      
      private var _remainingTimeText2:FilterFrameText;
      
      private var _timeUnitText:FilterFrameText;
      
      private var _itemList:Vector.<DDTKingWayLevelTargetItem>;
      
      private var _cellList:Vector.<DDTKingWayRewardCell>;
      
      private var _hBox:HBox;
      
      private var _getRewardBtn:BaseButton;
      
      private var _remainingTime:String;
      
      private var _taskInfo:QuestInfo;
      
      private var _info:DDTKingWayData;
      
      private var _timeUnit:int;
      
      private var _isGardeRange:Boolean;
      
      public function DDTKingWayLevelView()
      {
         var i:int = 0;
         var item:* = null;
         super();
         _remainingTimeText1 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.remainingTimeText1");
         _remainingTimeText2 = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.remainingTimeText2");
         _remainingTimeTextBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.remainingTimeTextBg");
         _timeUnitText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.remainingTimeUnitText");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.Hbox");
         _getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.getAwardBtn");
         addChild(_remainingTimeText1);
         addChild(_remainingTimeText2);
         addChild(_remainingTimeTextBg);
         addChild(_timeUnitText);
         addChild(_hBox);
         addChild(_getRewardBtn);
         _cellList = new Vector.<DDTKingWayRewardCell>();
         _itemList = new Vector.<DDTKingWayLevelTargetItem>(4);
         for(i = 0; i < 4; )
         {
            item = new DDTKingWayLevelTargetItem(i);
            PositionUtils.setPos(item,"asset.ddtKingWay.itemPos" + i);
            _itemList[i] = item;
            addChild(_itemList[i]);
            i++;
         }
         _getRewardBtn.addEventListener("click",__onGetRewardClick);
         TaskManager.instance.addEventListener("changed",__onQuestChange);
      }
      
      public function updataView(info:DDTKingWayData, isGardeRange:Boolean = true) : void
      {
         _info = info;
         _taskInfo = TaskManager.instance.getQuestByID(_info.QuestID);
         _isGardeRange = isGardeRange;
         if(_isGardeRange)
         {
            if(_taskInfo.data && !(_taskInfo.isAchieved && !_taskInfo.isAvailable) && !timeOut(_taskInfo,_info))
            {
               _remainingTimeText1.visible = true;
               _remainingTimeText2.visible = false;
               _remainingTimeText1.text = String(_remainingTime);
               _remainingTimeTextBg.text = LanguageMgr.GetTranslation("ddtKingWay.remainingTime");
            }
            else
            {
               _remainingTimeText1.visible = false;
               _remainingTimeText2.visible = true;
               _remainingTimeTextBg.text = "";
               if(_taskInfo.data == null || _taskInfo.isAchieved && !_taskInfo.isAvailable)
               {
                  _remainingTimeText2.text = LanguageMgr.GetTranslation("storeFine.forge.state1");
               }
               else
               {
                  _remainingTimeText2.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.over");
               }
            }
         }
         else
         {
            _remainingTimeText1.visible = false;
            _remainingTimeText2.visible = true;
            _remainingTimeTextBg.text = "";
            _remainingTimeText2.text = LanguageMgr.GetTranslation("ddtKingWay.nextRemainingTime");
         }
         updataItem();
         updateRewardShow();
         updataTimeUnit();
      }
      
      private function updataTimeUnit() : void
      {
         if(_isGardeRange)
         {
            if(_timeUnit == 3)
            {
               _timeUnitText.text = LanguageMgr.GetTranslation("wonderfulActivityManager.d");
            }
            else if(_timeUnit == 2 || _timeUnit == 1)
            {
               _timeUnitText.text = LanguageMgr.GetTranslation("wonderfulActivityManager.h");
            }
            else if(_timeUnit == 0)
            {
               _timeUnitText.text = "";
            }
         }
         else
         {
            _timeUnitText.text = "";
         }
      }
      
      private function updataItem(isGardeRange:Boolean = true) : void
      {
         var i:int = 0;
         for(i = 0; i < 4; )
         {
            _itemList[i].updataStutas(_taskInfo,timeOut(_taskInfo,_info),_isGardeRange);
            i++;
         }
      }
      
      public function timeOut(taskInfo:QuestInfo, info:DDTKingWayData) : Boolean
      {
         var now:Date = TimeManager.Instance.Now();
         if(taskInfo.data != null || taskInfo.isAchieved && !taskInfo.isAvailable)
         {
            _remainingTime = getTimeDiff(now,taskInfo,info);
            if(_remainingTime == "0")
            {
               return true;
            }
            return false;
         }
         updateTime(0);
         return true;
      }
      
      public function getTimeDiff(newDate:Date, taskInfo:QuestInfo, info:DDTKingWayData) : String
      {
         var d:* = 0;
         var h:* = 0;
         var m:* = 0;
         var s:* = 0;
         var diff:Number = Math.round((taskInfo.data.AddTiemsDate.getTime() + info.Validay * 60 * 60 * 24 * 1000 - newDate.getTime()) / 1000);
         if(diff >= 0)
         {
            d = uint(Math.floor(diff / 60 / 60 / 24));
            diff = diff % 86400;
            h = uint(Math.floor(diff / 60 / 60));
            diff = diff % 3600;
            m = uint(Math.floor(diff / 60));
            s = uint(diff % 60);
            if(taskInfo.data == null || taskInfo.isAchieved && !taskInfo.isAvailable)
            {
               updateTime(0);
               return "0";
            }
            if(d > 0)
            {
               updateTime(3);
               return String(d);
            }
            if(h > 0)
            {
               updateTime(2);
               return fixZero(h);
            }
            updateTime(1);
            return "1";
         }
         updateTime(0);
         return "0";
      }
      
      private function fixZero(num:uint) : String
      {
         return num < 10?String(num):String(num);
      }
      
      private function updateTime(num:int) : void
      {
         _timeUnit = num;
      }
      
      private function updateRewardShow() : void
      {
         var i:int = 0;
         var info:* = null;
         var goodArr:Array = _taskInfo.itemRewards;
         var len:int = goodArr.length > _cellList.length?goodArr.length:uint(_cellList.length);
         for(i = 0; i < len; )
         {
            if(i < goodArr.length)
            {
               info = ItemManager.fillByID(goodArr[i].itemID);
               info.IsBinds = goodArr[i].isBind;
               info.ValidDate = goodArr[i].ValidateTime;
               info.StrengthenLevel = goodArr[i].StrengthenLevel;
               info.AttackCompose = goodArr[i].AttackCompose;
               info.DefendCompose = goodArr[i].DefendCompose;
               info.AgilityCompose = goodArr[i].AgilityCompose;
               info.LuckCompose = goodArr[i].LuckCompose;
               if(i == _cellList.length)
               {
                  _cellList.push(new DDTKingWayRewardCell());
                  _hBox.addChild(_cellList[i]);
               }
               _cellList[i].info = info;
               _cellList[i].setCount(goodArr[i].count[_taskInfo.QuestLevel - 1]);
               _cellList[i].visible = true;
               if((_taskInfo.data == null || _taskInfo.isAchieved && !_taskInfo.isAvailable) && _isGardeRange)
               {
                  _cellList[i].showitem = true;
               }
               else
               {
                  _cellList[i].showitem = false;
               }
            }
            else
            {
               _cellList[i].visible = false;
            }
            i++;
         }
         _hBox.arrange();
         if(_taskInfo.data == null || timeOut(_taskInfo,_info) || !_taskInfo.isCompleted || _taskInfo.isAchieved && !_taskInfo.isAvailable)
         {
            _getRewardBtn.enable = false;
         }
         else
         {
            _getRewardBtn.enable = true;
         }
      }
      
      protected function __onGetRewardClick(event:MouseEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.playButtonSound();
         if(!_taskInfo)
         {
            return;
         }
         var questInfo:QuestInfo = _taskInfo;
         if(questInfo.RewardBindMoney != 0 && questInfo.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,true,true,1);
            alert.addEventListener("response",__onResponse);
         }
         else
         {
            SocketManager.Instance.out.sendQuestFinish(_taskInfo.QuestID,TaskManager.itemAwardSelected);
         }
      }
      
      private function __onResponse(pEvent:FrameEvent) : void
      {
         var questInfo:* = null;
         pEvent.currentTarget.removeEventListener("response",__onResponse);
         if(pEvent.responseCode == 3)
         {
            questInfo = _taskInfo;
            SocketManager.Instance.out.sendQuestFinish(_taskInfo.QuestID,TaskManager.itemAwardSelected);
         }
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      protected function __onQuestChange(event:TaskEvent) : void
      {
         if(event.info.Id == _info.QuestID)
         {
            updataView(_info);
            DDTKingWayManager.instance.checkIcon();
         }
      }
      
      public function dispose() : void
      {
         TaskManager.instance.removeEventListener("changed",__onQuestChange);
         _getRewardBtn.removeEventListener("click",__onGetRewardClick);
         ObjectUtils.disposeObject(_remainingTimeText1);
         _remainingTimeText1 = null;
         ObjectUtils.disposeObject(_remainingTimeText2);
         _remainingTimeText2 = null;
         ObjectUtils.disposeObject(_remainingTimeTextBg);
         _remainingTimeTextBg = null;
         ObjectUtils.disposeObject(_timeUnitText);
         _timeUnitText = null;
         while(_itemList.length)
         {
            ObjectUtils.disposeObject(_itemList.pop());
         }
         _itemList = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         _cellList.splice(0,_cellList.length);
         _cellList = null;
         ObjectUtils.disposeObject(_getRewardBtn);
         _getRewardBtn = null;
      }
   }
}
