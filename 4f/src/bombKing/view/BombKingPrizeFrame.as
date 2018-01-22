package bombKing.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   
   public class BombKingPrizeFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _desBg:Bitmap;
      
      private var _desTxt1:FilterFrameText;
      
      private var _desTxt2:FilterFrameText;
      
      private var _desTxt3:FilterFrameText;
      
      private var _NO1Img:Image;
      
      private var _NO2Img:Image;
      
      private var _NO3Img:Image;
      
      private var _otherImg:Image;
      
      public function BombKingPrizeFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
