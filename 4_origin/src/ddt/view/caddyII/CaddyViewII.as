package ddt.view.caddyII
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.data.EquipType;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import shop.view.SetsShopView;
   
   public class CaddyViewII extends RightView
   {
      
      public static const NEED_KEY:int = 4;
      
      public static const START_TURN:String = "caddy_start_turn";
      
      public static const START_MOVE_AFTER_TURN:String = "start_move_after_turn";
      
      public static const GOODSNUMBER:int = 25;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _gridBGI:MovieImage;
      
      private var _lookBtn:TextButton;
      
      private var _openBtn:BaseButton;
      
      private var _keyBtn:BaseButton;
      
      private var _boxBtn:BaseButton;
      
      private var _goodsNameTxt:FilterFrameText;
      
      private var _keyNumberTxt:FilterFrameText;
      
      private var _boxNumberTxt:FilterFrameText;
      
      private var _lookTrophy:LookTrophy;
      
      private var _keyNumber:int;
      
      private var _boxNumber:int;
      
      private var _selectedCount:int;
      
      private var _selectedGoodsInfo:InventoryItemInfo;
      
      private var _templateIDList:Vector.<int>;
      
      private var _turn:CaddyTurn;
      
      private var _vipDescTxt:FilterFrameText;
      
      private var _vipIcon:Image;
      
      private var isActive:Boolean = false;
      
      private var hasKey:Boolean = false;
      
      public function CaddyViewII()
      {
         super();
         initView();
         initEvents();
      }
      
      override public function set item(val:ItemTemplateInfo) : void
      {
         if(_item != val)
         {
            _item = val;
            if(_item.TemplateID == 112101)
            {
               if(_turn)
               {
                  _turn.setCaddyType(4);
               }
               _boxBtn.tipData = _item.Name;
            }
            else if(_item.TemplateID == 112100)
            {
               if(_turn)
               {
                  _turn.setCaddyType(5);
               }
               _boxBtn.tipData = _item.Name;
            }
            else
            {
               if(_turn)
               {
                  _turn.setCaddyType(1);
               }
               _boxBtn.tipData = _item.Name;
            }
            boxNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_item.TemplateID);
         }
      }
      
      private function initView() : void
      {
         var node:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("asset.caddy.NodeAsset");
         node.text = LanguageMgr.GetTranslation("tank.view.caddy.rightTitleTip");
         _vipDescTxt = ComponentFactory.Instance.creatComponentByStylename("asset.caddy.VipDescTxt");
         _vipDescTxt.text = LanguageMgr.GetTranslation("tank.view.caddy.VipDescTxt");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("caddy.VipIcon");
         var goodsNameBG:Image = ComponentFactory.Instance.creatComponentByStylename("caddy.GoodsNameBG");
         var goldBorder:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("caddy.rightGrid.goldBorder");
         var numberBG:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("caddy.numberBG");
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.rightBG");
         _gridBGI = ComponentFactory.Instance.creatComponentByStylename("caddy.rightGridBGI");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.LookBtn");
         _lookBtn.text = LanguageMgr.GetTranslation("tank.view.caddy.lookTrophy");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.OpenBtn");
         _keyBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.KeyBtn");
         _keyBtn.addChild(creatShape());
         _boxBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.BoxBtn");
         _boxBtn.addChild(creatShape());
         PositionUtils.setPos(_boxBtn,"caddyII.caddy.BoxBtn.point");
         _goodsNameTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.goodsNameTxt");
         _keyNumberTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.keyNumberTxt");
         _boxNumberTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.boxNumberTxt");
         PositionUtils.setPos(_boxNumberTxt,"caddyII.BoxNumberTxt.point");
         _turn = ComponentFactory.Instance.creatCustomObject("caddy.CaddyTurn",[_goodsNameTxt]);
         _lookTrophy = ComponentFactory.Instance.creatCustomObject("caddyII.LookTrophy");
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("AutoOpenButton");
         _autoCheck.text = LanguageMgr.GetTranslation("tank.view.award.auto");
         _autoCheck.selected = SharedManager.Instance.autoCaddy;
         var font:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.bagHavingTip");
         font.text = LanguageMgr.GetTranslation("tank.view.award.bagHaving");
         addChild(_bg);
         addChild(_gridBGI);
         addChild(node);
         addChild(goodsNameBG);
         addChild(numberBG);
         addChild(_lookBtn);
         addChild(_openBtn);
         addChild(_keyBtn);
         addChild(_boxBtn);
         addChild(_goodsNameTxt);
         addChild(_keyNumberTxt);
         addChild(_boxNumberTxt);
         addChild(_turn);
         addChild(goldBorder);
         addChild(_autoCheck);
         addChild(font);
         _keyBtn.tipData = LanguageMgr.GetTranslation("tank.view.caddy.quickBuyKey");
         _boxBtn.tipData = LanguageMgr.GetTranslation("tank.view.caddy.quickBoxKey");
         keyNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11456);
         boxNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(112047);
      }
      
      private function initEvents() : void
      {
         PlayerManager.Instance.Self.PropBag.addEventListener("update",_bagUpdate);
         _lookBtn.addEventListener("click",_look);
         _openBtn.addEventListener("click",__openClick);
         _keyBtn.addEventListener("click",_buyKey);
         _keyBtn.addEventListener("mouseMove",__quickBuyMouseOver);
         _keyBtn.addEventListener("mouseOut",__quickBuyMouseOut);
         _boxBtn.addEventListener("mouseMove",__quickBuyMouseOver);
         _boxBtn.addEventListener("mouseOut",__quickBuyMouseOut);
         _turn.addEventListener("caddy_turn_complete",_turnComplete);
         _autoCheck.addEventListener("select",__selectedChanged);
      }
      
      private function __selectedChanged(event:Event) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.autoCaddy = _autoCheck.selected;
      }
      
      private function __quickBuyMouseOut(evt:MouseEvent) : void
      {
         if(evt.currentTarget != _keyBtn)
         {
            if(evt.currentTarget == _boxBtn)
            {
            }
         }
      }
      
      private function __quickBuyMouseOver(evt:MouseEvent) : void
      {
         if(evt.currentTarget != _keyBtn)
         {
            if(evt.currentTarget == _boxBtn)
            {
            }
         }
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",_bagUpdate);
         _lookBtn.removeEventListener("click",_look);
         _openBtn.removeEventListener("click",__openClick);
         _keyBtn.removeEventListener("click",_buyKey);
         _keyBtn.removeEventListener("mouseMove",__quickBuyMouseOver);
         _keyBtn.removeEventListener("mouseOut",__quickBuyMouseOut);
         _boxBtn.removeEventListener("mouseMove",__quickBuyMouseOver);
         _boxBtn.removeEventListener("mouseOut",__quickBuyMouseOut);
         _turn.removeEventListener("caddy_turn_complete",_turnComplete);
         _autoCheck.removeEventListener("select",__selectedChanged);
      }
      
      private function __buyBuff(evt:MouseEvent) : void
      {
         var item:* = null;
         var carItem:* = null;
         SoundManager.instance.play("008");
         var list:Array = [];
         item = ShopManager.Instance.getGoodsByTemplateID(11907);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11908);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11909);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11910);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11911);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11912);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11913);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         var setspayFrame:SetsShopView = new SetsShopView();
         setspayFrame.initialize(list);
         LayerManager.Instance.addToLayer(setspayFrame,3,true,1);
      }
      
      private function creatShape(w:Number = 100, h:Number = 25) : Shape
      {
         var size:Point = ComponentFactory.Instance.creatCustomObject("caddy.QuickBuyBtn.ButtonSize");
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,size.x,size.y);
         shape.graphics.endFill();
         return shape;
      }
      
      private function _bagUpdate(e:BagEvent) : void
      {
         keyNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11456);
         boxNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_item.TemplateID);
      }
      
      private function _look(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(EquipType.isCaddy(_item))
         {
            _lookTrophy.show(CaddyModel.instance.getCaddyTrophy(_item.TemplateID));
         }
         else if(!EquipType.isBead(int(_item.Property1)))
         {
            if(!EquipType.isOfferPackage(_item))
            {
            }
         }
      }
      
      private function __openClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         openBoxImp();
      }
      
      private function hasKeys() : void
      {
         var caddyPayBuff:BuffInfo = PlayerManager.Instance.Self.getBuff(70);
         if(caddyPayBuff != null && caddyPayBuff.ValidCount > 0)
         {
            if(keyNumber + 1 >= 4)
            {
               hasKey = true;
            }
            else
            {
               hasKey = false;
            }
         }
         else if(keyNumber >= 4)
         {
            hasKey = true;
         }
         else
         {
            hasKey = false;
         }
      }
      
      private function openBoxImp() : void
      {
         hasKeys();
         if(boxNumber >= 1 && hasKey)
         {
            if(CaddyModel.instance.bagInfo.itemNumber < 25)
            {
               _openBtn.enable = false;
            }
            if(CaddyModel.instance.bagInfo.itemNumber >= 25)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.CaddyViewIIII"));
               return;
            }
            getRandomTempId();
            SocketManager.Instance.out.sendRouletteBox(5,-1,_item.TemplateID);
         }
         else if(!hasKey)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.EmptyKey"));
         }
         else if(boxNumber < 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.EmptyBox",_item.Name));
         }
      }
      
      private function _quickBuy() : void
      {
         _buyKey(null);
      }
      
      private function _buyKey(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _showQuickBuy(0);
      }
      
      private function _buyBox(e:MouseEvent) : void
      {
      }
      
      private function _showQuickBuy(id:int) : void
      {
         var quick:QuickBuyCaddy = ComponentFactory.Instance.creatCustomObject("caddy.QuickBuyCaddy");
         quick.show(id);
      }
      
      private function _turnComplete(e:Event) : void
      {
         dispatchEvent(new Event("start_move_after_turn"));
      }
      
      private function againImp() : void
      {
         ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("tank.view.caddy.showChat",_selectedGoodsInfo.Name + "x" + _selectedGoodsInfo.Count));
      }
      
      override public function again() : void
      {
         _openBtn.enable = true;
         _turn.again();
         ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("tank.view.caddy.showChat",_selectedGoodsInfo.Name + "x" + _selectedGoodsInfo.Count));
         if(SharedManager.Instance.autoCaddy)
         {
            if(CaddyModel.instance.bagInfo.itemNumber >= 25)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.FullBag"));
            }
            else if(keyNumber < 4)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.EmptyKey"));
            }
            else if(boxNumber < 1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.EmptyBox",_item.Name));
            }
            else
            {
               openBoxImp();
            }
         }
      }
      
      public function set keyNumber(value:int) : void
      {
         _keyNumber = value;
         _keyNumberTxt.text = String(_keyNumber);
      }
      
      public function get keyNumber() : int
      {
         return _keyNumber;
      }
      
      public function set boxNumber(value:int) : void
      {
         _boxNumber = value;
         _boxNumberTxt.text = String(_boxNumber);
      }
      
      public function get boxNumber() : int
      {
         return _boxNumber;
      }
      
      override public function setSelectGoodsInfo(info:InventoryItemInfo) : void
      {
         _openBtn.enable = false;
         _selectedGoodsInfo = info;
         _startTurn();
         _turn.setTurnInfo(_selectedGoodsInfo,_templateIDList);
         _turn.start(_item);
      }
      
      private function _startTurn() : void
      {
         var evt:CaddyEvent = new CaddyEvent("caddy_start_turn");
         evt.info = _selectedGoodsInfo;
         dispatchEvent(evt);
      }
      
      private function getRandomTempId() : void
      {
         var i:int = 0;
         var j:int = 0;
         var ran1:int = 0;
         var templateList:Vector.<BoxGoodsTempInfo> = BossBoxManager.instance.caddyBoxGoodsInfo;
         _templateIDList = new Vector.<int>();
         var number:int = 0;
         var basic:int = Math.floor(templateList.length / 25);
         var ran:int = Math.floor(Math.random() * basic);
         ran = ran == 0?1:ran;
         for(i = 1; i <= 25; )
         {
            if(ran * i < templateList.length)
            {
               _templateIDList.push(templateList[ran * i].TemplateId);
            }
            i++;
         }
         var itemID:int = 0;
         for(j = 0; j < _templateIDList.length; )
         {
            ran1 = Math.floor(Math.random() * _templateIDList.length);
            itemID = _templateIDList[j];
            _templateIDList[j] = _templateIDList[ran1];
            _templateIDList[ran1] = itemID;
            j++;
         }
      }
      
      override public function get openBtnEnable() : Boolean
      {
         return _openBtn.enable;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_gridBGI)
         {
            ObjectUtils.disposeObject(_gridBGI);
         }
         _gridBGI = null;
         if(_lookBtn)
         {
            ObjectUtils.disposeObject(_lookBtn);
         }
         _lookBtn = null;
         if(_openBtn)
         {
            ObjectUtils.disposeObject(_openBtn);
         }
         _openBtn = null;
         if(_goodsNameTxt)
         {
            ObjectUtils.disposeObject(_goodsNameTxt);
         }
         _goodsNameTxt = null;
         if(_keyNumberTxt)
         {
            ObjectUtils.disposeObject(_keyNumberTxt);
         }
         _keyNumberTxt = null;
         if(_boxNumberTxt)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _boxNumberTxt = null;
         if(_lookTrophy)
         {
            ObjectUtils.disposeObject(_lookTrophy);
         }
         _lookTrophy = null;
         if(_turn)
         {
            ObjectUtils.disposeObject(_turn);
         }
         _turn = null;
         if(_keyBtn)
         {
            ObjectUtils.disposeObject(_keyBtn);
         }
         _keyBtn = null;
         if(_boxBtn)
         {
            ObjectUtils.disposeObject(_boxBtn);
         }
         _boxBtn = null;
         ObjectUtils.disposeObject(_autoCheck);
         _autoCheck = null;
         ObjectUtils.disposeObject(_vipDescTxt);
         _vipDescTxt = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         _item = null;
         _selectedGoodsInfo = null;
         _templateIDList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
