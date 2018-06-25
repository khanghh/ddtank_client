package rescue.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.ImgNumConverter;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import rescue.data.RescueResultInfo;
   
   public class RescueResultFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _sceneImg:Bitmap;
      
      private var _scoreContainer:Sprite;
      
      private var _scoreTxt:Sprite;
      
      private var _hbox:HBox;
      
      private var _star:Bitmap;
      
      private var _winOrClose:Bitmap;
      
      private var _submitBtn:TextButton;
      
      public function RescueResultFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("rescue.resultFrameTitle");
         _bg = ComponentFactory.Instance.creatBitmap("rescue.result.bg");
         addToContent(_bg);
         _submitBtn = ComponentFactory.Instance.creat("rescue.result.EnterBtn");
         PositionUtils.setPos(_submitBtn,"rescue.result.submitBtnPos");
         _submitBtn.text = LanguageMgr.GetTranslation("ok");
         addToContent(_submitBtn);
         _scoreContainer = new Sprite();
         _scoreContainer.graphics.beginFill(0,0);
         _scoreContainer.graphics.drawRect(0,0,110,35);
         _scoreContainer.graphics.endFill();
         addToContent(_scoreContainer);
         PositionUtils.setPos(_scoreContainer,"rescue.result.scorePos");
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__frameEventHandler);
         _submitBtn.addEventListener("click",__submitBtnClick);
      }
      
      protected function __submitBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function setData(info:RescueResultInfo) : void
      {
         var i:int = 0;
         _sceneImg = ComponentFactory.Instance.creat("rescue.scene" + info.sceneId);
         PositionUtils.setPos(_sceneImg,"rescue.result.scenePos");
         addToContent(_sceneImg);
         _scoreTxt = ImgNumConverter.instance.convertToImg(info.score,"rescue.result.num",17);
         _scoreContainer.addChild(_scoreTxt);
         _scoreTxt.x = (_scoreContainer.width - _scoreTxt.width) / 2;
         _hbox = ComponentFactory.Instance.creatComponentByStylename("rescue.result.starHBox");
         addToContent(_hbox);
         for(i = 1; i <= info.star; )
         {
            _star = ComponentFactory.Instance.creat("rescue.star");
            _hbox.addChild(_star);
            i++;
         }
         _hbox.refreshChildPos();
         if(info.isWin)
         {
            _winOrClose = ComponentFactory.Instance.creat("asset.experience.rightViewWin");
         }
         else
         {
            _winOrClose = ComponentFactory.Instance.creat("asset.experience.rightViewLose");
         }
         PositionUtils.setPos(_winOrClose,"rescue.result.winOrLosePos");
         addToContent(_winOrClose);
         _winOrClose.scaleX = 0.8;
         _winOrClose.scaleY = 0.8;
         _winOrClose.smoothing = true;
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__frameEventHandler);
         _submitBtn.removeEventListener("click",__submitBtnClick);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_sceneImg);
         _sceneImg = null;
         ObjectUtils.disposeObject(_scoreContainer);
         _scoreContainer = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_star);
         _star = null;
         ObjectUtils.disposeObject(_winOrClose);
         _winOrClose = null;
         ObjectUtils.disposeObject(_submitBtn);
         _submitBtn = null;
         super.dispose();
      }
   }
}
