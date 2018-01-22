package ddtmatch.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   
   public class DDTMatchBuyFrame extends Frame
   {
       
      
      private var _inputBg:Scale9CornerImage;
      
      private var _confirm:TextButton;
      
      private var _cancel:TextButton;
      
      public function DDTMatchBuyFrame(){super();}
      
      private function initView() : void{}
      
      override public function dispose() : void{}
   }
}
