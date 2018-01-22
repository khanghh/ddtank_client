package luckStar
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import luckStar.event.LuckStarEvent;
   import luckStar.manager.LuckStarManager;
   import luckStar.view.LuckStarFrame;
   
   public class LuckStarController
   {
      
      private static var _instance:LuckStarController;
       
      
      private var _frame:LuckStarFrame;
      
      public function LuckStarController(param1:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : LuckStarController
      {
         if(LuckStarController._instance == null)
         {
            LuckStarController._instance = new LuckStarController(new PrivateClass());
         }
         return LuckStarController._instance;
      }
      
      public function setup() : void
      {
         LuckStarManager.Instance.addEventListener("allgoodsinfo",__onAllGoodsInfo);
         LuckStarManager.Instance.addEventListener("turngoodsinfo",__onTurnGoodsInfo);
         LuckStarManager.Instance.addEventListener("updatereward",__onUpdateReward);
         LuckStarManager.Instance.addEventListener("openluckystarframe",__onOpenLuckStarFrame);
         LuckStarManager.Instance.addEventListener("loaderluckstaricon",__onLoaderLuckStarIcon);
      }
      
      private function __onLoaderLuckStarIcon(param1:Event) : void
      {
         LoadingLuckStarUI.Instance.startLoad();
      }
      
      private function __onOpenLuckStarFrame(param1:Event) : void
      {
         if(_frame == null)
         {
            _frame = ComponentFactory.Instance.creat("luckyStar.view.LuckStarFrame");
            _frame.titleText = LanguageMgr.GetTranslation("ddt.luckStar.frameTitle");
            _frame.addEventListener("response",__onFrameClose);
            LuckStarManager.Instance.model.addEventListener("luckystarevent",_onLuckyStarEvent);
         }
         LayerManager.Instance.addToLayer(_frame,3,true,1);
         LoadingLuckStarUI.Instance.RequestActivityRank();
      }
      
      private function __onFrameClose(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            if(_frame.isTurn)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.luckStar.notExit"));
               return;
            }
            _frame.removeEventListener("response",__onFrameClose);
            ObjectUtils.disposeObject(_frame);
            _frame = null;
            LuckStarManager.Instance.model.removeEventListener("luckystarevent",_onLuckyStarEvent);
            SocketManager.Instance.out.sendLuckyStarClose();
            LuckStarManager.Instance.removeSocketEvent();
         }
      }
      
      private function _onLuckyStarEvent(param1:LuckStarEvent) : void
      {
         if(_frame)
         {
            if(param1.code == 0)
            {
               _frame.updateCellInfo();
               _frame.updateMinUseNum();
            }
            else if(param1.code == 1)
            {
               _frame.updateLuckyStarCoins();
            }
            else if(param1.code == 2)
            {
               _frame.updatePlayActionList();
            }
         }
      }
      
      private function __onUpdateReward(param1:Event) : void
      {
         _frame.updateNewAwardList(LuckStarManager.Instance.rewardMsg.name,LuckStarManager.Instance.rewardMsg.goodsID,LuckStarManager.Instance.rewardMsg.count);
      }
      
      private function __onTurnGoodsInfo(param1:Event) : void
      {
         if(LuckStarManager.Instance.iteminfo == null)
         {
            return;
         }
         _frame.getAwardGoods(LuckStarManager.Instance.iteminfo);
      }
      
      private function __onAllGoodsInfo(param1:Event) : void
      {
         if(_frame)
         {
            _frame.updateActivityDate();
         }
      }
      
      public function updateLuckyStarRank(param1:Object) : void
      {
         if(_frame)
         {
            _frame.updateRankInfo();
         }
      }
      
      public function get openState() : Boolean
      {
         return _frame != null;
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
