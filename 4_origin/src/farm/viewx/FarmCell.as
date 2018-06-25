package farm.viewx
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class FarmCell extends BaseCell
   {
       
      
      private var _bgbmp:ScaleBitmapImage;
      
      private var _manureNum:FilterFrameText;
      
      private var _invInfo:InventoryItemInfo;
      
      private var _continueDrag:Boolean;
      
      private var _contentData:BitmapData;
      
      public function FarmCell()
      {
         buttonMode = true;
         _bgbmp = ComponentFactory.Instance.creatComponentByStylename("asset.farm.cropIconBg");
         super(_bgbmp);
         addEventListener("mouseOver",__overFilter);
         addEventListener("mouseOut",__outFilter);
      }
      
      protected function __outFilter(event:MouseEvent) : void
      {
         filters = null;
      }
      
      protected function __overFilter(event:MouseEvent) : void
      {
         filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _manureNum = ComponentFactory.Instance.creatComponentByStylename("farm.seedSelect.cropNum");
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         return _invInfo;
      }
      
      public function set itemInfo(value:InventoryItemInfo) : void
      {
         .super.info = value;
         _invInfo = value;
         if(value)
         {
            _manureNum.text = value.Count.toString();
            addChild(_manureNum);
         }
      }
      
      override public function dragStart() : void
      {
         if(_info && stage && _allowDrag)
         {
            if(DragManager.startDrag(this,_invInfo,createDragImg(),stage.mouseX,stage.mouseY,"move",false,false,false,false,false,null,0,true))
            {
               locked = true;
            }
         }
      }
      
      override protected function createContentComplete() : void
      {
         super.createContentComplete();
         _contentData = new BitmapData(_pic.width / _pic.scaleX,_pic.height / _pic.scaleY,true,0);
         _contentData.draw(_pic);
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         if(effect.target is FarmFieldBlock)
         {
            dragStart();
         }
      }
      
      override protected function createDragImg() : DisplayObject
      {
         var img:* = null;
         if(_pic && _pic.width > 0 && _pic.height > 0)
         {
            img = new Bitmap(_contentData.clone(),"auto",true);
            img.width = 35;
            img.height = 35;
            return img;
         }
         return null;
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
   }
}
