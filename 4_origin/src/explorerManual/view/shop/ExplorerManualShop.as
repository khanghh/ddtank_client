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
      
      public function ExplorerManualShop(ctrl:ExplorerManualController)
      {
         _ctrl = ctrl;
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
         var tmpLen:int = _goodsInfoList.length;
         _totlePage = Math.ceil(tmpLen / 4);
         _currentPage = 1;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_response);
         _foreBtn.addEventListener("click",__changePageHandler);
         _nextBtn.addEventListener("click",__changePageHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChangeHandler);
      }
      
      private function _response(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1)
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
      
      private function __propertyChangeHandler(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["jampsCurrency"])
         {
            updateJampsCurrency();
         }
      }
      
      private function updateJampsCurrency() : void
      {
         _explorerPointValaue.text = PlayerManager.Instance.Self.jampsCurrency.toString();
      }
      
      private function __changePageHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var tmp:SimpleBitmapButton = event.currentTarget as SimpleBitmapButton;
         var _loc3_:* = tmp;
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
         var tmpCell:* = null;
         var i:int = 0;
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
         for(i = 0; i < 4; )
         {
            tmpCell = new ManualShopCell();
            tmpCell.x = 24 + i % 2 * (tmpCell.width + 3);
            tmpCell.y = 173 + int(i / 2) * (tmpCell.height + 2);
            addToContent(tmpCell);
            _shopCellList[i] = tmpCell;
            i++;
         }
         updateJampsCurrency();
         refreshView();
      }
      
      private function refreshView() : void
      {
         var i:int = 0;
         var tmpTag:int = 0;
         _pageTxt.text = _currentPage + "/" + _totlePage;
         var startIndex:int = (_currentPage - 1) * 4;
         var tmpCount:int = _goodsInfoList.length;
         for(i = 0; i < 4; )
         {
            tmpTag = startIndex + i;
            if(tmpTag >= tmpCount)
            {
               _shopCellList[i].visible = false;
            }
            else
            {
               _shopCellList[i].visible = true;
               _shopCellList[i].refreshShow(_goodsInfoList[tmpTag]);
            }
            i++;
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
