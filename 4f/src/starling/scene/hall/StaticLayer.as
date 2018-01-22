package starling.scene.hall
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gypsyShop.model.GypsyNPCModel;
   import road7th.StarlingMain;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.filters.BlurFilter;
   import starling.filters.FragmentFilter;
   
   public class StaticLayer extends Sprite
   {
       
      
      private var _btnArray:Array;
      
      private const btnPos:Object = {
         "dungeon":new Point(1443,44),
         "roomList":new Point(1844,0),
         "labyrinth":new Point(2776,9),
         "home":new Point(3097,20),
         "ringStation":new Point(3425,2),
         "cryptBoss":new Point(3565,385),
         "church":new Point(2781,365),
         "gypsy":new Point(274,233),
         "guide":new Point(1098,227),
         "constrion":new Point(1902,328),
         "store":new Point(1495,394),
         "auction":new Point(2412,379),
         "bluePlatform":new Point(622,354),
         "goldPlatform":new Point(474,375),
         "redPlatform":new Point(754,382),
         "drgnBoatBuilding":new Point(922,423),
         "laurel":new Point(811,423),
         "magicHouse":new Point(1058,333),
         "hotspring":new Point(1200,407),
         "poster":new Point(1230,180)
      };
      
      private const btnTitlePos:Object = {
         "dungeon":new Point(1716,137),
         "roomList":new Point(2151,151),
         "labyrinth":new Point(3033,184),
         "home":new Point(3178,158),
         "ringStation":new Point(3460,265),
         "cryptBoss":new Point(3550,456)
      };
      
      private var _buildNpcMap:Object;
      
      private var _buildTitleMap:Object;
      
      private var _buildImageMap:Object;
      
      private var _effectMap:Object;
      
      private var _bgLayer:BgLayer;
      
      private var _bottomLayer:Sprite;
      
      private var _buildLayer:Sprite;
      
      private var _effectLayer:Sprite;
      
      private var _buildTitleLayer:Sprite;
      
      private var _npcLayer:Sprite;
      
      private var _buildNpcEffectRectsMap:Object;
      
      public function StaticLayer(){super();}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function createBottomThing() : void{}
      
      private function createBuilds() : void{}
      
      private function createNpcs() : void{}
      
      private function createBulidEffects() : void{}
      
      private function createBuildTitles() : void{}
      
      private function createBuildTitle(param1:String) : void{}
      
      public function createBuild(param1:String) : void{}
      
      public function createNpc(param1:String) : void{}
      
      public function createImageBuild(param1:String) : void{}
      
      private function initBuilds() : void{}
      
      private function setBuildState(param1:int, param2:Boolean, param3:Boolean = false) : void{}
      
      public function setBuildVisible(param1:String, param2:Boolean) : void{}
      
      public function setCharacterFilter(param1:String, param2:Boolean) : void{}
      
      private function hideGuideNpc() : void{}
      
      public function changeBuildNpcBtnAni(param1:String, param2:String) : void{}
      
      public function removeBuildNpcBtn(param1:String) : void{}
      
      public function getBuildNpcBtnByName(param1:String) : BoneMovieFastStarling{return null;}
      
      public function checkAndPlay(param1:int, param2:int) : void{}
      
      override public function dispose() : void{}
   }
}
