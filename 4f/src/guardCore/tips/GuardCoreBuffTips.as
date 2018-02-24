package guardCore.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import guardCore.data.GuardCoreInfo;
   
   public class GuardCoreBuffTips extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      public function GuardCoreBuffTips(){super();}
      
      override protected function init() : void{}
      
      private function updateView() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function dispose() : void{}
   }
}
