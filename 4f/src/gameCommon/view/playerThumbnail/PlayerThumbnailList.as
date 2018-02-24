package gameCommon.view.playerThumbnail
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.events.GameEvent;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import gameCommon.model.Player;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class PlayerThumbnailList extends Sprite implements Disposeable
   {
       
      
      private var _info:DictionaryData;
      
      private var _players:DictionaryData;
      
      private var _dirct:int;
      
      private var _index:String;
      
      private var _list:Array;
      
      private var _thumbnailTip:PlayerThumbnailTip;
      
      public function PlayerThumbnailList(param1:DictionaryData, param2:int = 1){super();}
      
      private function initView() : void{}
      
      private function __onTipClick(param1:Event) : void{}
      
      private function __thumbnailHandle(param1:GameEvent) : void{}
      
      private function arrange() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __addLiving(param1:DictionaryEvent) : void{}
      
      private function delePlayer(param1:int) : void{}
      
      public function __removePlayer(param1:DictionaryEvent) : void{}
      
      public function dispose() : void{}
   }
}
