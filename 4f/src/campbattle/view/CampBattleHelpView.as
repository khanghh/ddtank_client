package campbattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class CampBattleHelpView extends BaseAlerFrame
   {
       
      
      private var _mc:MovieClip;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _back:Bitmap;
      
      public function CampBattleHelpView(){super();}
      
      override protected function init() : void{}
      
      override public function dispose() : void{}
   }
}
