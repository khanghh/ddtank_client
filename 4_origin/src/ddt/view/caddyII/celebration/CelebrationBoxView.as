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
      
      override public function setType(param1:int) : void
      {
         _type = param1;
      }
      
      override public function set item(param1:ItemTemplateInfo) : void
      {
         _item = param1;
      }
      
      private function initView() : void
      {
         var _loc9_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.rightBG");
         _gridBGI = ComponentFactory.Instance.creatComponentByStylename("caddy.rightGridBGI");
         var _loc7_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("bead.rightGrid.goldBorder");
         var _loc8_:Image = ComponentFactory.Instance.creatComponentByStylename("caddy.GoodsNameBG");
         var _loc4_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.openBG");
         var _loc6_:Image = ComponentFactory.Instance.creatComponentByStylename("caddy.numberI");
         PositionUtils.setPos(_loc6_,"celebration.boxNumberBGPos");
         var _loc1_:Image = ComponentFactory.Instance.creatComponentByStylename("caddy.numberI");
         PositionUtils.setPos(_loc1_,"celebration.keyNumberBGPos");
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
         _loc9_ = 0;
         while(_loc9_ < _movie.movie.currentLabels.length)
         {
            if(_movie.movie.currentLabels[_loc9_].name == "endFrame")
            {
               _endFrame = _movie.movie.currentLabels[_loc9_].frame;
            }
            _loc9_++;
         }
         _lookTrophy = ComponentFactory.Instance.creatCustomObject("caddyII.LookTrophy");
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("AutoOpenButton");
         _autoCheck.text = LanguageMgr.GetTranslation("tank.view.award.auto");
         _autoCheck.selected = SharedManager.Instance.autoCelebration;
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.bagHavingTip");
         _loc3_.text = LanguageMgr.GetTranslation("tank.view.award.bagHaving");
         addChild(_bg);
         addChild(_gridBGI);
         addChild(_loc4_);
         addChild(_loc7_);
         addChild(_loc8_);
         addChild(_goodsNameTxt);
         addChild(_loc3_);
         addChild(_loc6_);
         addChild(_loc1_);
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
         var _loc5_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(112255);
         if(_loc5_)
         {
            _boxBtn.tipData = _loc5_.Name;
         }
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(11658);
         if(_loc2_)
         {
            _keyBtn.tipData = _loc2_.Name;
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
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("bead.selectCellSize");
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,_loc2_.x,_loc2_.y);
         _loc1_.graphics.endFill();
         _selectCell = new BaseCell(_loc1_);
         _selectSprite = ComponentFactory.Instance.creatCustomObject("bead.SelectSprite");
         _selectCell.x = _selectCell.width / -2;
         _selectCell.y = _selectCell.height / -2;
         _selectSprite.addChild(_selectCell);
         addChild(_selectSprite);
         _selectSprite.visible = false;
      }
      
      private function _bagUpdate(param1:BagEvent) : void
      {
         keyNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11658);
         boxNumber = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(112255);
      }
      
      private function _look(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __openClick(param1:MouseEvent) : void
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
      
      private function __selectedChanged(param1:Event) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.autoCelebration = _autoCheck.selected;
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
      
      private function __frameHandler(param1:Event) : void
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
      
      override public function setSelectGoodsInfo(param1:InventoryItemInfo) : void
      {
         SoundManager.instance.play("139");
         _selectedGoodsInfo = param1;
         _cellMC.visible = false;
         _movie.visible = true;
         _movie.movie.play();
         _selectCell.info = _selectedGoodsInfo;
         _startTurn();
      }
      
      private function _startTurn() : void
      {
         var _loc1_:CaddyEvent = new CaddyEvent("caddy_start_turn");
         _loc1_.info = _selectedGoodsInfo;
         dispatchEvent(_loc1_);
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
