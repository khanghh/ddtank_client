package starling.scene.hall
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gypsyShop.model.GypsyNPCModel;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.filters.BlurFilter;
   import starling.filters.FragmentFilter;
   
   public class StaticLayer_NewYear extends Sprite
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
         "gypsy":new Point(274,248),
         "guide":new Point(1098,248),
         "constrion":new Point(1902,328),
         "store":new Point(1495,394),
         "auction":new Point(2412,379),
         "bluePlatform":new Point(622,354),
         "goldPlatform":new Point(474,375),
         "redPlatform":new Point(754,382),
         "drgnBoatBuilding":new Point(922,423),
         "laurel":new Point(922,423),
         "halloween":new Point(922,423),
         "storehouse":new Point(1199,411),
         "hotspring":new Point(110,407)
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
      
      private var _effectMap:Object;
      
      private var _bgLayer:BgLayer;
      
      private var _bottomLayer:Sprite;
      
      private var _buildLayer:Sprite;
      
      private var _effectLayer:Sprite;
      
      private var _buildTitleLayer:Sprite;
      
      private var _npcLayer:Sprite;
      
      private var _buildNpcEffectRectsMap:Object;
      
      public function StaticLayer_NewYear()
      {
         _btnArray = ["dungeon","roomList","labyrinth","home","ringStation","cryptBoss","church","gypsy","guide","constrion","store","auction","bluePlatform","goldPlatform","redPlatform","drgnBoatBuilding","laurel","halloween","storehouse","hotspring"];
         super();
         _buildNpcMap = {};
         _buildTitleMap = {};
         _effectMap = {};
         _bgLayer = new BgLayer();
         addChild(_bgLayer);
         _bottomLayer = new Sprite();
         addChild(_bottomLayer);
         _buildLayer = new Sprite();
         addChild(_buildLayer);
         _effectLayer = new Sprite();
         addChild(_effectLayer);
         _buildTitleLayer = new Sprite();
         addChild(_buildTitleLayer);
         _npcLayer = new Sprite();
         addChild(_npcLayer);
         createBottomThing();
         createBuilds();
         createBulidEffects();
         createBuildTitles();
         createNpcs();
         initBuilds();
         hideGuideNpc();
         initEvent();
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
      }
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"])
         {
            initBuilds();
         }
      }
      
      private function createBottomThing() : void
      {
         var _loc2_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.sea");
         _loc2_.x = -857;
         _loc2_.y = -22;
         _bottomLayer.addChild(_loc2_);
         var _loc3_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.boat");
         _loc3_.x = 959;
         _loc3_.y = -3;
         _bottomLayer.addChild(_loc3_);
         var _loc1_:Image = StarlingMain.instance.createImage("hall_scene_bg_light");
         _loc1_.x = -27;
         _loc1_.y = 18;
         _bottomLayer.addChild(_loc1_);
      }
      
      private function createBuilds() : void
      {
         createBuild("dungeon");
         createBuild("cryptBoss");
         createBuild("home");
         var _loc6_:Image = StarlingMain.instance.createImage("hall_scene_church_build");
         _loc6_.x = 2446;
         _buildLayer.addChild(_loc6_);
         var _loc8_:Image = StarlingMain.instance.createImage("hall_scene_bg_flower1");
         _loc8_.x = 1836;
         _loc8_.y = 232;
         _buildLayer.addChild(_loc8_);
         var _loc7_:Image = StarlingMain.instance.createImage("hall_scene_bg_flower2");
         _loc7_.x = 3341;
         _loc7_.y = 176;
         _buildLayer.addChild(_loc7_);
         var _loc9_:Image = StarlingMain.instance.createImage("hall_scene_bg_flower3");
         _loc9_.x = 3704;
         _loc9_.y = 234;
         _buildLayer.addChild(_loc9_);
         createBuild("ringStation");
         createBuild("labyrinth");
         createBuild("roomList");
         var _loc3_:Image = StarlingMain.instance.createImage("hall_scene_bg_dungeontree1");
         _loc3_.x = 1362;
         _loc3_.y = 9;
         _buildLayer.addChild(_loc3_);
         var _loc2_:Image = StarlingMain.instance.createImage("hall_scene_bg_dungeontree2");
         _loc2_.x = 1824;
         _loc2_.y = 94;
         _buildLayer.addChild(_loc2_);
         var _loc1_:Image = StarlingMain.instance.createImage("hall_scene_bg_roomlisttree");
         _loc1_.x = 2251;
         _loc1_.y = 45;
         _buildLayer.addChild(_loc1_);
         var _loc5_:Image = StarlingMain.instance.createImage("hall_scene_bg_church");
         _loc5_.x = 2443;
         _loc5_.y = 302;
         _buildLayer.addChild(_loc5_);
         var _loc4_:Image = StarlingMain.instance.createImage("hall_scene_bg_hometree");
         _loc4_.x = 3093;
         _loc4_.y = 74;
         _buildLayer.addChild(_loc4_);
      }
      
      private function createNpcs() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 6;
         while(_loc2_ < _btnArray.length)
         {
            _loc1_ = _btnArray[_loc2_];
            if(_loc1_ != "drgnBoatBuilding" && _loc1_ != "laurel")
            {
               createNpc(_loc1_);
            }
            _loc2_++;
         }
      }
      
      private function createBulidEffects() : void
      {
         var _loc5_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.lightEffect");
         _loc5_.x = 876;
         _loc5_.y = 193;
         _effectLayer.addChild(_loc5_);
         _effectMap["lightEffect"] = _loc5_;
         var _loc9_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.butterfly1");
         _loc9_.scaleX = 1.45;
         _loc9_.scaleY = 1.45;
         _loc9_.x = 1125;
         _loc9_.y = 127;
         _effectLayer.addChild(_loc9_);
         _effectMap["butterfly1"] = _loc9_;
         var _loc7_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.butterfly2");
         _loc7_.scaleX = 1.45;
         _loc7_.scaleY = 1.45;
         _loc7_.x = 1526;
         _loc7_.y = 109;
         _effectLayer.addChild(_loc7_);
         _effectMap["butterfly2"] = _loc7_;
         var _loc2_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.dungeonEffect");
         _loc2_.x = 1410;
         _loc2_.y = 32;
         _effectLayer.addChild(_loc2_);
         _effectMap["dungeonEffect"] = _loc2_;
         var _loc3_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.roomListEffect");
         _loc3_.scaleX = 0.36;
         _loc3_.scaleY = 0.36;
         _loc3_.x = 1980;
         _loc3_.y = 113;
         _effectLayer.addChild(_loc3_);
         _effectMap["roomListEffect"] = _loc3_;
         var _loc6_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.churchEffect");
         _loc6_.scaleX = 0.36;
         _loc6_.scaleY = 0.36;
         _loc6_.x = 2539;
         _loc6_.y = 280;
         _effectLayer.addChild(_loc6_);
         _effectMap["churchEffect"] = _loc6_;
         var _loc8_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.labyrinthEffect");
         _loc8_.x = 2783;
         _loc8_.y = 7;
         _effectLayer.addChild(_loc8_);
         _effectMap["labyrinthEffect"] = _loc8_;
         var _loc1_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.ringStationEffect");
         _loc1_.scaleX = 0.36;
         _loc1_.scaleY = 0.36;
         _loc1_.x = 3474;
         _loc1_.y = 214;
         _effectLayer.addChild(_loc1_);
         _effectMap["ringStationEffect"] = _loc1_;
         var _loc4_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.homeEffect2");
         _loc4_.x = 3256;
         _loc4_.y = 239;
         _effectLayer.addChild(_loc4_);
         _effectMap["homeEffect2"] = _loc4_;
      }
      
      private function createBuildTitles() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = btnTitlePos;
         for(var _loc1_ in btnTitlePos)
         {
            createBuildTitle(_loc1_);
         }
      }
      
      private function createBuildTitle(param1:String) : void
      {
         if(_buildTitleMap[param1])
         {
            return;
         }
         var _loc3_:Point = btnTitlePos[param1];
         var _loc2_:Image = StarlingMain.instance.createImage("hall_scene_build_title_" + param1);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         _buildTitleLayer.addChild(_loc2_);
         _buildTitleMap[param1] = _loc2_;
      }
      
      public function createBuild(param1:String) : void
      {
         if(_buildNpcMap[param1])
         {
            return;
         }
         var _loc3_:Point = btnPos[param1];
         var _loc2_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene." + param1);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         _buildLayer.addChild(_loc2_);
         _buildNpcMap[param1] = _loc2_;
      }
      
      public function createNpc(param1:String) : void
      {
         if(_buildNpcMap[param1])
         {
            return;
         }
         var _loc3_:Point = btnPos[param1];
         var _loc2_:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene." + param1);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         _npcLayer.addChild(_loc2_);
         _buildNpcMap[param1] = _loc2_;
      }
      
      private function initBuilds() : void
      {
         var _loc1_:int = PlayerManager.Instance.Self.Grade;
         setBuildState(0,_loc1_ >= 10?true:false);
         setBuildState(1,_loc1_ >= 3?true:false);
         setBuildState(2,_loc1_ >= 30?true:false);
         setBuildState(3,_loc1_ >= 25?true:false);
         setBuildState(4,_loc1_ >= 28?true:false);
         setBuildState(5,_loc1_ >= 46?true:false);
         setBuildState(6,true);
         setBuildState(7,GypsyNPCModel.getInstance().isStart());
         setBuildState(8,_loc1_ < 15?true:false,true);
         setBuildState(9,true);
         setBuildState(10,true);
         setBuildState(11,true);
         setBuildState(12,true);
         setBuildState(13,true);
         setBuildState(14,true);
         setBuildState(18,_loc1_ >= 15?true:false,true);
      }
      
      private function setBuildState(param1:int, param2:Boolean, param3:Boolean = false) : void
      {
         var _loc5_:String = _btnArray[param1];
         var _loc6_:BoneMovieStarling = _buildNpcMap[_loc5_];
         var _loc4_:Image = _buildTitleMap[_loc5_];
         if(_loc4_)
         {
            _loc4_.visible = param2;
         }
         if(param3)
         {
            _loc6_.visible = param2;
         }
      }
      
      public function setBuildVisible(param1:String, param2:Boolean) : void
      {
         var _loc3_:BoneMovieStarling = _buildNpcMap[param1];
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
      }
      
      public function setCharacterFilter(param1:String, param2:Boolean) : void
      {
         var _loc4_:* = null;
         var _loc3_:BoneMovieStarling = _buildNpcMap[param1];
         if(_loc3_)
         {
            _loc4_ = _loc3_.filter;
            _loc4_ && _loc4_.dispose();
            _loc3_.filter = !!param2?BlurFilter.createGlow(16776960,1,8,0.5):null;
         }
      }
      
      private function hideGuideNpc() : void
      {
         if(PlayerManager.Instance.Self.Grade > 20)
         {
            setBuildVisible("guide",false);
         }
      }
      
      public function changeBuildNpcBtnAni(param1:String, param2:String) : void
      {
         var _loc3_:BoneMovieStarling = _buildNpcMap[param1];
      }
      
      public function removeBuildNpcBtn(param1:String) : void
      {
         var _loc3_:BoneMovieStarling = _buildNpcMap[param1];
         if(_loc3_)
         {
            _loc3_.removeFromParent(true);
            delete _buildNpcMap[param1];
         }
         var _loc2_:Image = _buildTitleMap[param1];
         if(_loc2_)
         {
            _loc2_.removeFromParent(true);
            delete _buildTitleMap[param1];
         }
      }
      
      public function getBuildNpcBtnByName(param1:String) : BoneMovieStarling
      {
         return _buildNpcMap[param1];
      }
      
      public function checkAndPlay(param1:int, param2:int) : void
      {
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc9_:int = param1 - 70;
         var _loc8_:int = param2 + 70;
         if(_buildNpcEffectRectsMap == null)
         {
            if(BoneMovieFactory.instance.checkTextureAtlas("ui_hallScene_build_bones",0))
            {
               _buildNpcEffectRectsMap = {};
               var _loc13_:int = 0;
               var _loc12_:* = _buildNpcMap;
               for(var _loc5_ in _buildNpcMap)
               {
                  _loc7_ = _buildNpcMap[_loc5_];
                  _loc11_ = _loc7_.getBounds(_loc7_.parent);
                  _buildNpcEffectRectsMap[_loc5_] = _loc11_;
               }
               var _loc15_:int = 0;
               var _loc14_:* = _effectMap;
               for(var _loc10_ in _effectMap)
               {
                  _loc4_ = _effectMap[_loc10_];
                  _loc11_ = _loc4_.getBounds(_loc4_.parent);
                  _buildNpcEffectRectsMap[_loc10_] = _loc11_;
               }
            }
         }
         if(_buildNpcEffectRectsMap)
         {
            var _loc17_:int = 0;
            var _loc16_:* = _buildNpcEffectRectsMap;
            for(var _loc3_ in _buildNpcEffectRectsMap)
            {
               _loc6_ = _buildNpcMap[_loc3_];
               if(!_loc6_)
               {
                  _loc6_ = _effectMap[_loc3_];
               }
               if(_loc6_)
               {
                  _loc11_ = _buildNpcEffectRectsMap[_loc3_];
                  if(_loc11_.right > _loc9_ && _loc11_.left < _loc8_)
                  {
                     _loc6_.startClock();
                  }
                  else
                  {
                     _loc6_.stopClock();
                  }
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _buildNpcMap = null;
         _buildTitleMap = null;
         _effectMap = null;
         _bgLayer = null;
         _bottomLayer = null;
         _buildLayer = null;
         _effectLayer = null;
         _buildTitleLayer = null;
         _npcLayer = null;
         _buildNpcEffectRectsMap = null;
         super.dispose();
      }
   }
}
