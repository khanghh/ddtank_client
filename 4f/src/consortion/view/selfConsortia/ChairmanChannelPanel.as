package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ChairmanChannelPanel extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _declaration:TextButton;
      
      private var _jobManage:TextButton;
      
      private var _transfer:TextButton;
      
      private var _upGrade:TextButton;
      
      private var _mail:TextButton;
      
      private var _task:TextButton;
      
      public function ChairmanChannelPanel(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
