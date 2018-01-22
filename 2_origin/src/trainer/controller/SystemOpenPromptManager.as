package trainer.controller
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.cell.BagCell;
   import calendar.CalendarManager;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import consortion.ConsortionModelManager;
   import consortion.guard.ConsortiaGuardControl;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.loader.LoaderCreate;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperDataModuleLoad;
   import farm.FarmModelController;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import pet.sprite.PetSpriteManager;
   import sevenDouble.SevenDoubleManager;
   import trainer.view.SystemOpenPromptFrame;
   import treasure.model.TreasureModel;
   import vip.VipController;
   
   public class SystemOpenPromptManager extends EventDispatcher
   {
      
      public static const TOTEM:int = 1;
      
      public static const GEMSTONE:int = 2;
      
      public static const GET_AWARD:int = 3;
      
      public static const SIGN:int = 4;
      
      public static const CONSORTIA_BOSS_OPEN:int = 5;
      
      public static const TREASURE:int = 10;
      
      public static const BATTLE_GROUND_OPEN:int = 6;
      
      public static const FARM_CROP_RIPE:int = 7;
      
      public static const SEVEN_DOUBLE_DUNGEON:int = 8;
      
      public static const GET_NEW_EQUIP_TIP:int = 9;
      
      public static const ENCHANT:int = 10;
      
      public static const CONSORTIA_GUARD:int = 11;
      
      public static const TARGET:int = 12;
      
      private static var _instance:SystemOpenPromptManager;
       
      
      public var isShowNewEuipTip:Boolean;
      
      private var _item:InventoryItemInfo;
      
      private var _equipFrameDic:Dictionary;
      
      private var _isLoadComplete:Boolean = false;
      
      private var _frameList:Object;
      
      private var _isJudge:Boolean = false;
      
      public function SystemOpenPromptManager()
      {
         super(null);
      }
      
      public static function get instance() : SystemOpenPromptManager
      {
         if(_instance == null)
         {
            _instance = new SystemOpenPromptManager();
         }
         return _instance;
      }
      
      public function loadModule() : void
      {
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addUIModuleImp("systemopenprompt");
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "systemopenprompt")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            _isLoadComplete = true;
            showFrame();
         }
      }
      
      public function showFrame(param1:InventoryItemInfo = null, param2:int = 0) : void
      {
         var _loc3_:* = null;
         _frameList = {};
         if(PetSpriteManager.Instance.checkFarmCropRipe())
         {
            if(!_isLoadComplete)
            {
               loadModule();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc3_.show(7,gotoSystem);
            _frameList[7] = _loc3_;
         }
         if(PathManager.treasureSwitch && !_isJudge && PlayerManager.Instance.Self.Grade >= 25 && PlayerManager.Instance.Self.treasure + PlayerManager.Instance.Self.treasureAdd > 0 && !TreasureModel.instance.isEndTreasure)
         {
            if(!_isLoadComplete)
            {
               loadModule();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc3_.show(10,gotoSystem);
            _frameList[10] = _loc3_;
         }
         if(PlayerManager.Instance.Self.Grade >= 30 && !PlayerManager.Instance.Self.isNewOnceFinish(103))
         {
            if(!_isLoadComplete)
            {
               loadModule();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc3_.show(2,gotoSystem);
            _frameList[2] = _loc3_;
            SocketManager.Instance.out.syncWeakStep(103);
         }
         if(PlayerManager.Instance.Self.Grade >= 40 && !PlayerManager.Instance.Self.isNewOnceFinish(133))
         {
            if(!_isLoadComplete)
            {
               loadModule();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc3_.show(10,gotoSystem);
            _frameList[10] = _loc3_;
            SocketManager.Instance.out.syncWeakStep(133);
         }
         if(!_isJudge && PlayerManager.Instance.Self.Grade >= 5 && (PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.canTakeVipReward))
         {
            if(!_isLoadComplete)
            {
               loadModule();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc3_.show(3,gotoSystem);
            _frameList[3] = _loc3_;
         }
         if(!_isJudge && PlayerManager.Instance.Self.Grade >= 5 && !PlayerManager.Instance.Self.Sign)
         {
            if(!_isLoadComplete)
            {
               loadModule();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc3_.show(4,gotoSystem);
            _frameList[4] = _loc3_;
         }
         if(ConsortionModelManager.Instance.isShowBossOpenTip)
         {
            if(!_isLoadComplete)
            {
               loadModule();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc3_.show(5,gotoSystem);
            _frameList[5] = _loc3_;
            ConsortionModelManager.Instance.isShowBossOpenTip = false;
         }
         if(ConsortiaGuardControl.Instance.model.isOpen)
         {
            if(!_isLoadComplete)
            {
               loadModule();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc3_.show(11,gotoSystem);
            _frameList[11] = _loc3_;
         }
         if(ConsortionModelManager.Instance.checkRewardStauts())
         {
            if(!_isLoadComplete)
            {
               loadModule();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc3_.show(12,gotoSystem);
            _frameList[12] = _loc3_;
         }
         if(SevenDoubleManager.instance.isShowDungeonTip && !PlayerManager.Instance.Self.isSameDay && SevenDoubleManager.instance.isStart)
         {
            if(!_isLoadComplete)
            {
               loadModule();
               return;
            }
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc3_.show(8,gotoSystem);
            _frameList[8] = _loc3_;
            SevenDoubleManager.instance.isShowDungeonTip = false;
         }
         _isJudge = true;
      }
      
      public function showEquipTipFrame(param1:InventoryItemInfo) : void
      {
         var _loc2_:* = null;
         _equipFrameDic = new Dictionary();
         _item = param1;
         if(_item)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("SystemOpenPromptFrame");
            _loc2_.show(9,equipedNewEquip,_item);
            _equipFrameDic[param1.TemplateID] = _loc2_;
         }
      }
      
      public function equipedNewEquip(param1:BagCell) : void
      {
         var _loc3_:InventoryItemInfo = param1.info as InventoryItemInfo;
         var _loc2_:int = PlayerManager.Instance.getPlaceOfEquip(_loc3_);
         if(_loc2_ == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.systemOpenPrompt.equiped"));
         }
         else
         {
            SocketManager.Instance.out.sendMoveGoods(0,_loc3_.Place,0,_loc2_,_loc3_.Count);
         }
         _equipFrameDic[_loc3_.TemplateID] = null;
      }
      
      public function gotoSystem(param1:int) : void
      {
         switch(int(param1) - 1)
         {
            case 0:
               showTotem();
               break;
            case 1:
               showGemstone();
               break;
            case 2:
               showGetAward();
               break;
            case 3:
               showSign();
               break;
            case 4:
               new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createConsortiaBossTemplateLoader],showConsortiaBoss);
               break;
            case 5:
               showBattleGround();
               break;
            case 6:
               showFarm();
               break;
            case 7:
               goSevenDoubleDungeon();
               break;
            default:
               goSevenDoubleDungeon();
               break;
            case 9:
            case 10:
               showEnchant();
               break;
            case 11:
               showConsortion();
         }
         _frameList[param1] = null;
      }
      
      private function goSevenDoubleDungeon() : void
      {
         StateManager.setState("dungeon");
      }
      
      private function showFarm() : void
      {
         FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
      }
      
      private function showBattleGround() : void
      {
         BattleGroudManager.Instance.onShow();
      }
      
      private function showConsortiaBoss() : void
      {
         StateManager.setState("consortia",ConsortionModelManager.Instance.openBossFrame);
      }
      
      private function showSign() : void
      {
         CalendarManager.getInstance().open(1);
      }
      
      private function showGetAward() : void
      {
         VipController.instance.show();
      }
      
      private function showGemstone() : void
      {
         BagStore.instance.openStore("forge_store",3);
      }
      
      private function showConsortion() : void
      {
         StateManager.setState("consortia");
      }
      
      private function showEnchant() : void
      {
         BagStore.instance.openStore("forge_store",4);
      }
      
      private function showTotem() : void
      {
         BagAndInfoManager.Instance.showBagAndInfo(5);
      }
      
      public function dispose() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _frameList;
         for each(var _loc2_ in _frameList)
         {
            _loc2_.dispose();
         }
         _frameList = null;
         var _loc6_:int = 0;
         var _loc5_:* = _equipFrameDic;
         for each(var _loc1_ in _equipFrameDic)
         {
            _loc1_.dispose();
         }
         _equipFrameDic = null;
      }
      
      public function get isLoadComplete() : Boolean
      {
         return _isLoadComplete;
      }
   }
}
