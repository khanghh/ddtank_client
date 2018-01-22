package store.godRefining.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.events.BagEvent;
   import ddt.events.CEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import store.godRefining.GodRefiningManager;
   
   public class GodRefiningView extends Sprite implements Disposeable
   {
       
      
      private var _tabVbox:VBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _fineQuenchBtn:SelectedButton;
      
      private var _composeBtn:SelectedButton;
      
      private var _resetBtn:SelectedButton;
      
      private var _contentBg:DisplayObject;
      
      private var _fineQuenchView:GodRefiningFineQuenchView;
      
      private var _composeView:GodRefiningComposeView;
      
      private var _resetView:GodRefiningResetView;
      
      private var _rightView:GodRefiningRightView;
      
      private var currentPanel;
      
      public function GodRefiningView()
      {
         super();
         AssetModuleLoader.addModelLoader("godRefining",6);
         AssetModuleLoader.startCodeLoader(init);
      }
      
      private function init() : void
      {
         initView();
         initEvent();
         _btnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _contentBg = ComponentFactory.Instance.creatCustomObject("ddtstore.godRefining.ContentBg");
         addChild(_contentBg);
         _tabVbox = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.TabSelectedBtnContainer");
         PositionUtils.setPos(_tabVbox,"ddtstore.godRefining.VboxPos");
         addChild(_tabVbox);
         _fineQuenchBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.fineQuenchBtn");
         _composeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.composeBtn");
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.resetBtn");
         _tabVbox.addChild(_fineQuenchBtn);
         _tabVbox.addChild(_composeBtn);
         _tabVbox.addChild(_resetBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_fineQuenchBtn);
         _btnGroup.addSelectItem(_composeBtn);
         _btnGroup.addSelectItem(_resetBtn);
         _rightView = new GodRefiningRightView();
         PositionUtils.setPos(_rightView,"ddtstore.godRefining.rightViewPos");
         addChild(_rightView);
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__tabChangeHandler);
         PlayerManager.Instance.Self.Bag.addEventListener("update",updateBag);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",updateBag);
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateStoreBag);
         GodRefiningManager.instance.addEventListener("godRefining_equip_startdarg",__quitStartDrag);
         GodRefiningManager.instance.addEventListener("godRefining_equip_stopdarg",__quitStopDrag);
         GodRefiningManager.instance.addEventListener("godRefining_equip_move",__equipDoubleClickMove);
         GodRefiningManager.instance.addEventListener("godRefining_prop_move",__propDoubleClickMove);
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         if(_tabVbox)
         {
            _tabVbox.arrange();
         }
         if(_fineQuenchView)
         {
            _fineQuenchView.visible = false;
         }
         if(_composeView)
         {
            _composeView.visible = false;
         }
         if(_resetView)
         {
            _resetView.visible = false;
         }
         if(_btnGroup.selectIndex == 1)
         {
            if(_composeView == null)
            {
               _composeView = new GodRefiningComposeView();
               PositionUtils.setPos(_composeView,"ddtstore.godRefining.composeViewPos");
               addChild(_composeView);
            }
            currentPanel = _composeView;
         }
         else if(_btnGroup.selectIndex == 2)
         {
            if(_resetView == null)
            {
               _resetView = new GodRefiningResetView();
               PositionUtils.setPos(_resetView,"ddtstore.godRefining.resetViewPos");
               addChild(_resetView);
            }
            currentPanel = _resetView;
         }
         else
         {
            if(_fineQuenchView == null)
            {
               _fineQuenchView = new GodRefiningFineQuenchView();
               PositionUtils.setPos(_fineQuenchView,"ddtstore.godRefining.fineQuenchViewPos");
               addChild(_fineQuenchView);
            }
            currentPanel = _fineQuenchView;
         }
         currentPanel.visible = true;
         updateView();
      }
      
      private function __updateStoreBag(param1:BagEvent) : void
      {
         if(this.visible)
         {
            if(currentPanel)
            {
               currentPanel.refreshData(param1.changedSlots);
            }
         }
      }
      
      private function updateBag(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         if(this.visible)
         {
            _loc2_ = param1.target as BagInfo;
            if(_rightView)
            {
               _rightView.refreshData(param1.changedSlots,_loc2_);
            }
         }
      }
      
      private function __quitStartDrag(param1:CEvent) : void
      {
         if(currentPanel)
         {
            currentPanel.quitStartDrag(param1);
         }
      }
      
      private function __quitStopDrag(param1:CEvent) : void
      {
         if(currentPanel)
         {
            currentPanel.quitStopDrag(param1);
         }
      }
      
      private function __equipDoubleClickMove(param1:CEvent) : void
      {
         if(currentPanel)
         {
            currentPanel.equipDoubleClickMove(param1);
         }
      }
      
      private function __propDoubleClickMove(param1:CEvent) : void
      {
         if(currentPanel)
         {
            currentPanel.propDoubleClickMove(param1);
         }
      }
      
      public function updateView() : void
      {
         SocketManager.Instance.out.sendMoveGoods(12,0,0,-1);
         if(currentPanel)
         {
            currentPanel.updateView();
         }
         if(_rightView)
         {
            _rightView.updateView(_btnGroup.selectIndex);
         }
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__tabChangeHandler);
         PlayerManager.Instance.Self.Bag.removeEventListener("update",updateBag);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",updateBag);
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateStoreBag);
         GodRefiningManager.instance.removeEventListener("godRefining_equip_startdarg",__quitStartDrag);
         GodRefiningManager.instance.removeEventListener("godRefining_equip_stopdarg",__quitStopDrag);
         GodRefiningManager.instance.removeEventListener("godRefining_equip_move",__equipDoubleClickMove);
         GodRefiningManager.instance.removeEventListener("godRefining_prop_move",__propDoubleClickMove);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_tabVbox);
         ObjectUtils.disposeAllChildren(this);
         _contentBg = null;
         _tabVbox = null;
         _btnGroup = null;
         _fineQuenchBtn = null;
         _composeBtn = null;
         _resetBtn = null;
         _fineQuenchView = null;
         _composeView = null;
         _resetView = null;
         _rightView = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
