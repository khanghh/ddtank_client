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
      
      public function set tipWidth(param1:int) : void
      {
         if(_tipWidth == param1)
         {
            return;
         }
         _tipWidth = param1;
         onPropertiesChanged("tipWidth");
      }
      
      public function get tipHeight() : int
      {
         return _tipHeight;
      }
      
      public function set tipHeight(param1:int) : void
      {
         if(_tipHeight == param1)
         {
            return;
         }
         _tipHeight = param1;
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
