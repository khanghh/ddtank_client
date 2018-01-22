package hall.tasktrack
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import quest.TaskManager;
   import tryonSystem.TryonSystemController;
   
   public class HallTaskCompleteCommitView extends Sprite implements Disposeable
   {
       
      
      private var _commitBtnTxt:FilterFrameText;
      
      private var _questInfo:QuestInfo;
      
      private var _questId:int;
      
      private var _timeOutId:int;
      
      public function HallTaskCompleteCommitView(param1:int)
      {
         super();
         _questId = param1;
         _questInfo = TaskManager.instance.getQuestByID(_questId);
         initView();
         _timeOutId = setTimeout(dispose,5500);
         this.addEventListener("addedToStage",onATS);
      }
      
      protected function onATS(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onATS);
         SoundManager.instance.play("215");
      }
      
      private function initView() : void
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.hall.taskComplete.commitView.bg");
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("hall.taskCompleteCommitView.contentTxt");
         _loc2_.text = getTypeStr(_questInfo) + LanguageMgr.GetTranslation("hall.taskCompleteCommit.contentTxt",_questInfo.Title);
         _commitBtnTxt = ComponentFactory.Instance.creatComponentByStylename("hall.taskCompleteCommitView.commitBtnTxt");
         _commitBtnTxt.htmlText = "<u><a href=\"event:1\">" + LanguageMgr.GetTranslation("hall.taskCompleteCommit.commitTxt") + "</a></u>";
         _commitBtnTxt.addEventListener("link",textClickHandler);
         _commitBtnTxt.mouseEnabled = true;
         _commitBtnTxt.selectable = false;
         addChild(_loc1_);
         addChild(_loc2_);
         addChild(_commitBtnTxt);
      }
      
      private function textClickHandler(param1:TextEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_questInfo.RewardBindMoney != 0 && _questInfo.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
            _loc2_.addEventListener("response",__onResponse);
         }
         else
         {
            finishQuest();
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onResponse);
         if(param1.responseCode == 3)
         {
            finishQuest();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function finishQuest() : void
      {
         var _loc3_:* = null;
         var _loc1_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _questInfo.itemRewards;
         for each(var _loc2_ in _questInfo.itemRewards)
         {
            _loc3_ = new InventoryItemInfo();
            _loc3_.TemplateID = _loc2_.itemID;
            ItemManager.fill(_loc3_);
            _loc3_.ValidDate = _loc2_.ValidateTime;
            _loc3_.TemplateID = _loc2_.itemID;
            _loc3_.IsJudge = true;
            _loc3_.IsBinds = _loc2_.isBind;
            _loc3_.AttackCompose = _loc2_.AttackCompose;
            _loc3_.DefendCompose = _loc2_.DefendCompose;
            _loc3_.AgilityCompose = _loc2_.AgilityCompose;
            _loc3_.LuckCompose = _loc2_.LuckCompose;
            _loc3_.StrengthenLevel = _loc2_.StrengthenLevel;
            _loc3_.Count = _loc2_.count[_questInfo.QuestLevel - 1];
            if(!(0 != _loc3_.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != _loc3_.NeedSex))
            {
               if(_loc2_.isOptional == 1)
               {
                  _loc1_.push(_loc3_);
               }
            }
         }
         if(_loc1_.length > 0)
         {
            HallTaskTrackManager.instance.moduleLoad(showSelectedAwardFrame,[_loc1_]);
         }
         else
         {
            TaskManager.instance.sendQuestFinish(_questInfo.QuestID);
            if(TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(318)) && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(319)))
            {
               SocketManager.Instance.out.syncWeakStep(49);
            }
         }
         clearTimeout(_timeOutId);
         _questInfo = null;
         dispose();
      }
      
      private function showSelectedAwardFrame(param1:Array) : void
      {
         TryonSystemController.Instance.show(param1,chooseReward,null);
      }
      
      private function chooseReward(param1:ItemTemplateInfo) : void
      {
         SocketManager.Instance.out.sendQuestFinish(_questId,param1.TemplateID);
      }
      
      private function getSexByInt(param1:Boolean) : int
      {
         if(param1)
         {
            return 1;
         }
         return 2;
      }
      
      private function getTypeStr(param1:QuestInfo) : String
      {
         var _loc2_:String = "";
         switch(int(param1.Type))
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.TankLink");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.BranchLine");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Daily");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
            case 6:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            case 10:
               _loc2_ = LanguageMgr.GetTranslation("tank.view.quest.bubble.buried");
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(_commitBtnTxt)
         {
            _commitBtnTxt.removeEventListener("link",textClickHandler);
         }
         ObjectUtils.disposeAllChildren(this);
         _commitBtnTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
