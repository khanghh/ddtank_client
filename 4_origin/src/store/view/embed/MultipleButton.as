package store.view.embed
{
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.ITransformableTipedDisplay;
   
   public class MultipleButton extends TextButton implements ITransformableTipedDisplay
   {
       
      
      public var P_tipWidth:String = "tipWidth";
      
      public var P_tipHeight:String = "tipHeight";
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      public function MultipleButton()
      {
         super();
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(value:int) : void
      {
         if(_tipWidth == value)
         {
            return;
         }
         _tipWidth = value;
         onPropertiesChanged(P_tipWidth);
      }
      
      public function get tipHeight() : int
      {
         return _tipHeight;
      }
      
      public function set tipHeight(value:int) : void
      {
         if(_tipHeight == value)
         {
            return;
         }
         _tipHeight = value;
         onPropertiesChanged(P_tipHeight);
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["tipDirction"] || _changedPropeties["tipGap"] || _changedPropeties["tipStyle"] || _changedPropeties["tipData"] || _changedPropeties[P_tipWidth] || _changedPropeties[P_tipHeight])
         {
            ShowTipManager.Instance.addTip(this);
         }
      }
   }
}
