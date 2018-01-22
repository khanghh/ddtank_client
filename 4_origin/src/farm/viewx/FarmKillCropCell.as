package farm.viewx
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class FarmKillCropCell extends BaseCell
   {
       
      
      private var _bgbmp:BaseButton;
      
      private var _invInfo:InventoryItemInfo;
      
      private var _killCropIcon:Bitmap;
      
      public function FarmKillCropCell()
      {
         buttonMode = true;
         _bgbmp = ComponentFactory.Instance.creatComponentByStylename("farm.doKillBtn");
         _killCropIcon = ComponentFactory.Instance.creatBitmap("assets.farm.killCropImg");
         super(_bgbmp);
         addEventListener("mouseOver",__overFilter);
         addEventListener("mouseOut",__outFilter);
         addEventListener("click",__clickHandler);
      }
      
      public function setBtnVis(param1:Boolean) : void
      {
         _bgbmp.enable = param1;
         if(param1 == false)
         {
            removeEventListener("mouseOver",__overFilter);
            removeEventListener("mouseOut",__outFilter);
            removeEventListener("click",__clickHandler);
         }
         else
         {
            addEventListener("mouseOver",__overFilter);
            addEventListener("mouseOut",__outFilter);
            addEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dragStart();
      }
      
      protected function __outFilter(param1:MouseEvent) : void
      {
         filters = null;
         _bgbmp.x = _bgbmp.x + 15;
      }
      
      protected function __overFilter(param1:MouseEvent) : void
      {
         filters = ComponentFactory.Instance.creatFilters("lightFilter");
         _bgbmp.x = _bgbmp.x - 15;
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         return _invInfo;
      }
      
      public function set itemInfo(param1:InventoryItemInfo) : void
      {
         .super.info = param1;
         _invInfo = param1;
      }
      
      private function get killCropIcon() : DisplayObject
      {
         return new Bitmap(_killCropIcon.bitmapData.clone(),"auto",true);
      }
      
      override public function dragStart() : void
      {
         if(stage && _allowDrag)
         {
            if(DragManager.startDrag(this,_invInfo,killCropIcon,stage.mouseX,stage.mouseY,"move",false,false,false,false,false,null,0,true))
            {
               locked = true;
            }
         }
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         if(param1.target is FarmFieldBlock)
         {
            dragStart();
         }
      }
      
      override protected function updateSize(param1:Sprite) : void
      {
         if(param1)
         {
            param1.width = _contentWidth - 20;
            param1.height = _contentHeight - 20;
            if(_picPos != null)
            {
               param1.x = _picPos.x;
            }
            else
            {
               param1.x = Math.abs(param1.width - _contentWidth) / 2;
            }
            if(_picPos != null)
            {
               param1.y = _picPos.y;
            }
            else
            {
               param1.y = Math.abs(param1.height - _contentHeight) / 2;
            }
         }
      }
      
      override protected function updateSizeII(param1:Sprite) : void
      {
         param1.x = 13;
         param1.y = 10;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("mouseOver",__overFilter);
         removeEventListener("mouseOut",__outFilter);
         removeEventListener("click",__clickHandler);
         if(_bgbmp)
         {
            ObjectUtils.disposeObject(_bgbmp);
         }
         _bgbmp = null;
         if(_killCropIcon)
         {
            ObjectUtils.disposeObject(_killCropIcon);
         }
         _killCropIcon = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
