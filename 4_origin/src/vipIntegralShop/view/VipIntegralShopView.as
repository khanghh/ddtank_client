package vipIntegralShop.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import vipIntegralShop.VipIntegralShopController;
   import vipIntegralShop.data.VipIntegralShopInfo;
   
   public class VipIntegralShopView extends Frame
   {
      
      private static const MAXNUM:int = 4;
       
      
      private var _bg:Bitmap;
      
      private var _infoText:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _integralNum:FilterFrameText;
      
      private var _callText:FilterFrameText;
      
      private var _foreBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _shopCellList:Vector.<VipIntegralShopCell>;
      
      private var _currentPage:int;
      
      private var _totlePage:int;
      
      public function VipIntegralShopView()
      {
         super();
         initData();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function initData() : void
      {
         var _loc1_:int = VipIntegralShopController.instance.goodsInfoList.length;
         _totlePage = Math.ceil(_loc1_ / 4);
         _currentPage = 1;
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.getVipIntegralShopLimit();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         titleText = LanguageMgr.GetTranslation("vipIntegralShopView.titleText");
         _bg = ComponentFactory.Instance.creat("asset.vipIntegralShopView.viewBg");
         addToContent(_bg);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.infoText");
         _infoText.text = LanguageMgr.GetTranslation("vipIntegralShopView.info.Text");
         addToContent(_infoText);
         _callText = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.call");
         _callText.text = LanguageMgr.GetTranslation("vipIntegralShopView.callText");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.pageTxt");
         addToContent(_pageTxt);
         _foreBtn = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.foreBtn");
         addToContent(_foreBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.nextBtn");
         addToContent(_nextBtn);
         _integralNum = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.integralNum");
         _integralNum.text = PlayerManager.Instance.Self.VipIntegral.toString();
         addToContent(_integralNum);
         _shopCellList = new Vector.<VipIntegralShopCell>(4);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new VipIntegralShopCell();
            _loc1_.x = 16 + _loc2_ % 2 * (_loc1_.width + 3);
            _loc1_.y = 227 + int(_loc2_ / 2) * (_loc1_.height + 2);
            addToContent(_loc1_);
            _shopCellList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _foreBtn.addEventListener("click",__changePageHandler);
         _nextBtn.addEventListener("click",__changePageHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onUpdatePlayerProperty);
      }
      
      protected function __onUpdatePlayerProperty(param1:PlayerPropertyEvent) : void
      {
         _integralNum.text = PlayerManager.Instance.Self.VipIntegral.toString();
      }
      
      public function refreshView() : void
      {
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _pageTxt.text = _currentPage + "/" + _totlePage;
         var _loc2_:int = (_currentPage - 1) * 4;
         var _loc4_:int = VipIntegralShopController.instance.goodsInfoList.length;
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            _loc3_ = _loc2_ + _loc5_;
            if(_loc3_ >= _loc4_)
            {
               _shopCellList[_loc5_].visible = false;
            }
            else
            {
               _shopCellList[_loc5_].visible = true;
               _loc1_ = VipIntegralShopController.instance.goodsInfoList[_loc3_];
               _shopCellList[_loc5_].refreshShow(_loc1_);
            }
            _loc5_++;
         }
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
         sendPkg();
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
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _foreBtn.removeEventListener("click",__changePageHandler);
         _nextBtn.removeEventListener("click",__changePageHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onUpdatePlayerProperty);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               VipIntegralShopController.instance.hide();
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
