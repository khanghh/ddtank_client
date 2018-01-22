package gradeBuy
{
   import bagAndInfo.cell.BagCell;
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreController;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.MouseEvent;
   import gradeBuy.view.GradeBuyItemsListView;
   import gradeBuy.view.GradeBuyRewardTypeView;
   import gradeBuy.view.GradeBuyTypeItem;
   
   public class GradeBuyController extends CoreController
   {
      
      private static var instance:GradeBuyController;
       
      
      private var _manager:GradeBuyManager;
      
      private var _typeView:GradeBuyRewardTypeView;
      
      public function GradeBuyController(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : GradeBuyController
      {
         if(!instance)
         {
            instance = new GradeBuyController(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         _manager = GradeBuyManager.getInstance();
         addEventsMap([["gb_show",onShowHandler]],_manager);
      }
      
      protected function onShowHandler(param1:CEvent) : void
      {
         new HelperUIModuleLoad().loadUIModule(["gradeBuy"],onUILoaded);
      }
      
      private function onUILoaded() : void
      {
         addClickListener = function():void
         {
            StageReferance.stage.addEventListener("click",onStageClick,false);
         };
         ShowTipManager.Instance.tempChangeTipContainer();
         _typeView = new GradeBuyRewardTypeView();
         _typeView.x = 420;
         _typeView.y = 120;
         LayerManager.Instance.addToLayer(_typeView,3,false,1);
         _typeView.update();
         _manager.startTimer();
         TweenLite.delayedCall(0.75,addClickListener);
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("click",onStageClick);
         _manager.viewClosed();
         ObjectUtils.disposeObject(_typeView);
         _typeView = null;
         if(param1.target is BagCell == false && param1.target is GradeBuyTypeItem == false)
         {
            _manager.stopTimer();
            ShowTipManager.Instance.setup();
         }
      }
      
      public function showItemListView(param1:ItemTemplateInfo, param2:Object) : void
      {
         var _loc3_:GradeBuyItemsListView = ComponentFactory.Instance.creatComponentByStylename("gradeBuy.itemListframe");
         LayerManager.Instance.addToLayer(_loc3_,3,true,1);
         _loc3_.setData(param1,param2);
      }
      
      public function arrage() : void
      {
      }
      
      public function hideTypeView() : void
      {
         ObjectUtils.disposeObject(_typeView);
         _typeView = null;
         GradeBuyManager.getInstance().updateBtn();
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
