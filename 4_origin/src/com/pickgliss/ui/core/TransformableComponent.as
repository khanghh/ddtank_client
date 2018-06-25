package com.pickgliss.ui.core
{
   import com.pickgliss.ui.ShowTipManager;
   
   public class TransformableComponent extends Component implements ITransformableTipedDisplay
   {
      
      public static const P_tipWidth:String = "tipWidth";
      
      public static const P_tipHeight:String = "tipHeight";
       
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      public function TransformableComponent()
      {
         super();
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(w:int) : void
      {
         if(_tipWidth == w)
         {
            return;
         }
         _tipWidth = w;
         onPropertiesChanged("tipWidth");
      }
      
      public function get tipHeight() : int
      {
         return _tipHeight;
      }
      
      public function set tipHeight(h:int) : void
      {
         if(_tipHeight == h)
         {
            return;
         }
         _tipHeight = h;
         onPropertiesChanged("tipHeight");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["tipWidth"] || _changedPropeties["tipHeight"] || _changedPropeties["tipDirction"] || _changedPropeties["tipGap"] || _changedPropeties["tipStyle"] || _changedPropeties["tipData"])
         {
            ShowTipManager.Instance.addTip(this);
         }
      }
   }
}
