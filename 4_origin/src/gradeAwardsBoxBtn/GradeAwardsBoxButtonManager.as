package gradeAwardsBoxBtn
{
   import bagAndInfo.BagAndInfoManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.events.MouseEvent;
   import gradeAwardsBoxBtn.model.GradeAwardsBoxModel;
   import gradeAwardsBoxBtn.model.RemainingTimeManager;
   import gradeAwardsBoxBtn.view.GradeAwardsBoxSprite;
   import gradeAwardsBoxBtn.view.GradeAwardsFlyIntoBagView;
   import hall.HallStateView;
   
   public class GradeAwardsBoxButtonManager
   {
      
      private static var instance:GradeAwardsBoxButtonManager;
       
      
      private const ON_FRAME_CLOSE:String = "ofc";
      
      private var _gradeAwardsBoxSprite:GradeAwardsBoxSprite;
      
      public function GradeAwardsBoxButtonManager(single:inner)
      {
         super();
      }
      
      public static function getInstance() : GradeAwardsBoxButtonManager
      {
         if(!instance)
         {
            instance = new GradeAwardsBoxButtonManager(new inner());
         }
         return instance;
      }
      
      public function init() : void
      {
         BagAndInfoManager.Instance.registerOnPreviewFrameCloseHandler("ofc",gradeAwardsFlyIntoBag);
         _gradeAwardsBoxSprite = GradeAwardsBoxSprite.getInstance();
         _gradeAwardsBoxSprite.addEventListener("click",onGradeAwardsClickHandler);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",onGoodsUpdated);
      }
      
      private function gradeAwardsFlyIntoBag(infos:Array) : void
      {
         new GradeAwardsFlyIntoBagView().onFrameClose(infos);
         var GABModel:GradeAwardsBoxModel = GradeAwardsBoxModel.getInstance();
         var info:InventoryItemInfo = GABModel.getGradeAwardsBoxInfo();
         updateGradeAwardsBtn(info);
      }
      
      public function setHall(hall:HallStateView) : void
      {
         _gradeAwardsBoxSprite.setHall(hall);
         var __info:InventoryItemInfo = GradeAwardsBoxModel.getInstance().getGradeAwardsBoxInfo();
         updateGradeAwardsBtn(__info);
      }
      
      protected function onGradeAwardsClickHandler(me:MouseEvent) : void
      {
         var itemInfo:InventoryItemInfo = GradeAwardsBoxModel.getInstance().getGradeAwardsBoxInfo();
         var gradeAwardsBoxNeedLevel:Number = itemInfo.NeedLevel;
         var canGainAwards:int = GradeAwardsBoxModel.getInstance().canGainGradeAwardsOnButtonClicked(itemInfo);
         switch(int(canGainAwards))
         {
            case 0:
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.over"));
            case 1:
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.hall.gradeBox.needLevel",gradeAwardsBoxNeedLevel));
               return;
            default:
               _gradeAwardsBoxSprite.hide();
               if(itemInfo != null)
               {
                  SocketManager.Instance.out.sendItemOpenUp(itemInfo.BagType,itemInfo.Place);
                  checkLast(itemInfo);
               }
               return;
         }
      }
      
      protected function onGoodsUpdated(e:BagEvent) : void
      {
         updateGradeAwardsBtn(GradeAwardsBoxModel.getInstance().getGradeAwardsBoxInfo());
      }
      
      private function updateGradeAwardsBtn(info:InventoryItemInfo = null) : void
      {
         if(_gradeAwardsBoxSprite == null)
         {
            return;
         }
         if(GradeAwardsBoxModel.getInstance().isShowGradeAwardsBtn(info))
         {
            _gradeAwardsBoxSprite.show(info,GradeAwardsBoxModel.getInstance().canGain(info));
            onButtonShown(info);
         }
         else
         {
            _gradeAwardsBoxSprite.hide();
            onButtonHide();
            checkLast(info);
         }
      }
      
      private function onButtonShown(info:InventoryItemInfo) : void
      {
         var timeString:* = null;
         if(_gradeAwardsBoxSprite.isVisible)
         {
            timeString = GradeAwardsBoxModel.getInstance().getRemainTime(info);
            _gradeAwardsBoxSprite.updateText(timeString);
            if(!RemainingTimeManager.getInstance().isRuning())
            {
               RemainingTimeManager.getInstance().funOnTimer = onTimer;
               RemainingTimeManager.getInstance().start();
            }
         }
      }
      
      private function onButtonHide() : void
      {
         if(!_gradeAwardsBoxSprite.isVisible)
         {
            RemainingTimeManager.getInstance().stop();
         }
      }
      
      private function onTimer() : void
      {
         var shining:Boolean = false;
         var timeString:* = null;
         var info:InventoryItemInfo = GradeAwardsBoxModel.getInstance().getGradeAwardsBoxInfo();
         if(GradeAwardsBoxModel.getInstance().isShowGradeAwardsBtn(info))
         {
            if(!_gradeAwardsBoxSprite.isVisible)
            {
               shining = GradeAwardsBoxModel.getInstance().canGain(info);
               _gradeAwardsBoxSprite.show(info,shining);
            }
            timeString = GradeAwardsBoxModel.getInstance().getRemainTime(info);
            _gradeAwardsBoxSprite.updateText(timeString);
         }
         else
         {
            RemainingTimeManager.getInstance().stop();
            _gradeAwardsBoxSprite.hide();
            checkLast(info);
         }
      }
      
      private function checkLast(itemInfo:InventoryItemInfo) : void
      {
         if(itemInfo == null)
         {
            return;
         }
         if(GradeAwardsBoxModel.getInstance().isTheLastBoxBtn(itemInfo))
         {
            RemainingTimeManager.getInstance().stop();
            _gradeAwardsBoxSprite.removeEventListener("click",onGradeAwardsClickHandler);
            _gradeAwardsBoxSprite.dispose();
            _gradeAwardsBoxSprite = null;
         }
      }
      
      public function dispose() : void
      {
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",onGoodsUpdated);
         BagAndInfoManager.Instance.unregisterOnPreviewFrameCloseHandler("ofc");
         RemainingTimeManager.getInstance().stop();
         if(_gradeAwardsBoxSprite != null)
         {
            _gradeAwardsBoxSprite.removeEventListener("click",onGradeAwardsClickHandler);
            _gradeAwardsBoxSprite = null;
         }
         instance = null;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
