package church.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   
   public class ChurchAlertFrame extends BaseAlerFrame
   {
       
      
      private var _txt:FilterFrameText;
      
      public function ChurchAlertFrame(){super();}
      
      public function setTxt(param1:String) : void{}
      
      override public function dispose() : void{}
   }
}
