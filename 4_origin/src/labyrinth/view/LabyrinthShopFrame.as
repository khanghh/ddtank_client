package labyrinth.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LabyrinthShopFrame extends BaseAlerFrame
   {
      
      public static const SHOP_ITEM_NUM:uint = 8;
      
      public static var CURRENT_MONEY_TYPE:int = 1;
       
      
      private var CURRENT_PAGE:int = 1;
      
      private var _goodItems:Vector.<LabyrinthShopItem>;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _rightItemLightMc:MovieClip;
      
      protected var _goodItemContainerBg:Image;
      
      private var _firstPage:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _endPageBtn:BaseButton;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _currentPageInput:Scale9CornerImage;
      
      private var _navigationBarContainer:Sprite;
      
      private var _coinNumBG:Scale9CornerImage;
      
      private var _coinText:FilterFrameText;
      
      private var _coinNumText:FilterFrameText;
      
      private var _lable:FilterFrameText;
      
      public function LabyrinthShopFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         var title:* = null;
         var descript:* = null;
         var coinTxt:* = null;
         var coinNum:* = null;
         var i:int = 0;
         var dx:Number = NaN;
         var dy:Number = NaN;
         super.init();
         if(BuriedManager.Instance.isOpening)
         {
            title = LanguageMgr.GetTranslation("buried.alertInfo.shopTitle");
            descript = LanguageMgr.GetTranslation("buried.alertInfo.ligthStoneOver.text2");
            coinTxt = LanguageMgr.GetTranslation("buried.alertInfo.LabyrinthShopFrame.text1");
            coinNum = BuriedManager.Instance.getBuriedStoneNum();
         }
         else
         {
            title = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthShopFrame.title");
            descript = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthShopFrame.text2");
            coinTxt = LanguageMgr.GetTranslation("dt.labyrinth.LabyrinthShopFrame.text1");
            coinNum = PlayerManager.Instance.Self.hardCurrency.toString();
         }
         var alerInfo:AlertInfo = new AlertInfo(title,"",LanguageMgr.GetTranslation("tank.calendar.Activity.BackButtonText"));
         info = alerInfo;
         _goodItems = new Vector.<LabyrinthShopItem>();
         _rightItemLightMc = ComponentFactory.Instance.creatCustomObject("labyrinth.LabyrinthShopFrame.RightItemLightMc");
         _goodItemContainerAll = ComponentFactory.Instance.creatCustomObject("labyrinth.LabyrinthShopFrame.GoodItemContainerAll");
         _goodItemContainerBg = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthShopFrame.GoodItemContainerBg");
         _navigationBarContainer = ComponentFactory.Instance.creatCustomObject("labyrinth.LabyrinthShopFrame.navigationBarContainer");
         _prePageBtn = UICreatShortcut.creatAndAdd("ddtshop.BtnPrePage",_navigationBarContainer);
         _nextPageBtn = UICreatShortcut.creatAndAdd("ddtshop.BtnNextPage",_navigationBarContainer);
         _currentPageInput = UICreatShortcut.creatAndAdd("ddtshop.CurrentPageInput",_navigationBarContainer);
         _currentPageTxt = UICreatShortcut.creatAndAdd("ddtshop.CurrentPage",_navigationBarContainer);
         _coinNumBG = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthShopFrame.coinBG");
         _coinText = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthShopFrame.coinText");
         _coinText.text = coinTxt;
         _coinNumText = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthShopFrame.coinNumText");
         _coinNumText.text = coinNum;
         _lable = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthShopFrame.lable");
         _lable.text = descript;
         addToContent(_goodItemContainerBg);
         addToContent(_goodItemContainerAll);
         addToContent(_navigationBarContainer);
         addToContent(_coinNumBG);
         addToContent(_coinText);
         addToContent(_coinNumText);
         addToContent(_lable);
         for(i = 0; i < 8; )
         {
            _goodItems[i] = ComponentFactory.Instance.creatCustomObject("labyrinth.view.labyrinthShopItem");
            dx = _goodItems[i].width;
            dy = _goodItems[i].height;
            dx = dx * (int(i % 2));
            dy = dy * (int(i / 2));
            _goodItems[i].x = dx;
            _goodItems[i].y = dy + i / 2 * 2;
            _goodItemContainerAll.addChild(_goodItems[i]);
            _goodItems[i].setItemLight(_rightItemLightMc);
            i++;
         }
         loadList();
         initEvent();
      }
      
      private function initEvent() : void
      {
         _prePageBtn.addEventListener("click",__pageBtnClick);
         _nextPageBtn.addEventListener("click",__pageBtnClick);
         BuriedManager.Instance.addEventListener("buried_UpDate_Stone_Count",upDateStoneHander);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onUpdate);
      }
      
      private function upDateStoneHander(e:BuriedEvent) : void
      {
         if(BuriedManager.Instance.isOpening)
         {
            _coinNumText.text = BuriedManager.Instance.getBuriedStoneNum();
         }
      }
      
      public function removeEvent() : void
      {
         BuriedManager.Instance.removeEventListener("buried_UpDate_Stone_Count",upDateStoneHander);
         _prePageBtn.removeEventListener("click",__pageBtnClick);
         _nextPageBtn.removeEventListener("click",__pageBtnClick);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onUpdate);
      }
      
      protected function __onUpdate(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["hardCurrency"] == true)
         {
            _coinNumText.text = PlayerManager.Instance.Self.hardCurrency.toString();
         }
      }
      
      private function clearitems() : void
      {
         var i:int = 0;
         for(i = 0; i < 8; )
         {
            _goodItems[i].shopItemInfo = null;
            i++;
         }
      }
      
      public function loadList() : void
      {
         setList(ShopManager.Instance.getValidSortedGoodsByType(getType(),CURRENT_PAGE));
      }
      
      public function setList(list:Vector.<ShopItemInfo>) : void
      {
         var i:int = 0;
         clearitems();
         for(i = 0; i < 8; )
         {
            _goodItems[i].selected = false;
            if(list)
            {
               if(i < list.length && list[i])
               {
                  _goodItems[i].shopItemInfo = list[i];
               }
               i++;
               continue;
            }
            break;
         }
         _currentPageTxt.text = CURRENT_PAGE + "/" + ShopManager.Instance.getResultPages(getType());
      }
      
      private function __pageBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ShopManager.Instance.getResultPages(getType()) == 0)
         {
            return;
         }
         var _loc2_:* = evt.currentTarget;
         if(_firstPage !== _loc2_)
         {
            if(_prePageBtn !== _loc2_)
            {
               if(_nextPageBtn !== _loc2_)
               {
                  if(_endPageBtn === _loc2_)
                  {
                     if(CURRENT_PAGE != ShopManager.Instance.getResultPages(getType()))
                     {
                        CURRENT_PAGE = ShopManager.Instance.getResultPages(getType());
                     }
                  }
               }
               else
               {
                  if(CURRENT_PAGE == ShopManager.Instance.getResultPages(getType()))
                  {
                     CURRENT_PAGE = 0;
                  }
                  CURRENT_PAGE = Number(CURRENT_PAGE) + 1;
               }
            }
            else
            {
               if(CURRENT_PAGE == 1)
               {
                  CURRENT_PAGE = ShopManager.Instance.getResultPages(getType()) + 1;
               }
               CURRENT_PAGE = Number(CURRENT_PAGE) - 1;
            }
         }
         else if(CURRENT_PAGE != 1)
         {
            CURRENT_PAGE = 1;
         }
         loadList();
      }
      
      public function getType() : int
      {
         return 94;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function disposeItems() : void
      {
         var i:int = 0;
         for(i = 0; i < _goodItems.length; )
         {
            ObjectUtils.disposeObject(_goodItems[i]);
            _goodItems[i] = null;
            i++;
         }
         _goodItems = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         disposeItems();
         ObjectUtils.disposeObject(_goodItemContainerAll);
         _goodItemContainerAll = null;
         ObjectUtils.disposeObject(_rightItemLightMc);
         _rightItemLightMc = null;
         ObjectUtils.disposeObject(_goodItemContainerBg);
         _goodItemContainerBg = null;
         ObjectUtils.disposeObject(_firstPage);
         _firstPage = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_endPageBtn);
         _endPageBtn = null;
         ObjectUtils.disposeObject(_currentPageTxt);
         _currentPageTxt = null;
         ObjectUtils.disposeObject(_currentPageInput);
         _currentPageInput = null;
         ObjectUtils.disposeObject(_navigationBarContainer);
         _navigationBarContainer = null;
         ObjectUtils.disposeObject(_coinNumBG);
         _coinNumBG = null;
         ObjectUtils.disposeObject(_coinText);
         _coinText = null;
         ObjectUtils.disposeObject(_coinNumText);
         _coinNumText = null;
         ObjectUtils.disposeObject(_lable);
         _lable = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
