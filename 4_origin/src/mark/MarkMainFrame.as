package mark
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.OneLineTip;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import mark.data.MarkChipData;
   import mark.event.MarkEvent;
   import mark.mornUI.MarkMainFrameUI;
   import mark.views.MarkArtificeView;
   import mark.views.MarkHammerView;
   import morn.core.handlers.Handler;
   
   public class MarkMainFrame extends MarkMainFrameUI
   {
       
      
      private var _tabContainer:VBox;
      
      private var _tab:SelectedButtonGroup;
      
      private var _containers:Dictionary = null;
      
      private var _transfer:SelectedButton = null;
      
      private var _transferSprite:Sprite = null;
      
      private var _transferTip:OneLineTip = null;
      
      private var _tabMask:Sprite = null;
      
      public function MarkMainFrame()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("mark.hammerView.bg");
         addChild(_loc1_);
         _tab = new SelectedButtonGroup();
         _tabContainer = ComponentFactory.Instance.creatComponentByStylename("mark.tabContainer");
         addChild(_tabContainer);
         var _loc2_:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("mark.hammer");
         _tabContainer.addChild(_loc2_);
         _tab.addSelectItem(_loc2_);
         _transfer = ComponentFactory.Instance.creatComponentByStylename("mark.transfer");
         _tabContainer.addChild(_transfer);
         _tab.addSelectItem(_transfer);
         btnClose.clickHandler = new Handler(close);
         _tabMask = new Sprite();
         PositionUtils.setPos(_tabMask,{
            "x":29,
            "y":56
         });
         addChild(_tabMask);
         _tabMask.graphics.beginFill(0,0);
         _tabMask.graphics.drawRect(0,0,52,157);
         _tabMask.graphics.endFill();
         _tabMask.visible = false;
         initEvent();
         _tab.selectIndex = 0;
         checkChipStatus();
      }
      
      private function checkChipStatus(param1:MarkEvent = null) : void
      {
         var _loc3_:MarkChipData = MarkMgr.inst.model.getChipById(MarkMgr.inst.model.chipItemID);
         var _loc2_:* = _loc3_.bornLv + _loc3_.hammerLv > 1;
         _transfer.enable = _loc2_;
         if(_loc2_)
         {
            ObjectUtils.disposeObject(_transferSprite);
            _transferSprite = null;
         }
         else if(_transferSprite == null)
         {
            _transferSprite = new Sprite();
            _transferSprite.graphics.beginFill(0,0);
            _transferSprite.graphics.drawRect(0,0,40,70);
            _transferSprite.graphics.endFill();
            PositionUtils.setPos(_transferSprite,{
               "x":31,
               "y":166
            });
            addChild(_transferSprite);
            _transferTip = new OneLineTip();
            _transferTip.tipData = LanguageMgr.GetTranslation("mark.openTransferTips");
            _transferTip.visible = false;
            _transferSprite.addEventListener("rollOver",overHander);
            _transferSprite.addEventListener("rollOut",outHander);
         }
      }
      
      private function overHander(param1:MouseEvent) : void
      {
         var _loc2_:OneLineTip = _transferTip;
         _loc2_.visible = true;
         LayerManager.Instance.addToLayer(_loc2_,2);
         var _loc3_:Point = param1.currentTarget.localToGlobal(new Point(0,0));
         _loc2_.x = _loc3_.x - _loc2_.width * 0.5;
         _loc2_.y = _loc3_.y + param1.currentTarget.height;
      }
      
      private function outHander(param1:MouseEvent) : void
      {
         var _loc2_:OneLineTip = _transferTip;
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      private function close() : void
      {
         if(MarkMgr.inst.model.transferPro)
         {
            MarkMgr.inst.submitTransfer();
            return;
         }
         dispose();
      }
      
      private function initEvent() : void
      {
         _tab.addEventListener("change",select);
         MarkMgr.inst.addEventListener("updateChips",checkChipStatus);
         _tabMask.addEventListener("click",onMaskClick);
         MarkMgr.inst.addEventListener("transferResult",transferResultHandler);
         MarkMgr.inst.addEventListener("submitResult",submitResult);
      }
      
      private function transferResultHandler(param1:MarkEvent) : void
      {
         _tabMask.visible = true;
      }
      
      private function submitResult(param1:MarkEvent) : void
      {
         _tabMask.visible = false;
      }
      
      private function onMaskClick(param1:MouseEvent) : void
      {
         if(MarkMgr.inst.model.transferPro)
         {
            MarkMgr.inst.submitTransfer();
         }
      }
      
      private function removeEvent() : void
      {
         _tab.removeEventListener("change",select);
         MarkMgr.inst.removeEventListener("updateChips",checkChipStatus);
         if(_transferSprite)
         {
            _transferSprite.removeEventListener("rollOver",overHander);
            _transferSprite.removeEventListener("rollOut",outHander);
         }
         _tabMask.removeEventListener("click",onMaskClick);
         MarkMgr.inst.removeEventListener("transferResult",transferResultHandler);
         MarkMgr.inst.removeEventListener("submitResult",submitResult);
      }
      
      private function select(param1:Event) : void
      {
         _tabContainer.arrange();
         if(!_containers)
         {
            _containers = new Dictionary(true);
         }
         var _loc5_:int = 0;
         var _loc4_:* = _containers;
         for each(var _loc2_ in _containers)
         {
            _loc2_.visible = false;
         }
         var _loc3_:DisplayObjectContainer = _containers[_tab.selectIndex];
         switch(int(_tab.selectIndex))
         {
            case 0:
               lblTitle.text = LanguageMgr.GetTranslation("mark.hammer");
               if(!_loc3_)
               {
                  _loc3_ = new MarkHammerView();
                  PositionUtils.setPos(_loc3_,"mark.hammerViewPos");
                  addChild(_loc3_);
                  _containers[_tab.selectIndex] = _loc3_;
               }
               break;
            case 1:
               lblTitle.text = LanguageMgr.GetTranslation("mark.transfer");
               if(!_loc3_)
               {
                  _loc3_ = new MarkArtificeView();
                  PositionUtils.setPos(_loc3_,"mark.transferViewPos");
                  addChild(_loc3_);
                  _containers[_tab.selectIndex] = _loc3_;
                  break;
               }
         }
         _loc3_.visible = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_transferSprite)
         {
            ObjectUtils.disposeObject(_transferSprite);
         }
         _transferSprite = null;
         if(_transferTip)
         {
            ObjectUtils.disposeObject(_transferTip);
         }
         _transferTip = null;
         var _loc3_:int = 0;
         var _loc2_:* = _containers;
         for each(var _loc1_ in _containers)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _containers = null;
         _transfer = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
