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
      
      public function GradeBuyController(param1:inner){super();}
      
      public static function getInstance() : GradeBuyController{return null;}
      
      public function setup() : void{}
      
      protected function onShowHandler(param1:CEvent) : void{}
      
      private function onUILoaded() : void{}
      
      private function onStageClick(param1:MouseEvent) : void{}
      
      public function showItemListView(param1:ItemTemplateInfo, param2:Object) : void{}
      
      public function arrage() : void{}
      
      public function hideTypeView() : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
