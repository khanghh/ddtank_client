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
      
      public function GradeAwardsBoxButtonManager(param1:inner)
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
      
      private function gradeAwardsFlyIntoBag(param1:Array) : void
      {
         new GradeAwardsFlyIntoBagView().onFrameClose(param1);
         var _loc2_:GradeAwardsBoxModel = GradeAwardsBoxModel.getInstance();
         var _loc3_:InventoryItemInfo = _loc2_.getGradeAwardsBoxInfo();
         updateGradeAwardsBtn(_loc3_);
      }
      
      public function setHall(param1:HallStateView) : void
      {
         _gradeAwardsBoxSprite.setHall(param1);
         var _loc2_:InventoryItemInfo = GradeAwardsBoxModel.getInstance().getGradeAwardsBoxInfo();
         updateGradeAwardsBtn(_loc2_);
      }
      
      protected function onGradeAwardsClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:InventoryItemInfo = GradeAwardsBoxModel.getInstance().getGradeAwardsBoxInfo();
         var _loc2_:Number = _loc3_.NeedLevel;
         var _loc4_:int = GradeAwardsBoxModel.getInstance().canGainGradeAwardsOnButtonClicked(_loc3_);
         switch(int(_loc4_))
         {
            case 0:
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.over"));
            case 1:
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.hall.gradeBox.needLevel",_loc2_));
               return;
            default:
               _gradeAwardsBoxSprite.hide();
               if(_loc3_ != null)
               {
                  SocketManager.Instance.out.sendItemOpenUp(_loc3_.BagType,_loc3_.Place);
                  checkLast(_loc3_);
               }
               return;
         }
      }
      
      protected function onGoodsUpdated(param1:BagEvent) : void
      {
         updateGradeAwardsBtn(GradeAwardsBoxModel.getInstance().getGradeAwardsBoxInfo());
      }
      
      private function updateGradeAwardsBtn(param1:InventoryItemInfo = null) : void
      {
         if(_gradeAwardsBoxSprite == null)
         {
            return;
         }
         if(GradeAwardsBoxModel.getInstance().isShowGradeAwardsBtn(param1))
         {
            _gradeAwardsBoxSprite.show(param1,GradeAwardsBoxModel.getInstance().canGain(param1));
            onButtonShown(param1);
         }
         else
         {
            _gradeAwardsBoxSprite.hide();
            onButtonHide();
            checkLast(param1);
         }
      }
      
      private function onButtonShown(param1:InventoryItemInfo) : void
      {
         var _loc2_:* = null;
         if(_gradeAwardsBoxSprite.isVisible)
         {
            _loc2_ = GradeAwardsBoxModel.getInstance().getRemainTime(param1);
            _gradeAwardsBoxSprite.updateText(_loc2_);
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
         var _loc2_:Boolean = false;
         var _loc1_:* = null;
         var _loc3_:InventoryItemInfo = GradeAwardsBoxModel.getInstance().getGradeAwardsBoxInfo();
         if(GradeAwardsBoxModel.getInstance().isShowGradeAwardsBtn(_loc3_))
         {
            if(!_gradeAwardsBoxSprite.isVisible)
            {
               _loc2_ = GradeAwardsBoxModel.getInstance().canGain(_loc3_);
               _gradeAwardsBoxSprite.show(_loc3_,_loc2_);
            }
            _loc1_ = GradeAwardsBoxModel.getInstance().getRemainTime(_loc3_);
            _gradeAwardsBoxSprite.updateText(_loc1_);
         }
         else
         {
            RemainingTimeManager.getInstance().stop();
            _gradeAwardsBoxSprite.hide();
            checkLast(_loc3_);
         }
      }
      
      private function checkLast(param1:InventoryItemInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(GradeAwardsBoxModel.getInstance().isTheLastBoxBtn(param1))
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
