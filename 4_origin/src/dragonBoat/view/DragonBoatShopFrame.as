package dragonBoat.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import dragonBoat.DragonBoatManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DragonBoatShopFrame extends BaseAlerFrame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _coinText:FilterFrameText;
      
      private var _coinNumBG:Scale9CornerImage;
      
      private var _coinNumText:FilterFrameText;
      
      private var _lable:FilterFrameText;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _shopCellList:Vector.<DragonBoatShopCell>;
      
      private var _currentPage:int;
      
      private var _totlePage:int;
      
      private var _goodsInfoList:Vector.<ShopItemInfo>;
      
      private var activeId:int;
      
      public function DragonBoatShopFrame()
      {
         super();
         activeId = DragonBoatManager.instance.activeInfo.ActiveID;
         switch(int(activeId) - 1)
         {
            case 0:
               _goodsInfoList = ShopManager.Instance.getValidGoodByType(95);
               break;
            default:
               _goodsInfoList = ShopManager.Instance.getValidGoodByType(95);
               break;
            default:
               _goodsInfoList = ShopManager.Instance.getValidGoodByType(95);
               break;
            case 3:
               _goodsInfoList = ShopManager.Instance.getValidGoodByType(95);
               break;
            default:
               _goodsInfoList = ShopManager.Instance.getValidGoodByType(95);
               break;
            case 5:
               _goodsInfoList = ShopManager.Instance.getValidGoodByType(103);
               break;
            case 6:
               _goodsInfoList = ShopManager.Instance.getValidGoodByType(106);
               break;
            case 7:
               _goodsInfoList = ShopManager.Instance.getValidGoodByType(108);
         }
         var _loc1_:int = _goodsInfoList.length;
         _totlePage = Math.ceil(_loc1_ / 8);
         _currentPage = 1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.dragonBoat.shopTitleTxt"),"",LanguageMgr.GetTranslation("tank.calendar.Activity.BackButtonText"),false);
         _loc3_.moveEnable = false;
         _loc3_.autoDispose = false;
         _loc3_.sound = "008";
         info = _loc3_;
         _bg = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.bg");
         _coinText = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.coinTxt");
         _coinText.text = LanguageMgr.GetTranslation("ddt.dragonBoat.shopCoinTxt");
         _coinNumBG = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.coinBg");
         _coinNumText = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.coinNumTxt");
         _lable = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.labelTxt");
         _lable.text = LanguageMgr.GetTranslation("ddt.dragonBoat.shopPromptTxt");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.pageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.coinNumTxt");
         PositionUtils.setPos(_pageTxt,"dragonBoat.shopFrame.pageTxtPos");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.nextBtn");
         addToContent(_bg);
         addToContent(_coinText);
         addToContent(_coinNumBG);
         addToContent(_coinNumText);
         addToContent(_lable);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         _shopCellList = new Vector.<DragonBoatShopCell>(8);
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new DragonBoatShopCell();
            _loc1_.x = 10 + _loc2_ % 2 * (_loc1_.width + 6);
            _loc1_.y = 15 + int(_loc2_ / 2) * (_loc1_.height + 5);
            addToContent(_loc1_);
            _shopCellList[_loc2_] = _loc1_;
            _loc2_++;
         }
         refreshView();
      }
      
      private function refreshShopView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _pageTxt.text = _currentPage + "/" + _totlePage;
         var _loc1_:int = (_currentPage - 1) * 8;
         var _loc3_:int = _goodsInfoList.length;
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = _loc1_ + _loc4_;
            if(_loc2_ >= _loc3_)
            {
               _shopCellList[_loc4_].refreshShow(null);
            }
            else
            {
               _shopCellList[_loc4_].refreshShow(_goodsInfoList[_loc2_]);
            }
            _loc4_++;
         }
      }
      
      private function refreshView(param1:Event = null) : void
      {
         refreshShopView();
         refreshMoneyTxt();
      }
      
      private function refreshMoneyTxt() : void
      {
         _coinNumText.text = DragonBoatManager.instance.useableScore.toString();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler,false,0,true);
         _preBtn.addEventListener("click",changePageHandler,false,0,true);
         _nextBtn.addEventListener("click",changePageHandler,false,0,true);
         DragonBoatManager.instance.addEventListener("DragonBoatBuildOrDecorateUpdate",refreshView);
      }
      
      private function changePageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc3_:* = _loc2_;
         if(_preBtn !== _loc3_)
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
         refreshShopView();
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         _preBtn.removeEventListener("click",changePageHandler);
         _nextBtn.removeEventListener("click",changePageHandler);
         DragonBoatManager.instance.removeEventListener("DragonBoatBuildOrDecorateUpdate",refreshView);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _goodsInfoList = null;
         _shopCellList = null;
         _bg = null;
         _coinText = null;
         _coinNumBG = null;
         _coinNumText = null;
         _lable = null;
         _pageBg = null;
         _pageTxt = null;
         _preBtn = null;
         _nextBtn = null;
      }
   }
}
