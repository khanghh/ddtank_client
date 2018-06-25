package catchInsect.view
{
   import catchInsect.CatchInsectManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CatchInsectCheckGeinFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _indivPrizeView:IndivPrizeView;
      
      private var _selfZoneView:CatchInsectRankView;
      
      private var _crossZoneView:CatchInsectRankView;
      
      private var _hBox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _indivPrizeBtn:SelectedTextButton;
      
      private var _selfZoneBtn:SelectedTextButton;
      
      private var _crossZoneBtn:SelectedTextButton;
      
      private var _scoreImg:Bitmap;
      
      private var _txtBg:Scale9CornerImage;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _convertBtn:SimpleBitmapButton;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var currentIndex:int;
      
      public function CatchInsectCheckGeinFrame()
      {
         super();
         initView();
         initEvents();
         SocketManager.Instance.out.updateInsectInfo();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("catchInsect.chooseFrameTitle");
         _bg = ComponentFactory.Instance.creatComponentByStylename("catchInsect.checkGeinFrame.bg");
         addToContent(_bg);
         _indivPrizeView = new IndivPrizeView();
         PositionUtils.setPos(_indivPrizeView,"catchInsect.viewPos");
         addToContent(_indivPrizeView);
         _selfZoneView = new CatchInsectRankView(0);
         PositionUtils.setPos(_selfZoneView,"catchInsect.viewPos");
         addToContent(_selfZoneView);
         _selfZoneView.visible = false;
         _crossZoneView = new CatchInsectRankView(1);
         PositionUtils.setPos(_crossZoneView,"catchInsect.viewPos");
         addToContent(_crossZoneView);
         _crossZoneView.visible = false;
         _hBox = ComponentFactory.Instance.creatComponentByStylename("catchInsect.checkGeinFrame.hBox");
         addToContent(_hBox);
         _indivPrizeBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.indivPrizeBtn");
         _hBox.addChild(_indivPrizeBtn);
         _indivPrizeBtn.text = LanguageMgr.GetTranslation("catchInsect.geinFrame.tab1");
         _selfZoneBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.selfZoneBtn");
         _hBox.addChild(_selfZoneBtn);
         _selfZoneBtn.text = LanguageMgr.GetTranslation("catchInsect.geinFrame.tab2");
         _crossZoneBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.crossZoneBtn");
         _hBox.addChild(_crossZoneBtn);
         _crossZoneBtn.text = LanguageMgr.GetTranslation("catchInsect.geinFrame.tab3");
         _scoreImg = ComponentFactory.Instance.creat("catchInsect.myScore");
         addToContent(_scoreImg);
         _txtBg = ComponentFactory.Instance.creatComponentByStylename("catchInsect.txtBg");
         addToContent(_txtBg);
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.scoreTxt");
         addToContent(_scoreTxt);
         _scoreTxt.text = "0";
         _convertBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.convertBtn");
         addToContent(_convertBtn);
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.tipsTxt");
         addToContent(_tipsTxt);
         _tipsTxt.text = LanguageMgr.GetTranslation("catchInsect.geinFrame.tips");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"catchInsect.HelpButton",null,LanguageMgr.GetTranslation("ddt.ringstation.helpTitle"),"catchInsect.helpTxt",504,484);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_indivPrizeBtn);
         _btnGroup.addSelectItem(_selfZoneBtn);
         _btnGroup.addSelectItem(_crossZoneBtn);
         _btnGroup.selectIndex = 0;
         currentIndex = 0;
      }
      
      private function initEvents() : void
      {
         _btnGroup.addEventListener("change",__changeHandler);
         _convertBtn.addEventListener("click",__convertBtnClick);
         CatchInsectManager.instance.addEventListener("updateInfo",__updateView);
      }
      
      protected function __updateView(event:Event) : void
      {
         var total:int = CatchInsectManager.instance.model.score;
         var avaible:int = CatchInsectManager.instance.model.avaibleScore;
         var prizeStatus:int = CatchInsectManager.instance.model.prizeStatus;
         _scoreTxt.text = avaible + "/" + total;
         _indivPrizeView.setPrizeStatus(prizeStatus);
      }
      
      protected function __convertBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:CatchInsectShopFrame = ComponentFactory.Instance.creatCustomObject("catchInsect.shopFrame");
         frame.addEventListener("response",__frameEvent);
         frame.show();
      }
      
      protected function __frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:Disposeable = event.target as Disposeable;
         frame.dispose();
         frame = null;
      }
      
      protected function __changeHandler(event:Event) : void
      {
         if(_btnGroup.selectIndex == currentIndex)
         {
            return;
         }
         SoundManager.instance.play("008");
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _indivPrizeView.visible = true;
               _selfZoneView.visible = false;
               _crossZoneView.visible = false;
               break;
            case 1:
               _indivPrizeView.visible = false;
               _selfZoneView.visible = true;
               _crossZoneView.visible = false;
               SocketManager.Instance.out.updateInsectLocalRank();
               SocketManager.Instance.out.updateInsectLocalSelfInfo();
               break;
            case 2:
               _indivPrizeView.visible = false;
               _selfZoneView.visible = false;
               _crossZoneView.visible = true;
               SocketManager.Instance.out.updateInsectAreaRank();
               SocketManager.Instance.out.updateInsectAreaSelfInfo();
         }
         currentIndex = _btnGroup.selectIndex;
      }
      
      private function removeEvents() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__changeHandler);
         }
         if(_convertBtn)
         {
            _convertBtn.removeEventListener("click",__convertBtnClick);
         }
         CatchInsectManager.instance.removeEventListener("updateInfo",__updateView);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         super.dispose();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_indivPrizeView);
         _indivPrizeView = null;
         ObjectUtils.disposeObject(_selfZoneView);
         _selfZoneView = null;
         ObjectUtils.disposeObject(_crossZoneView);
         _crossZoneView = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_indivPrizeBtn);
         _indivPrizeBtn = null;
         ObjectUtils.disposeObject(_selfZoneBtn);
         _selfZoneBtn = null;
         ObjectUtils.disposeObject(_crossZoneBtn);
         _crossZoneBtn = null;
         ObjectUtils.disposeObject(_scoreImg);
         _scoreImg = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_convertBtn);
         _convertBtn = null;
         ObjectUtils.disposeObject(_tipsTxt);
         _tipsTxt = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
      }
   }
}
