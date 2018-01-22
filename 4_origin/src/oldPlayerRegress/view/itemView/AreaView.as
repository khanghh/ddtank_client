package oldPlayerRegress.view.itemView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import oldPlayerRegress.RegressManager;
   import road7th.comm.PackageIn;
   
   public class AreaView extends Frame
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _bottomBtnBg:ScaleBitmapImage;
      
      private var _titleImg:ScaleFrameImage;
      
      private var _areaInfo:FilterFrameText;
      
      private var _areaInfoItem:FilterFrameText;
      
      private var _caption:FilterFrameText;
      
      private var _applyBtn:SimpleBitmapButton;
      
      public function AreaView()
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
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("regress.areaTitleImg");
         _bottomBtnBg = ComponentFactory.Instance.creatComponentByStylename("regress.bottomBgImg");
         _areaInfo = ComponentFactory.Instance.creatComponentByStylename("regress.Description");
         _areaInfo.text = LanguageMgr.GetTranslation("ddt.regress.areaView.areaInfo");
         PositionUtils.setPos(_areaInfo,"regress.area.areaInfo.pos");
         _areaInfoItem = ComponentFactory.Instance.creatComponentByStylename("regress.Description");
         _areaInfoItem.htmlText = LanguageMgr.GetTranslation("ddt.regress.areaView.areaInfoItem");
         PositionUtils.setPos(_areaInfoItem,"regress.area.areaInfoItem.pos");
         _caption = ComponentFactory.Instance.creatComponentByStylename("regress.areaCaption");
         _caption.text = LanguageMgr.GetTranslation("ddt.regress.areaView.caption");
         _applyBtn = ComponentFactory.Instance.creatComponentByStylename("regress.applyBtn");
         _applyBtn.enable = false;
         if(RegressManager.isApplyEnable)
         {
            _applyBtn.enable = true;
         }
         addToContent(_titleBg);
         addToContent(_bottomBtnBg);
         addToContent(_titleImg);
         addToContent(_areaInfo);
         addToContent(_areaInfoItem);
         addToContent(_caption);
         addToContent(_applyBtn);
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      private function initEvent() : void
      {
         _applyBtn.addEventListener("click",__onMouseClickApply);
         SocketManager.Instance.addEventListener(PkgEvent.format(149,3),__onApplyPacks);
         SocketManager.Instance.addEventListener(PkgEvent.format(149,6),__onApplyEnable);
      }
      
      protected function __onMouseClickApply(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.sendRegressApllyPacks();
      }
      
      protected function __onApplyPacks(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         if(_loc3_.bytesAvailable > 0)
         {
            _loc2_ = _loc3_.readInt();
            if(_loc2_ == 1)
            {
               RegressManager.isApplyEnable = false;
               _applyBtn.enable = false;
            }
         }
      }
      
      protected function __onApplyEnable(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         if(_loc3_.bytesAvailable > 0)
         {
            _loc2_ = _loc3_.readInt();
            if(_loc2_ == 1)
            {
               RegressManager.isApplyEnable = false;
               _applyBtn.enable = false;
            }
            else
            {
               RegressManager.isApplyEnable = true;
               _applyBtn.enable = true;
            }
         }
      }
      
      private function removeEvent() : void
      {
         _applyBtn.removeEventListener("click",__onMouseClickApply);
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,3),__onApplyPacks);
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,6),__onApplyEnable);
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
         if(_areaInfo)
         {
            _areaInfo.dispose();
            _areaInfo = null;
         }
         if(_areaInfoItem)
         {
            _areaInfoItem.dispose();
            _areaInfoItem = null;
         }
         if(_caption)
         {
            _caption.dispose();
            _caption = null;
         }
         if(_applyBtn)
         {
            _applyBtn.dispose();
            _applyBtn = null;
         }
      }
   }
}
