package horse.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import trainer.view.NewHandContainer;
   
   public class HorseFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _leftTopView:HorseFrameLeftTopView;
      
      private var _rightTopView:HorseFrameRightTopView;
      
      private var _leftBottomView:HorseFrameLeftBottomView;
      
      private var _rightBottomView:HorseFrameRightBottomView;
      
      private var _helpBtn:SimpleBitmapButton;
      
      public function HorseFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function checkAmuetGuide() : void{}
      
      override public function dispose() : void{}
   }
}
