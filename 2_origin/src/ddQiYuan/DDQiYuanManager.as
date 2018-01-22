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
      
      public function DDQiYuanManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
         var _loc1_:Array = ServerConfigManager.instance.ddqyOfferCostMoneyArr;
         _model.OFFER_1_TIME_COST_MONEY = _loc1_[0];
         _model.OFFER_10_TIME_COST_MONEY = _loc1_[1];
         _model.OPEN_TREASUREBOX_COST_MONEY = ServerConfigManager.instance.ddqyOpenTreasureboxCostMoney;
         SocketManager.Instance.out.queryDDQiYuanMyInfo();
      }
      
      private function onPackTypeMyInfo(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         _model.myAreaOfferTimes = _loc4_.readInt();
         _model.myAreaOfferDegree = _loc4_.readInt();
         _model.myOfferTimes = _loc4_.readInt();
         var _loc3_:Array = [];
         var _loc5_:int = _loc4_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = {};
            _loc2_["goodId"] = _loc4_.readInt();
            _loc2_["goodCount"] = _loc4_.readInt();
            _loc3_.push(_loc2_);
            _loc6_++;
         }
         _model.hasGetGoodArr = _loc3_;
         _model.hasGainTreasureBoxNum = _loc4_.readInt();
         _model.hasGainJoinRewardCount = _loc4_.readInt();
         SocketManager.Instance.out.queryDDQiYuanRankRewardConfig();
      }
      
      private function onPackTypeRankRewardConfig(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc10_:* = null;
         var _loc13_:* = null;
         var _loc8_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc5_:Array = [];
         var _loc7_:int = _loc3_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc10_ = {};
            _loc10_["offerTimes"] = _loc3_.readInt();
            _loc10_["goodId"] = _loc3_.readInt();
            _loc10_["goodCount"] = _loc3_.readInt();
            _loc10_["isBind"] = _loc3_.readBoolean();
            _loc10_["validDate"] = _loc3_.readInt();
            _loc10_["remind"] = _model.myOfferTimes >= _loc10_["offerTimes"];
            _loc5_.push(_loc10_);
            _loc6_++;
         }
         _model.beliefConfigArr = _loc5_;
         var _loc2_:Array = [];
         var _loc12_:int = _loc3_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc12_)
         {
            _loc13_ = {};
            _loc13_["rank"] = _loc3_.readInt();
            _loc13_["goodId"] = _loc3_.readInt();
            _loc13_["goodCount"] = _loc3_.readInt();
            _loc13_["isBind"] = _loc3_.readBoolean();
            _loc13_["validDate"] = _loc3_.readInt();
            _loc2_.push(_loc13_);
            _loc6_++;
         }
         _model.myAreaRankConfigArr = _loc2_;
         var _loc4_:Array = [];
         var _loc14_:int = _loc3_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc14_)
         {
            _loc8_ = {};
            _loc8_["rank"] = _loc3_.readInt();
            _loc8_["goodId"] = _loc3_.readInt();
            _loc8_["goodCount"] = _loc3_.readInt();
            _loc8_["isBind"] = _loc3_.readBoolean();
            _loc8_["validDate"] = _loc3_.readInt();
            _loc4_.push(_loc8_);
            _loc6_++;
         }
         _model.allAreaRankConfigArr = _loc4_;
         _model.joinRewardLeastOfferTimes = _loc3_.readInt();
         _model.rankRewardLeastOfferTimes = _loc3_.readInt();
         var _loc11_:Object = {};
         _loc11_["goodId"] = _loc3_.readInt();
         _loc11_["goodCount"] = _loc3_.readInt();
         _loc11_["isBind"] = _loc3_.readBoolean();
         _loc11_["validDate"] = _loc3_.readInt();
         _model.joinRewardGood = _loc11_;
         var _loc9_:Object = {};
         _loc9_["goodId"] = _loc3_.readInt();
         _loc9_["goodCount"] = _loc3_.readInt();
         _loc9_["isBind"] = _loc3_.readBoolean();
         _loc9_["validDate"] = _loc3_.readInt();
         _loc9_["probability"] = _loc3_.readInt() / 10;
         _model.joinRewardProbabilityGainGood = _loc9_;
         _model.offerTimesPerBaoZhu = _loc3_.readInt();
         _model.offerTimesPerTreasureBox = _loc3_.readInt();
         _model.offer1Or10TimesRewardBoxGoodArr = _loc3_.readUTF().split(",");
         _model.openTreasureBoxGoodArr = _loc3_.readUTF().split(",");
         _isLoadData = false;
         dispatchEvent(new Event("event_open_frame"));
      }
      
      private function onPackTypeAreaRank(param1:PkgEvent) : void
      {
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc9_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc7_:int = _loc4_.readInt();
         if(_loc7_ == 0)
         {
            _loc6_ = [];
            _loc8_ = _loc4_.readInt();
            _loc10_ = 0;
            while(_loc10_ < _loc8_)
            {
               _loc2_ = {};
               _loc2_["rank"] = _loc10_ + 1;
               _loc2_["playerId"] = _loc4_.readInt();
               _loc2_["nickName"] = _loc4_.readUTF();
               _loc2_["offerTimes"] = _loc4_.readInt();
               _loc6_.push(_loc2_);
               _loc10_++;
            }
            _model.myAreaRankArr = _loc6_;
         }
         else if(_loc7_ == 1)
         {
            _loc9_ = [];
            _loc5_ = _loc4_.readInt();
            _loc10_ = 0;
            while(_loc10_ < _loc5_)
            {
               _loc3_ = {};
               _loc3_["areaName"] = _loc4_.readUTF();
               _loc4_.readInt();
               _loc3_["nickName"] = _loc4_.readUTF();
               _loc3_["offerTimes"] = _loc4_.readInt();
               _loc3_["rank"] = _loc10_ + 1;
               _loc9_.push(_loc3_);
               _loc10_++;
            }
            _model.allAreaRankArr = _loc9_;
         }
         dispatchEvent(new CEvent("event_query_area_rank_back",_loc7_));
      }
      
      private function onPackTypeQueryTowerTask(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc12_:int = 0;
         var _loc6_:PackageIn = param1.pkg;
         var _loc9_:Array = [];
         var _loc13_:int = _loc6_.readInt();
         var _loc10_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _loc13_)
         {
            _loc3_ = {};
            _loc3_["grade"] = _loc6_.readInt();
            _loc3_["goodId"] = _loc6_.readInt();
            _loc3_["goodCount"] = _loc6_.readInt();
            _loc3_["isBind"] = _loc6_.readBoolean();
            _loc3_["hasGain"] = false;
            _loc10_.push(_loc3_);
            _loc2_ = [];
            _loc5_ = _loc6_.readInt();
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc4_ = {};
               _loc4_["goodId"] = _loc6_.readInt();
               _loc4_["needCount"] = _loc6_.readInt();
               _loc4_["currCount"] = _loc6_.readInt();
               _loc2_.push(_loc4_);
               _loc7_++;
            }
            _loc9_.push(_loc2_);
            _loc8_++;
         }
         var _loc11_:int = _loc6_.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc11_)
         {
            _loc12_ = _loc6_.readInt();
            _loc10_[_loc12_ - 1]["hasGain"] = true;
            _loc8_++;
         }
         _model.taskGroupArr = _loc9_;
         _model.towerTaskRewardArr = _loc10_;
         dispatchEvent(new Event("event_query_tower_task_back"));
      }
      
      private function onPackTypeOffer(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
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
            showPreviewFrame(LanguageMgr.GetTranslation("ddQiYuan.frame.offer1TimeRewardTitle"),_loc2_,LanguageMgr.GetTranslation("ddQiYuan.frame.openOffer1TimeRewardTips"));
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
            showPreviewFrame(LanguageMgr.GetTranslation("ddQiYuan.frame.offer10TimeRewardTitle"),_loc2_,LanguageMgr.GetTranslation("ddQiYuan.frame.openOffer10TimeRewardTips"));
         }
         dispatchEvent(new CEvent("event_op_back",_lastOpType));
      }
      
      private function remindGainBeliefReward() : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:* = _model.beliefConfigArr;
         for each(var _loc1_ in _model.beliefConfigArr)
         {
            if(_loc1_["offerTimes"] <= _model.myOfferTimes && _loc1_["remind"] == false)
            {
               _loc1_["remind"] = true;
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function onPackTypeOpenBoGuBox(param1:PkgEvent) : void
      {
         _model.hasGainTreasureBoxNum++;
         _model.myAreaOfferDegree = _model.myAreaOfferDegree + 5;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddQiYuan.frame.openTreasureBoxDegreeTips",5));
         var _loc2_:PackageIn = param1.pkg;
         showPreviewFrame(LanguageMgr.GetTranslation("ddQiYuan.frame.openTreasureBoxRewardTitle"),_loc2_,LanguageMgr.GetTranslation("ddQiYuan.frame.openTreasureBoxRewardTips"));
         dispatchEvent(new CEvent("event_op_back",_lastOpType));
      }
      
      private function onPackTypeActiveOpenClose(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.isOpen = _loc2_.readBoolean();
         _model.endTime = _loc2_.readDate();
         checkAndShowIcon();
      }
      
      private function onPackTypeGainJoinReward(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.hasGainJoinRewardCount = _loc2_.readInt();
         dispatchEvent(new Event("event_gain_join_reward_back"));
      }
      
      private function onPackTypeGainTowerTask(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         var _loc2_:Object = _model.towerTaskRewardArr[_loc4_ - 1];
         _loc2_["hasGain"] = true;
         dispatchEvent(new CEvent("event_gain_bogu_task_reward_back",_loc4_));
      }
      
      private function checkAndShowIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("ddqiyuan",_model.isOpen);
      }
      
      private function __awardframeDispose(param1:CEvent = null) : void
      {
         if(_awardsViewFrame)
         {
            _awardsViewFrame.dispatchEvent(new FrameEvent(2));
            _awardsViewFrame = null;
         }
      }
      
      private function showPreviewFrame(param1:String, param2:PackageIn, param3:String) : void
      {
         title = param1;
         pkg = param2;
         tips = param3;
         OnPreviewFrameCloseHandler = function(param1:Array):void
         {
            BagAndInfoManager.Instance.unregisterOnPreviewFrameCloseHandler("DDQIYuanManager");
         };
         var goodArrLen:int = pkg.readInt();
         var goodArr:Array = [];
         var i:int = 0;
         while(i < goodArrLen)
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
      
      public function sendOfferTimes(param1:int) : void
      {
         times = param1;
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
            onUsePropConfirm = function(param1:BaseAlerFrame):void
            {
               notShowAlertAgain = param1["isNoPrompt"];
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
            onUsePropConfirm = function(param1:BaseAlerFrame):void
            {
               _buyConfirmAlertData.notShowAlertAgain = param1["isNoPrompt"];
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
      
      public function getInventoryItemInfo(param1:Object) : InventoryItemInfo
      {
         var _loc3_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1["goodId"]);
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc2_.ValidDate = param1.validDate;
         _loc2_.Count = param1.goodCount;
         _loc2_.IsBinds = param1.isBind;
         _loc2_.Property5 = "1";
         return _loc2_;
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
