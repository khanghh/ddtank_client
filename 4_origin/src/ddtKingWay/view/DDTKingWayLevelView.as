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
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new DDTKingWayLevelTargetItem(_loc2_);
            PositionUtils.setPos(_loc1_,"asset.ddtKingWay.itemPos" + _loc2_);
            _itemList[_loc2_] = _loc1_;
            addChild(_itemList[_loc2_]);
            _loc2_++;
         }
         _getRewardBtn.addEventListener("click",__onGetRewardClick);
         TaskManager.instance.addEventListener("changed",__onQuestChange);
      }
      
      public function updataView(param1:DDTKingWayData, param2:Boolean = true) : void
      {
         _info = param1;
         _taskInfo = TaskManager.instance.getQuestByID(_info.QuestID);
         _isGardeRange = param2;
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
      
      private function updataItem(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _itemList[_loc2_].updataStutas(_taskInfo,timeOut(_taskInfo,_info),_isGardeRange);
            _loc2_++;
         }
      }
      
      public function timeOut(param1:QuestInfo, param2:DDTKingWayData) : Boolean
      {
         var _loc3_:Date = TimeManager.Instance.Now();
         if(param1.data != null || param1.isAchieved && !param1.isAvailable)
         {
            _remainingTime = getTimeDiff(_loc3_,param1,param2);
            if(_remainingTime == "0")
            {
               return true;
            }
            return false;
         }
         updateTime(0);
         return true;
      }
      
      public function getTimeDiff(param1:Date, param2:QuestInfo, param3:DDTKingWayData) : String
      {
         var _loc4_:* = 0;
         var _loc8_:* = 0;
         var _loc7_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:Number = Math.round((param2.data.AddTiemsDate.getTime() + param3.Validay * 60 * 60 * 24 * 1000 - param1.getTime()) / 1000);
         if(_loc6_ >= 0)
         {
            _loc4_ = uint(Math.floor(_loc6_ / 60 / 60 / 24));
            _loc6_ = _loc6_ % 86400;
            _loc8_ = uint(Math.floor(_loc6_ / 60 / 60));
            _loc6_ = _loc6_ % 3600;
            _loc7_ = uint(Math.floor(_loc6_ / 60));
            _loc5_ = uint(_loc6_ % 60);
            if(param2.data == null || param2.isAchieved && !param2.isAvailable)
            {
               updateTime(0);
               return "0";
            }
            if(_loc4_ > 0)
            {
               updateTime(3);
               return String(_loc4_);
            }
            if(_loc8_ > 0)
            {
               updateTime(2);
               return fixZero(_loc8_);
            }
            updateTime(1);
            return "1";
         }
         updateTime(0);
         return "0";
      }
      
      private function fixZero(param1:uint) : String
      {
         return param1 < 10?String(param1):String(param1);
      }
      
      private function updateTime(param1:int) : void
      {
         _timeUnit = param1;
      }
      
      private function updateRewardShow() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Array = _taskInfo.itemRewards;
         var _loc2_:int = _loc1_.length > _cellList.length?_loc1_.length:uint(_cellList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc4_ < _loc1_.length)
            {
               _loc3_ = ItemManager.fillByID(_loc1_[_loc4_].itemID);
               _loc3_.IsBinds = _loc1_[_loc4_].isBind;
               _loc3_.ValidDate = _loc1_[_loc4_].ValidateTime;
               _loc3_.StrengthenLevel = _loc1_[_loc4_].StrengthenLevel;
               _loc3_.AttackCompose = _loc1_[_loc4_].AttackCompose;
               _loc3_.DefendCompose = _loc1_[_loc4_].DefendCompose;
               _loc3_.AgilityCompose = _loc1_[_loc4_].AgilityCompose;
               _loc3_.LuckCompose = _loc1_[_loc4_].LuckCompose;
               if(_loc4_ == _cellList.length)
               {
                  _cellList.push(new DDTKingWayRewardCell());
                  _hBox.addChild(_cellList[_loc4_]);
               }
               _cellList[_loc4_].info = _loc3_;
               _cellList[_loc4_].setCount(_loc1_[_loc4_].count[_taskInfo.QuestLevel - 1]);
               _cellList[_loc4_].visible = true;
               if((_taskInfo.data == null || _taskInfo.isAchieved && !_taskInfo.isAvailable) && _isGardeRange)
               {
                  _cellList[_loc4_].showitem = true;
               }
               else
               {
                  _cellList[_loc4_].showitem = false;
               }
            }
            else
            {
               _cellList[_loc4_].visible = false;
            }
            _loc4_++;
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
      
      protected function __onGetRewardClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(!_taskInfo)
         {
            return;
         }
         var _loc3_:QuestInfo = _taskInfo;
         if(_loc3_.RewardBindMoney != 0 && _loc3_.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),true,true,true,1);
            _loc2_.addEventListener("response",__onResponse);
         }
         else
         {
            SocketManager.Instance.out.sendQuestFinish(_taskInfo.QuestID,TaskManager.itemAwardSelected);
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         param1.currentTarget.removeEventListener("response",__onResponse);
         if(param1.responseCode == 3)
         {
            _loc2_ = _taskInfo;
            SocketManager.Instance.out.sendQuestFinish(_taskInfo.QuestID,TaskManager.itemAwardSelected);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      protected function __onQuestChange(param1:TaskEvent) : void
      {
         if(param1.info.Id == _info.QuestID)
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
