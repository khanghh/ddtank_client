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
      
      private var _getMoney:FilterFrameText;
      
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
         _getMoney = ComponentFactory.Instance.creatComponentByStylename("regress.getDemand");
         _getMoney.text = "0";
         PositionUtils.setPos(_getMoney,"regress.area.getMoney.pos");
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
         addToContent(_getMoney);
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
         SocketManager.Instance.addEventListener(PkgEvent.format(149,17),__getNewAreaMoney);
      }
      
      protected function __onMouseClickApply(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.sendRegressApllyPacks();
      }
      
      protected function __onApplyPacks(event:CrazyTankSocketEvent) : void
      {
         var num:int = 0;
         var pkg:PackageIn = event.pkg;
         if(pkg.bytesAvailable > 0)
         {
            num = pkg.readInt();
            if(num == 1)
            {
               RegressManager.isApplyEnable = false;
               _applyBtn.enable = false;
            }
         }
      }
      
      protected function __getNewAreaMoney(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _getMoney.text = String(pkg.readInt()) + LanguageMgr.GetTranslation("tank.oldPlayer.bindMoney");
      }
      
      protected function __onApplyEnable(event:CrazyTankSocketEvent) : void
      {
         var num:int = 0;
         var pkg:PackageIn = event.pkg;
         if(pkg.bytesAvailable > 0)
         {
            num = pkg.readInt();
            if(num == 1)
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
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,17),__getNewAreaMoney);
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
         if(_getMoney)
         {
            _getMoney.dispose();
            _getMoney = null;
         }
         if(_applyBtn)
         {
            _applyBtn.dispose();
            _applyBtn = null;
         }
      }
   }
}
