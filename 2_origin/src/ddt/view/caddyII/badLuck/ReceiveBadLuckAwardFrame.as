package ddt.view.caddyII.badLuck
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.InventoryItemAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   
   public class ReceiveBadLuckAwardFrame extends BaseAlerFrame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _bg2:MutipleImage;
      
      private var _bg3:MutipleImage;
      
      private var _bg6:Bitmap;
      
      private var _bg7:Bitmap;
      
      private var _titleBit:Bitmap;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _itemList:Vector.<ReceiveBadLuckItem>;
      
      private var _goodList:Vector.<InventoryItemInfo>;
      
      private var _dataList:Vector.<Object>;
      
      private var _rankingText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _propertyText:FilterFrameText;
      
      private var _regulationText1:FilterFrameText;
      
      private var _regulationText2:FilterFrameText;
      
      private var _regulationText3:FilterFrameText;
      
      private var _regulationText4:FilterFrameText;
      
      public function ReceiveBadLuckAwardFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.title = LanguageMgr.GetTranslation("tank.ReceiveBadLuckAwardFrame.title");
         _loc1_.submitLabel = LanguageMgr.GetTranslation("ok");
         _loc1_.showCancel = false;
         info = _loc1_;
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.RBadLuckBGI");
         _titleBit = ComponentFactory.Instance.creatBitmap("asset.RBadLuck.FontTitle");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("caddy.RBadLuckBGII");
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("caddy.RBadLuckBGIII");
         _bg6 = ComponentFactory.Instance.creatBitmap("asset.RBadLuck.FontR");
         _bg7 = ComponentFactory.Instance.creatBitmap("asset.RBadLuck.FontRbadEx");
         _rankingText = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.rankingText");
         _rankingText.text = LanguageMgr.GetTranslation("caddy.badLuck.rankingText。text");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.nameText");
         _nameText.text = LanguageMgr.GetTranslation("caddy.badLuck.nameText.text");
         _propertyText = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.propertyText");
         _propertyText.text = LanguageMgr.GetTranslation("caddy.badLuck.propertyText.text");
         _regulationText1 = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.regulationText1");
         _regulationText1.text = LanguageMgr.GetTranslation("caddy.badLuck.regulationText1.text");
         _regulationText2 = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.regulationText2");
         _regulationText2.text = LanguageMgr.GetTranslation("caddy.badLuck.regulationText2.text");
         _regulationText3 = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.regulationText3");
         _regulationText3.text = LanguageMgr.GetTranslation("caddy.badLuck.regulationText3.text");
         _regulationText4 = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.regulationText4");
         _regulationText4.text = LanguageMgr.GetTranslation("caddy.badLuck.regulationText4.text");
         addToContent(_bg);
         addToContent(_titleBit);
         addToContent(_bg2);
         addToContent(_bg3);
         addToContent(_bg6);
         addToContent(_bg7);
         addToContent(_rankingText);
         addToContent(_nameText);
         addToContent(_propertyText);
         addToContent(_regulationText1);
         addToContent(_regulationText2);
         addToContent(_regulationText3);
         addToContent(_regulationText4);
         _list = ComponentFactory.Instance.creatComponentByStylename("caddy.RbadLuckBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("caddy.RbadLuckScrollpanel");
         _panel.setView(_list);
         _panel.invalidateViewport();
         addToContent(_panel);
         _itemList = new Vector.<ReceiveBadLuckItem>();
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("card.ReceiveBadLuckItem");
            _list.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc3_++;
         }
         _panel.invalidateViewport();
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
      }
      
      private function creatItemTempleteLoader() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("User_LotteryRank.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsTemplateFailure");
         _loc1_.analyzer = new InventoryItemAnalyzer(__loadComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
         return _loc1_;
      }
      
      private function __loadComplete(param1:InventoryItemAnalyzer) : void
      {
         _goodList = param1.list;
         RouletteManager.instance.goodList = param1.list;
         updateData();
      }
      
      private function updateData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc6_:int = 0;
         var _loc5_:* = _goodList;
         for each(var _loc4_ in _goodList)
         {
            _loc4_.BeginDate = _loc2_.fullYear + "-" + (_loc2_.month + 1) + "-" + _loc2_.date + " " + _loc2_.hours + ":" + _loc2_.minutes + ":" + _loc2_.seconds;
         }
         _loc3_ = 0;
         while(_loc3_ < 10 && _loc3_ < _goodList.length)
         {
            if(_dataList == null || _loc3_ >= _dataList.length || _dataList[_loc3_] == null)
            {
               _loc1_ = "MyName";
            }
            else
            {
               _loc1_ = _dataList[_loc3_].Nickname;
            }
            _itemList[_loc3_].update(_loc3_,_loc1_,_goodList[_loc3_]);
            _loc3_++;
         }
      }
      
      private function __response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 1 || param1.responseCode == 0 || param1.responseCode == 3)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      public function set dataList(param1:Vector.<Object>) : void
      {
         _dataList = param1;
      }
      
      public function show() : void
      {
         if(RouletteManager.instance.goodList == null)
         {
            creatItemTempleteLoader();
         }
         else
         {
            _goodList = RouletteManager.instance.goodList;
            updateData();
         }
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_bg2)
         {
            ObjectUtils.disposeObject(_bg2);
         }
         _bg2 = null;
         if(_bg3)
         {
            ObjectUtils.disposeObject(_bg3);
         }
         _bg3 = null;
         if(_bg6)
         {
            ObjectUtils.disposeObject(_bg6);
         }
         _bg6 = null;
         if(_bg7)
         {
            ObjectUtils.disposeObject(_bg7);
         }
         _bg7 = null;
         if(_titleBit)
         {
            ObjectUtils.disposeObject(_titleBit);
         }
         _titleBit = null;
         if(_rankingText)
         {
            ObjectUtils.disposeObject(_rankingText);
         }
         _rankingText = null;
         if(_nameText)
         {
            ObjectUtils.disposeObject(_nameText);
         }
         _nameText = null;
         if(_propertyText)
         {
            ObjectUtils.disposeObject(_propertyText);
         }
         _propertyText = null;
         if(_regulationText1)
         {
            ObjectUtils.disposeObject(_regulationText1);
         }
         _regulationText1 = null;
         if(_regulationText2)
         {
            ObjectUtils.disposeObject(_regulationText2);
         }
         _regulationText2 = null;
         if(_regulationText3)
         {
            ObjectUtils.disposeObject(_regulationText3);
         }
         _regulationText3 = null;
         if(_regulationText4)
         {
            ObjectUtils.disposeObject(_regulationText4);
         }
         _regulationText4 = null;
         var _loc3_:int = 0;
         var _loc2_:* = _itemList;
         for each(var _loc1_ in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
