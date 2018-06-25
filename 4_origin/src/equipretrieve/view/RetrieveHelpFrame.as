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
      
      public function RetrieveHelpFrame()
      {
         super();
         setView();
      }
      
      private function setView() : void
      {
         cancelButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.view.equipretrieve.helpTip"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("close"),true,false);
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         info.escEnable = true;
         _helpBg = ComponentFactory.Instance.creatComponentByStylename("ddtequipretrieve.help.BG1");
         _BG = ComponentFactory.Instance.creatComponentByStylename("ddtequipretrieve.help.txt");
         addToContent(_helpBg);
         addToContent(_BG);
         addEventListener("response",_response);
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      override public function dispose() : void
      {
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
