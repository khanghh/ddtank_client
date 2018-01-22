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
      
      public function MgStoneCell(param1:int = 0, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null)
      {
         super(param1,param2,param3,param4);
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
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
      }
      
      override protected function onMouseClick(param1:MouseEvent) : void
      {
      }
      
      protected function onClick(param1:InteractiveEvent) : void
      {
         dispatchEvent(new CellEvent("itemclick",this));
      }
      
      protected function onDoubleClick(param1:InteractiveEvent) : void
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
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         if(param1.data is InventoryItemInfo)
         {
            _loc2_ = param1.data as InventoryItemInfo;
            if(param1.source is MgStoneCell)
            {
               SocketManager.Instance.out.moveMagicStone(_loc2_.Place,_place);
               DragManager.acceptDrag(this);
               return;
            }
         }
         else if(param1.source is MgStoneLockBtn)
         {
            DragManager.acceptDrag(this);
         }
         else if(param1.source is MgStoneFeedBtn)
         {
            DragManager.acceptDrag(this);
         }
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new CellEvent("dragStop",null,true));
         if(param1.action == "move")
         {
            if(!param1.target)
            {
               param1.action = "none";
               if(!(param1.target is MgStoneCell))
               {
                  if(!param1.target)
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
         super.dragStop(param1);
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
      
      override public function set info(param1:ItemTemplateInfo) : void
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
         .super.info = param1;
         if(param1)
         {
            if(!_nameTxt)
            {
               _nameTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.mgStoneCell.name");
               _nameTxt.mouseEnabled = false;
               addChild(_nameTxt);
            }
            _nameTxt.text = param1.Name.substr(0,2);
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
