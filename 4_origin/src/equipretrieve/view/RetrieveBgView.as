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
         var i:int = 0;
         var point:* = null;
         _pointArray = new Vector.<Point>();
         for(i = 0; i < 5; )
         {
            point = ComponentFactory.Instance.creatCustomObject("equipretrieve.cellPoint" + i);
            _pointArray.push(point);
            i++;
         }
      }
      
      private function _buildCell() : void
      {
         var i:int = 0;
         var _cell:* = null;
         var _moveCell:* = null;
         _cells = new Vector.<StoreCell>();
         _moveCells = new Vector.<StoreCell>();
         for(i = 0; i < 5; )
         {
            if(i == 0)
            {
               _cell = new RetrieveResultCell(i);
               _moveCell = new RetrieveResultCell(i);
               addChild(_cell);
               addChild(_moveCell);
               addChild(_dropArea);
            }
            else
            {
               _cell = new RetrieveCell(i);
               _moveCell = new RetrieveCell(i);
               addChild(_cell);
               addChild(_moveCell);
            }
            var _loc4_:* = _pointArray[i].x;
            _cell.x = _loc4_;
            _moveCell.x = _loc4_;
            _loc4_ = _pointArray[i].y;
            _cell.y = _loc4_;
            _moveCell.y = _loc4_;
            _cells[i] = _cell;
            _moveCell.visible = false;
            _moveCell.BGVisible = false;
            _moveCells[i] = _moveCell;
            RetrieveModel.Instance.setSaveCells(_cell,i);
            i++;
         }
      }
      
      public function startShine() : void
      {
         var i:int = 0;
         for(i = 1; i < 5; )
         {
            _cells[i].startShine();
            i++;
         }
      }
      
      public function stopShine() : void
      {
         var i:int = 0;
         for(i = 1; i < 5; )
         {
            _cells[i].stopShine();
            i++;
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
      
      private function executeRetrieve(e:MouseEvent) : void
      {
         var i:int = 0;
         var alert:* = null;
         var j:int = 0;
         var alert1:* = null;
         SoundManager.instance.play("008");
         for(i = 1; i < _cells.length; )
         {
            if(_cells[i].info == null)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.equipretrieve.countlack"));
               return;
            }
            i++;
         }
         if(int(_needGoldText.text) > PlayerManager.Instance.Self.Gold)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.moveEnable = false;
            alert.addEventListener("response",_responseV);
            return;
         }
         var count:int = 0;
         for(j = 1; j < _cells.length; )
         {
            if(_cells[j].itemInfo.IsBinds == true)
            {
               count++;
            }
            j++;
         }
         if(count > 0 && count < 4)
         {
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.StoreIIStrengthBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert1.moveEnable = false;
            alert1.info.enableHtml = true;
            alert1.info.mutiline = true;
            alert1.addEventListener("response",_bingResponse);
            return;
         }
         RetrieveController.Instance.viewMouseEvtBoolean = false;
         SocketManager.Instance.out.sendEquipRetrieve();
      }
      
      private function _bingResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",_bingResponse);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            RetrieveController.Instance.viewMouseEvtBoolean = false;
            SocketManager.Instance.out.sendEquipRetrieve();
         }
         ObjectUtils.disposeObject(alert);
      }
      
      private function _responseV(evt:FrameEvent) : void
      {
         var _quick:* = null;
         SoundManager.instance.play("008");
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _quick.itemID = 11233;
            LayerManager.Instance.addToLayer(_quick,2,true,1);
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      public function refreshData(items:Dictionary) : void
      {
         var itemPlace:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = items;
         for(var place in items)
         {
            if(place != "0")
            {
               itemPlace = place;
               _cells[itemPlace].info = PlayerManager.Instance.Self.StoreBag.items[place];
               if(!PlayerManager.Instance.Self.StoreBag.items["0"])
               {
                  RetrieveModel.Instance.setSaveInfo(PlayerManager.Instance.Self.StoreBag.items[place],itemPlace);
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
         if(items["0"] && PlayerManager.Instance.Self.StoreBag.items["0"])
         {
            _moveCells[0].info = items["0"];
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
      
      public function cellDoubleClick(cell:BagCell) : void
      {
         var i:int = 0;
         var info:InventoryItemInfo = cell.info as InventoryItemInfo;
         for(i = 1; i < _cells.length; )
         {
            if(_cells[i].info == null)
            {
               SocketManager.Instance.out.sendMoveGoods(cell.bagType,info.Place,12,i);
               RetrieveModel.Instance.setSavePlaceType(info,i);
               return;
            }
            i++;
         }
         SocketManager.Instance.out.sendMoveGoods(cell.bagType,info.Place,12,1);
         RetrieveModel.Instance.setSaveInfo(info,1);
         RetrieveModel.Instance.setSavePlaceType(info,1);
      }
      
      public function returnBag() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for(var place in _cells)
         {
            if(_cells[place].info)
            {
               SocketManager.Instance.out.sendMoveGoods(12,int(place),int(!EquipType.isEquipBoolean(_cells[place].info)),-1);
            }
         }
      }
      
      private function _cellslightMovie() : void
      {
         var i:int = 0;
         var animation:* = null;
         if(!_moveCells)
         {
            return;
         }
         var animationControl:AnimationControl = new AnimationControl();
         animationControl.addEventListener("complete",_cellslightMovieOver);
         for(i = 1; i < _moveCells.length; )
         {
            _moveCells[i].info = RetrieveModel.Instance.getSaveCells(i).info;
            _moveCells[i].visible = true;
            animation = new GlowFilterAnimation();
            animation.start(_moveCells[i]);
            animation.addMovie(0,0,4);
            animation.addMovie(15,15,4);
            animation.addMovie(15,15,2);
            animation.addMovie(0,0,4);
            animation.addMovie(0,0,2);
            animation.addMovie(15,15,4);
            animation.addMovie(15,15,2);
            animation.addMovie(0,0,4);
            animationControl.addMovies(animation);
            i++;
         }
         SoundManager.instance.play("147");
         animationControl.startMovie();
      }
      
      private function _cellslightMovieOver(e:Event) : void
      {
         e.currentTarget.removeEventListener("complete",_cellslightMovieOver);
         _cellsMove();
      }
      
      private function _cellsMove() : void
      {
         var i:int = 0;
         if(!_moveCells)
         {
            return;
         }
         var tweenline:TimelineLite = new TimelineLite({"onComplete":_tweenlineComplete});
         var arrAct0:Array = [];
         var arrAct1:Array = [];
         for(i = 1; i < _moveCells.length; )
         {
            arrAct0.push(TweenLite.to(_moveCells[i],0.3,{
               "x":_moveCells[0].x + 12,
               "y":_moveCells[0].y + 12
            }));
            arrAct1.push(TweenLite.to(_moveCells[i],0.2,{
               "scaleX":0.5,
               "scaleY":0.5,
               "x":_moveCells[0].x + 30,
               "y":_moveCells[0].y + 30
            }));
            i++;
         }
         tweenline.appendMultiple(arrAct0);
         tweenline.appendMultiple(arrAct1);
      }
      
      private function _tweenlineComplete() : void
      {
         var i:int = 0;
         if(!_moveCells)
         {
            return;
         }
         for(i = 1; i < _moveCells.length; )
         {
            _moveCells[i].x = RetrieveModel.Instance.getSaveCells(i).oldx;
            _moveCells[i].y = RetrieveModel.Instance.getSaveCells(i).oldy;
            var _loc15_:* = 1;
            _moveCells[i].scaleY = _loc15_;
            _moveCells[i].scaleX = _loc15_;
            _moveCells[i].visible = false;
            i++;
         }
         var effectMc0:MovieImage = MovieImage(ComponentFactory.Instance.creatComponentByStylename("effectmc0"));
         var effectMc1:MovieImage = MovieImage(ComponentFactory.Instance.creatComponentByStylename("effectmc1"));
         var effectMc2:MovieImage = MovieImage(ComponentFactory.Instance.creatComponentByStylename("effectmc2"));
         var effectMc3:MovieImage = MovieImage(ComponentFactory.Instance.creatComponentByStylename("effectmc3"));
         var effectMc4:MovieImage = MovieImage(ComponentFactory.Instance.creatComponentByStylename("effectmc4"));
         var movieControl:MovieClipControl = new MovieClipControl(45);
         addChild(effectMc0);
         addChild(effectMc1);
         addChild(effectMc2);
         addChild(_moveCells[0]);
         addChild(effectMc3);
         addChild(effectMc4);
         _effectMcArr = new Vector.<MovieImage>();
         _effectMcArr.push(effectMc0);
         _effectMcArr.push(effectMc1);
         _effectMcArr.push(effectMc2);
         _effectMcArr.push(effectMc3);
         _effectMcArr.push(effectMc4);
         movieControl.addMovies(effectMc0.movie,1,effectMc0.movie.totalFrames);
         movieControl.addMovies(effectMc1.movie,1,effectMc1.movie.totalFrames);
         movieControl.addMovies(effectMc2.movie,1,effectMc2.movie.totalFrames);
         movieControl.addMovies(effectMc3.movie,2,effectMc3.movie.totalFrames);
         movieControl.addMovies(effectMc4.movie,5,effectMc4.movie.totalFrames);
         movieControl.startMovie();
         var tweenline:TimelineLite = new TimelineLite({"onComplete":_tweenline1Complete});
         _moveCells[0].info = RetrieveModel.Instance.getSaveCells(0).info;
         _moveCells[0].visible = true;
         _loc15_ = 0.2;
         _moveCells[0].scaleY = _loc15_;
         _moveCells[0].scaleX = _loc15_;
         var centerX:Number = _moveCells[0].x + _moveCells[0].width / 2;
         var centerY:Number = _moveCells[0].y + _moveCells[0].height / 2;
         var oldWidth:Number = _moveCells[0].width / 2;
         var oldHeight:Number = _moveCells[0].height / 2;
         var moveToX:Number = RetrieveModel.Instance.getresultCell().point.x - this.localToGlobal(new Point(_moveCells[0].x,_moveCells[0].y)).x + _moveCells[0].x;
         var moveToY:Number = RetrieveModel.Instance.getresultCell().point.y - this.localToGlobal(new Point(_moveCells[0].x,_moveCells[0].y)).y + _moveCells[0].y;
         _loc15_ = 0.2;
         _moveCells[0].scaleY = _loc15_;
         _moveCells[0].scaleX = _loc15_;
         _moveCells[0].x = centerX - 0.2 * oldWidth;
         _moveCells[0].y = centerY - 0.2 * oldHeight;
         tweenline.append(TweenLite.to(_moveCells[0],0.2,{
            "scaleX":0.2,
            "scaleY":0.2,
            "x":centerX - 0.2 * oldWidth,
            "y":centerY - 0.2 * oldHeight
         }));
         tweenline.append(TweenLite.to(_moveCells[0],0.2,{
            "scaleX":0.8,
            "scaleY":0.8,
            "x":centerX - 0.8 * oldWidth,
            "y":centerY - 0.8 * oldHeight
         }));
         tweenline.append(TweenLite.to(_moveCells[0],1.3,{
            "scaleX":0.8,
            "scaleY":0.8,
            "x":centerX - 0.8 * oldWidth,
            "y":centerY - 0.8 * oldHeight
         }));
         tweenline.append(TweenLite.to(_moveCells[0],0.2,{
            "scaleX":1.2,
            "scaleY":1.2,
            "x":centerX - 1.2 * oldWidth,
            "y":centerY - 1.2 * oldHeight
         }));
         tweenline.append(TweenLite.to(_moveCells[0],0.5,{
            "scaleX":0.5,
            "scaleY":0.5,
            "x":moveToX,
            "y":moveToY
         }));
      }
      
      private function _tweenline1Complete() : void
      {
         var i:int = 0;
         for(i = 0; i < _effectMcArr.length; )
         {
            if(_effectMcArr[i])
            {
               ObjectUtils.disposeObject(_effectMcArr[i]);
            }
            _effectMcArr[i] = null;
            i++;
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
         var i:int = 0;
         if(!_cells)
         {
            return;
         }
         var tmp:int = _cells.length;
         for(i = 1; i < 5; )
         {
            if(_cells[i])
            {
               _cells[i].info = null;
            }
            i++;
         }
         hideArr();
      }
      
      public function dispose() : void
      {
         var place:int = 0;
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
         for(place = 0; place < _cells.length; )
         {
            if(_cells[place])
            {
               ObjectUtils.disposeObject(_cells[place]);
            }
            if(_moveCells[place])
            {
               ObjectUtils.disposeObject(_moveCells[place]);
            }
            _moveCells[place] = null;
            _cells[place] = null;
            place++;
         }
         _cells = null;
         _moveCells = null;
      }
   }
}
