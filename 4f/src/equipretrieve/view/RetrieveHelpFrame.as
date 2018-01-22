package equipretrieve.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   
   public class RetrieveHelpFrame extends BaseAlerFrame
   {
       
      
      private var _BG:MovieImage;
      
      private var _helpBg:Scale9CornerImage;
      
      private var _alertInfo:AlertInfo;
      
      public function RetrieveHelpFrame(){super();}
      
      private function setView() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
