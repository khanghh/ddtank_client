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
      
      protected function __outFilter(param1:MouseEvent) : void
      {
         filters = null;
      }
      
      protected function __overFilter(param1:MouseEvent) : void
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
      
      public function set itemInfo(param1:InventoryItemInfo) : void
      {
         .super.info = param1;
         _invInfo = param1;
         if(param1)
         {
            _manureNum.text = param1.Count.toString();
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
      
      override public function dragStop(param1:DragEffect) : void
      {
         if(param1.target is FarmFieldBlock)
         {
            dragStart();
         }
      }
      
      override protected function createDragImg() : DisplayObject
      {
         var _loc1_:* = null;
         if(_pic && _pic.width > 0 && _pic.height > 0)
         {
            _loc1_ = new Bitmap(_contentData.clone(),"auto",true);
            _loc1_.width = 35;
            _loc1_.height = 35;
            return _loc1_;
         }
         return null;
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
   }
}
