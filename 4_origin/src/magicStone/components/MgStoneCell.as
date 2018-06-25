package magicStone.components
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MgStoneCell extends BagCell
   {
       
      
      private var _lockIcon:Bitmap;
      
      protected var _nameTxt:FilterFrameText;
      
      public function MgStoneCell(index:int = 0, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null)
      {
         super(index,info,showLoading,bg);
         _picPos = new Point(2,0);
         initEvents();
      }
      
      private function initEvents() : void
      {
         addEventListener("interactive_click",onClick);
         addEventListener("interactive_double_click",onDoubleClick);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("interactive_click",onClick);
         removeEventListener("interactive_double_click",onDoubleClick);
         DoubleClickManager.Instance.disableDoubleClick(this);
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
      }
      
      override protected function onMouseClick(evt:MouseEvent) : void
      {
      }
      
      protected function onClick(evt:InteractiveEvent) : void
      {
         dispatchEvent(new CellEvent("itemclick",this));
      }
      
      protected function onDoubleClick(evt:InteractiveEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(info)
         {
            dispatchEvent(new CellEvent("doubleclick",this));
         }
      }
      
      override public function dragStart() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_info && !locked && stage && _allowDrag)
         {
            if(DragManager.startDrag(this,_info,createDragImg(),stage.mouseX,stage.mouseY,"move"))
            {
               locked = true;
               dragHidePicTxt();
               if(_info && _pic.numChildren > 0)
               {
                  dispatchEvent(new CellEvent("dragStart",this.info,true));
               }
            }
         }
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var info:* = null;
         if(effect.data is InventoryItemInfo)
         {
            info = effect.data as InventoryItemInfo;
            if(effect.source is MgStoneCell)
            {
               SocketManager.Instance.out.moveMagicStone(info.Place,_place);
               DragManager.acceptDrag(this);
               return;
            }
         }
         else if(effect.source is MgStoneLockBtn)
         {
            DragManager.acceptDrag(this);
         }
         else if(effect.source is MgStoneFeedBtn)
         {
            DragManager.acceptDrag(this);
         }
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new CellEvent("dragStop",null,true));
         if(effect.action == "move")
         {
            if(!effect.target)
            {
               effect.action = "none";
               if(!(effect.target is MgStoneCell))
               {
                  if(!effect.target)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.CanntDestory"));
                  }
               }
            }
            else
            {
               locked = false;
            }
         }
         dragShowPicTxt();
         super.dragStop(effect);
      }
      
      private function dragHidePicTxt() : void
      {
         if(_lockIcon)
         {
            _lockIcon.visible = false;
         }
      }
      
      private function dragShowPicTxt() : void
      {
         if(itemInfo.goodsLock && _lockIcon)
         {
            _lockIcon.visible = true;
         }
      }
      
      public function lockMgStone() : void
      {
         if(!itemInfo.goodsLock)
         {
            if(_lockIcon)
            {
               _lockIcon.visible = true;
            }
            else
            {
               _lockIcon = ComponentFactory.Instance.creatBitmap("asset.beadSystem.beadInset.lockIcon1");
               var _loc1_:* = 0.7;
               _lockIcon.scaleY = _loc1_;
               _lockIcon.scaleX = _loc1_;
               this.addChild(_lockIcon);
            }
            setChildIndex(_lockIcon,numChildren - 1);
            SocketManager.Instance.out.lockMagicStone(_place);
         }
         else
         {
            if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
            SocketManager.Instance.out.lockMagicStone(_place);
         }
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         if(_info)
         {
            _tipData = null;
            locked = false;
            if(_nameTxt)
            {
               _nameTxt.htmlText = "";
               _nameTxt.visible = false;
            }
         }
         .super.info = value;
         if(value)
         {
            if(!_nameTxt)
            {
               _nameTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.mgStoneCell.name");
               _nameTxt.mouseEnabled = false;
               addChild(_nameTxt);
            }
            _nameTxt.text = value.Name.substr(0,2);
            _nameTxt.visible = true;
            setChildIndex(_nameTxt,numChildren - 1);
            if(itemInfo && itemInfo.goodsLock)
            {
               if(_lockIcon)
               {
                  _lockIcon.visible = true;
               }
               else
               {
                  _lockIcon = ComponentFactory.Instance.creatBitmap("asset.beadSystem.beadInset.lockIcon1");
                  var _loc2_:* = 0.7;
                  _lockIcon.scaleY = _loc2_;
                  _lockIcon.scaleX = _loc2_;
                  this.addChild(_lockIcon);
               }
               setChildIndex(_lockIcon,numChildren - 1);
            }
            else if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
         }
         else if(_lockIcon)
         {
            _lockIcon.visible = false;
         }
      }
      
      override protected function createLoading() : void
      {
         super.createLoading();
         PositionUtils.setPos(_loadingasset,"ddt.personalInfocell.loadingPos");
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_lockIcon);
         _lockIcon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         super.dispose();
      }
   }
}
