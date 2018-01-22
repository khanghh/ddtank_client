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
         var _loc1_:int = 0;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.taskvbox");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.giftHbox");
         _giftArr = new Vector.<SevendayTaskCell>();
         _tastArr = [];
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _tastArr[_loc1_] = new SevendayTaskItem();
            _vBox.addChild(_tastArr[_loc1_]);
            _giftArr[_loc1_] = new SevendayTaskCell();
            _hBox.addChild(_giftArr[_loc1_]);
            _loc1_++;
         }
         addChild(_vBox);
         addChild(_hBox);
         _getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.sevenday.getbtn");
         _getRewardBtn.addEventListener("click",_getGift);
         addChild(_getRewardBtn);
         TaskManager.instance.addEventListener("changed",__onQuestChange);
      }
      
      public function update(param1:QuestInfo) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _info = param1;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            (_tastArr[_loc4_] as SevendayTaskItem).update(param1,_loc4_);
            _loc3_ = ItemManager.Instance.getTemplateById(param1.itemRewards[_loc4_].itemID);
            _loc2_ = param1.itemRewards[_loc4_].count[0];
            _giftArr[_loc4_].update(_loc3_,_loc2_);
            _loc4_++;
         }
         _vBox.arrange();
         _hBox.arrange();
         updateState();
      }
      
      private function __onQuestChange(param1:TaskEvent) : void
      {
         var _loc2_:Boolean = false;
         if(_info && param1.info.QuestID == _info.QuestID)
         {
            updateState();
            _loc2_ = SevendayManager.instance.isNotAllAchieved(param1.info.QuestID);
            if(!_loc2_)
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
      
      private function isGetReward(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _giftArr.length)
         {
            _giftArr[_loc2_].isGet = param1;
            _loc2_++;
         }
      }
      
      private function _getGift(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(_info.RewardBindMoney != 0)
         {
            _loc3_ = _info.RewardBindMoney + PlayerManager.Instance.Self.DDTMoney;
            _loc4_ = ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel);
            if(_loc3_ > _loc4_)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
               _loc2_.addEventListener("response",__onResponse);
               return;
            }
         }
         finishQuest(_info);
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onResponse);
         if(param1.responseCode == 3)
         {
            finishQuest(_info);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function finishQuest(param1:QuestInfo) : void
      {
         if(param1)
         {
            TaskManager.instance.sendQuestFinish(param1.QuestID);
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
