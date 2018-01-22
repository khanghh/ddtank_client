package ddt.command
{
   import com.pickgliss.ui.core.TransformableComponent;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   
   public class StripTip extends TransformableComponent
   {
       
      
      private var _view:DisplayObject;
      
      private var _mouseActiveObjectShape:Shape;
      
      public function StripTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _mouseActiveObjectShape = new Shape();
         _mouseActiveObjectShape.graphics.beginFill(65280,0);
         _mouseActiveObjectShape.graphics.drawRect(0,0,100,100);
         _mouseActiveObjectShape.graphics.endFill();
         super.init();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_mouseActiveObjectShape);
      }
      
      public function setView(param1:DisplayObject) : void
      {
         _view = param1;
         addChild(_view);
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["height"] || _changedPropeties["width"])
         {
            _mouseActiveObjectShape.width = _width;
            _mouseActiveObjectShape.height = _height;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_mouseActiveObjectShape)
         {
            ObjectUtils.disposeObject(_mouseActiveObjectShape);
         }
         _mouseActiveObjectShape = null;
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
