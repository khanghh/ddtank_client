package beadSystem.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   import store.view.embed.EmbedStoneCell;
   
   public class PlayerBeadInfoView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _beadCells:DictionaryData;
      
      private var _HoleOpen:DictionaryData;
      
      private var _pointArray:Vector.<Point>;
      
      private var _playerInfo:PlayerInfo;
      
      public function PlayerBeadInfoView(){super();}
      
      private function initView() : void{}
      
      private function getCellsPoint() : void{}
      
      public function set playerInfo(param1:PlayerInfo) : void{}
      
      public function dispose() : void{}
   }
}
