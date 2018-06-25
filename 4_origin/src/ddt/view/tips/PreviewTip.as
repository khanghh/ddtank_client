package ddt.view.tips
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class PreviewTip extends Sprite implements Disposeable, ITransformableTip
   {
       
      
      private var _tipData:Object;
      
      public function PreviewTip()
      {
         super();
      }
      
      public function get tipWidth() : int
      {
         return width;
      }
      
      public function set tipWidth(w:int) : void
      {
      }
      
      public function get tipHeight() : int
      {
         return height;
      }
      
      public function set tipHeight(h:int) : void
      {
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(data:Object) : void
      {
         if(!data || data is DisplayObject == false)
         {
            return;
         }
         if(data == _tipData)
         {
            return;
         }
         _tipData = data;
         ObjectUtils.disposeAllChildren(this);
         addChild(_tipData as DisplayObject);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
