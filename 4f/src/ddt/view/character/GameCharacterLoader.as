package ddt.view.character
{
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import room.RoomManager;
   
   public class GameCharacterLoader extends BaseCharacterLoader
   {
      
      public static var MALE_STATES:Array = [[1,1],[2,2],[3,3],[4,4],[5,5],[7,7],[8,8],[11,9]];
      
      public static var FEMALE_STATES:Array = [[1,1],[2,2],[3,3],[4,4],[5,5],[7,6],[9,8],[11,9]];
       
      
      private var _sp:Vector.<BitmapData>;
      
      private var _faceup:BitmapData;
      
      private var _face:BitmapData;
      
      private var _lackHpFace:Vector.<BitmapData>;
      
      private var _faceDown:BitmapData;
      
      private var _normalSuit:BitmapData;
      
      private var _lackHpSuit:BitmapData;
      
      public var specialType:int = -1;
      
      public var stateType:int = -1;
      
      public function GameCharacterLoader(param1:PlayerInfo){super(null);}
      
      public function get STATES_ENUM() : Array{return null;}
      
      override protected function initLayers() : void{}
      
      override public function update() : void{}
      
      override protected function getIndexByTemplateId(param1:String) : int{return 0;}
      
      override protected function drawCharacter() : void{}
      
      private function drawSuits() : void{}
      
      private function drawNormal() : void{}
      
      override public function getContent() : Array{return null;}
      
      override protected function getCharacterLoader(param1:ItemTemplateInfo, param2:String = "", param3:String = null) : ILayer{return null;}
      
      override public function dispose() : void{}
   }
}
