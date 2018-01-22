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
      
      public function StaticLayer()
      {
         _btnArray = ["dungeon","roomList","labyrinth","home","ringStation","cryptBoss","church","gypsy","guide","constrion","store","auction","bluePlatform","goldPlatform","redPlatform","drgnBoatBuilding","laurel","magicHouse","hotspring","poster"];
         super();
         _buildNpcMap = {};
         _buildTitleMap = {};
         _buildImageMap = {};
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
         var _loc2_:BoneMovieFastStarling = BoneMovieFactory.instance.creatBoneMovieFast("hallScene.sea");
         _loc2_.x = -857;
         _loc2_.y = -22;
         _bottomLayer.addChild(_loc2_);
         var _loc3_:BoneMovieFastStarling = BoneMovieFactory.instance.creatBoneMovieFast("hallScene.boat");
         _loc3_.x = 959;
         _loc3_.y = -3;
         _bottomLayer.addChild(_loc3_);
         var _loc1_:Image = StarlingMain.instance.createImage("hall_scene_bg_light");
         _loc1_.y = 135;
         _bottomLayer.addChild(_loc1_);
      }
      
      private function createBuilds() : void
      {
         createBuild("dungeon");
         createBuild("cryptBoss");
         createBuild("home");
         var _loc1_:Image = StarlingMain.instance.createImage("hall_scene_church_build");
         _loc1_.x = 2446;
         _buildLayer.addChild(_loc1_);
         var _loc3_:Image = StarlingMain.instance.createImage("hall_scene_bg_flower1");
         _loc3_.x = 1836;
         _loc3_.y = 232;
         _buildLayer.addChild(_loc3_);
         var _loc2_:Image = StarlingMain.instance.createImage("hall_scene_bg_flower2");
         _loc2_.x = 3341;
         _loc2_.y = 176;
         _buildLayer.addChild(_loc2_);
         var _loc4_:Image = StarlingMain.instance.createImage("hall_scene_bg_flower3");
         _loc4_.x = 3704;
         _loc4_.y = 150;
         _buildLayer.addChild(_loc4_);
         createImageBuild("poster");
         createBuild("ringStation");
         createBuild("labyrinth");
         createBuild("roomList");
      }
      
      private function createNpcs() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 6;
         while(_loc2_ < _btnArray.length)
         {
            _loc1_ = _btnArray[_loc2_];
            if(_loc1_ != "drgnBoatBuilding" && _loc1_ != "laurel" && _loc1_ != "guide" && _loc1_ != "poster")
            {
               createNpc(_loc1_);
            }
            _loc2_++;
         }
      }
      
      private function createBulidEffects() : void
      {
         var _loc2_:BoneMovieFastStarling = BoneMovieFactory.instance.creatBoneMovieFast("hallScene.butterfly1");
         _loc2_.scaleX = 1.45;
         _loc2_.scaleY = 1.45;
         _loc2_.x = 1125;
         _loc2_.y = 127;
         _effectLayer.addChild(_loc2_);
         _effectMap["butterfly1"] = _loc2_;
         var _loc1_:BoneMovieFastStarling = BoneMovieFactory.instance.creatBoneMovieFast("hallScene.butterfly2");
         _loc1_.scaleX = 1.45;
         _loc1_.scaleY = 1.45;
         _loc1_.x = 1526;
         _loc1_.y = 109;
         _effectLayer.addChild(_loc1_);
         _effectMap["butterfly2"] = _loc1_;
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
         var _loc2_:BoneMovieFastStarling = BoneMovieFactory.instance.creatBoneMovieFast("hallScene." + param1);
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
         var _loc2_:BoneMovieFastStarling = BoneMovieFactory.instance.creatBoneMovieFast("hallScene." + param1);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         _npcLayer.addChild(_loc2_);
         _buildNpcMap[param1] = _loc2_;
      }
      
      public function createImageBuild(param1:String) : void
      {
         if(_buildImageMap[param1])
         {
            return;
         }
         var _loc3_:Point = btnPos[param1];
         var _loc2_:Image = StarlingMain.instance.createImage("hall_scene_image_" + param1);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         _npcLayer.addChild(_loc2_);
         _buildImageMap[param1] = _loc2_;
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
         setBuildState(9,true);
         setBuildState(10,true);
         setBuildState(11,true);
         setBuildState(12,true);
         setBuildState(13,true);
         setBuildState(14,true);
      }
      
      private function setBuildState(param1:int, param2:Boolean, param3:Boolean = false) : void
      {
         var _loc5_:String = _btnArray[param1];
         var _loc7_:BoneMovieFastStarling = _buildNpcMap[_loc5_];
         var _loc4_:Image = _buildTitleMap[_loc5_];
         var _loc6_:Image = _buildImageMap[_loc5_];
         if(_loc4_)
         {
            _loc4_.visible = param2;
         }
         if(param3)
         {
            _loc7_.visible = param2;
         }
         if(_loc6_)
         {
            _loc6_.visible = param2;
         }
      }
      
      public function setBuildVisible(param1:String, param2:Boolean) : void
      {
         var _loc3_:BoneMovieFastStarling = _buildNpcMap[param1];
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
      }
      
      public function setCharacterFilter(param1:String, param2:Boolean) : void
      {
         var _loc4_:* = null;
         var _loc3_:DisplayObject = _buildNpcMap[param1] || _buildImageMap[param1];
         if(_loc3_ && (_loc3_ is BoneMovieFastStarling || param1 == "poster"))
         {
            _loc4_ = _loc3_.filter;
            _loc4_ && _loc4_.dispose();
            _loc3_.filter = !!param2?BlurFilter.createGlow(16776960,1,8,0.5):null;
         }
      }
      
      private function hideGuideNpc() : void
      {
         if(PlayerManager.Instance.Self.Grade > 0)
         {
            setBuildVisible("guide",false);
         }
      }
      
      public function changeBuildNpcBtnAni(param1:String, param2:String) : void
      {
         var _loc3_:BoneMovieFastStarling = _buildNpcMap[param1];
      }
      
      public function removeBuildNpcBtn(param1:String) : void
      {
         var _loc4_:BoneMovieFastStarling = _buildNpcMap[param1];
         if(_loc4_)
         {
            _loc4_.removeFromParent(true);
            delete _buildNpcMap[param1];
         }
         var _loc2_:Image = _buildTitleMap[param1];
         if(_loc2_)
         {
            _loc2_.removeFromParent(true);
            delete _buildTitleMap[param1];
         }
         var _loc3_:Image = _buildImageMap[param1];
         if(_loc3_)
         {
            _loc3_.removeFromParent(true);
            delete _buildImageMap[param1];
         }
      }
      
      public function getBuildNpcBtnByName(param1:String) : BoneMovieFastStarling
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
         _buildImageMap = null;
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
