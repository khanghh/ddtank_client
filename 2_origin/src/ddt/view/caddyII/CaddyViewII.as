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
      
      override public function set item(param1:ItemTemplateInfo) : void
      {
         if(_item != param1)
         {
            _item = param1;
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
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("asset.caddy.NodeAsset");
         _loc1_.text = LanguageMgr.GetTranslation("tank.view.caddy.rightTitleTip");
         _vipDescTxt = ComponentFactory.Instance.creatComponentByStylename("asset.caddy.VipDescTxt");
         _vipDescTxt.text = LanguageMgr.GetTranslation("tank.view.caddy.VipDescTxt");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("caddy.VipIcon");
         var _loc5_:Image = ComponentFactory.Instance.creatComponentByStylename("caddy.GoodsNameBG");
         var _loc4_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("caddy.rightGrid.goldBorder");
         var _loc3_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("caddy.numberBG");
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
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.bagHavingTip");
         _loc2_.text = LanguageMgr.GetTranslation("tank.view.award.bagHaving");
         addChild(_bg);
         addChild(_gridBGI);
         addChild(_loc1_);
         addChild(_loc5_);
         addChild(_loc3_);
         addChild(_lookBtn);
         addChild(_openBtn);
         addChild(_keyBtn);
         addChild(_boxBtn);
         addChild(_goodsNameTxt);
         addChild(_keyNumberTxt);
         addChild(_boxNumberTxt);
         addChild(_turn);
         addChild(_loc4_);
         addChild(_autoCheck);
         addChild(_loc2_);
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
      
      private function __selectedChanged(param1:Event) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.autoCaddy = _autoCheck.selected;
      }
      
      private function __quickBuyMouseOut(param1:MouseEvent) : void
      {
         if(param1.currentTarget != _keyBtn)
         {
            if(param1.currentTarget == _boxBtn)
            {
            }
         }
      }
      
      private function __quickBuyMouseOver(param1:MouseEvent) : void
      {
         if(param1.currentTarget != _keyBtn)
         {
            if(param1.currentTarget == _boxBtn)
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
      
      private function __buyBuff(param1:MouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc5_:Array = [];
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11907);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11908);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11909);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11910);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11911);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11912);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11913);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         var _loc2_:SetsShopView = new SetsShopView();
         _loc2_.initialize(_loc5_);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      private function creatShape(param1:Number = 100, param2:Number = 25) : Shape
      {
         var _loc4_:Point = ComponentFactory.Instance.creatCustomObject("caddy.QuickBuyBtn.ButtonSize");
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(16777215,0);
         _loc3_.graphics.drawRect(0,0,_loc4_.x,_loc4_.y);
         _loc3_.graphics.endFill();
         return _loc3_;
      }
      
      private function _bagUpdate(param1:BagEvent) : void
      {
         keyNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11456);
         boxNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_item.TemplateID);
      }
      
      private function _look(param1:MouseEvent) : void
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
      
      private function __openClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         openBoxImp();
      }
      
      private function hasKeys() : void
      {
         var _loc1_:BuffInfo = PlayerManager.Instance.Self.getBuff(70);
         if(_loc1_ != null && _loc1_.ValidCount > 0)
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
      
      private function _buyKey(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _showQuickBuy(0);
      }
      
      private function _buyBox(param1:MouseEvent) : void
      {
      }
      
      private function _showQuickBuy(param1:int) : void
      {
         var _loc2_:QuickBuyCaddy = ComponentFactory.Instance.creatCustomObject("caddy.QuickBuyCaddy");
         _loc2_.show(param1);
      }
      
      private function _turnComplete(param1:Event) : void
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
      
      public function set keyNumber(param1:int) : void
      {
         _keyNumber = param1;
         _keyNumberTxt.text = String(_keyNumber);
      }
      
      public function get keyNumber() : int
      {
         return _keyNumber;
      }
      
      public function set boxNumber(param1:int) : void
      {
         _boxNumber = param1;
         _boxNumberTxt.text = String(_boxNumber);
      }
      
      public function get boxNumber() : int
      {
         return _boxNumber;
      }
      
      override public function setSelectGoodsInfo(param1:InventoryItemInfo) : void
      {
         _openBtn.enable = false;
         _selectedGoodsInfo = param1;
         _startTurn();
         _turn.setTurnInfo(_selectedGoodsInfo,_templateIDList);
         _turn.start(_item);
      }
      
      private function _startTurn() : void
      {
         var _loc1_:CaddyEvent = new CaddyEvent("caddy_start_turn");
         _loc1_.info = _selectedGoodsInfo;
         dispatchEvent(_loc1_);
      }
      
      private function getRandomTempId() : void
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:Vector.<BoxGoodsTempInfo> = BossBoxManager.instance.caddyBoxGoodsInfo;
         _templateIDList = new Vector.<int>();
         var _loc4_:int = 0;
         var _loc3_:int = Math.floor(_loc5_.length / 25);
         var _loc2_:int = Math.floor(Math.random() * _loc3_);
         _loc2_ = _loc2_ == 0?1:_loc2_;
         _loc8_ = 1;
         while(_loc8_ <= 25)
         {
            if(_loc2_ * _loc8_ < _loc5_.length)
            {
               _templateIDList.push(_loc5_[_loc2_ * _loc8_].TemplateId);
            }
            _loc8_++;
         }
         var _loc1_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _templateIDList.length)
         {
            _loc7_ = Math.floor(Math.random() * _templateIDList.length);
            _loc1_ = _templateIDList[_loc6_];
            _templateIDList[_loc6_] = _templateIDList[_loc7_];
            _templateIDList[_loc7_] = _loc1_;
            _loc6_++;
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
