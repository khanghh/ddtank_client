package ddt.view.caddyII
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.data.EquipType;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.PositionUtils;
   import ddt.view.caddyII.bead.BeadCell;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class BLESSView extends RightView
   {
      
      public static const GOODSNUMBER:int = 25;
      
      public static const SELECT_SCALE_NUMBER:Number = 0;
      
      public static const SCALE_NUMBER:Number = 0.1;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _gridBGI:MovieImage;
      
      private var _lookBtn:TextButton;
      
      private var _openBtn:BaseButton;
      
      private var _turnBG:ScaleFrameImage;
      
      private var _movie:MovieImage;
      
      private var _Vipmovie:MovieImage;
      
      private var _keyBtn:BaseButton;
      
      private var _paiBtn:TextButton;
      
      private var _boxBtn:BaseButton;
      
      private var _goodsNameTxt:FilterFrameText;
      
      private var _selectCell:BaseCell;
      
      private var _turnCell:BeadCell;
      
      private var _keyNumberTxt:FilterFrameText;
      
      private var _boxNumberTxt:FilterFrameText;
      
      private var _lookTrophy:LookTrophy;
      
      private var _keyNumber:int;
      
      private var _boxNumber:int;
      
      private var _selectedCount:int;
      
      private var _selectedGoodsInfo:InventoryItemInfo;
      
      private var _templateIDList:Vector.<int>;
      
      private var _vipDescTxt:FilterFrameText;
      
      private var _vipIcon:Image;
      
      private var _endFrame:int;
      
      private var _selectSprite:Sprite;
      
      private var _turnSprite:Sprite;
      
      private var _startY:Number;
      
      private var _effect:IEffect;
      
      private var _cellMC:MovieClip;
      
      private var _GoldCell:MovieClip;
      
      private var _SiverCell:MovieClip;
      
      private var _listView:CaddyAwardListFrame;
      
      private var isActive:Boolean = false;
      
      public function BLESSView()
      {
         super();
         initView();
         initEvents();
      }
      
      override public function setType(val:int) : void
      {
         _type = val;
         if(_type == 112222)
         {
         }
         creatTweenMagnify();
      }
      
      override public function set item(val:ItemTemplateInfo) : void
      {
         if(_item != val)
         {
            _item = val;
            if(_item.TemplateID == 112222)
            {
               _cellMC.visible = true;
               _GoldCell.visible = false;
               _SiverCell.visible = false;
               _boxBtn.tipData = LanguageMgr.GetTranslation("tank.view.caddy.quickBless");
            }
            else if(_item.TemplateID == 112223)
            {
               _cellMC.visible = false;
               _GoldCell.visible = false;
               _SiverCell.visible = true;
               _boxBtn.tipData = LanguageMgr.GetTranslation("tank.view.caddy.quickBless2");
            }
            else if(_item.TemplateID == 112224)
            {
               _cellMC.visible = false;
               _GoldCell.visible = true;
               _SiverCell.visible = false;
               _boxBtn.tipData = LanguageMgr.GetTranslation("tank.view.caddy.quickBless1");
            }
            boxNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_item.TemplateID);
         }
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var k:int = 0;
         var goldBorder:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("bead.rightGrid.goldBorder");
         _vipDescTxt = ComponentFactory.Instance.creatComponentByStylename("asset.caddy.VipDescTxt");
         _vipDescTxt.text = LanguageMgr.GetTranslation("tank.view.caddy.VipDescTxt");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("caddy.VipIcon");
         var goodsNameBG:Image = ComponentFactory.Instance.creatComponentByStylename("caddy.GoodsNameBG");
         var numberBG:Image = ComponentFactory.Instance.creatComponentByStylename("caddy.numberI");
         PositionUtils.setPos(numberBG,"CaddyViewII.numberIPos");
         var openBG:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.openBG");
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.rightBG");
         _gridBGI = ComponentFactory.Instance.creatComponentByStylename("caddy.rightGridBGI");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.LookBtn");
         _lookBtn.text = LanguageMgr.GetTranslation("tank.view.caddy.lookTrophy");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.OpenBtn");
         _keyBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.KeyBtn");
         _keyBtn.addChild(creatShape());
         _boxBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.BlessBtn");
         _boxBtn.addChild(creatShape());
         _goodsNameTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.goodsNameTxt");
         _keyNumberTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.keyNumberTxt");
         _boxNumberTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.boxNumberTxt");
         _turnSprite = ComponentFactory.Instance.creatCustomObject("bead.turnSprite");
         _cellMC = ComponentFactory.Instance.creat("asset.Bless.play");
         PositionUtils.setPos(_cellMC,"caddyII.bless.point");
         _GoldCell = ComponentFactory.Instance.creat("asset.GoldBless.play");
         PositionUtils.setPos(_GoldCell,"caddyII.bless.point");
         _GoldCell.visible = false;
         _SiverCell = ComponentFactory.Instance.creat("asset.SiverBless.play");
         PositionUtils.setPos(_SiverCell,"caddyII.bless.point");
         _SiverCell.visible = false;
         _turnCell = new BeadCell();
         _turnCell.info = ItemManager.Instance.getTemplateById(112222);
         _movie = ComponentFactory.Instance.creatComponentByStylename("bead.movieAsset");
         for(i = 0; i < _movie.movie.currentLabels.length; )
         {
            if(_movie.movie.currentLabels[i].name == "endFrame")
            {
               _endFrame = _movie.movie.currentLabels[i].frame;
            }
            i++;
         }
         _Vipmovie = ComponentFactory.Instance.creatComponentByStylename("bead.VipmovieAsset");
         for(k = 0; k < _Vipmovie.movie.currentLabels.length; )
         {
            if(_Vipmovie.movie.currentLabels[k].name == "endFrame")
            {
               _endFrame = _Vipmovie.movie.currentLabels[k].frame;
            }
            k++;
         }
         _lookTrophy = ComponentFactory.Instance.creatCustomObject("caddyII.LookTrophy");
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("AutoOpenButton");
         _autoCheck.text = LanguageMgr.GetTranslation("tank.view.award.auto");
         _autoCheck.selected = SharedManager.Instance.autoCaddy;
         var font:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.bagHavingTip");
         font.text = LanguageMgr.GetTranslation("tank.view.award.bagHaving");
         _paiBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.awardListBtn");
         _paiBtn.text = "排行奖励";
         addChild(_bg);
         addChild(_gridBGI);
         addChild(goldBorder);
         addChild(_vipDescTxt);
         addChild(_vipIcon);
         addChild(goodsNameBG);
         addChild(numberBG);
         addChild(_lookBtn);
         addChild(_openBtn);
         addChild(_boxBtn);
         addChild(_goodsNameTxt);
         addChild(openBG);
         _turnSprite.addChild(_turnCell);
         addChild(_cellMC);
         addChild(_GoldCell);
         addChild(_SiverCell);
         addChild(_boxNumberTxt);
         addChild(goldBorder);
         addChild(_autoCheck);
         addChild(font);
         _startY = _turnSprite.y;
         createSelectCell();
         addChild(_movie);
         _movie.movie.stop();
         _movie.visible = false;
         addChild(_Vipmovie);
         addChild(_paiBtn);
         _Vipmovie.movie.stop();
         _Vipmovie.visible = false;
         _keyBtn.tipData = LanguageMgr.GetTranslation("tank.view.caddy.quickBuyKey");
         keyNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11456);
         boxNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(112222);
         creatTweenMagnify();
         creatEffect();
         updateItemShape();
      }
      
      private function initEvents() : void
      {
         PlayerManager.Instance.Self.PropBag.addEventListener("update",_bagUpdate);
         _lookBtn.addEventListener("click",_look);
         _paiBtn.addEventListener("click",paihangHander);
         _openBtn.addEventListener("click",__openClick);
         _movie.movie.addEventListener("enterFrame",__frameHandler);
         _Vipmovie.movie.addEventListener("enterFrame",__VipframeHandler);
         _keyBtn.addEventListener("click",_buyKey);
         _autoCheck.addEventListener("select",__selectedChanged);
      }
      
      protected function paihangHander(event:MouseEvent) : void
      {
         _listView = ComponentFactory.Instance.creatComponentByStylename("caddyAwardListFrame");
         LayerManager.Instance.addToLayer(_listView,2,true,0);
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",_bagUpdate);
         _lookBtn.removeEventListener("click",_look);
         _openBtn.removeEventListener("click",__openClick);
         _movie.movie.removeEventListener("enterFrame",__frameHandler);
         _Vipmovie.movie.removeEventListener("enterFrame",__VipframeHandler);
         _keyBtn.removeEventListener("click",_buyKey);
         _autoCheck.removeEventListener("select",__selectedChanged);
      }
      
      private function updateItemShape() : void
      {
         _turnCell.x = _turnCell.width / -2;
         _turnCell.y = -89;
      }
      
      private function createSelectCell() : void
      {
         var size:Point = ComponentFactory.Instance.creatCustomObject("bead.selectCellSize");
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,size.x,size.y);
         shape.graphics.endFill();
         _selectCell = new BaseCell(shape);
         _selectSprite = ComponentFactory.Instance.creatCustomObject("bead.SelectSprite");
         _selectCell.x = _selectCell.width / -2;
         _selectCell.y = _selectCell.height / -2;
         _selectSprite.addChild(_selectCell);
         addChild(_selectSprite);
         _selectSprite.visible = false;
      }
      
      private function _bagUpdate(event:BagEvent) : void
      {
         keyNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11456);
         boxNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_item.TemplateID);
      }
      
      private function _look(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(EquipType.isCaddy(_item) || EquipType.isBless(_item))
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createCaddyAwardsLoader],lookTrophy);
         }
      }
      
      private function lookTrophy() : void
      {
         _lookTrophy.show(CaddyModel.instance.getCaddyTrophy(_item.TemplateID));
      }
      
      private function __openClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(CaddyModel.instance.bagInfo.itemNumber >= 25)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.FullBag"));
            return;
         }
         openImp();
      }
      
      private function hasKey() : Boolean
      {
         var caddyPayBuff:BuffInfo = PlayerManager.Instance.Self.getBuff(70);
         if(caddyPayBuff != null && caddyPayBuff.ValidCount > 0)
         {
            return keyNumber + 1 >= 4;
         }
         return keyNumber >= 4;
      }
      
      private function openImp() : void
      {
         if(boxNumber >= 1)
         {
            if(CaddyModel.instance.bagInfo.itemNumber < 25)
            {
               _openBtn.enable = false;
            }
            getRandomTempId();
            SocketManager.Instance.out.sendRouletteBox(5,-1,_item.TemplateID);
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
      
      private function _showQuickBuy(id:int) : void
      {
         var quick:QuickBuyCaddy = ComponentFactory.Instance.creatCustomObject("caddy.QuickBuyCaddy");
         quick.show(id);
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
      
      private function __selectedChanged(event:Event) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.autoCaddy = _autoCheck.selected;
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
      
      private function __frameHandler(event:Event) : void
      {
         if(_movie.movie.currentFrame == _endFrame)
         {
            _selectSprite.visible = true;
            _goodsNameTxt.text = _selectedGoodsInfo.Name;
            creatTweenSelectMagnify();
         }
      }
      
      private function __VipframeHandler(event:Event) : void
      {
         if(_Vipmovie.movie.currentFrame == _endFrame)
         {
            _selectSprite.visible = true;
            _goodsNameTxt.text = _selectedGoodsInfo.Name;
            creatTweenSelectMagnify();
         }
      }
      
      private function creatTweenSelectMagnify() : void
      {
         TweenMax.from(_selectSprite,0.7,{
            "scaleX":0,
            "scaleY":0,
            "y":320,
            "alpha":20,
            "onComplete":_moveOk,
            "ease":Elastic.easeOut
         });
      }
      
      private function creatTweenMagnify() : void
      {
         TweenLite.killTweensOf(_turnSprite);
         var _loc1_:int = 1;
         _turnSprite.scaleY = _loc1_;
         _turnSprite.scaleX = _loc1_;
         _turnSprite.y = _startY;
         TweenLite.from(_turnSprite,0.5,{
            "scaleX":0.1,
            "scaleY":0.1
         });
         TweenLite.to(_turnSprite,0.4,{
            "delay":0.5,
            "y":_startY + 4,
            "repeat":-1,
            "yoyo":true
         });
      }
      
      private function creatEffect() : void
      {
         _effect = EffectManager.Instance.creatEffect(4,_turnCell,{
            "color":"gold",
            "speed":0.4,
            "blurWidth":10,
            "intensity":40,
            "strength":0.6
         });
         _effect.play();
      }
      
      private function _moveOk() : void
      {
      }
      
      private function _toMove() : void
      {
         dispatchEvent(new Event("start_move_after_turn"));
         if(_selectCell)
         {
            _selectCell.info = null;
         }
         if(_selectSprite)
         {
            _selectSprite.visible = false;
         }
         if(_type == 112222)
         {
            if(_goodsNameTxt)
            {
               _goodsNameTxt.text = ItemManager.Instance.getTemplateById(_type).Name;
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
      
      override public function again() : void
      {
         _turnSprite.visible = true;
         if(_item.TemplateID == 112222)
         {
            _cellMC.visible = true;
            _GoldCell.visible = false;
            _SiverCell.visible = false;
         }
         else if(_item.TemplateID == 112223)
         {
            _cellMC.visible = false;
            _GoldCell.visible = false;
            _SiverCell.visible = true;
         }
         else if(_item.TemplateID == 112224)
         {
            _cellMC.visible = false;
            _GoldCell.visible = true;
            _SiverCell.visible = false;
         }
         _movie.visible = false;
         _movie.movie.gotoAndStop(1);
         _Vipmovie.visible = false;
         _Vipmovie.movie.gotoAndStop(1);
         _selectSprite.visible = false;
         _openBtn.enable = true;
         if(SharedManager.Instance.autoCaddy)
         {
            if(CaddyModel.instance.bagInfo.itemNumber >= 25)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.FullBag"));
            }
            else if(boxNumber < 1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.EmptyBox",_item.Name));
            }
            else
            {
               openImp();
            }
         }
      }
      
      override public function setSelectGoodsInfo(info:InventoryItemInfo) : void
      {
         SoundManager.instance.play("139");
         _selectedGoodsInfo = info;
         _turnSprite.visible = false;
         if(_item.TemplateID == 112222)
         {
            _cellMC.visible = false;
            _GoldCell.visible = false;
            _SiverCell.visible = false;
         }
         else if(_item.TemplateID == 112223)
         {
            _cellMC.visible = false;
            _GoldCell.visible = false;
            _SiverCell.visible = false;
         }
         else if(_item.TemplateID == 112224)
         {
            _cellMC.visible = false;
            _GoldCell.visible = false;
            _SiverCell.visible = false;
         }
         if(PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= ServerConfigManager.instance.getPrivilegeMinLevel("13"))
         {
            _movie.visible = false;
            _Vipmovie.visible = true;
            _Vipmovie.movie.play();
            _movie.movie.stop();
         }
         else
         {
            _movie.visible = true;
            _Vipmovie.visible = false;
            _Vipmovie.movie.stop();
            _movie.movie.play();
         }
         _selectCell.info = _selectedGoodsInfo;
         _startTurn();
      }
      
      private function _startTurn() : void
      {
         var evt:CaddyEvent = new CaddyEvent("caddy_start_turn");
         evt.info = _selectedGoodsInfo;
         dispatchEvent(evt);
      }
      
      override public function get openBtnEnable() : Boolean
      {
         return _openBtn.enable;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         TweenMax.killTweensOf(_turnSprite);
         TweenMax.killTweensOf(_selectSprite);
         if(_movie)
         {
            ObjectUtils.disposeObject(_movie);
         }
         _movie = null;
         if(_Vipmovie)
         {
            ObjectUtils.disposeObject(_Vipmovie);
         }
         _movie = null;
         if(_selectCell)
         {
            ObjectUtils.disposeObject(_selectCell);
         }
         _selectCell = null;
         if(_selectSprite)
         {
            ObjectUtils.disposeObject(_selectSprite);
         }
         _selectSprite = null;
         if(_turnSprite)
         {
            ObjectUtils.disposeObject(_turnSprite);
         }
         _turnSprite = null;
         if(_autoCheck)
         {
            ObjectUtils.disposeObject(_autoCheck);
         }
         _autoCheck = null;
         if(_openBtn)
         {
            ObjectUtils.disposeObject(_openBtn);
         }
         _openBtn = null;
         EffectManager.Instance.removeEffect(_effect);
      }
   }
}
