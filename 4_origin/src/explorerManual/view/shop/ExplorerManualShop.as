package explorerManual.view.shop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import explorerManual.ExplorerManualController;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class ExplorerManualShop extends Frame
   {
      
      private static const MAXNUM:int = 4;
       
      
      private var _ctrl:ExplorerManualController;
      
      private var _bg:Bitmap;
      
      private var _titleIcon:Bitmap;
      
      private var _descTxt:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _explorerNum:FilterFrameText;
      
      private var _explorerPointIcon:Bitmap;
      
      private var _explorerPointValaue:FilterFrameText;
      
      private var _manualTxt:FilterFrameText;
      
      private var _goodsInfoList:Vector.<ShopItemInfo>;
      
      private var _shopCellList:Vector.<ManualShopCell>;
      
      private var _totlePage:int;
      
      private var _currentPage:int;
      
      private var _foreBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _inputBg:Scale9CornerImage;
      
      private var _inputBg1:Scale9CornerImage;
      
      public function ExplorerManualShop(param1:ExplorerManualController)
      {
         _ctrl = param1;
         initData();
         super();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         initEvent();
      }
      
      private function initData() : void
      {
         _goodsInfoList = ShopManager.Instance.getValidGoodByType(109);
         var _loc1_:int = _goodsInfoList.length;
         _totlePage = Math.ceil(_loc1_ / 4);
         _currentPage = 1;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_response);
         _foreBtn.addEventListener("click",__changePageHandler);
         _nextBtn.addEventListener("click",__changePageHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChangeHandler);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_response);
         _foreBtn.removeEventListener("click",__changePageHandler);
         _nextBtn.removeEventListener("click",__changePageHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChangeHandler);
      }
      
      private function __propertyChangeHandler(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["jampsCurrency"])
         {
            updateJampsCurrency();
         }
      }
      
      private function updateJampsCurrency() : void
      {
         _explorerPointValaue.text = PlayerManager.Instance.Self.jampsCurrency.toString();
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
      
      override protected function init() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         super.init();
         titleText = LanguageMgr.GetTranslation("explorerManual.manualShop.titleTxt");
         _bg = ComponentFactory.Instance.creat("asset.explorerManual.shop.bgAsset");
         addToContent(_bg);
         _titleIcon = ComponentFactory.Instance.creat("asset.explorerManual.shop.exchangeShop.txtIcon");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("explorerManual.shop.descText");
         _descTxt.text = LanguageMgr.GetTranslation("explorerManual.shop.desc.text");
         _explorerNum = ComponentFactory.Instance.creatComponentByStylename("explorerManual.shop.explorerNum");
         _explorerNum.text = LanguageMgr.GetTranslation("explorerManual.shop.explorerNum");
         PositionUtils.setPos(_explorerNum,"explorerManual.manualShop.manualTxt.pos");
         _manualTxt = ComponentFactory.Instance.creatComponentByStylename("explorerManual.shop.explorerNum");
         _manualTxt.text = LanguageMgr.GetTranslation("explorerManual.shop.manualTxt");
         _explorerPointIcon = ComponentFactory.Instance.creat("asset.explorerManual.shop.explorerPoint.txtIcon");
         _explorerPointValaue = ComponentFactory.Instance.creatComponentByStylename("explorerManual.shop.explorerPointValue");
         _explorerPointValaue.text = "100";
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageTxt");
         _foreBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.foreBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.nextBtn");
         _inputBg = ComponentFactory.Instance.creat("explorerManual.inputBg");
         _inputBg1 = ComponentFactory.Instance.creat("explorerManual.inputBg");
         PositionUtils.setPos(_inputBg1,"explorerManual.manualShop.explorerValuepos");
         _shopCellList = new Vector.<ManualShopCell>(4);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new ManualShopCell();
            _loc1_.x = 24 + _loc2_ % 2 * (_loc1_.width + 3);
            _loc1_.y = 173 + int(_loc2_ / 2) * (_loc1_.height + 2);
            addToContent(_loc1_);
            _shopCellList[_loc2_] = _loc1_;
            _loc2_++;
         }
         updateJampsCurrency();
         refreshView();
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
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_titleIcon)
         {
            addToContent(_titleIcon);
         }
         if(_descTxt)
         {
            addToContent(_descTxt);
         }
         if(_explorerNum)
         {
            addToContent(_explorerNum);
         }
         if(_manualTxt)
         {
            addToContent(_manualTxt);
         }
         if(_foreBtn)
         {
            addToContent(_foreBtn);
         }
         if(_nextBtn)
         {
            addToContent(_nextBtn);
         }
         if(_explorerPointIcon)
         {
            addToContent(_explorerPointIcon);
         }
         if(_inputBg)
         {
            addToContent(_inputBg);
         }
         if(_inputBg1)
         {
            addToContent(_inputBg1);
         }
         if(_explorerPointValaue)
         {
            addToContent(_explorerPointValaue);
         }
         if(_pageTxt)
         {
            addToContent(_pageTxt);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_manualTxt);
         _manualTxt = null;
         ObjectUtils.disposeObject(_titleIcon);
         _titleIcon = null;
         ObjectUtils.disposeObject(_explorerNum);
         _explorerNum = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_foreBtn);
         _foreBtn = null;
         while(_shopCellList && _shopCellList.length > 0)
         {
            ObjectUtils.disposeObject(_shopCellList.shift());
         }
         _shopCellList = null;
         _goodsInfoList = null;
         _ctrl = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
