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
         var bg:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("mark.hammerView.bg");
         addChild(bg);
         _tab = new SelectedButtonGroup();
         _tabContainer = ComponentFactory.Instance.creatComponentByStylename("mark.tabContainer");
         addChild(_tabContainer);
         var hammer:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("mark.hammer");
         _tabContainer.addChild(hammer);
         _tab.addSelectItem(hammer);
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
      
      private function checkChipStatus(evt:MarkEvent = null) : void
      {
         var chip:MarkChipData = MarkMgr.inst.model.getChipById(MarkMgr.inst.model.chipItemID);
         var isTransfer:* = chip.bornLv + chip.hammerLv > 1;
         _transfer.enable = isTransfer;
         if(isTransfer)
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
      
      private function overHander(e:MouseEvent) : void
      {
         var tip:OneLineTip = _transferTip;
         tip.visible = true;
         LayerManager.Instance.addToLayer(tip,2);
         var pos:Point = e.currentTarget.localToGlobal(new Point(0,0));
         tip.x = pos.x - tip.width * 0.5;
         tip.y = pos.y + e.currentTarget.height;
      }
      
      private function outHander(e:MouseEvent) : void
      {
         var tip:OneLineTip = _transferTip;
         if(tip)
         {
            tip.visible = false;
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
      
      private function transferResultHandler(evt:MarkEvent) : void
      {
         _tabMask.visible = true;
      }
      
      private function submitResult(evt:MarkEvent) : void
      {
         _tabMask.visible = false;
      }
      
      private function onMaskClick(evt:MouseEvent) : void
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
      
      private function select(evt:Event) : void
      {
         _tabContainer.arrange();
         if(!_containers)
         {
            _containers = new Dictionary(true);
         }
         var _loc5_:int = 0;
         var _loc4_:* = _containers;
         for each(var it in _containers)
         {
            it.visible = false;
         }
         var container:DisplayObjectContainer = _containers[_tab.selectIndex];
         switch(int(_tab.selectIndex))
         {
            case 0:
               lblTitle.text = LanguageMgr.GetTranslation("mark.hammer");
               if(!container)
               {
                  container = new MarkHammerView();
                  PositionUtils.setPos(container,"mark.hammerViewPos");
                  addChild(container);
                  _containers[_tab.selectIndex] = container;
               }
               break;
            case 1:
               lblTitle.text = LanguageMgr.GetTranslation("mark.transfer");
               if(!container)
               {
                  container = new MarkArtificeView();
                  PositionUtils.setPos(container,"mark.transferViewPos");
                  addChild(container);
                  _containers[_tab.selectIndex] = container;
                  break;
               }
         }
         container.visible = true;
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
         for each(var it in _containers)
         {
            ObjectUtils.disposeObject(it);
         }
         _containers = null;
         _transfer = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
