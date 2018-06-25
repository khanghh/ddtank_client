package catchInsect.view
{
   import catchInsect.CatchInsectManager;
   import catchInsect.componets.CatchInsectShopItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CatchInsectShopFrame extends BaseAlerFrame
   {
      
      public static const SHOP_ITEM_NUM:uint = 8;
       
      
      private var _goodItems:Vector.<CatchInsectShopItem>;
      
      private var _rightItemLightMc:MovieClip;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _goodItemContainerBg:Image;
      
      private var _navigationBarContainer:Sprite;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _currentPageInput:Scale9CornerImage;
      
      private var _scoreNumBG:Scale9CornerImage;
      
      private var _scoreText:FilterFrameText;
      
      private var _scoreNumText:FilterFrameText;
      
      private var _label:FilterFrameText;
      
      private var curPage:int = 1;
      
      public function CatchInsectShopFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         initView();
         initEvents();
         loadList();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var title:String = LanguageMgr.GetTranslation("catchInsect.shopFrameTitle");
         var alerInfo:AlertInfo = new AlertInfo(title,"",LanguageMgr.GetTranslation("tank.calendar.Activity.BackButtonText"));
         info = alerInfo;
         _goodItems = new Vector.<CatchInsectShopItem>();
         _rightItemLightMc = ComponentFactory.Instance.creatCustomObject("catchInsect.shopFrame.RightItemLightMc");
         _goodItemContainerAll = ComponentFactory.Instance.creatCustomObject("catchInsect.shopFrame.GoodItemContainerAll");
         _goodItemContainerBg = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.GoodItemContainerBg");
         _navigationBarContainer = ComponentFactory.Instance.creatCustomObject("catchInsect.shopFrame.navigationBarContainer");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.BtnPrePage");
         _navigationBarContainer.addChild(_prePageBtn);
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.BtnNextPage");
         _navigationBarContainer.addChild(_nextPageBtn);
         _currentPageInput = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.CurrentPageInput");
         _navigationBarContainer.addChild(_currentPageInput);
         _currentPageTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.pageTxt");
         _navigationBarContainer.addChild(_currentPageTxt);
         _scoreNumBG = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.coinBG");
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.scoreText");
         _scoreText.text = LanguageMgr.GetTranslation("magicStone.remainScore");
         _scoreNumText = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.scoreNumTxt");
         _scoreNumText.text = CatchInsectManager.instance.model.avaibleScore.toString();
         _label = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.label");
         addToContent(_goodItemContainerBg);
         addToContent(_goodItemContainerAll);
         addToContent(_navigationBarContainer);
         addToContent(_scoreNumBG);
         addToContent(_scoreText);
         addToContent(_scoreNumText);
         addToContent(_label);
         for(i = 0; i < 8; )
         {
            _goodItems[i] = new CatchInsectShopItem();
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
      }
      
      public function loadList() : void
      {
         setList(ShopManager.Instance.getValidSortedGoodsByType(getType(),curPage));
         SocketManager.Instance.out.updateRemainCount();
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
         _currentPageTxt.text = curPage + "/" + ShopManager.Instance.getResultPages(getType());
      }
      
      private function clearitems() : void
      {
         var i:int = 0;
         for(i = 0; i <= _goodItems.length - 1; )
         {
            _goodItems[i].shopItemInfo = null;
            i++;
         }
      }
      
      private function initEvents() : void
      {
         _prePageBtn.addEventListener("click",__pageBtnClick);
         _nextPageBtn.addEventListener("click",__pageBtnClick);
         CatchInsectManager.instance.addEventListener("updateInfo",__updateView);
      }
      
      protected function __updateView(event:Event) : void
      {
         var total:int = CatchInsectManager.instance.model.score;
         var avaible:int = CatchInsectManager.instance.model.avaibleScore;
         _scoreNumText.text = avaible.toString();
      }
      
      private function __pageBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ShopManager.Instance.getResultPages(getType()) == 0)
         {
            return;
         }
         var _loc2_:* = evt.currentTarget;
         if(_prePageBtn !== _loc2_)
         {
            if(_nextPageBtn === _loc2_)
            {
               if(curPage == ShopManager.Instance.getResultPages(getType()))
               {
                  curPage = 0;
               }
               curPage = Number(curPage) + 1;
            }
         }
         else
         {
            if(curPage == 1)
            {
               curPage = ShopManager.Instance.getResultPages(getType()) + 1;
            }
            curPage = Number(curPage) - 1;
         }
         loadList();
      }
      
      public function updateScore(num:int) : void
      {
         if(_scoreNumText)
         {
            _scoreNumText.text = num.toString();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvents() : void
      {
         _prePageBtn.removeEventListener("click",__pageBtnClick);
         _nextPageBtn.removeEventListener("click",__pageBtnClick);
         CatchInsectManager.instance.removeEventListener("updateInfo",__updateView);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         removeEvents();
         for(i = 0; i <= _goodItems.length - 1; )
         {
            ObjectUtils.disposeObject(_goodItems[i]);
            _goodItems[i] = null;
            i++;
         }
         ObjectUtils.disposeObject(_rightItemLightMc);
         _rightItemLightMc = null;
         ObjectUtils.disposeObject(_goodItemContainerAll);
         _goodItemContainerAll = null;
         ObjectUtils.disposeObject(_goodItemContainerBg);
         _goodItemContainerBg = null;
         ObjectUtils.disposeObject(_navigationBarContainer);
         _navigationBarContainer = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_currentPageTxt);
         _currentPageTxt = null;
         ObjectUtils.disposeObject(_currentPageInput);
         _currentPageInput = null;
         ObjectUtils.disposeObject(_scoreNumBG);
         _scoreNumBG = null;
         ObjectUtils.disposeObject(_scoreText);
         _scoreText = null;
         ObjectUtils.disposeObject(_scoreNumText);
         _scoreNumText = null;
         ObjectUtils.disposeObject(_label);
         _label = null;
         super.dispose();
      }
      
      public function getType() : int
      {
         return 102;
      }
   }
}
