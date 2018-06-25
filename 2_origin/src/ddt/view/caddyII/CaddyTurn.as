package ddt.view.caddyII
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.media.Video;
   import flash.utils.setTimeout;
   import road7th.utils.MovieClipWrapper;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CaddyTurn extends Sprite implements Disposeable
   {
      
      public static const TURN_COMPLETE:String = "caddy_turn_complete";
      
      public static const TIMER_DELAY:int = 100;
       
      
      private var _turnSprite:Sprite;
      
      private var _selectSprite:Sprite;
      
      private var _selectedCell:BaseCell;
      
      private var _cellNow:BaseCell;
      
      private var _goodsNameTxt:FilterFrameText;
      
      private var _selectedGoodsInfo:InventoryItemInfo;
      
      private var _cells:Vector.<BaseCell>;
      
      private var _templateIDList:Vector.<int>;
      
      private var _timer:TimerJuggler;
      
      private var _showCellAble:Boolean = false;
      
      private var _cellNumber:int = 0;
      
      private var _movie:MovieClip;
      
      private var _turnStartFrame:int;
      
      private var _showItemFrame:int;
      
      private var _turnEndFrame:int;
      
      private var _itemsScale:Number = 0.9;
      
      private var _getMovie:MovieClipWrapper;
      
      private var _box:ItemTemplateInfo;
      
      private var _caddyType:int = 1;
      
      public function CaddyTurn(txt:FilterFrameText)
      {
         super();
         init(txt);
         initEvents();
      }
      
      public function setCaddyType(val:int) : void
      {
         if(_caddyType != val)
         {
            _caddyType = val;
            configMovie();
         }
      }
      
      private function configMovie() : void
      {
         var i:int = 0;
         var movie:MovieClip = _movie;
         if(_caddyType == 4)
         {
            _movie = ComponentFactory.Instance.creat("ddt.view.caddyII.Gold_videoAsset");
         }
         else if(_caddyType == 5)
         {
            _movie = ComponentFactory.Instance.creat("ddt.view.caddyII.Silver_videoAsset");
         }
         else
         {
            _movie = ComponentFactory.Instance.creat("ddt.view.caddyII.videoAsset");
         }
         for(i = 0; i < _movie.currentLabels.length; )
         {
            if(_movie.currentLabels[i].name == "turn")
            {
               _turnStartFrame = _movie.currentLabels[i].frame;
            }
            else if(_movie.currentLabels[i].name == "showItems")
            {
               _showItemFrame = _movie.currentLabels[i].frame;
            }
            else if(_movie.currentLabels[i].name == "turnEnd")
            {
               _turnEndFrame = _movie.currentLabels[i].frame;
            }
            i++;
         }
         PositionUtils.setPos(_movie,"caddy.moviePos");
         addChildAt(_movie,0);
         if(movie && movie != _movie)
         {
            movie.removeEventListener("enterFrame",__frameHandler);
            disposeMovie(movie);
            ObjectUtils.disposeObject(movie);
         }
      }
      
      private function init(txt:FilterFrameText) : void
      {
         configMovie();
         _getMovie = new MovieClipWrapper(ComponentFactory.Instance.creatCustomObject("MovieGet"));
         _getMovie.stop();
         addChild(_getMovie.movie);
         _turnSprite = ComponentFactory.Instance.creatCustomObject("caddy.turnSprite");
         addChild(_turnSprite);
         _goodsNameTxt = txt;
         var size:Point = ComponentFactory.Instance.creatCustomObject("caddy.selectCellSize");
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,size.x,size.y);
         shape.graphics.endFill();
         _selectSprite = ComponentFactory.Instance.creatCustomObject("caddy.turnSprite");
         _selectedCell = new BaseCell(shape);
         _selectedCell.x = _selectedCell.width / -2;
         _selectedCell.y = _selectedCell.height / -2;
         _selectSprite.addChild(_selectedCell);
         addChild(_selectSprite);
         _timer = TimerManager.getInstance().addTimerJuggler(100);
         _timer.stop();
         _cells = new Vector.<BaseCell>();
      }
      
      private function initEvents() : void
      {
         _timer.addEventListener("timer",_oneComplete);
      }
      
      private function removeEvens() : void
      {
         _movie.removeEventListener("enterFrame",__frameHandler);
         _timer.removeEventListener("timer",_oneComplete);
         _getMovie.removeEventListener("complete",__getMovieComplete);
      }
      
      private function createCells() : void
      {
         var i:int = 0;
         var cell:* = null;
         var selectedCell:* = null;
         _cells = new Vector.<BaseCell>();
         var ran:int = Math.floor(Math.random() * _templateIDList.length);
         for(i = 0; i < _templateIDList.length; )
         {
            cell = new BaseCell(ComponentFactory.Instance.creatBitmap("asset.caddy.caddyCellBG"));
            cell.info = ItemManager.Instance.getTemplateById(_templateIDList[i]);
            cell.x = cell.width / -2;
            cell.y = cell.height / -2;
            _turnSprite.addChild(cell);
            cell.visible = false;
            if(i == ran)
            {
               selectedCell = new BaseCell(ComponentFactory.Instance.creatBitmap("asset.caddy.caddyCellBG"));
               selectedCell.info = _selectedGoodsInfo;
               selectedCell.x = selectedCell.width / -2;
               selectedCell.y = selectedCell.height / -2;
               _turnSprite.addChild(selectedCell);
               _cells.push(selectedCell);
               selectedCell.visible = false;
            }
            _cells.push(cell);
            i++;
         }
         _turnSprite.scaleX = _itemsScale;
         _turnSprite.scaleY = _itemsScale;
      }
      
      private function _oneComplete(evt:Event) : void
      {
         _cells[_cellNumber].visible = !!_showCellAble?true:false;
         if(_cellNow == null)
         {
            _cellNow = _cells[_cellNumber];
         }
         else
         {
            _cellNow.visible = false;
            _cellNow = _cells[_cellNumber];
         }
         _cellNumber = Number(_cellNumber) + 1;
         if(_cellNumber >= _cells.length)
         {
            _cellNumber = 0;
         }
         _goodsNameTxt.text = _cellNow.info.Name;
      }
      
      private function _timeOut() : void
      {
         _clear();
         dispatchEvent(new Event("caddy_turn_complete"));
      }
      
      public function again() : void
      {
         _movie.gotoAndPlay(1);
      }
      
      private function turn() : void
      {
         if(_box.TemplateID == 112047)
         {
            TweenLite.to(_turnSprite,2.5,{
               "rotationX":-1800,
               "ease":Linear.easeNone
            });
         }
         else
         {
            TweenLite.to(_turnSprite,3.5,{
               "rotationX":-1800,
               "ease":Linear.easeNone
            });
         }
      }
      
      private function creatTweenMagnify(duration:Number = 1, scale:Number = 1.5, repeat:int = -1, yoyo:Boolean = true, delay:int = 1100) : void
      {
         if(_caddyType == 4)
         {
            TweenMax.to(_selectSprite,duration,{
               "scaleX":scale,
               "scaleY":scale,
               "repeat":repeat,
               "yoyo":yoyo
            });
         }
         else
         {
            TweenMax.to(_selectSprite,duration,{
               "scaleX":scale,
               "scaleY":scale,
               "repeat":repeat,
               "yoyo":yoyo,
               "ease":Elastic.easeOut
            });
            setTimeout(_timeOut,delay);
         }
      }
      
      private function _clear() : void
      {
         _selectedGoodsInfo = null;
         _templateIDList = null;
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            ObjectUtils.disposeObject(cell);
         }
         _cells = null;
         TweenMax.killTweensOf(_selectSprite);
         if(_selectedCell)
         {
            _selectedCell.visible = false;
         }
         if(_selectSprite)
         {
            _loc3_ = 1;
            _selectSprite.scaleY = _loc3_;
            _selectSprite.scaleX = _loc3_;
         }
         if(_goodsNameTxt)
         {
            _goodsNameTxt.text = "";
         }
      }
      
      public function setTurnInfo(info:InventoryItemInfo, list:Vector.<int>) : void
      {
         _selectedGoodsInfo = info;
         _templateIDList = list;
         createCells();
      }
      
      public function start(box:ItemTemplateInfo) : void
      {
         _box = box;
         if(_box.TemplateID == 112047)
         {
            SoundManager.instance.play("155");
         }
         else
         {
            SoundManager.instance.play("137");
         }
         _movie.addEventListener("enterFrame",__frameHandler);
         if(PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= ServerConfigManager.instance.getPrivilegeMinLevel("13"))
         {
            _movie.gotoAndPlay(_turnEndFrame);
            _timer.stop();
         }
         else
         {
            _movie.gotoAndPlay(_turnStartFrame);
            showItems();
            _showCellAble = false;
            _turnSprite.visible = true;
         }
      }
      
      private function __frameHandler(event:Event) : void
      {
         if(_movie.currentFrame == _showItemFrame)
         {
            _showCellAble = true;
            turn();
         }
         else if(_movie.currentFrame == _turnEndFrame)
         {
            _movie.gotoAndStop(_turnEndFrame + 1);
            _timer.stop();
            _turnSprite.visible = false;
            _selectedCell.info = _selectedGoodsInfo;
            _selectedCell.visible = true;
            TweenLite.killDelayedCallsTo(_turnSprite);
            _turnSprite.rotationX = 0;
            _turnSprite.scaleX = 1;
            _turnSprite.scaleY = 1;
            if(_caddyType == 4)
            {
               _getMovie.movie.visible = true;
               _getMovie.gotoAndPlay(1);
               _getMovie.addEventListener("complete",__getMovieComplete);
               TweenMax.to(_selectSprite,0.5,{
                  "scaleX":2,
                  "scaleY":2,
                  "onComplete":getTweenComplete
               });
            }
            else
            {
               _goodsNameTxt.text = _selectedCell.info.Name;
               creatTweenMagnify();
            }
         }
      }
      
      private function getTweenComplete() : void
      {
         _goodsNameTxt.text = _selectedCell.info.Name;
         var _loc1_:* = 1.8;
         _selectSprite.scaleY = _loc1_;
         _selectSprite.scaleX = _loc1_;
         creatTweenMagnify(1,2,-1,true,3500);
      }
      
      private function __getMovieComplete(event:Event) : void
      {
         _getMovie.removeEventListener("complete",__getMovieComplete);
         _getMovie.movie.visible = false;
         _timeOut();
      }
      
      private function showItems() : void
      {
         _timer.reset();
         _timer.start();
      }
      
      private function disposeMovie(target:DisplayObjectContainer) : void
      {
         var len:int = 0;
         var i:int = 0;
         var child:* = null;
         if(target != null)
         {
            if(target is MovieClip)
            {
               MovieClip(target).gotoAndStop(1);
            }
            len = target.numChildren;
            for(i = 0; i < len; )
            {
               child = target.getChildAt(i);
               if(child is Video)
               {
                  Video(child).clear();
               }
               i++;
            }
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvens();
         if(_turnSprite)
         {
            ObjectUtils.disposeObject(_turnSprite);
         }
         _turnSprite = null;
         if(_selectSprite)
         {
            ObjectUtils.disposeObject(_selectSprite);
         }
         _selectSprite = null;
         if(_selectedCell)
         {
            ObjectUtils.disposeObject(_selectedCell);
         }
         _selectedCell = null;
         if(_cellNow)
         {
            ObjectUtils.disposeObject(_cellNow);
         }
         _cellNow = null;
         if(_movie)
         {
            disposeMovie(_movie);
         }
         ObjectUtils.disposeObject(_movie);
         _movie = null;
         if(_getMovie)
         {
            ObjectUtils.disposeObject(_getMovie);
         }
         _getMovie = null;
         if(_timer)
         {
            _timer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
         }
         i = 0;
         while(_cells && i < _cells.length)
         {
            ObjectUtils.disposeObject(_cells[i]);
            i++;
         }
         _cells = null;
         _goodsNameTxt = null;
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
