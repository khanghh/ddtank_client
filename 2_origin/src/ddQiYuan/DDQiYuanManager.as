package ddQiYuan
{
   import bagAndInfo.BagAndInfoManager;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.model.DDQiYuanModel;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.HelperBuyAlert;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class DDQiYuanManager extends EventDispatcher
   {
      
      public static const EVENT_OPEN_FRAME:String = "event_open_frame";
      
      public static const EVENT_OP_START:String = "event_op_start";
      
      public static const EVENT_OP_BACK:String = "event_op_back";
      
      public static const EVENT_OP_FRAMEDISPOSE:String = "event_op_framedispose";
      
      public static const EVENT_QUERY_AREA_RANK_BACK:String = "event_query_area_rank_back";
      
      public static const EVENT_GAIN_JOIN_REWARD_BACK:String = "event_gain_join_reward_back";
      
      public static const EVENT_QUERY_TOWER_TASK_BACK:String = "event_query_tower_task_back";
      
      public static const EVENT_GAIN_BOGU_TASK_REWARD_BACK:String = "event_gain_bogu_task_reward_back";
      
      public static const EVENT_CHANGE_TYPE:String = "event_change_type";
      
      public static const PACK_TYPE_MY_INFO:int = 39;
      
      public static const PACK_TYPE_RANK_REWARD_CONFIG:int = 33;
      
      public static const PACK_TYPE_OFFER:int = 38;
      
      public static const PACK_TYPE_OPEN_BOGU_BOX:int = 34;
      
      public static const PACK_TYPE_AREA_RANK:int = 37;
      
      public static const PACK_TYPE_QUERY_TOWER_TASK:int = 35;
      
      public static const PACK_TYPE_RECEIVE_BOGU_TASK_REWARD:int = 36;
      
      public static const PACK_TYPE_PUSH_OPEN_CLOSE:int = 40;
      
      public static const PACK_TYPE_GAIN_JOIN_REWARD:int = 51;
      
      public static const OPTYPE_OFFER_1:int = 1;
      
      public static const OPTYPE_OFFER_10:int = 2;
      
      public static const OPTYPE_OPEN_TREASURE_BOX:int = 3;
      
      private static var _instance:DDQiYuanManager;
       
      
      private var _model:DDQiYuanModel;
      
      private var _hallView:HallStateView;
      
      private var _lastOpType:int;
      
      private var _isLoadData:Boolean = false;
      
      private var _buyConfirmAlertData:ConfirmAlertData;
      
      public var continueOpen:int = 0;
      
      public var notShowAlertAgain:Boolean;
      
      private var _awardsViewFrame:BaseAlerFrame;
      
      public var useType:int = 0;
      
      public function DDQiYuanManager(target:IEventDispatcher = null)
      {
         super(target);
         _instance = this;
         _model = new DDQiYuanModel();
         _buyConfirmAlertData = new ConfirmAlertData();
         _buyConfirmAlertData.isBind = true;
         _buyConfirmAlertData.notShowAlertAgain = false;
      }
      
      public static function get instance() : DDQiYuanManager
      {
         if(_instance == null)
         {
            _instance = new DDQiYuanManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(329,39),onPackTypeMyInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,33),onPackTypeRankRewardConfig);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,37),onPackTypeAreaRank);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,35),onPackTypeQueryTowerTask);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,38),onPackTypeOffer);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,34),onPackTypeOpenBoGuBox);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,40),onPackTypeActiveOpenClose);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,51),onPackTypeGainJoinReward);
         SocketManager.Instance.addEventListener(PkgEvent.format(329,36),onPackTypeGainTowerTask);
         this.addEventListener("event_op_framedispose",__awardframeDispose);
      }
      
      public function show() : void
      {
         if(_isLoadData)
         {
            return;
         }
         _isLoadData = true;
         _model.myAreaRankArr = null;
         _model.allAreaRankArr = null;
         var ddqyOfferCostMoneyArr:Array = ServerConfigManager.instance.ddqyOfferCostMoneyArr;
         _model.OFFER_1_TIME_COST_MONEY = ddqyOfferCostMoneyArr[0];
         _model.OFFER_10_TIME_COST_MONEY = ddqyOfferCostMoneyArr[1];
         _model.OPEN_TREASUREBOX_COST_MONEY = ServerConfigManager.instance.ddqyOpenTreasureboxCostMoney;
         SocketManager.Instance.out.queryDDQiYuanMyInfo();
      }
      
      private function onPackTypeMyInfo(evt:PkgEvent) : void
      {
         var i:int = 0;
         var hasGetGoodItem:* = null;
         var pkg:PackageIn = evt.pkg;
         _model.myAreaOfferTimes = pkg.readInt();
         _model.myAreaOfferDegree = pkg.readInt();
         _model.myOfferTimes = pkg.readInt();
         var hasGetGoodArr:Array = [];
         var hasGetGoodArrLen:int = pkg.readInt();
         for(i = 0; i < hasGetGoodArrLen; )
         {
            hasGetGoodItem = {};
            hasGetGoodItem["goodId"] = pkg.readInt();
            hasGetGoodItem["goodCount"] = pkg.readInt();
            hasGetGoodArr.push(hasGetGoodItem);
            i++;
         }
         _model.hasGetGoodArr = hasGetGoodArr;
         _model.hasGainTreasureBoxNum = pkg.readInt();
         _model.hasGainJoinRewardCount = pkg.readInt();
         SocketManager.Instance.out.queryDDQiYuanRankRewardConfig();
      }
      
      private function onPackTypeRankRewardConfig(evt:PkgEvent) : void
      {
         var i:int = 0;
         var beliefConfigItem:* = null;
         var myAreaRankConfigItem:* = null;
         var allAreaRankConfigItem:* = null;
         var pkg:PackageIn = evt.pkg;
         var beliefConfigArr:Array = [];
         var beliefConfigArrLen:int = pkg.readInt();
         for(i = 0; i < beliefConfigArrLen; )
         {
            beliefConfigItem = {};
            beliefConfigItem["offerTimes"] = pkg.readInt();
            beliefConfigItem["goodId"] = pkg.readInt();
            beliefConfigItem["goodCount"] = pkg.readInt();
            beliefConfigItem["isBind"] = pkg.readBoolean();
            beliefConfigItem["validDate"] = pkg.readInt();
            beliefConfigItem["remind"] = _model.myOfferTimes >= beliefConfigItem["offerTimes"];
            beliefConfigArr.push(beliefConfigItem);
            i++;
         }
         _model.beliefConfigArr = beliefConfigArr;
         var myAreaRankConfigArr:Array = [];
         var myAreaRankConfigArrLen:int = pkg.readInt();
         for(i = 0; i < myAreaRankConfigArrLen; )
         {
            myAreaRankConfigItem = {};
            myAreaRankConfigItem["rank"] = pkg.readInt();
            myAreaRankConfigItem["goodId"] = pkg.readInt();
            myAreaRankConfigItem["goodCount"] = pkg.readInt();
            myAreaRankConfigItem["isBind"] = pkg.readBoolean();
            myAreaRankConfigItem["validDate"] = pkg.readInt();
            myAreaRankConfigArr.push(myAreaRankConfigItem);
            i++;
         }
         _model.myAreaRankConfigArr = myAreaRankConfigArr;
         var allAreaRankConfigArr:Array = [];
         var allAreaRankConfigArrLen:int = pkg.readInt();
         for(i = 0; i < allAreaRankConfigArrLen; )
         {
            allAreaRankConfigItem = {};
            allAreaRankConfigItem["rank"] = pkg.readInt();
            allAreaRankConfigItem["goodId"] = pkg.readInt();
            allAreaRankConfigItem["goodCount"] = pkg.readInt();
            allAreaRankConfigItem["isBind"] = pkg.readBoolean();
            allAreaRankConfigItem["validDate"] = pkg.readInt();
            allAreaRankConfigArr.push(allAreaRankConfigItem);
            i++;
         }
         _model.allAreaRankConfigArr = allAreaRankConfigArr;
         _model.joinRewardLeastOfferTimes = pkg.readInt();
         _model.rankRewardLeastOfferTimes = pkg.readInt();
         var joinRewardGood:Object = {};
         joinRewardGood["goodId"] = pkg.readInt();
         joinRewardGood["goodCount"] = pkg.readInt();
         joinRewardGood["isBind"] = pkg.readBoolean();
         joinRewardGood["validDate"] = pkg.readInt();
         _model.joinRewardGood = joinRewardGood;
         var joinRewardProbabilityGainGood:Object = {};
         joinRewardProbabilityGainGood["goodId"] = pkg.readInt();
         joinRewardProbabilityGainGood["goodCount"] = pkg.readInt();
         joinRewardProbabilityGainGood["isBind"] = pkg.readBoolean();
         joinRewardProbabilityGainGood["validDate"] = pkg.readInt();
         joinRewardProbabilityGainGood["probability"] = pkg.readInt() / 10;
         _model.joinRewardProbabilityGainGood = joinRewardProbabilityGainGood;
         _model.offerTimesPerBaoZhu = pkg.readInt();
         _model.offerTimesPerTreasureBox = pkg.readInt();
         _model.offer1Or10TimesRewardBoxGoodArr = pkg.readUTF().split(",");
         _model.openTreasureBoxGoodArr = pkg.readUTF().split(",");
         _isLoadData = false;
         dispatchEvent(new Event("event_open_frame"));
      }
      
      private function onPackTypeAreaRank(evt:PkgEvent) : void
      {
         var i:int = 0;
         var myAreaRankArr:* = null;
         var myAreaRankArrLen:int = 0;
         var myAreaRank:* = null;
         var allAreaRankArr:* = null;
         var allAreaRankArrLen:int = 0;
         var allAreaRank:* = null;
         var pkg:PackageIn = evt.pkg;
         var type:int = pkg.readInt();
         if(type == 0)
         {
            myAreaRankArr = [];
            myAreaRankArrLen = pkg.readInt();
            for(i = 0; i < myAreaRankArrLen; )
            {
               myAreaRank = {};
               myAreaRank["rank"] = i + 1;
               myAreaRank["playerId"] = pkg.readInt();
               myAreaRank["nickName"] = pkg.readUTF();
               myAreaRank["offerTimes"] = pkg.readInt();
               myAreaRankArr.push(myAreaRank);
               i++;
            }
            _model.myAreaRankArr = myAreaRankArr;
         }
         else if(type == 1)
         {
            allAreaRankArr = [];
            allAreaRankArrLen = pkg.readInt();
            for(i = 0; i < allAreaRankArrLen; )
            {
               allAreaRank = {};
               allAreaRank["areaName"] = pkg.readUTF();
               pkg.readInt();
               allAreaRank["nickName"] = pkg.readUTF();
               allAreaRank["offerTimes"] = pkg.readInt();
               allAreaRank["rank"] = i + 1;
               allAreaRankArr.push(allAreaRank);
               i++;
            }
            _model.allAreaRankArr = allAreaRankArr;
         }
         dispatchEvent(new CEvent("event_query_area_rank_back",type));
      }
      
      private function onPackTypeQueryTowerTask(evt:PkgEvent) : void
      {
         var i:int = 0;
         var reward:* = null;
         var taskArr:* = null;
         var taskArrLen:int = 0;
         var j:int = 0;
         var task:* = null;
         var grade:int = 0;
         var pkg:PackageIn = evt.pkg;
         var taskGroupArr:Array = [];
         var taskGroupArrLen:int = pkg.readInt();
         var rewardArr:Array = [];
         for(i = 0; i < taskGroupArrLen; )
         {
            reward = {};
            reward["grade"] = pkg.readInt();
            reward["goodId"] = pkg.readInt();
            reward["goodCount"] = pkg.readInt();
            reward["isBind"] = pkg.readBoolean();
            reward["hasGain"] = false;
            rewardArr.push(reward);
            taskArr = [];
            taskArrLen = pkg.readInt();
            for(j = 0; j < taskArrLen; )
            {
               task = {};
               task["goodId"] = pkg.readInt();
               task["needCount"] = pkg.readInt();
               task["currCount"] = pkg.readInt();
               taskArr.push(task);
               j++;
            }
            taskGroupArr.push(taskArr);
            i++;
         }
         var gainRewardCount:int = pkg.readInt();
         for(i = 0; i < gainRewardCount; )
         {
            grade = pkg.readInt();
            rewardArr[grade - 1]["hasGain"] = true;
            i++;
         }
         _model.taskGroupArr = taskGroupArr;
         _model.towerTaskRewardArr = rewardArr;
         dispatchEvent(new Event("event_query_tower_task_back"));
      }
      
      private function onPackTypeOffer(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         if(_lastOpType == 1)
         {
            _model.myAreaOfferDegree = _model.myAreaOfferDegree + 1;
            _model.myOfferTimes = _model.myOfferTimes + 1;
            _model.myAreaOfferTimes = _model.myAreaOfferTimes + 1;
            if(remindGainBeliefReward())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddQiYuan.frame.beliefRewardTips",_model.myOfferTimes));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddQiYuan.frame.offer1TimeDegreeTips",1));
            }
            showPreviewFrame(LanguageMgr.GetTranslation("ddQiYuan.frame.offer1TimeRewardTitle"),pkg,LanguageMgr.GetTranslation("ddQiYuan.frame.openOffer1TimeRewardTips"));
         }
         else
         {
            _model.myAreaOfferDegree = _model.myAreaOfferDegree + 10;
            _model.myOfferTimes = _model.myOfferTimes + 10;
            _model.myAreaOfferTimes = _model.myAreaOfferTimes + 10;
            if(remindGainBeliefReward())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddQiYuan.frame.beliefRewardTips",_model.myOfferTimes));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddQiYuan.frame.offer10TimeDegreeTips",10));
            }
            showPreviewFrame(LanguageMgr.GetTranslation("ddQiYuan.frame.offer10TimeRewardTitle"),pkg,LanguageMgr.GetTranslation("ddQiYuan.frame.openOffer10TimeRewardTips"));
         }
         dispatchEvent(new CEvent("event_op_back",_lastOpType));
      }
      
      private function remindGainBeliefReward() : Boolean
      {
         var needRemind:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:* = _model.beliefConfigArr;
         for each(var obj in _model.beliefConfigArr)
         {
            if(obj["offerTimes"] <= _model.myOfferTimes && obj["remind"] == false)
            {
               obj["remind"] = true;
               needRemind = true;
            }
         }
         return needRemind;
      }
      
      private function onPackTypeOpenBoGuBox(evt:PkgEvent) : void
      {
         _model.hasGainTreasureBoxNum++;
         _model.myAreaOfferDegree = _model.myAreaOfferDegree + 5;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddQiYuan.frame.openTreasureBoxDegreeTips",5));
         var pkg:PackageIn = evt.pkg;
         showPreviewFrame(LanguageMgr.GetTranslation("ddQiYuan.frame.openTreasureBoxRewardTitle"),pkg,LanguageMgr.GetTranslation("ddQiYuan.frame.openTreasureBoxRewardTips"));
         dispatchEvent(new CEvent("event_op_back",_lastOpType));
      }
      
      private function onPackTypeActiveOpenClose(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         _model.isOpen = pkg.readBoolean();
         _model.endTime = pkg.readDate();
         checkAndShowIcon();
      }
      
      private function onPackTypeGainJoinReward(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         _model.hasGainJoinRewardCount = pkg.readInt();
         dispatchEvent(new Event("event_gain_join_reward_back"));
      }
      
      private function onPackTypeGainTowerTask(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var phase:int = pkg.readInt();
         var data:Object = _model.towerTaskRewardArr[phase - 1];
         data["hasGain"] = true;
         dispatchEvent(new CEvent("event_gain_bogu_task_reward_back",phase));
      }
      
      private function checkAndShowIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("ddqiyuan",_model.isOpen);
      }
      
      private function __awardframeDispose(event:CEvent = null) : void
      {
         if(_awardsViewFrame)
         {
            _awardsViewFrame.dispatchEvent(new FrameEvent(2));
            _awardsViewFrame = null;
         }
      }
      
      private function showPreviewFrame(title:String, pkg:PackageIn, tips:String) : void
      {
         title = title;
         pkg = pkg;
         tips = tips;
         OnPreviewFrameCloseHandler = function(itemList:Array):void
         {
            BagAndInfoManager.Instance.unregisterOnPreviewFrameCloseHandler("DDQIYuanManager");
         };
         var goodArrLen:int = pkg.readInt();
         var goodArr:Array = [];
         for(var i:int = 0; i < goodArrLen; )
         {
            var inventoryItemInfo:InventoryItemInfo = new InventoryItemInfo();
            inventoryItemInfo.TemplateID = pkg.readInt();
            inventoryItemInfo = ItemManager.fill(inventoryItemInfo);
            inventoryItemInfo.Count = pkg.readInt();
            inventoryItemInfo.IsBinds = pkg.readBoolean();
            inventoryItemInfo.ValidDate = pkg.readInt();
            inventoryItemInfo.StrengthenLevel = pkg.readInt();
            inventoryItemInfo.AttackCompose = pkg.readInt();
            inventoryItemInfo.DefendCompose = pkg.readInt();
            inventoryItemInfo.AgilityCompose = pkg.readInt();
            inventoryItemInfo.LuckCompose = pkg.readInt();
            if(EquipType.isMagicStone(inventoryItemInfo.CategoryID))
            {
               inventoryItemInfo.Level = inventoryItemInfo.StrengthenLevel;
               inventoryItemInfo.Attack = inventoryItemInfo.AttackCompose;
               inventoryItemInfo.Defence = inventoryItemInfo.DefendCompose;
               inventoryItemInfo.Agility = inventoryItemInfo.AgilityCompose;
               inventoryItemInfo.Luck = inventoryItemInfo.LuckCompose;
               inventoryItemInfo.Level = inventoryItemInfo.StrengthenLevel;
               inventoryItemInfo.MagicAttack = pkg.readInt();
               inventoryItemInfo.MagicDefence = pkg.readInt();
            }
            else
            {
               pkg.readInt();
               pkg.readInt();
            }
            goodArr.push(inventoryItemInfo);
            var hasFind:Boolean = false;
            var _loc8_:int = 0;
            var _loc7_:* = _model.hasGetGoodArr;
            for each(good in _model.hasGetGoodArr)
            {
               if(good["goodId"] == inventoryItemInfo.TemplateID)
               {
                  var _loc5_:String = "goodCount";
                  var _loc6_:* = good[_loc5_] + inventoryItemInfo.Count;
                  good[_loc5_] = _loc6_;
                  hasFind = true;
               }
            }
            if(!hasFind)
            {
               _model.hasGetGoodArr.push({
                  "goodId":inventoryItemInfo.TemplateID,
                  "goodCount":inventoryItemInfo.Count
               });
            }
            i = Number(i) + 1;
         }
         BagAndInfoManager.Instance.registerOnPreviewFrameCloseHandler("DDQIYuanManager",OnPreviewFrameCloseHandler);
         __awardframeDispose(null);
         _awardsViewFrame = BagAndInfoManager.Instance.showPreviewFrame(title,goodArr);
      }
      
      public function sendOfferTimes(times:int) : void
      {
         times = times;
         _lastOpType = times == 1?1:2;
         var gouYunBagCount:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(12543);
         if(gouYunBagCount >= times)
         {
            useType = 1;
            dispatchEvent(new Event("event_op_start"));
            SocketManager.Instance.out.sendDDQiYuanOfferTimes(times == 1?0:1,false);
         }
         else
         {
            onUsePropConfirm = function(frame:BaseAlerFrame):void
            {
               notShowAlertAgain = frame["isNoPrompt"];
            };
            onUsePropCheckOut = function():void
            {
               _buyConfirmAlertData.isBind = CheckMoneyUtils.instance.isBind;
               dispatchEvent(new Event("event_op_start"));
               SocketManager.Instance.out.sendDDQiYuanOfferTimes(times == 1?0:1,CheckMoneyUtils.instance.isBind);
            };
            onUsePropCancel = function():void
            {
               continueOpen = 0;
            };
            if(useType == 1)
            {
               dispatchEvent(new Event("event_change_type"));
               return;
            }
            useType = 2;
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _buyConfirmAlertData.moneyNeeded = times == 1?_model.OFFER_1_TIME_COST_MONEY:int(_model.OFFER_10_TIME_COST_MONEY);
            _buyConfirmAlertData.notShowAlertAgain = notShowAlertAgain || continueOpen > 0;
            if(_buyConfirmAlertData.notShowAlertAgain)
            {
               CheckMoneyUtils.instance.checkMoney(_buyConfirmAlertData.isBind,_buyConfirmAlertData.moneyNeeded,onUsePropCheckOut,onUsePropCancel);
            }
            else
            {
               var msgKey:String = times == 1?"ddQiYuan.frame.offer1ByMoneyAlertMsg":"ddQiYuan.frame.offer10ByMoneyAlertMsg";
               var msg:String = LanguageMgr.GetTranslation(msgKey,_buyConfirmAlertData.moneyNeeded);
               HelperBuyAlert.getInstance().alert(msg,_buyConfirmAlertData,"SimpleAlertWithNotShowAgain",onUsePropCheckOut,onUsePropConfirm,onUsePropCancel);
            }
         }
      }
      
      public function sendDDQiYuanOpenTreasureBox() : void
      {
         _lastOpType = 3;
         var leftGainTreasureBoxNum:int = int(_model.myAreaOfferTimes / _model.offerTimesPerTreasureBox) - _model.hasGainTreasureBoxNum;
         if(leftGainTreasureBoxNum <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddQiYuan.frame.notEnoughTreasureBox"));
            return;
         }
         var boxKeyCount:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(12544);
         if(boxKeyCount > 0)
         {
            dispatchEvent(new Event("event_op_start"));
            SocketManager.Instance.out.sendDDQiYuanOpenTreasureBox(false);
         }
         else
         {
            onUsePropConfirm = function(frame:BaseAlerFrame):void
            {
               _buyConfirmAlertData.notShowAlertAgain = frame["isNoPrompt"];
            };
            onUsePropCheckOut = function():void
            {
               _buyConfirmAlertData.isBind = CheckMoneyUtils.instance.isBind;
               dispatchEvent(new Event("event_op_start"));
               SocketManager.Instance.out.sendDDQiYuanOpenTreasureBox(CheckMoneyUtils.instance.isBind);
            };
            onUsePropCancel = function():void
            {
               _buyConfirmAlertData.notShowAlertAgain = false;
            };
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _buyConfirmAlertData.moneyNeeded = _model.OPEN_TREASUREBOX_COST_MONEY;
            if(_buyConfirmAlertData.notShowAlertAgain)
            {
               CheckMoneyUtils.instance.checkMoney(_buyConfirmAlertData.isBind,_buyConfirmAlertData.moneyNeeded,onUsePropCheckOut,onUsePropCancel);
            }
            else
            {
               var msg:String = LanguageMgr.GetTranslation("ddQiYuan.frame.openTreasureBoxByMoneyAlertMsg",_buyConfirmAlertData.moneyNeeded);
               HelperBuyAlert.getInstance().alert(msg,_buyConfirmAlertData,"SimpleAlertWithNotShowAgain",onUsePropCheckOut,onUsePropConfirm,onUsePropCancel);
            }
         }
      }
      
      public function getInventoryItemInfo(good:Object) : InventoryItemInfo
      {
         var templeteInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(good["goodId"]);
         var inventoryItemInfo:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(inventoryItemInfo,templeteInfo);
         inventoryItemInfo.ValidDate = good.validDate;
         inventoryItemInfo.Count = good.goodCount;
         inventoryItemInfo.IsBinds = good.isBind;
         inventoryItemInfo.Property5 = "1";
         return inventoryItemInfo;
      }
      
      public function get lastOpType() : int
      {
         return _lastOpType;
      }
      
      public function get model() : DDQiYuanModel
      {
         return this._model;
      }
   }
}
