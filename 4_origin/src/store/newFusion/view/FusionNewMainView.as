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
      
      public function FusionNewMainView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _leftBg = ComponentFactory.Instance.creatBitmap("asset.newFusion.leftBg");
         _rightView = new FusionNewRightView();
         PositionUtils.setPos(_rightView,"store.newFusion.mainView.rightViewPos");
         _canFusionSCB = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.canFusionSCB");
         _vbox = new VBox();
         _vbox.spacing = 2;
         _unitList = new Vector.<FusionNewUnitView>();
         _loc2_ = 1;
         while(_loc2_ <= 6)
         {
            _loc1_ = new FusionNewUnitView(_loc2_,_rightView);
            _loc1_.addEventListener("fusionNewUnitView_selected_change",refreshView,false,0,true);
            _vbox.addChild(_loc1_);
            _unitList.push(_loc1_);
            _loc2_++;
         }
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.unitScrollPanel");
         _listPanel.setView(_vbox);
         _listPanel.invalidateViewport();
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"store.newFusion.HelpButton",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.newFusion.helpPromptTxt",404,484);
         addChild(_leftBg);
         addChild(_listPanel);
         addChild(_canFusionSCB);
         addChild(_rightView);
      }
      
      private function initEvent() : void
      {
         _canFusionSCB.addEventListener("click",canFusionChangeHandler,false,0,true);
      }
      
      private function canFusionChangeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:int = 0;
         var _loc3_:* = _unitList;
         for each(var _loc2_ in _unitList)
         {
            _loc2_.isFilter = _canFusionSCB.selected;
         }
      }
      
      private function refreshView(param1:Event) : void
      {
         var _loc2_:FusionNewUnitView = param1.target as FusionNewUnitView;
         var _loc5_:int = 0;
         var _loc4_:* = _unitList;
         for each(var _loc3_ in _unitList)
         {
            if(_loc3_ != _loc2_)
            {
               _loc3_.unextendHandler();
            }
         }
         _vbox.arrange();
      }
      
      public function dragDrop(param1:BagCell) : void
      {
      }
      
      public function refreshData(param1:Dictionary) : void
      {
      }
      
      public function updateData() : void
      {
      }
      
      public function hide() : void
      {
         this.visible = false;
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      private function removeEvent() : void
      {
         if(_canFusionSCB)
         {
            _canFusionSCB.removeEventListener("click",canFusionChangeHandler);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _leftBg = null;
         _vbox = null;
         _listPanel = null;
         _canFusionSCB = null;
         _helpBtn = null;
         _rightView = null;
         _unitList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
