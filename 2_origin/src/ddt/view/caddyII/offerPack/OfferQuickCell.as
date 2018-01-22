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
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("offer.quickCellSize");
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,_loc2_.x,_loc2_.y);
         _loc1_.graphics.endFill();
         super(_loc1_);
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
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
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
      
      public function set autoSelect(param1:Boolean) : void
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
