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
      
      public function BombKingPrizeFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("bombKing.prizes");
         _bg = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeFrame.bg");
         addToContent(_bg);
         _desBg = ComponentFactory.Instance.creat("bombKing.prizeDesBg");
         addToContent(_desBg);
         _desTxt1 = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeFrame.desTxt");
         PositionUtils.setPos(_desTxt1,"bombKing.prizeFrame.desTxt1");
         addToContent(_desTxt1);
         _desTxt1.text = LanguageMgr.GetTranslation("bombKing.desTxt1");
         _desTxt2 = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeFrame.desTxt");
         PositionUtils.setPos(_desTxt2,"bombKing.prizeFrame.desTxt2");
         addToContent(_desTxt2);
         _desTxt2.text = LanguageMgr.GetTranslation("bombKing.desTxt2");
         _desTxt3 = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeFrame.desTxt");
         PositionUtils.setPos(_desTxt3,"bombKing.prizeFrame.desTxt3");
         addToContent(_desTxt3);
         _desTxt3.text = LanguageMgr.GetTranslation("bombKing.desTxt3");
         _NO1Img = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeFrame.NO1");
         addToContent(_NO1Img);
         _NO1Img.tipData = 1;
         _NO2Img = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeFrame.NO2");
         addToContent(_NO2Img);
         _NO2Img.tipData = 2;
         _NO3Img = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeFrame.NO3");
         addToContent(_NO3Img);
         _NO3Img.tipData = 3;
         _otherImg = ComponentFactory.Instance.creatComponentByStylename("bombKing.prizeFrame.Other");
         addToContent(_otherImg);
         _otherImg.tipData = 0;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__frameEventHandler);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         param1.currentTarget.removeEventListener("response",__frameEventHandler);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_desBg);
         _desBg = null;
         ObjectUtils.disposeObject(_desTxt1);
         _desTxt1 = null;
         ObjectUtils.disposeObject(_desTxt2);
         _desTxt2 = null;
         ObjectUtils.disposeObject(_desTxt3);
         _desTxt3 = null;
         ObjectUtils.disposeObject(_NO1Img);
         _NO1Img = null;
         ObjectUtils.disposeObject(_NO2Img);
         _NO2Img = null;
         ObjectUtils.disposeObject(_NO3Img);
         _NO3Img = null;
         ObjectUtils.disposeObject(_otherImg);
         _otherImg = null;
         super.dispose();
      }
   }
}
