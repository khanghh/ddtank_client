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
      
      public function CaddyTurn(param1:FilterFrameText){super();}
      
      public function setCaddyType(param1:int) : void{}
      
      private function configMovie() : void{}
      
      private function init(param1:FilterFrameText) : void{}
      
      private function initEvents() : void{}
      
      private function removeEvens() : void{}
      
      private function createCells() : void{}
      
      private function _oneComplete(param1:Event) : void{}
      
      private function _timeOut() : void{}
      
      public function again() : void{}
      
      private function turn() : void{}
      
      private function creatTweenMagnify(param1:Number = 1, param2:Number = 1.5, param3:int = -1, param4:Boolean = true, param5:int = 1100) : void{}
      
      private function _clear() : void{}
      
      public function setTurnInfo(param1:InventoryItemInfo, param2:Vector.<int>) : void{}
      
      public function start(param1:ItemTemplateInfo) : void{}
      
      private function __frameHandler(param1:Event) : void{}
      
      private function getTweenComplete() : void{}
      
      private function __getMovieComplete(param1:Event) : void{}
      
      private function showItems() : void{}
      
      private function disposeMovie(param1:DisplayObjectContainer) : void{}
      
      public function dispose() : void{}
   }
}
