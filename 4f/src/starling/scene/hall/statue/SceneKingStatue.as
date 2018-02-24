package starling.scene.hall.statue
{
   import bombKing.data.BKingStatueInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import phy.maps.Tile;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class SceneKingStatue extends Sprite
   {
      
      private static const RANK_SCALE:Array = [0.66,0.63,0.6];
       
      
      private var _type:int;
      
      private var _info:BKingStatueInfo;
      
      private var _image:Image;
      
      private var _nameSprite:Sprite;
      
      private var _title:Image;
      
      private var _isDispose:Boolean = false;
      
      public function SceneKingStatue(param1:int){super();}
      
      private function createPlayerName() : void{}
      
      public function set info(param1:BKingStatueInfo) : void{}
      
      private function __characterComplete(param1:Event) : void{}
      
      override public function dispose() : void{}
   }
}
