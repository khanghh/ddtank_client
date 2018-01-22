package store.newFusion.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import store.IStoreViewBG;
   
   public class FusionNewMainView extends Sprite implements IStoreViewBG
   {
       
      
      private var _leftBg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _listPanel:ScrollPanel;
      
      private var _unitList:Vector.<FusionNewUnitView>;
      
      private var _rightView:FusionNewRightView;
      
      private var _canFusionSCB:SelectedCheckButton;
      
      private var _helpBtn:BaseButton;
      
      public function FusionNewMainView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function canFusionChangeHandler(param1:MouseEvent) : void{}
      
      private function refreshView(param1:Event) : void{}
      
      public function dragDrop(param1:BagCell) : void{}
      
      public function refreshData(param1:Dictionary) : void{}
      
      public function updateData() : void{}
      
      public function hide() : void{}
      
      public function show() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
