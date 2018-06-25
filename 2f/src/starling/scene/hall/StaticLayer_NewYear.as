package starling.scene.hall{   import bones.BoneMovieFactory;   import bones.display.BoneMovieStarling;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.PlayerManager;   import flash.geom.Point;   import flash.geom.Rectangle;   import gypsyShop.model.GypsyNPCModel;   import road7th.StarlingMain;   import starling.display.Image;   import starling.display.Sprite;   import starling.filters.BlurFilter;   import starling.filters.FragmentFilter;      public class StaticLayer_NewYear extends Sprite   {                   private var _btnArray:Array;            private const btnPos:Object = {         "dungeon":new Point(1443,44),         "roomList":new Point(1844,0),         "labyrinth":new Point(2776,9),         "home":new Point(3097,20),         "ringStation":new Point(3425,2),         "cryptBoss":new Point(3565,385),         "church":new Point(2781,365),         "gypsy":new Point(274,248),         "guide":new Point(1098,248),         "constrion":new Point(1902,328),         "store":new Point(1495,394),         "auction":new Point(2412,379),         "bluePlatform":new Point(622,354),         "goldPlatform":new Point(474,375),         "redPlatform":new Point(754,382),         "drgnBoatBuilding":new Point(922,423),         "laurel":new Point(922,423),         "halloween":new Point(922,423),         "storehouse":new Point(1199,411),         "hotspring":new Point(110,407)      };            private const btnTitlePos:Object = {         "dungeon":new Point(1716,137),         "roomList":new Point(2151,151),         "labyrinth":new Point(3033,184),         "home":new Point(3178,158),         "ringStation":new Point(3460,265),         "cryptBoss":new Point(3550,456)      };            private var _buildNpcMap:Object;            private var _buildTitleMap:Object;            private var _effectMap:Object;            private var _bgLayer:BgLayer;            private var _bottomLayer:Sprite;            private var _buildLayer:Sprite;            private var _effectLayer:Sprite;            private var _buildTitleLayer:Sprite;            private var _npcLayer:Sprite;            private var _buildNpcEffectRectsMap:Object;            public function StaticLayer_NewYear() { super(); }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __propertyChange(event:PlayerPropertyEvent) : void { }
            private function createBottomThing() : void { }
            private function createBuilds() : void { }
            private function createNpcs() : void { }
            private function createBulidEffects() : void { }
            private function createBuildTitles() : void { }
            private function createBuildTitle(titleName:String) : void { }
            public function createBuild(btnName:String) : void { }
            public function createNpc(btnName:String) : void { }
            private function initBuilds() : void { }
            private function setBuildState(idx:int, enable:Boolean, isVisible:Boolean = false) : void { }
            public function setBuildVisible(btnName:String, isVisible:Boolean) : void { }
            public function setCharacterFilter(btnName:String, value:Boolean) : void { }
            private function hideGuideNpc() : void { }
            public function changeBuildNpcBtnAni(btnName:String, animationName:String) : void { }
            public function removeBuildNpcBtn(btnName:String) : void { }
            public function getBuildNpcBtnByName(btnName:String) : BoneMovieStarling { return null; }
            public function checkAndPlay(startCheckX:int, endCheckX:int) : void { }
            override public function dispose() : void { }
   }}