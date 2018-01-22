package magicStone.views
{
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
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import magicStone.MagicStoneControl;
   import magicStone.components.MagicStoneShopItem;
   import road7th.comm.PackageIn;
   
   public class MagicStoneShopFrame extends BaseAlerFrame
   {
      
      public static const SHOP_ITEM_NUM:uint = 8;
       
      
      private var _goodItems:Vector.<MagicStoneShopItem>;
      
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
      
      public function MagicStoneShopFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         MagicStoneControl.instance.shopFrame = this;
         initView();
         initEvents();
         loadList();
      }
      
      private function initView() : void
      {
         var _loc5_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:String = LanguageMgr.GetTranslation("magicStone.shopFrameTitle");
         var _loc4_:AlertInfo = new AlertInfo(_loc1_,"",LanguageMgr.GetTranslation("tank.calendar.Activity.BackButtonText"));
         info = _loc4_;
         _goodItems = new Vector.<MagicStoneShopItem>();
         _rightItemLightMc = ComponentFactory.Instance.creatCustomObject("magicStone.shopFrame.RightItemLightMc");
         _goodItemContainerAll = ComponentFactory.Instance.creatCustomObject("magicStone.shopFrame.GoodItemContainerAll");
         _goodItemContainerBg = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.GoodItemContainerBg");
         _navigationBarContainer = ComponentFactory.Instance.creatCustomObject("magicStone.shopFrame.navigationBarContainer");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.BtnPrePage");
         _navigationBarContainer.addChild(_prePageBtn);
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.BtnNextPage");
         _navigationBarContainer.addChild(_nextPageBtn);
         _currentPageInput = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.CurrentPageInput");
         _navigationBarContainer.addChild(_currentPageInput);
         _currentPageTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.pageTxt");
         _navigationBarContainer.addChild(_currentPageTxt);
         _scoreNumBG = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.coinBG");
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.scoreText");
         _scoreText.text = LanguageMgr.GetTranslation("magicStone.remainScore");
         _scoreNumText = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.scoreNumTxt");
         _scoreNumText.text = MagicStoneControl.instance.mgStoneScore.toString();
         _label = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.label");
         _label.text = LanguageMgr.GetTranslation("magicStone.onlyBindedCanBuy");
         addToContent(_goodItemContainerBg);
         addToContent(_goodItemContainerAll);
         addToContent(_navigationBarContainer);
         addToContent(_scoreNumBG);
         addToContent(_scoreText);
         addToContent(_scoreNumText);
         addToContent(_label);
         _loc5_ = 0;
         while(_loc5_ < 8)
         {
            _goodItems[_loc5_] = new MagicStoneShopItem();
            _loc2_ = _goodItems[_loc5_].width;
            _loc3_ = _goodItems[_loc5_].height;
            _loc2_ = _loc2_ * (int(_loc5_ % 2));
            _loc3_ = _loc3_ * (int(_loc5_ / 2));
            _goodItems[_loc5_].x = _loc2_;
            _goodItems[_loc5_].y = _loc3_ + _loc5_ / 2 * 2;
            _goodItemContainerAll.addChild(_goodItems[_loc5_]);
            _goodItems[_loc5_].setItemLight(_rightItemLightMc);
            _loc5_++;
         }
      }
      
      public function loadList() : void
      {
         setList(ShopManager.Instance.getValidSortedGoodsByType(getType(),curPage));
         SocketManager.Instance.out.updateRemainCount();
      }
      
      public function setList(param1:Vector.<ShopItemInfo>) : void
      {
         var _loc2_:int = 0;
         clearitems();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _goodItems[_loc2_].selected = false;
            if(param1)
            {
               if(_loc2_ < param1.length && param1[_loc2_])
               {
                  _goodItems[_loc2_].shopItemInfo = param1[_loc2_];
               }
               _loc2_++;
               continue;
            }
            break;
         }
         _currentPageTxt.text = curPage + "/" + ShopManager.Instance.getResultPages(getType());
      }
      
      private function clearitems() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ <= _goodItems.length - 1)
         {
            _goodItems[_loc1_].shopItemInfo = null;
            _loc1_++;
         }
      }
      
      private function initEvents() : void
      {
         _prePageBtn.addEventListener("click",__pageBtnClick);
         _nextPageBtn.addEventListener("click",__pageBtnClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(258,16),__updateRemainCount);
      }
      
      protected function __updateRemainCount(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         _loc5_ = 0;
         while(_loc5_ <= _goodItems.length - 1)
         {
            _loc3_ = _goodItems[_loc5_];
            if(_loc3_.shopItemInfo && _loc3_.shopItemInfo.TemplateInfo.Property3 == "0")
            {
               _loc3_.setRemainCount(_loc2_);
            }
            _loc5_++;
         }
      }
      
      private function __pageBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ShopManager.Instance.getResultPages(getType()) == 0)
         {
            return;
         }
         var _loc2_:* = param1.currentTarget;
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
      
      public function updateScore(param1:int) : void
      {
         if(_scoreNumText)
         {
            _scoreNumText.text = param1.toString();
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
         SocketManager.Instance.removeEventListener(PkgEvent.format(258,16),__updateRemainCount);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         MagicStoneControl.instance.shopFrame = null;
         removeEvents();
         _loc1_ = 0;
         while(_loc1_ <= _goodItems.length - 1)
         {
            ObjectUtils.disposeObject(_goodItems[_loc1_]);
            _goodItems[_loc1_] = null;
            _loc1_++;
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
         return 101;
      }
   }
}
