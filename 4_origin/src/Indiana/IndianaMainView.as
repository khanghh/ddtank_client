package Indiana
{
   import Indiana.analyzer.IndianaGoodsItemInfo;
   import Indiana.analyzer.IndianaShopItemInfo;
   import Indiana.item.GradientBitmapText;
   import Indiana.item.IndianaShowBuyCodeView;
   import Indiana.item.IndianaTitleCellView;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetInfoManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.character.BaseWingLayer;
   import ddt.view.character.ILayer;
   import ddt.view.character.LayerFactory;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import invite.InviteManager;
   import pet.data.PetInfo;
   import pet.data.PetTemplateInfo;
   import petsBag.view.item.PetBigItem;
   import road.game.resource.ActionMovie;
   import road.game.resource.ActionMovieEvent;
   
   public class IndianaMainView extends Frame
   {
       
      
      private var _frameBg:Bitmap;
      
      private var _iconCon:Sprite;
      
      private var _itemName:GradientBitmapText;
      
      private var _helpBtn:BaseButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _itemDetails:SelectedButton;
      
      private var _itemRecode:SelectedButton;
      
      private var _itemHis:SelectedButton;
      
      private var _leftPageBtn:BaseButton;
      
      private var _rightPageBtn:BaseButton;
      
      private var _titleView:IndianaTitleCellView;
      
      private var _infoLogic:IndianaMainInfoLogic;
      
      private var _detaileView:IndianaDetaileView;
      
      private var _currentView:DisplayObject;
      
      private var _itemDis:GradientBitmapText;
      
      private var _itemValue:FilterFrameText;
      
      private var _itemDisII:FilterFrameText;
      
      private var _recodeView:IndianaRecodePanel;
      
      private var _historyView:HistoryofIndianaPanel;
      
      private var _info:Array;
      
      private var _petMovie:ActionMovie;
      
      private var _petItem:PetBigItem;
      
      private var _wing:MovieClip;
      
      private var _icon:Bitmap;
      
      private var _currentInfo:IndianaShopItemInfo;
      
      private var _buyCodeView:IndianaShowBuyCodeView;
      
      private var _loader:BitmapLoader;
      
      private var ACTIONS:Array;
      
      private var layer:ILayer;
      
      private var _lastTime:uint = 0;
      
      private var isFirst:Boolean = true;
      
      private var _currentPerodId:int;
      
      public function IndianaMainView()
      {
         ACTIONS = ["standA","walkA","walkB","hunger"];
         super();
         initView();
         initEvent();
         InviteManager.Instance.enabled = false;
      }
      
      private function initView() : void
      {
         _iconCon = new Sprite();
         _iconCon.x = 169;
         _iconCon.y = 208;
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"indiana.helpbtn",null,LanguageMgr.GetTranslation("Indiana.resoult.helpDis"),"assete.indiana.readMe",444,530);
         _itemDis = new GradientBitmapText();
         _itemDis.FilterTxtStyle = "indiana.gradient.Txt";
         _itemDis.BitMapStyle = "asset.gradient.bg";
         PositionUtils.setPos(_itemDis,"indiana.itemNameDis.pos");
         _itemDisII = ComponentFactory.Instance.creatComponentByStylename("indiana.itemDis.Txt");
         _itemValue = ComponentFactory.Instance.creatComponentByStylename("indiana.itemValue.Txt");
         _itemName = new GradientBitmapText();
         _itemName.FilterTxtStyle = "indiana.gradient.Txt";
         _itemName.BitMapStyle = "asset.gradient.bg";
         PositionUtils.setPos(_itemName,"indiana.itemNameDisII.pos");
         _itemDetails = ComponentFactory.Instance.creatComponentByStylename("indiana.details.selectBtn");
         _itemRecode = ComponentFactory.Instance.creatComponentByStylename("indiana.recode.selectBtn");
         _itemHis = ComponentFactory.Instance.creatComponentByStylename("indiana.history.selectBtn");
         _leftPageBtn = ComponentFactory.Instance.creatComponentByStylename("indiana.leftpagebtn");
         _rightPageBtn = ComponentFactory.Instance.creatComponentByStylename("indiana.rigthpagebtn");
         _info = IndianaDataManager.instance.getShopItem();
         _titleView = new IndianaTitleCellView();
         _titleView.setInfos(_info);
         PositionUtils.setPos(_titleView,"itemTitleView.pos");
         _infoLogic = new IndianaMainInfoLogic();
         PositionUtils.setPos(_infoLogic,"infologic.pos");
         _currentInfo = IndianaDataManager.instance.getCurrentShopItem;
         addToContent(_iconCon);
         addToContent(_helpBtn);
         addToContent(_itemName);
         addToContent(_itemDetails);
         addToContent(_itemRecode);
         addToContent(_itemHis);
         addToContent(_leftPageBtn);
         addToContent(_rightPageBtn);
         addToContent(_titleView);
         addToContent(_infoLogic);
         addToContent(_itemValue);
         addToContent(_itemDis);
         addToContent(_itemDisII);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_itemDetails);
         _btnGroup.addSelectItem(_itemRecode);
         _btnGroup.addSelectItem(_itemHis);
         _btnGroup.addEventListener("change",__changeHandler);
         _btnGroup.selectIndex = 0;
      }
      
      private function clearIcon() : void
      {
         var item:* = null;
         if(_petItem)
         {
            if(_petItem.parent)
            {
               _petItem.parent.removeChild(_petItem);
            }
            ObjectUtils.disposeObject(_petItem);
            _petItem = null;
         }
         if(layer)
         {
            ObjectUtils.disposeObject(layer);
            layer = null;
         }
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
         if(_iconCon)
         {
            while(_iconCon.numChildren > 0)
            {
               item = _iconCon.removeChildAt(0);
               ObjectUtils.disposeObject(item);
               item = null;
            }
         }
      }
      
      private function setIcon(value:IndianaShopItemInfo) : void
      {
         var item:* = null;
         var petId:int = 0;
         var tempInfo:* = null;
         var __info:* = null;
         var petInfo:* = null;
         var url:* = null;
         var itemInfo:IndianaGoodsItemInfo = IndianaDataManager.instance.getIndianaGoodsItemInfoByshopId(value.ShopId);
         clearIcon();
         if(itemInfo.GoodType == 2)
         {
            petId = itemInfo.Remark.split("|")[0];
            tempInfo = ItemManager.Instance.getTemplateById(itemInfo.GoodsID);
            __info = PetInfoManager.getPetByTemplateID(petId);
            if(__info)
            {
               petInfo = new PetInfo();
               ObjectUtils.copyProperties(petInfo,__info);
               if(_petItem == null)
               {
                  _petItem = new PetBigItem();
                  PositionUtils.setPos(_petItem,"indiana.petMv.pos");
                  _iconCon.addChild(_petItem);
               }
               _petItem.info = petInfo;
            }
         }
         else if(itemInfo.GoodType == 4)
         {
            if(_wing)
            {
               if(_wing.parent)
               {
                  _wing.parent.removeChild(_wing);
               }
               _wing = null;
            }
            item = IndianaDataManager.instance.getTemplatesByShopId(value.ShopId);
            layer = LayerFactory.instance.createLayer(item,PlayerManager.Instance.Self.Sex,"","show");
            layer.load(__wingOnComplete);
         }
         else
         {
            url = PathManager.solvePath(itemInfo.ResourcePath) + ".png";
            _loader = LoadResourceManager.Instance.createLoader(url,0);
            _loader.addEventListener("complete",__bitmapOnComplete);
            LoadResourceManager.Instance.startLoad(_loader);
         }
      }
      
      private function setTitleInfo(value:IndianaShopItemInfo) : void
      {
         var tempInfo:* = null;
         var goodInfo:* = null;
         var name:* = null;
         var dis:* = null;
         if(value)
         {
            tempInfo = IndianaDataManager.instance.getTemplatesByShopId(value.ShopId);
            goodInfo = IndianaDataManager.instance.getIndianaGoodsItemInfoByshopId(value.ShopId);
            dis = goodInfo.Publicity;
            name = goodInfo.Name + "," + dis;
            name = name.length > 13?name.substr(0,13):name;
            _itemDis.setText(name);
            _itemDisII.text = LanguageMgr.GetTranslation("Indiana.main.perNum",value.PeriodName);
            _itemDisII.x = _itemDis.x + _itemDis.textWidth + 10;
            _itemValue.text = LanguageMgr.GetTranslation("Indiana.item.value",goodInfo.Cost);
            _itemName.setText(LanguageMgr.GetTranslation("Indiana.item.order",value.Order));
            this._titleView.updateCurrentCell(value.PeriodId);
            setIcon(value);
         }
      }
      
      private function __bitmapOnComplete(event:LoaderEvent) : void
      {
         _icon = event.loader.content as Bitmap;
         _icon.x = -51;
         _icon.y = -74;
         _iconCon.addChild(_icon);
         clearLoader();
      }
      
      private function __wingOnComplete(evnt:BaseWingLayer) : void
      {
         clearIcon();
         _wing = evnt.getContent() as MovieClip;
         _wing.x = -20;
         _wing.y = -61;
         _iconCon.addChild(_wing);
      }
      
      private function __onComplete(event:LoaderEvent) : void
      {
         var movieClass:* = null;
         _loader.removeEventListener("complete",__onComplete);
         if(ModuleLoader.hasDefinition("pet.asset.game." + _info.GameAssetUrl))
         {
            movieClass = ModuleLoader.getDefinition("pet.asset.game." + _info.GameAssetUrl) as Class;
            _petMovie = new movieClass();
            _petMovie.mute();
            _petMovie.doAction(Helpers.randomPick(ACTIONS));
            _petMovie.addEventListener("actionEnd",doNextAction);
            addChild(_petMovie);
         }
      }
      
      private function doNextAction(event:ActionMovieEvent) : void
      {
         if(_petMovie)
         {
            if(getTimer() - _lastTime > 40)
            {
               _petMovie.doAction(Helpers.randomPick(ACTIONS));
            }
            _lastTime = getTimer();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function upData() : void
      {
         if(_infoLogic)
         {
            _infoLogic.upDate();
            __changeHandler(null);
            setTitleInfo(IndianaDataManager.instance.getCurrentShopItem);
         }
      }
      
      private function initEvent() : void
      {
         _leftPageBtn.addEventListener("click",__leftClickHandler);
         _rightPageBtn.addEventListener("click",__rightClickHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(385,IndianaEPackageType.CHECK_CODE),__checkCodeHandler);
      }
      
      private function __checkCodeHandler(pkg:PkgEvent) : void
      {
         var begins:* = null;
         var timesarr:* = null;
         var begin:int = 0;
         var time:int = 0;
         var i:int = 0;
         var len:int = pkg.pkg.readInt();
         if(len > 0)
         {
            begins = [];
            timesarr = [];
            for(i = 0; i < len; )
            {
               begin = pkg.pkg.readInt();
               time = pkg.pkg.readInt();
               begins.push(begin + "|" + time);
               i++;
            }
            if(_buyCodeView)
            {
               ObjectUtils.disposeObject(_buyCodeView);
               _buyCodeView = null;
            }
            _buyCodeView = new IndianaShowBuyCodeView(begins);
            PositionUtils.setPos(_buyCodeView,"indiana.buy.view.pos");
            addChild(_buyCodeView);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("Indiana.message.nocode"));
         }
      }
      
      private function __leftClickHandler(evt:MouseEvent) : void
      {
         SocketManager.Instance.out.sendUpdateSysDate();
         var perid:int = _titleView.leftCell.Info.PeriodId;
         SocketManager.Instance.out.sendIndianaEnterGame(perid);
      }
      
      private function __rightClickHandler(evt:MouseEvent) : void
      {
         SocketManager.Instance.out.sendUpdateSysDate();
         var perid:int = _titleView.rightCell.Info.PeriodId;
         SocketManager.Instance.out.sendIndianaEnterGame(perid);
      }
      
      private function __changeHandler(e:Event) : void
      {
         _currentInfo = IndianaDataManager.instance.getCurrentShopItem;
         IndianaDataManager.instance.updataRecode = false;
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               if(_currentView && _currentView != _detaileView)
               {
                  _currentView.visible = false;
               }
               if(_detaileView == null)
               {
                  _detaileView = new IndianaDetaileView();
                  addToContent(_detaileView);
               }
               _detaileView.setInfo(IndianaDataManager.instance.getCurrentShopItem);
               _currentView = _detaileView;
               _detaileView.visible = true;
               break;
            case 1:
               IndianaDataManager.instance.updataRecode = true;
               if(_currentPerodId != _currentInfo.PeriodId)
               {
                  _currentPerodId = _currentInfo.PeriodId;
                  SocketManager.Instance.out.sendIndianaCurrentData(_currentInfo.PeriodId);
               }
               if(_currentView && _currentView != _recodeView)
               {
                  _currentView.visible = false;
               }
               if(_recodeView == null)
               {
                  _recodeView = new IndianaRecodePanel();
                  addToContent(_recodeView);
               }
               _recodeView.visible = true;
               _currentView = _recodeView;
               break;
            case 2:
               if(isFirst)
               {
                  SocketManager.Instance.out.sendIndianaHistoryData();
                  isFirst = false;
               }
               if(_currentView && _currentView != _historyView)
               {
                  _currentView.visible = false;
               }
               if(_historyView == null)
               {
                  _historyView = new HistoryofIndianaPanel();
                  addToContent(_historyView);
               }
               _historyView.visible = true;
               _currentView = _historyView;
         }
      }
      
      private function clearLoader() : void
      {
         if(_loader)
         {
            _loader.removeEventListener("complete",__bitmapOnComplete);
         }
         _loader = null;
      }
      
      private function removeEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__changeHandler);
         }
         if(_leftPageBtn)
         {
            _leftPageBtn.removeEventListener("click",__leftClickHandler);
         }
         if(_rightPageBtn)
         {
            _rightPageBtn.removeEventListener("click",__rightClickHandler);
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(385,IndianaEPackageType.CHECK_CODE),__checkCodeHandler);
      }
      
      override protected function onResponse(type:int) : void
      {
         SoundManager.instance.play("008");
         IndianaDataManager.instance.disposeView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearLoader();
         InviteManager.Instance.enabled = true;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(_currentView)
         {
            ObjectUtils.disposeObject(_currentView);
            _currentView = null;
         }
         if(_detaileView)
         {
            ObjectUtils.disposeObject(_detaileView);
            _detaileView = null;
         }
         if(_leftPageBtn)
         {
            ObjectUtils.disposeObject(_leftPageBtn);
            _leftPageBtn = null;
         }
         if(_rightPageBtn)
         {
            ObjectUtils.disposeObject(_rightPageBtn);
            _rightPageBtn = null;
         }
         if(_titleView)
         {
            ObjectUtils.disposeObject(_titleView);
            _titleView = null;
         }
         if(_infoLogic)
         {
            ObjectUtils.disposeObject(_infoLogic);
            _infoLogic = null;
         }
         if(_itemValue)
         {
            ObjectUtils.disposeObject(_itemValue);
            if(_itemValue)
            {
               ObjectUtils.disposeObject(_itemValue);
               _itemValue = null;
            }
         }
         _itemDis = null;
         _itemDisII = null;
         if(_btnGroup)
         {
            _btnGroup.dispose();
            _btnGroup = null;
         }
         if(_itemDetails)
         {
            ObjectUtils.disposeObject(_itemDetails);
            _itemDetails = null;
         }
         if(_itemRecode)
         {
            ObjectUtils.disposeObject(_itemRecode);
            _itemRecode = null;
         }
         if(_itemHis)
         {
            ObjectUtils.disposeObject(_itemHis);
            _itemHis = null;
         }
         if(_iconCon)
         {
            ObjectUtils.disposeObject(_iconCon);
            _iconCon = null;
         }
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
            _helpBtn = null;
         }
         if(_itemName)
         {
            ObjectUtils.disposeObject(_itemName);
            _itemName = null;
         }
         if(_buyCodeView)
         {
            ObjectUtils.disposeObject(_buyCodeView);
            _buyCodeView = null;
         }
         super.dispose();
      }
   }
}
