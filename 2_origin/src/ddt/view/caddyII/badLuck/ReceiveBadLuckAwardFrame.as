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
         var i:int = 0;
         var item:* = null;
         var alerInfo:AlertInfo = new AlertInfo();
         alerInfo.title = LanguageMgr.GetTranslation("tank.ReceiveBadLuckAwardFrame.title");
         alerInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         alerInfo.showCancel = false;
         info = alerInfo;
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
         for(i = 0; i < 10; )
         {
            item = ComponentFactory.Instance.creatCustomObject("card.ReceiveBadLuckItem");
            _list.addChild(item);
            _itemList.push(item);
            i++;
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
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("User_LotteryRank.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingGoodsTemplateFailure");
         loader.analyzer = new InventoryItemAnalyzer(__loadComplete);
         LoadResourceManager.Instance.startLoad(loader);
         return loader;
      }
      
      private function __loadComplete(action:InventoryItemAnalyzer) : void
      {
         _goodList = action.list;
         RouletteManager.instance.goodList = action.list;
         updateData();
      }
      
      private function updateData() : void
      {
         var i:int = 0;
         var name:* = null;
         var date:Date = TimeManager.Instance.Now();
         var _loc6_:int = 0;
         var _loc5_:* = _goodList;
         for each(var info in _goodList)
         {
            info.BeginDate = date.fullYear + "-" + (date.month + 1) + "-" + date.date + " " + date.hours + ":" + date.minutes + ":" + date.seconds;
         }
         i = 0;
         while(i < 10 && i < _goodList.length)
         {
            if(_dataList == null || i >= _dataList.length || _dataList[i] == null)
            {
               name = "MyName";
            }
            else
            {
               name = _dataList[i].Nickname;
            }
            _itemList[i].update(i,name,_goodList[i]);
            i++;
         }
      }
      
      private function __response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 1 || e.responseCode == 0 || e.responseCode == 3)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      public function set dataList(value:Vector.<Object>) : void
      {
         _dataList = value;
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
         for each(var item in _itemList)
         {
            ObjectUtils.disposeObject(item);
            item = null;
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
