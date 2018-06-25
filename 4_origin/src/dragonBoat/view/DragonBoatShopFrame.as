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
         var tmpLen:int = _goodsInfoList.length;
         _totlePage = Math.ceil(tmpLen / 8);
         _currentPage = 1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmpCell:* = null;
         var alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.dragonBoat.shopTitleTxt"),"",LanguageMgr.GetTranslation("tank.calendar.Activity.BackButtonText"),false);
         alertInfo.moveEnable = false;
         alertInfo.autoDispose = false;
         alertInfo.sound = "008";
         info = alertInfo;
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
         for(i = 0; i < 8; )
         {
            tmpCell = new DragonBoatShopCell();
            tmpCell.x = 10 + i % 2 * (tmpCell.width + 6);
            tmpCell.y = 15 + int(i / 2) * (tmpCell.height + 5);
            addToContent(tmpCell);
            _shopCellList[i] = tmpCell;
            i++;
         }
         refreshView();
      }
      
      private function refreshShopView() : void
      {
         var i:int = 0;
         var tmpTag:int = 0;
         _pageTxt.text = _currentPage + "/" + _totlePage;
         var startIndex:int = (_currentPage - 1) * 8;
         var tmpCount:int = _goodsInfoList.length;
         for(i = 0; i < 8; )
         {
            tmpTag = startIndex + i;
            if(tmpTag >= tmpCount)
            {
               _shopCellList[i].refreshShow(null);
            }
            else
            {
               _shopCellList[i].refreshShow(_goodsInfoList[tmpTag]);
            }
            i++;
         }
      }
      
      private function refreshView(event:Event = null) : void
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
      
      private function changePageHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var tmp:SimpleBitmapButton = event.currentTarget as SimpleBitmapButton;
         var _loc3_:* = tmp;
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
      
      private function responseHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
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
