package ddt.view.caddyII.celebration
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.LookTrophy;
   import ddt.view.caddyII.RightView;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class CelebrationBoxView extends RightView
   {
      
      public static const SELECT_SCALE_NUMBER:Number = 0;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _gridBGI:MovieImage;
      
      private var _lookBtn:TextButton;
      
      private var _openBtn:BaseButton;
      
      private var _turnBG:ScaleFrameImage;
      
      private var _movie:MovieImage;
      
      private var _keyBtn:BaseButton;
      
      private var _boxBtn:BaseButton;
      
      private var _goodsNameTxt:FilterFrameText;
      
      private var _selectCell:BaseCell;
      
      private var _keyNumberTxt:FilterFrameText;
      
      private var _boxNumberTxt:FilterFrameText;
      
      private var _lookTrophy:LookTrophy;
      
      private var _keyNumber:int;
      
      private var _boxNumber:int;
      
      private var _selectedCount:int;
      
      private var _selectedGoodsInfo:InventoryItemInfo;
      
      private var _endFrame:int;
      
      private var _selectSprite:Sprite;
      
      private var _cellMC:MovieClip;
      
      public function CelebrationBoxView()
      {
         super();
         initView();
         initEvents();
      }
      
      override public function setType(val:int) : void
      {
         _type = val;
      }
      
      override public function set item(val:ItemTemplateInfo) : void
      {
         _item = val;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.rightBG");
         _gridBGI = ComponentFactory.Instance.creatComponentByStylename("caddy.rightGridBGI");
         var goldBorder:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("bead.rightGrid.goldBorder");
         var goodsNameBG:Image = ComponentFactory.Instance.creatComponentByStylename("caddy.GoodsNameBG");
         var openBG:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.openBG");
         var numberBG:Image = ComponentFactory.Instance.creatComponentByStylename("caddy.numberI");
         PositionUtils.setPos(numberBG,"celebration.boxNumberBGPos");
         var keyBG:Image = ComponentFactory.Instance.creatComponentByStylename("caddy.numberI");
         PositionUtils.setPos(keyBG,"celebration.keyNumberBGPos");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.LookBtn");
         _lookBtn.text = LanguageMgr.GetTranslation("tank.view.caddy.lookTrophy");
         _lookBtn.visible = false;
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.OpenBtn");
         _boxBtn = ComponentFactory.Instance.creatComponentByStylename("celebration.BoxBtn");
         _boxBtn.addChild(creatShape());
         _keyBtn = ComponentFactory.Instance.creatComponentByStylename("celebration.KeyBtn");
         _keyBtn.addChild(creatShape());
         _goodsNameTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.goodsNameTxt");
         _boxNumberTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.boxNumberTxt");
         PositionUtils.setPos(_boxNumberTxt,"celebration.boxNumberTxtPos");
         _keyNumberTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.keyNumberTxt");
         PositionUtils.setPos(_keyNumberTxt,"celebration.keyNumberTxtPos");
         _cellMC = ComponentFactory.Instance.creat("asset.celebration.boxCartoon");
         _cellMC.gotoAndStop(1);
         PositionUtils.setPos(_cellMC,"celebration.boxCartoonPos");
         _movie = ComponentFactory.Instance.creatComponentByStylename("bead.movieAsset");
         for(i = 0; i < _movie.movie.currentLabels.length; )
         {
            if(_movie.movie.currentLabels[i].name == "endFrame")
            {
               _endFrame = _movie.movie.currentLabels[i].frame;
            }
            i++;
         }
         _lookTrophy = ComponentFactory.Instance.creatCustomObject("caddyII.LookTrophy");
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("AutoOpenButton");
         _autoCheck.text = LanguageMgr.GetTranslation("tank.view.award.auto");
         _autoCheck.selected = SharedManager.Instance.autoCelebration;
         var font:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.bagHavingTip");
         font.text = LanguageMgr.GetTranslation("tank.view.award.bagHaving");
         addChild(_bg);
         addChild(_gridBGI);
         addChild(openBG);
         addChild(goldBorder);
         addChild(goodsNameBG);
         addChild(_goodsNameTxt);
         addChild(font);
         addChild(numberBG);
         addChild(keyBG);
         addChild(_boxBtn);
         addChild(_keyBtn);
         addChild(_boxNumberTxt);
         addChild(_keyNumberTxt);
         addChild(_cellMC);
         addChild(_autoCheck);
         createSelectCell();
         addChild(_movie);
         _movie.movie.stop();
         _movie.visible = false;
         addChild(_lookBtn);
         addChild(_openBtn);
         var boxItemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(112255);
         if(boxItemInfo)
         {
            _boxBtn.tipData = boxItemInfo.Name;
         }
         var keyItemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(11658);
         if(keyItemInfo)
         {
            _keyBtn.tipData = keyItemInfo.Name;
         }
         boxNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(112255);
         keyNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11658);
      }
      
      private function initEvents() : void
      {
         PlayerManager.Instance.Self.PropBag.addEventListener("update",_bagUpdate);
         _lookBtn.addEventListener("click",_look);
         _openBtn.addEventListener("click",__openClick);
         _movie.movie.addEventListener("enterFrame",__frameHandler);
         _autoCheck.addEventListener("select",__selectedChanged);
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",_bagUpdate);
         if(_lookBtn)
         {
            _lookBtn.removeEventListener("click",_look);
         }
         if(_openBtn)
         {
            _openBtn.removeEventListener("click",__openClick);
         }
         if(_movie && _movie.movie)
         {
            _movie.movie.removeEventListener("enterFrame",__frameHandler);
         }
         if(_autoCheck)
         {
            _autoCheck.removeEventListener("select",__selectedChanged);
         }
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
         keyNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11658);
         boxNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(112255);
      }
      
      private function _look(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __openClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         openImp();
      }
      
      private function openImp() : void
      {
         if(CaddyModel.instance.bagInfo.itemNumber >= 30)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.FullBag"));
            return;
         }
         if(boxNumber < 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.celebration.hasNotOpen",ItemManager.Instance.getTemplateById(112255).Name,1));
            return;
         }
         if(keyNumber < 10)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.celebration.hasNotOpen",ItemManager.Instance.getTemplateById(11658).Name,10));
            return;
         }
         _openBtn.enable = false;
         SocketManager.Instance.out.sendRouletteBox(5,-4,112255);
      }
      
      private function __selectedChanged(event:Event) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.autoCelebration = _autoCheck.selected;
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
         _cellMC.visible = true;
         _movie.visible = false;
         _movie.movie.gotoAndStop(1);
         _selectSprite.visible = false;
         _openBtn.enable = true;
         if(SharedManager.Instance.autoCelebration)
         {
            openImp();
         }
      }
      
      override public function setSelectGoodsInfo(info:InventoryItemInfo) : void
      {
         SoundManager.instance.play("139");
         _selectedGoodsInfo = info;
         _cellMC.visible = false;
         _movie.visible = true;
         _movie.movie.play();
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
         if(_selectSprite)
         {
            TweenMax.killTweensOf(_selectSprite);
         }
         if(_cellMC)
         {
            _cellMC.gotoAndStop(2);
         }
         _selectedGoodsInfo = null;
         ObjectUtils.disposeObject(_selectCell);
         _selectCell = null;
         ObjectUtils.disposeObject(_lookTrophy);
         _lookTrophy = null;
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _gridBGI = null;
         _lookBtn = null;
         _openBtn = null;
         _turnBG = null;
         _movie = null;
         _keyBtn = null;
         _boxBtn = null;
         _goodsNameTxt = null;
         _keyNumberTxt = null;
         _boxNumberTxt = null;
         _selectSprite = null;
         _cellMC = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
