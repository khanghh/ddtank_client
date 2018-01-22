package equipretrieve.view
{
   import bagAndInfo.cell.BagCell;
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import equipretrieve.RetrieveController;
   import equipretrieve.RetrieveModel;
   import equipretrieve.effect.AnimationControl;
   import equipretrieve.effect.GlowFilterAnimation;
   import equipretrieve.effect.MovieClipControl;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import store.StoreCell;
   
   public class RetrieveBgView extends Sprite implements Disposeable
   {
       
      
      private var _retrieveBt:SelectedButton;
      
      private var _helpBt:SelectedButton;
      
      private var _needGoldText:FilterFrameText;
      
      private var _GoldBitmap:Bitmap;
      
      private var _background:MovieImage;
      
      private var _dropArea:RetrieveDragInArea;
      
      private var _pointArray:Vector.<Point>;
      
      private var _cells:Vector.<StoreCell>;
      
      private var _moveCells:Vector.<StoreCell>;
      
      private var _tweenInt:int = 0;
      
      private var _retrieveBtLightBoo:Boolean;
      
      private var _startStrthTip:MutipleImage;
      
      private var _trieveShine:MovieImage;
      
      private var _retrieveffect:IEffect;
      
      private var _effectMcArr:Vector.<MovieImage>;
      
      private var _titleBg:Bitmap;
      
      private var _needMoneyIcon:Bitmap;
      
      public function RetrieveBgView()
      {
         super();
         _initView();
         addEvt();
      }
      
      public function _initView() : void
      {
         _retrieveBt = ComponentFactory.Instance.creatComponentByStylename("retrieve.retrieveBt");
         _trieveShine = ComponentFactory.Instance.creatComponentByStylename("retrieve.trieveBtShine");
         var _loc1_:Boolean = false;
         _trieveShine.mouseEnabled = _loc1_;
         _trieveShine.mouseChildren = _loc1_;
         _needGoldText = ComponentFactory.Instance.creatComponentByStylename("retrieve.needGold");
         _GoldBitmap = ComponentFactory.Instance.creatBitmap("asset.ddtcore.Gold");
         _helpBt = HelpFrameUtils.Instance.simpleHelpButton(this,"retrieve.helpBt",null,LanguageMgr.GetTranslation("tank.view.equipretrieve.helpTip"),"ddtequipretrieve.help.txt",408,488) as SelectedButton;
         _dropArea = new RetrieveDragInArea(_cells);
         _startStrthTip = ComponentFactory.Instance.creatComponentByStylename("trieve.ArrowHeadTip");
         _needMoneyIcon = ComponentFactory.Instance.creatBitmap("asset.retrieveFrame.needMoneyIcon");
         _getCellsPoint();
         _buildCell();
         addChild(_trieveShine);
         addChild(_retrieveBt);
         addChild(_needGoldText);
         addChild(_needMoneyIcon);
         addChild(_GoldBitmap);
         addChild(_startStrthTip);
         _retrieveBtLightBoo = false;
         hideArr();
      }
      
      private function _getCellsPoint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointArray = new Vector.<Point>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("equipretrieve.cellPoint" + _loc2_);
            _pointArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function _buildCell() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _cells = new Vector.<StoreCell>();
         _moveCells = new Vector.<StoreCell>();
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            if(_loc3_ == 0)
            {
               _loc1_ = new RetrieveResultCell(_loc3_);
               _loc2_ = new RetrieveResultCell(_loc3_);
               addChild(_loc1_);
               addChild(_loc2_);
               addChild(_dropArea);
            }
            else
            {
               _loc1_ = new RetrieveCell(_loc3_);
               _loc2_ = new RetrieveCell(_loc3_);
               addChild(_loc1_);
               addChild(_loc2_);
            }
            var _loc4_:* = _pointArray[_loc3_].x;
            _loc1_.x = _loc4_;
            _loc2_.x = _loc4_;
            _loc4_ = _pointArray[_loc3_].y;
            _loc1_.y = _loc4_;
            _loc2_.y = _loc4_;
            _cells[_loc3_] = _loc1_;
            _loc2_.visible = false;
            _loc2_.BGVisible = false;
            _moveCells[_loc3_] = _loc2_;
            RetrieveModel.Instance.setSaveCells(_loc1_,_loc3_);
            _loc3_++;
         }
      }
      
      public function startShine() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ < 5)
         {
            _cells[_loc1_].startShine();
            _loc1_++;
         }
      }
      
      public function stopShine() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ < 5)
         {
            _cells[_loc1_].stopShine();
            _loc1_++;
         }
      }
      
      private function addEvt() : void
      {
         _retrieveBt.addEventListener("click",executeRetrieve);
      }
      
      private function removeEvt() : void
      {
         _retrieveBt.removeEventListener("click",executeRetrieve);
      }
      
      private function showArr() : void
      {
         _startStrthTip.visible = true;
         _trieveShine.visible = true;
         _trieveShine.movie.gotoAndPlay(1);
      }
      
      private function hideArr() : void
      {
         _trieveShine.visible = false;
         _trieveShine.movie.stop();
         _startStrthTip.visible = false;
      }
      
      private function executeRetrieve(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         SoundManager.instance.play("008");
         _loc6_ = 1;
         while(_loc6_ < _cells.length)
         {
            if(_cells[_loc6_].info == null)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.equipretrieve.countlack"));
               return;
            }
            _loc6_++;
         }
         if(int(_needGoldText.text) > PlayerManager.Instance.Self.Gold)
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc3_.moveEnable = false;
            _loc3_.addEventListener("response",_responseV);
            return;
         }
         var _loc2_:int = 0;
         _loc5_ = 1;
         while(_loc5_ < _cells.length)
         {
            if(_cells[_loc5_].itemInfo.IsBinds == true)
            {
               _loc2_++;
            }
            _loc5_++;
         }
         if(_loc2_ > 0 && _loc2_ < 4)
         {
            _loc4_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.StoreIIStrengthBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc4_.moveEnable = false;
            _loc4_.info.enableHtml = true;
            _loc4_.info.mutiline = true;
            _loc4_.addEventListener("response",_bingResponse);
            return;
         }
         RetrieveController.Instance.viewMouseEvtBoolean = false;
         SocketManager.Instance.out.sendEquipRetrieve();
      }
      
      private function _bingResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",_bingResponse);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            RetrieveController.Instance.viewMouseEvtBoolean = false;
            SocketManager.Instance.out.sendEquipRetrieve();
         }
         ObjectUtils.disposeObject(_loc2_);
      }
      
      private function _responseV(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _loc2_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _loc2_.itemID = 11233;
            LayerManager.Instance.addToLayer(_loc2_,2,true,1);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      public function refreshData(param1:Dictionary) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc3_ in param1)
         {
            if(_loc3_ != "0")
            {
               _loc2_ = _loc3_;
               _cells[_loc2_].info = PlayerManager.Instance.Self.StoreBag.items[_loc3_];
               if(!PlayerManager.Instance.Self.StoreBag.items["0"])
               {
                  RetrieveModel.Instance.setSaveInfo(PlayerManager.Instance.Self.StoreBag.items[_loc3_],_loc2_);
               }
            }
         }
         if(_cells["1"].info && _cells["2"].info && _cells["3"].info && _cells["4"].info)
         {
            showArr();
         }
         else
         {
            hideArr();
         }
         if(param1["0"] && PlayerManager.Instance.Self.StoreBag.items["0"])
         {
            _moveCells[0].info = param1["0"];
            RetrieveModel.Instance.setSaveInfo(_moveCells[0].itemInfo,0);
            if(_moveCells[0].info && EquipType.isEquipBoolean(_moveCells[0].info))
            {
               RetrieveController.Instance.retrieveType = 0;
            }
            else
            {
               RetrieveController.Instance.retrieveType = 1;
            }
            _cellslightMovie();
         }
      }
      
      public function cellDoubleClick(param1:BagCell) : void
      {
         var _loc2_:int = 0;
         var _loc3_:InventoryItemInfo = param1.info as InventoryItemInfo;
         _loc2_ = 1;
         while(_loc2_ < _cells.length)
         {
            if(_cells[_loc2_].info == null)
            {
               SocketManager.Instance.out.sendMoveGoods(param1.bagType,_loc3_.Place,12,_loc2_);
               RetrieveModel.Instance.setSavePlaceType(_loc3_,_loc2_);
               return;
            }
            _loc2_++;
         }
         SocketManager.Instance.out.sendMoveGoods(param1.bagType,_loc3_.Place,12,1);
         RetrieveModel.Instance.setSaveInfo(_loc3_,1);
         RetrieveModel.Instance.setSavePlaceType(_loc3_,1);
      }
      
      public function returnBag() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for(var _loc1_ in _cells)
         {
            if(_cells[_loc1_].info)
            {
               SocketManager.Instance.out.sendMoveGoods(12,int(_loc1_),int(!EquipType.isEquipBoolean(_cells[_loc1_].info)),-1);
            }
         }
      }
      
      private function _cellslightMovie() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(!_moveCells)
         {
            return;
         }
         var _loc1_:AnimationControl = new AnimationControl();
         _loc1_.addEventListener("complete",_cellslightMovieOver);
         _loc3_ = 1;
         while(_loc3_ < _moveCells.length)
         {
            _moveCells[_loc3_].info = RetrieveModel.Instance.getSaveCells(_loc3_).info;
            _moveCells[_loc3_].visible = true;
            _loc2_ = new GlowFilterAnimation();
            _loc2_.start(_moveCells[_loc3_]);
            _loc2_.addMovie(0,0,4);
            _loc2_.addMovie(15,15,4);
            _loc2_.addMovie(15,15,2);
            _loc2_.addMovie(0,0,4);
            _loc2_.addMovie(0,0,2);
            _loc2_.addMovie(15,15,4);
            _loc2_.addMovie(15,15,2);
            _loc2_.addMovie(0,0,4);
            _loc1_.addMovies(_loc2_);
            _loc3_++;
         }
         SoundManager.instance.play("147");
         _loc1_.startMovie();
      }
      
      private function _cellslightMovieOver(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("complete",_cellslightMovieOver);
         _cellsMove();
      }
      
      private function _cellsMove() : void
      {
         var _loc4_:int = 0;
         if(!_moveCells)
         {
            return;
         }
         var _loc3_:TimelineLite = new TimelineLite({"onComplete":_tweenlineComplete});
         var _loc2_:Array = [];
         var _loc1_:Array = [];
         _loc4_ = 1;
         while(_loc4_ < _moveCells.length)
         {
            _loc2_.push(TweenLite.to(_moveCells[_loc4_],0.3,{
               "x":_moveCells[0].x + 12,
               "y":_moveCells[0].y + 12
            }));
            _loc1_.push(TweenLite.to(_moveCells[_loc4_],0.2,{
               "scaleX":0.5,
               "scaleY":0.5,
               "x":_moveCells[0].x + 30,
               "y":_moveCells[0].y + 30
            }));
            _loc4_++;
         }
         _loc3_.appendMultiple(_loc2_);
         _loc3_.appendMultiple(_loc1_);
      }
      
      private function _tweenlineComplete() : void
      {
         var _loc9_:int = 0;
         if(!_moveCells)
         {
            return;
         }
         _loc9_ = 1;
         while(_loc9_ < _moveCells.length)
         {
            _moveCells[_loc9_].x = RetrieveModel.Instance.getSaveCells(_loc9_).oldx;
            _moveCells[_loc9_].y = RetrieveModel.Instance.getSaveCells(_loc9_).oldy;
            var _loc15_:* = 1;
            _moveCells[_loc9_].scaleY = _loc15_;
            _moveCells[_loc9_].scaleX = _loc15_;
            _moveCells[_loc9_].visible = false;
            _loc9_++;
         }
         var _loc10_:MovieImage = MovieImage(ComponentFactory.Instance.creatComponentByStylename("effectmc0"));
         var _loc7_:MovieImage = MovieImage(ComponentFactory.Instance.creatComponentByStylename("effectmc1"));
         var _loc8_:MovieImage = MovieImage(ComponentFactory.Instance.creatComponentByStylename("effectmc2"));
         var _loc4_:MovieImage = MovieImage(ComponentFactory.Instance.creatComponentByStylename("effectmc3"));
         var _loc5_:MovieImage = MovieImage(ComponentFactory.Instance.creatComponentByStylename("effectmc4"));
         var _loc1_:MovieClipControl = new MovieClipControl(45);
         addChild(_loc10_);
         addChild(_loc7_);
         addChild(_loc8_);
         addChild(_moveCells[0]);
         addChild(_loc4_);
         addChild(_loc5_);
         _effectMcArr = new Vector.<MovieImage>();
         _effectMcArr.push(_loc10_);
         _effectMcArr.push(_loc7_);
         _effectMcArr.push(_loc8_);
         _effectMcArr.push(_loc4_);
         _effectMcArr.push(_loc5_);
         _loc1_.addMovies(_loc10_.movie,1,_loc10_.movie.totalFrames);
         _loc1_.addMovies(_loc7_.movie,1,_loc7_.movie.totalFrames);
         _loc1_.addMovies(_loc8_.movie,1,_loc8_.movie.totalFrames);
         _loc1_.addMovies(_loc4_.movie,2,_loc4_.movie.totalFrames);
         _loc1_.addMovies(_loc5_.movie,5,_loc5_.movie.totalFrames);
         _loc1_.startMovie();
         var _loc6_:TimelineLite = new TimelineLite({"onComplete":_tweenline1Complete});
         _moveCells[0].info = RetrieveModel.Instance.getSaveCells(0).info;
         _moveCells[0].visible = true;
         _loc15_ = 0.2;
         _moveCells[0].scaleY = _loc15_;
         _moveCells[0].scaleX = _loc15_;
         var _loc12_:Number = _moveCells[0].x + _moveCells[0].width / 2;
         var _loc11_:Number = _moveCells[0].y + _moveCells[0].height / 2;
         var _loc13_:Number = _moveCells[0].width / 2;
         var _loc14_:Number = _moveCells[0].height / 2;
         var _loc3_:Number = RetrieveModel.Instance.getresultCell().point.x - this.localToGlobal(new Point(_moveCells[0].x,_moveCells[0].y)).x + _moveCells[0].x;
         var _loc2_:Number = RetrieveModel.Instance.getresultCell().point.y - this.localToGlobal(new Point(_moveCells[0].x,_moveCells[0].y)).y + _moveCells[0].y;
         _loc15_ = 0.2;
         _moveCells[0].scaleY = _loc15_;
         _moveCells[0].scaleX = _loc15_;
         _moveCells[0].x = _loc12_ - 0.2 * _loc13_;
         _moveCells[0].y = _loc11_ - 0.2 * _loc14_;
         _loc6_.append(TweenLite.to(_moveCells[0],0.2,{
            "scaleX":0.2,
            "scaleY":0.2,
            "x":_loc12_ - 0.2 * _loc13_,
            "y":_loc11_ - 0.2 * _loc14_
         }));
         _loc6_.append(TweenLite.to(_moveCells[0],0.2,{
            "scaleX":0.8,
            "scaleY":0.8,
            "x":_loc12_ - 0.8 * _loc13_,
            "y":_loc11_ - 0.8 * _loc14_
         }));
         _loc6_.append(TweenLite.to(_moveCells[0],1.3,{
            "scaleX":0.8,
            "scaleY":0.8,
            "x":_loc12_ - 0.8 * _loc13_,
            "y":_loc11_ - 0.8 * _loc14_
         }));
         _loc6_.append(TweenLite.to(_moveCells[0],0.2,{
            "scaleX":1.2,
            "scaleY":1.2,
            "x":_loc12_ - 1.2 * _loc13_,
            "y":_loc11_ - 1.2 * _loc14_
         }));
         _loc6_.append(TweenLite.to(_moveCells[0],0.5,{
            "scaleX":0.5,
            "scaleY":0.5,
            "x":_loc3_,
            "y":_loc2_
         }));
      }
      
      private function _tweenline1Complete() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _effectMcArr.length)
         {
            if(_effectMcArr[_loc1_])
            {
               ObjectUtils.disposeObject(_effectMcArr[_loc1_]);
            }
            _effectMcArr[_loc1_] = null;
            _loc1_++;
         }
         if(!_moveCells)
         {
            return;
         }
         _moveCells[0].x = RetrieveModel.Instance.getSaveCells(0).oldx;
         _moveCells[0].y = RetrieveModel.Instance.getSaveCells(0).oldy;
         var _loc2_:int = 1;
         _moveCells[0].scaleY = _loc2_;
         _moveCells[0].scaleX = _loc2_;
         _moveCells[0].visible = false;
         if(RetrieveModel.Instance.isFull == false)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.equipretrieve.success"));
            SocketManager.Instance.out.sendMoveGoods(12,0,RetrieveModel.Instance.getresultCell().bagType,-1);
         }
         else
         {
            SocketManager.Instance.out.sendMoveGoods(12,0,RetrieveModel.Instance.getresultCell().bagType,-1);
         }
         RetrieveController.Instance.viewMouseEvtBoolean = true;
      }
      
      public function clearCellInfo() : void
      {
         var _loc2_:int = 0;
         if(!_cells)
         {
            return;
         }
         var _loc1_:int = _cells.length;
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            if(_cells[_loc2_])
            {
               _cells[_loc2_].info = null;
            }
            _loc2_++;
         }
         hideArr();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_titleBg)
         {
            ObjectUtils.disposeObject(_titleBg);
         }
         if(_retrieveBt)
         {
            ObjectUtils.disposeObject(_retrieveBt);
         }
         if(_background)
         {
            ObjectUtils.disposeObject(_background);
         }
         if(_dropArea)
         {
            ObjectUtils.disposeObject(_dropArea);
         }
         if(_helpBt)
         {
            ObjectUtils.disposeObject(_helpBt);
         }
         if(_startStrthTip)
         {
            ObjectUtils.disposeObject(_startStrthTip);
         }
         if(_trieveShine)
         {
            ObjectUtils.disposeObject(_trieveShine);
         }
         if(_needGoldText)
         {
            ObjectUtils.disposeObject(_needGoldText);
         }
         if(_GoldBitmap)
         {
            ObjectUtils.disposeObject(_GoldBitmap);
         }
         if(_needMoneyIcon)
         {
            ObjectUtils.disposeObject(_needMoneyIcon);
         }
         _needGoldText = null;
         _trieveShine = null;
         _startStrthTip = null;
         _pointArray = null;
         _retrieveBt = null;
         _helpBt = null;
         _dropArea = null;
         _background = null;
         _GoldBitmap = null;
         _needMoneyIcon = null;
         returnBag();
         _loc1_ = 0;
         while(_loc1_ < _cells.length)
         {
            if(_cells[_loc1_])
            {
               ObjectUtils.disposeObject(_cells[_loc1_]);
            }
            if(_moveCells[_loc1_])
            {
               ObjectUtils.disposeObject(_moveCells[_loc1_]);
            }
            _moveCells[_loc1_] = null;
            _cells[_loc1_] = null;
            _loc1_++;
         }
         _cells = null;
         _moveCells = null;
      }
   }
}
