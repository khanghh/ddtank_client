package ddt.view.caddyII.offerPack
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.geom.Point;
   
   public class OfferQuickCell extends BaseCell implements ISelectable
   {
       
      
      private var _mcBg:ScaleBitmapImage;
      
      private var _selected:Boolean;
      
      private var _selecetedShin:Scale9CornerImage;
      
      public function OfferQuickCell()
      {
         var size:Point = ComponentFactory.Instance.creatCustomObject("offer.quickCellSize");
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,size.x,size.y);
         shape.graphics.endFill();
         super(shape);
         tipDirctions = "7,0";
         initView();
      }
      
      private function initView() : void
      {
         _mcBg = ComponentFactory.Instance.creatComponentByStylename("offer.StoreShortcutCellBg");
         addChildAt(_mcBg,0);
         _selecetedShin = ComponentFactory.Instance.creatComponentByStylename("offer.oferQuickBuyShin");
         addChild(_selecetedShin);
         var _loc1_:* = false;
         _selecetedShin.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _selecetedShin.mouseChildren = _loc1_;
         _selecetedShin.visible = _loc1_;
         buttonMode = true;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(_selected == value)
         {
            return;
         }
         _selected = value;
         if(_selected)
         {
            _selecetedShin.visible = true;
            setChildIndex(_selecetedShin,numChildren - 1);
         }
         else
         {
            _selecetedShin.visible = false;
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set autoSelect(value:Boolean) : void
      {
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this as DisplayObject;
      }
      
      public function showBg() : void
      {
         _mcBg.visible = true;
      }
      
      public function hideBg() : void
      {
         _mcBg.visible = false;
      }
      
      override public function dispose() : void
      {
         if(_mcBg)
         {
            ObjectUtils.disposeObject(_mcBg);
         }
         _mcBg = null;
         if(_selecetedShin)
         {
            ObjectUtils.disposeObject(_selecetedShin);
         }
         _selecetedShin = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
