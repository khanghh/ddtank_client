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
         var _loc1_:* = null;
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
               _loc1_ = _iconCon.removeChildAt(0);
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
      }
      
      private function setIcon(param1:IndianaShopItemInfo) : void
      {
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc5_:IndianaGoodsItemInfo = IndianaDataManager.instance.getIndianaGoodsItemInfoByshopId(param1.ShopId);
         clearIcon();
         if(_loc5_.GoodType == 2)
         {
            _loc2_ = _loc5_.Remark.split("|")[0];
            _loc3_ = ItemManager.Instance.getTemplateById(_loc5_.GoodsID);
            _loc6_ = PetInfoManager.getPetByTemplateID(_loc2_);
            if(_loc6_)
            {
               _loc8_ = new PetInfo();
               ObjectUtils.copyProperties(_loc8_,_loc6_);
               if(_petItem == null)
               {
                  _petItem = new PetBigItem();
                  PositionUtils.setPos(_petItem,"indiana.petMv.pos");
                  _iconCon.addChild(_petItem);
               }
               _petItem.info = _loc8_;
            }
         }
         else if(_loc5_.GoodType == 4)
         {
            if(_wing)
            {
               if(_wing.parent)
               {
                  _wing.parent.removeChild(_wing);
               }
               _wing = null;
            }
            _loc4_ = IndianaDataManager.instance.getTemplatesByShopId(param1.ShopId);
            layer = LayerFactory.instance.createLayer(_loc4_,PlayerManager.Instance.Self.Sex,"","show");
            layer.load(__wingOnComplete);
         }
         else
         {
            _loc7_ = PathManager.solvePath(_loc5_.ResourcePath) + ".png";
            _loader = LoadResourceManager.Instance.createLoader(_loc7_,0);
            _loader.addEventListener("complete",__bitmapOnComplete);
            LoadResourceManager.Instance.startLoad(_loader);
         }
      }
      
      private function setTitleInfo(param1:IndianaShopItemInfo) : void
      {
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1)
         {
            _loc5_ = IndianaDataManager.instance.getTemplatesByShopId(param1.ShopId);
            _loc2_ = IndianaDataManager.instance.getIndianaGoodsItemInfoByshopId(param1.ShopId);
            _loc3_ = _loc2_.Publicity;
            _loc4_ = _loc2_.Name + "," + _loc3_;
            _loc4_ = _loc4_.length > 13?_loc4_.substr(0,13):_loc4_;
            _itemDis.setText(_loc4_);
            _itemDisII.text = LanguageMgr.GetTranslation("Indiana.main.perNum",param1.PeriodName);
            _itemDisII.x = _itemDis.x + _itemDis.textWidth + 10;
            _itemValue.text = LanguageMgr.GetTranslation("Indiana.item.value",_loc2_.Cost);
            _itemName.setText(LanguageMgr.GetTranslation("Indiana.item.order",param1.Order));
            this._titleView.updateCurrentCell(param1.PeriodId);
            setIcon(param1);
         }
      }
      
      private function __bitmapOnComplete(param1:LoaderEvent) : void
      {
         _icon = param1.loader.content as Bitmap;
         _icon.x = -51;
         _icon.y = -74;
         _iconCon.addChild(_icon);
         clearLoader();
      }
      
      private function __wingOnComplete(param1:BaseWingLayer) : void
      {
         clearIcon();
         _wing = param1.getContent() as MovieClip;
         _wing.x = -20;
         _wing.y = -61;
         _iconCon.addChild(_wing);
      }
      
      private function __onComplete(param1:LoaderEvent) : void
      {
         var _loc2_:* = null;
         _loader.removeEventListener("complete",__onComplete);
         if(ModuleLoader.hasDefinition("pet.asset.game." + _info.GameAssetUrl))
         {
            _loc2_ = ModuleLoader.getDefinition("pet.asset.game." + _info.GameAssetUrl) as Class;
            _petMovie = new _loc2_();
            _petMovie.mute();
            _petMovie.doAction(Helpers.randomPick(ACTIONS));
            _petMovie.addEventListener("actionEnd",doNextAction);
            addChild(_petMovie);
         }
      }
      
      private function doNextAction(param1:ActionMovieEvent) : void
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
      
      private function __checkCodeHandler(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = param1.pkg.readInt();
         if(_loc5_ > 0)
         {
            _loc4_ = [];
            _loc2_ = [];
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = param1.pkg.readInt();
               _loc3_ = param1.pkg.readInt();
               _loc4_.push(_loc7_ + "|" + _loc3_);
               _loc6_++;
            }
            if(_buyCodeView)
            {
               ObjectUtils.disposeObject(_buyCodeView);
               _buyCodeView = null;
            }
            _buyCodeView = new IndianaShowBuyCodeView(_loc4_);
            PositionUtils.setPos(_buyCodeView,"indiana.buy.view.pos");
            addChild(_buyCodeView);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("Indiana.message.nocode"));
         }
      }
      
      private function __leftClickHandler(param1:MouseEvent) : void
      {
         SocketManager.Instance.out.sendUpdateSysDate();
         var _loc2_:int = _titleView.leftCell.Info.PeriodId;
         SocketManager.Instance.out.sendIndianaEnterGame(_loc2_);
      }
      
      private function __rightClickHandler(param1:MouseEvent) : void
      {
         SocketManager.Instance.out.sendUpdateSysDate();
         var _loc2_:int = _titleView.rightCell.Info.PeriodId;
         SocketManager.Instance.out.sendIndianaEnterGame(_loc2_);
      }
      
      private function __changeHandler(param1:Event) : void
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
      
      override protected function onResponse(param1:int) : void
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
