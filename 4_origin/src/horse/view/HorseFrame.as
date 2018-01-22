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
      
      public function HorseFrame()
      {
         super();
         initView();
         initEvent();
         checkAmuetGuide();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("horse.frame.titleTxt");
         _bg = ComponentFactory.Instance.creatBitmap("asset.horse.frame.bg");
         _leftTopView = new HorseFrameLeftTopView();
         _rightTopView = new HorseFrameRightTopView();
         _leftBottomView = new HorseFrameLeftBottomView();
         PositionUtils.setPos(_leftBottomView,"horse.horseFrameLeftBottomViewPos");
         _rightBottomView = new HorseFrameRightBottomView();
         PositionUtils.setPos(_rightBottomView,"horse.horseFrameRightBottomViewPos");
         addToContent(_bg);
         addToContent(_leftTopView);
         addToContent(_rightTopView);
         addToContent(_leftBottomView);
         addToContent(_rightBottomView);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"horse.frame.helpBtn",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.horse.frame.helpPromptTxt",404,484) as SimpleBitmapButton;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      private function checkAmuetGuide() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(141))
         {
            if(PlayerManager.Instance.Self.Grade >= 31)
            {
               NewHandContainer.Instance.showArrow(100000,0,new Point(716,322),"","",LayerManager.Instance.getLayerByType(2),0,true);
            }
         }
      }
      
      override public function dispose() : void
      {
         NewHandContainer.Instance.clearArrowByID(100000);
         removeEvent();
         super.dispose();
         _bg = null;
         _leftTopView = null;
         _rightTopView = null;
         _leftBottomView = null;
         _rightBottomView = null;
         _helpBtn = null;
      }
   }
}
