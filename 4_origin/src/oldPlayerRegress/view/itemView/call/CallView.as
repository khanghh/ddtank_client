package oldPlayerRegress.view.itemView.call
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import oldPlayerRegress.RegressManager;
   import road7th.comm.PackageIn;
   
   public class CallView extends Frame
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _bottomBtnBg:ScaleBitmapImage;
      
      private var _titleImg:ScaleFrameImage;
      
      private var _configBtn:SimpleBitmapButton;
      
      private var _callInfo:FilterFrameText;
      
      private var _inputBg:Scale9CornerImage;
      
      private var _lookBtn:Bitmap;
      
      private var _callLookupView:CallLookUpView;
      
      public function CallView()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creat("asset.regress.titleBg");
         _bottomBtnBg = ComponentFactory.Instance.creatComponentByStylename("regress.bottomBgImg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("call.titleImg");
         _configBtn = ComponentFactory.Instance.creatComponentByStylename("call.configBtn");
         _configBtn.enable = false;
         if(RegressManager.isCallEnable)
         {
            _configBtn.enable = true;
         }
         _callInfo = ComponentFactory.Instance.creatComponentByStylename("regress.Description");
         _callInfo.text = LanguageMgr.GetTranslation("ddt.regress.callView.callInfo");
         PositionUtils.setPos(_callInfo,"regress.call.callInfo.pos");
         _callLookupView = new CallLookUpView();
         var pos:Point = ComponentFactory.Instance.creatCustomObject("regress.call.cookupView.Pos");
         _callLookupView.x = pos.x;
         _callLookupView.y = pos.y;
         addToContent(_titleBg);
         addToContent(_bottomBtnBg);
         addToContent(_titleImg);
         addToContent(_configBtn);
         addToContent(_callInfo);
         addToContent(_callLookupView);
      }
      
      private function initEvent() : void
      {
         _configBtn.addEventListener("click",__onMouseClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(149,2),__onCheck);
      }
      
      protected function __onCheck(event:PkgEvent) : void
      {
         var num:int = 0;
         var pkg:PackageIn = event.pkg;
         if(pkg.bytesAvailable > 0)
         {
            num = pkg.readInt();
            if(num == 1)
            {
               RegressManager.isCallEnable = false;
               _configBtn.enable = false;
            }
         }
      }
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_callLookupView.inputText.text != "")
         {
            SocketManager.Instance.out.sendRegressCheckPlayer(_callLookupView.inputText.text);
         }
      }
      
      private function removeEvent() : void
      {
         _configBtn.removeEventListener("click",__onMouseClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,2),__onCheck);
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_titleBg)
         {
            _titleBg = null;
         }
         if(_bottomBtnBg)
         {
            _bottomBtnBg.dispose();
            _bottomBtnBg = null;
         }
         if(_titleImg)
         {
            _titleImg.dispose();
            _titleImg = null;
         }
         if(_configBtn)
         {
            _configBtn.dispose();
            _configBtn = null;
         }
         if(_callInfo)
         {
            _callInfo.dispose();
            _callInfo = null;
         }
         if(_inputBg)
         {
            _inputBg.dispose();
            _inputBg = null;
         }
         if(_bottomBtnBg)
         {
            _lookBtn = null;
         }
         if(_callLookupView)
         {
            _callLookupView.dispose();
            _callLookupView = null;
         }
      }
   }
}
