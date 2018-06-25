package sevenday.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.events.TaskEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import quest.TaskManager;
   import sevenday.SevendayManager;
   
   public class SevendayTaskLeftView extends Sprite implements Disposeable
   {
       
      
      private var _vBox:VBox;
      
      private var _tastArr:Array;
      
      private var _info:QuestInfo;
      
      private var _hBox:HBox;
      
      private var _giftArr:Vector.<SevendayTaskCell>;
      
      private var _getRewardBtn:SimpleBitmapButton;
      
      public function SevendayTaskLeftView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var j:int = 0;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.taskvbox");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.giftHbox");
         _giftArr = new Vector.<SevendayTaskCell>();
         _tastArr = [];
         for(j = 0; j < 3; )
         {
            _tastArr[j] = new SevendayTaskItem();
            _vBox.addChild(_tastArr[j]);
            _giftArr[j] = new SevendayTaskCell();
            _hBox.addChild(_giftArr[j]);
            j++;
         }
         addChild(_vBox);
         addChild(_hBox);
         _getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.getbtn");
         _getRewardBtn.addEventListener("click",_getGift);
         addChild(_getRewardBtn);
         TaskManager.instance.addEventListener("changed",__onQuestChange);
      }
      
      public function update(questInfo:QuestInfo) : void
      {
         var i:int = 0;
         var info:* = null;
         var count:int = 0;
         _info = questInfo;
         for(i = 0; i < 3; )
         {
            (_tastArr[i] as SevendayTaskItem).update(questInfo,i);
            info = ItemManager.Instance.getTemplateById(questInfo.itemRewards[i].itemID);
            count = questInfo.itemRewards[i].count[0];
            _giftArr[i].update(info,count);
            i++;
         }
         _vBox.arrange();
         _hBox.arrange();
         updateState();
      }
      
      private function __onQuestChange(e:TaskEvent) : void
      {
         var isNotAllAchieved:Boolean = false;
         if(_info && e.info.QuestID == _info.QuestID)
         {
            updateState();
            isNotAllAchieved = SevendayManager.instance.isNotAllAchieved(e.info.QuestID);
            if(!isNotAllAchieved)
            {
               SevendayManager.instance.checkIcon();
            }
         }
      }
      
      private function updateState() : void
      {
         _getRewardBtn.enable = false;
         if(_info)
         {
            if(_info.data == null || _info.isAchieved)
            {
               isGetReward(true);
               _getRewardBtn.enable = false;
            }
            else
            {
               isGetReward(false);
               if(_info.isCompleted)
               {
                  _getRewardBtn.enable = true;
               }
            }
         }
      }
      
      private function isGetReward(value:Boolean) : void
      {
         var i:int = 0;
         for(i = 0; i < _giftArr.length; )
         {
            _giftArr[i].isGet = value;
            i++;
         }
      }
      
      private function _getGift(e:MouseEvent) : void
      {
         var needBindMoney:int = 0;
         var limitMoney:int = 0;
         var alert:* = null;
         SoundManager.instance.playButtonSound();
         if(_info.RewardBindMoney != 0)
         {
            needBindMoney = _info.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney;
            limitMoney = ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel);
            if(needBindMoney > limitMoney)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
               alert.addEventListener("response",__onResponse);
               return;
            }
         }
         finishQuest(_info);
      }
      
      private function __onResponse(pEvent:FrameEvent) : void
      {
         pEvent.currentTarget.removeEventListener("response",__onResponse);
         if(pEvent.responseCode == 3)
         {
            finishQuest(_info);
         }
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      private function finishQuest(questInfo:QuestInfo) : void
      {
         if(questInfo)
         {
            TaskManager.instance.sendQuestFinish(questInfo.QuestID);
         }
         SocketManager.Instance.out.getSevendayProgressCount();
      }
      
      public function dispose() : void
      {
         TaskManager.instance.removeEventListener("changed",__onQuestChange);
         _getRewardBtn.removeEventListener("click",_getGift);
         ObjectUtils.disposeObject(_getRewardBtn);
         _getRewardBtn = null;
         _tastArr.splice(0,_tastArr.length);
         _tastArr = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         while(_giftArr.length)
         {
            ObjectUtils.disposeObject(_giftArr.pop());
         }
         _giftArr = null;
      }
   }
}
