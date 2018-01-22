package oldplayerintegralshop.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import oldplayerintegralshop.IntegralShopController;
   import road7th.comm.PackageIn;
   
   public class IntegralShopView extends Frame
   {
      
      private static const MAXNUM:int = 4;
       
      
      private var _bg:Bitmap;
      
      private var _infoText:FilterFrameText;
      
      private var _leaveNumText:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _integralNum:FilterFrameText;
      
      private var _callText:FilterFrameText;
      
      private var _foreBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _shopCellList:Vector.<IntegralShopCell>;
      
      private var _currentPage:int;
      
      private var _totlePage:int;
      
      private var _goodsInfoList:Vector.<ShopItemInfo>;
      
      private var _integralCom:Component;
      
      public function IntegralShopView()
      {
         super();
         initData();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.sendUpdateIntegral();
      }
      
      private function initData() : void
      {
         _goodsInfoList = ShopManager.Instance.getValidGoodByType(199);
         var _loc1_:int = _goodsInfoList.length;
         _totlePage = Math.ceil(_loc1_ / 4);
         _currentPage = 1;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         titleText = LanguageMgr.GetTranslation("IMView.integralShop.TitleText");
         _bg = ComponentFactory.Instance.creat("asset.integralShopView.viewBg");
         addToContent(_bg);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("integralShopView.infoText");
         _infoText.text = LanguageMgr.GetTranslation("integralShopView.info.Text");
         addToContent(_infoText);
         _leaveNumText = ComponentFactory.Instance.creatComponentByStylename("integralShopView.leaveNumText");
         addToContent(_leaveNumText);
         _callText = ComponentFactory.Instance.creatComponentByStylename("integralShopView.call");
         _callText.text = LanguageMgr.GetTranslation("integralShopView.callText");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("integralShopView.pageTxt");
         addToContent(_pageTxt);
         _foreBtn = ComponentFactory.Instance.creatComponentByStylename("integralShopView.foreBtn");
         addToContent(_foreBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("integralShopView.nextBtn");
         addToContent(_nextBtn);
         _shopCellList = new Vector.<IntegralShopCell>(4);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new IntegralShopCell();
            _loc1_.x = 16 + _loc2_ % 2 * (_loc1_.width + 3);
            _loc1_.y = 227 + int(_loc2_ / 2) * (_loc1_.height + 2);
            addToContent(_loc1_);
            _shopCellList[_loc2_] = _loc1_;
            _loc2_++;
         }
         refreshView();
         creatIntegralNum();
      }
      
      private function creatIntegralNum() : void
      {
         _integralNum = ComponentFactory.Instance.creatComponentByStylename("integralShopView.integralNum");
         _integralNum.text = "0";
         _integralCom = new Component();
         addToContent(_integralCom);
         _integralCom.width = _integralNum.width;
         _integralCom.height = _integralNum.height;
         PositionUtils.setPos(_integralCom,"integralShopView.integralNumPos");
         _integralCom.addChild(_integralNum);
         _integralCom.tipStyle = "ddt.view.tips.OneLineTip";
         _integralCom.tipDirctions = "7,2,5";
         _integralCom.tipData = LanguageMgr.GetTranslation("integralShopView.limitIntegralText",ServerConfigManager.instance.callScoreLimit);
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _pageTxt.text = _currentPage + "/" + _totlePage;
         var _loc1_:int = (_currentPage - 1) * 4;
         var _loc3_:int = _goodsInfoList.length;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc2_ = _loc1_ + _loc4_;
            if(_loc2_ >= _loc3_)
            {
               _shopCellList[_loc4_].visible = false;
            }
            else
            {
               _shopCellList[_loc4_].visible = true;
               _shopCellList[_loc4_].refreshShow(_goodsInfoList[_loc2_]);
            }
            _loc4_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _foreBtn.addEventListener("click",__changePageHandler);
         _nextBtn.addEventListener("click",__changePageHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(149,9),__onUpdateIntegral);
      }
      
      protected function __onUpdateIntegral(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _loc2_.readInt();
         IntegralShopController.instance.integralNum = _loc2_.readInt();
         _leaveNumText.text = LanguageMgr.GetTranslation("integralShopView.leaveNumText",_loc2_.readInt().toString() + "/" + ServerConfigManager.instance.oldPlayerShopBuyLimit.toString()) + "       " + LanguageMgr.GetTranslation("integralShopView.limitIntegralText",ServerConfigManager.instance.callScoreLimit);
         _integralNum.text = String(IntegralShopController.instance.integralNum);
      }
      
      private function __changePageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc3_:* = _loc2_;
         if(_foreBtn !== _loc3_)
         {
            if(_nextBtn === _loc3_)
            {
               if(_currentPage >= _totlePage)
               {
                  _currentPage = 1;
               }
               else
               {
                  _currentPage = Number(_currentPage) + 1;
               }
            }
         }
         else if(_currentPage <= 1)
         {
            _currentPage = _totlePage;
         }
         else
         {
            _currentPage = Number(_currentPage) - 1;
         }
         refreshView();
      }
      
      protected function __onAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertResponse);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
               SoundManager.instance.playButtonSound();
               _loc2_.dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _foreBtn.removeEventListener("click",__changePageHandler);
         _nextBtn.removeEventListener("click",__changePageHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,9),__onUpdateIntegral);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               IntegralShopController.instance.hide();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_infoText)
         {
            _infoText.dispose();
            _infoText = null;
         }
         if(_leaveNumText)
         {
            _leaveNumText.dispose();
            _leaveNumText = null;
         }
         if(_callText)
         {
            _callText.dispose();
            _callText = null;
         }
         if(_pageTxt)
         {
            _pageTxt.dispose();
            _pageTxt = null;
         }
         if(_integralNum)
         {
            _integralNum.dispose();
            _integralNum = null;
         }
         if(_nextBtn)
         {
            _nextBtn.dispose();
            _nextBtn = null;
         }
         if(_foreBtn)
         {
            _foreBtn.dispose();
            _foreBtn = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
