package kingDivision.view
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import kingDivision.KingDivisionManager;
   import kingDivision.data.KingDivisionConsortionItemInfo;
   
   public class KingCell extends Sprite implements Disposeable
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      public var _playerInfo:KingDivisionConsortionItemInfo;
      
      private var _info:PlayerInfo;
      
      private var _character:ShowCharacter;
      
      private var _figure:Bitmap;
      
      private var _directrion:String;
      
      private var _consortionName:String;
      
      private var _index:int;
      
      private var components:Component;
      
      private var _dic:Dictionary;
      
      public function KingCell(){super();}
      
      public function setNickName(param1:KingDivisionConsortionItemInfo, param2:String = "left") : void{}
      
      private function setInfo() : void{}
      
      private function __playerInfoChange(param1:PlayerPropertyEvent) : void{}
      
      private function updateCharacter() : void{}
      
      private function __characterComplete(param1:Event) : void{}
      
      private function tipUpdate() : void{}
      
      public function get info() : PlayerInfo{return null;}
      
      public function get index() : int{return 0;}
      
      public function set index(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
