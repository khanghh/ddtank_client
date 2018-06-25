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
      
      public function setBtnVis(value:Boolean) : void
      {
         _bgbmp.enable = value;
         if(value == false)
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
      
      private function __clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dragStart();
      }
      
      protected function __outFilter(event:MouseEvent) : void
      {
         filters = null;
         _bgbmp.x = _bgbmp.x + 15;
      }
      
      protected function __overFilter(event:MouseEvent) : void
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
      
      public function set itemInfo(value:InventoryItemInfo) : void
      {
         .super.info = value;
         _invInfo = value;
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
      
      override public function dragStop(effect:DragEffect) : void
      {
         if(effect.target is FarmFieldBlock)
         {
            dragStart();
         }
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         if(sp)
         {
            sp.width = _contentWidth - 20;
            sp.height = _contentHeight - 20;
            if(_picPos != null)
            {
               sp.x = _picPos.x;
            }
            else
            {
               sp.x = Math.abs(sp.width - _contentWidth) / 2;
            }
            if(_picPos != null)
            {
               sp.y = _picPos.y;
            }
            else
            {
               sp.y = Math.abs(sp.height - _contentHeight) / 2;
            }
         }
      }
      
      override protected function updateSizeII(sp:Sprite) : void
      {
         sp.x = 13;
         sp.y = 10;
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
