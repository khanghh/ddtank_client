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
      
      public function HallTaskCompleteCommitView(questId:int)
      {
         super();
         _questId = questId;
         _questInfo = TaskManager.instance.getQuestByID(_questId);
         initView();
         _timeOutId = setTimeout(dispose,5500);
         this.addEventListener("addedToStage",onATS);
      }
      
      protected function onATS(e:Event) : void
      {
         this.removeEventListener("addedToStage",onATS);
         SoundManager.instance.play("215");
      }
      
      private function initView() : void
      {
         var bg:MovieClip = ComponentFactory.Instance.creat("asset.hall.taskComplete.commitView.bg");
         var contentTxt:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("hall.taskCompleteCommitView.contentTxt");
         contentTxt.text = getTypeStr(_questInfo) + LanguageMgr.GetTranslation("hall.taskCompleteCommit.contentTxt",_questInfo.Title);
         _commitBtnTxt = ComponentFactory.Instance.creatComponentByStylename("hall.taskCompleteCommitView.commitBtnTxt");
         _commitBtnTxt.htmlText = "<u><a href=\"event:1\">" + LanguageMgr.GetTranslation("hall.taskCompleteCommit.commitTxt") + "</a></u>";
         _commitBtnTxt.addEventListener("link",textClickHandler);
         _commitBtnTxt.mouseEnabled = true;
         _commitBtnTxt.selectable = false;
         addChild(bg);
         addChild(contentTxt);
         addChild(_commitBtnTxt);
      }
      
      private function textClickHandler(event:TextEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         if(_questInfo.RewardBindMoney != 0 && _questInfo.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
            alert.addEventListener("response",__onResponse);
         }
         else
         {
            finishQuest();
         }
      }
      
      private function __onResponse(pEvent:FrameEvent) : void
      {
         pEvent.currentTarget.removeEventListener("response",__onResponse);
         if(pEvent.responseCode == 3)
         {
            finishQuest();
         }
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      private function finishQuest() : void
      {
         var info:* = null;
         var items:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _questInfo.itemRewards;
         for each(var temp in _questInfo.itemRewards)
         {
            info = new InventoryItemInfo();
            info.TemplateID = temp.itemID;
            ItemManager.fill(info);
            info.ValidDate = temp.ValidateTime;
            info.TemplateID = temp.itemID;
            info.IsJudge = true;
            info.IsBinds = temp.isBind;
            info.AttackCompose = temp.AttackCompose;
            info.DefendCompose = temp.DefendCompose;
            info.AgilityCompose = temp.AgilityCompose;
            info.LuckCompose = temp.LuckCompose;
            info.StrengthenLevel = temp.StrengthenLevel;
            info.Count = temp.count[_questInfo.QuestLevel - 1];
            if(!(0 != info.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != info.NeedSex))
            {
               if(temp.isOptional == 1)
               {
                  items.push(info);
               }
            }
         }
         if(items.length > 0)
         {
            HallTaskTrackManager.instance.moduleLoad(showSelectedAwardFrame,[items]);
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
      
      private function showSelectedAwardFrame(items:Array) : void
      {
         TryonSystemController.Instance.show(items,chooseReward,null);
      }
      
      private function chooseReward(item:ItemTemplateInfo) : void
      {
         SocketManager.Instance.out.sendQuestFinish(_questId,item.TemplateID);
      }
      
      private function getSexByInt(Sex:Boolean) : int
      {
         if(Sex)
         {
            return 1;
         }
         return 2;
      }
      
      private function getTypeStr(questInfo:QuestInfo) : String
      {
         var tmp:String = "";
         switch(int(questInfo.Type))
         {
            case 0:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.TankLink");
               break;
            case 1:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.BranchLine");
               break;
            case 2:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Daily");
               break;
            case 3:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
            case 6:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            default:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
               break;
            case 10:
               tmp = LanguageMgr.GetTranslation("tank.view.quest.bubble.buried");
         }
         return tmp;
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
