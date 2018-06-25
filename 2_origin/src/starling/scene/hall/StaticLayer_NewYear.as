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
      
      private function __propertyChange(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Grade"])
         {
            initBuilds();
         }
      }
      
      private function createBottomThing() : void
      {
         var sea:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.sea");
         sea.x = -857;
         sea.y = -22;
         _bottomLayer.addChild(sea);
         var boat:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.boat");
         boat.x = 959;
         boat.y = -3;
         _bottomLayer.addChild(boat);
         var image:Image = StarlingMain.instance.createImage("hall_scene_bg_light");
         image.x = -27;
         image.y = 18;
         _bottomLayer.addChild(image);
      }
      
      private function createBuilds() : void
      {
         createBuild("dungeon");
         createBuild("cryptBoss");
         createBuild("home");
         var churchBuildImage:Image = StarlingMain.instance.createImage("hall_scene_church_build");
         churchBuildImage.x = 2446;
         _buildLayer.addChild(churchBuildImage);
         var flowImage1:Image = StarlingMain.instance.createImage("hall_scene_bg_flower1");
         flowImage1.x = 1836;
         flowImage1.y = 232;
         _buildLayer.addChild(flowImage1);
         var flowImage2:Image = StarlingMain.instance.createImage("hall_scene_bg_flower2");
         flowImage2.x = 3341;
         flowImage2.y = 176;
         _buildLayer.addChild(flowImage2);
         var flowImage3:Image = StarlingMain.instance.createImage("hall_scene_bg_flower3");
         flowImage3.x = 3704;
         flowImage3.y = 234;
         _buildLayer.addChild(flowImage3);
         createBuild("ringStation");
         createBuild("labyrinth");
         createBuild("roomList");
         var hall_scene_bg_dungeontree1_Image:Image = StarlingMain.instance.createImage("hall_scene_bg_dungeontree1");
         hall_scene_bg_dungeontree1_Image.x = 1362;
         hall_scene_bg_dungeontree1_Image.y = 9;
         _buildLayer.addChild(hall_scene_bg_dungeontree1_Image);
         var hall_scene_bg_dungeontree2_Image:Image = StarlingMain.instance.createImage("hall_scene_bg_dungeontree2");
         hall_scene_bg_dungeontree2_Image.x = 1824;
         hall_scene_bg_dungeontree2_Image.y = 94;
         _buildLayer.addChild(hall_scene_bg_dungeontree2_Image);
         var hall_scene_bg_roomlisttree_Image:Image = StarlingMain.instance.createImage("hall_scene_bg_roomlisttree");
         hall_scene_bg_roomlisttree_Image.x = 2251;
         hall_scene_bg_roomlisttree_Image.y = 45;
         _buildLayer.addChild(hall_scene_bg_roomlisttree_Image);
         var hall_scene_bg_church_Image:Image = StarlingMain.instance.createImage("hall_scene_bg_church");
         hall_scene_bg_church_Image.x = 2443;
         hall_scene_bg_church_Image.y = 302;
         _buildLayer.addChild(hall_scene_bg_church_Image);
         var hall_scene_bg_hometree_Image:Image = StarlingMain.instance.createImage("hall_scene_bg_hometree");
         hall_scene_bg_hometree_Image.x = 3093;
         hall_scene_bg_hometree_Image.y = 74;
         _buildLayer.addChild(hall_scene_bg_hometree_Image);
      }
      
      private function createNpcs() : void
      {
         var i:int = 0;
         var btnName:* = null;
         for(i = 6; i < _btnArray.length; )
         {
            btnName = _btnArray[i];
            if(btnName != "drgnBoatBuilding" && btnName != "laurel")
            {
               createNpc(btnName);
            }
            i++;
         }
      }
      
      private function createBulidEffects() : void
      {
         var lightEffect:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.lightEffect");
         lightEffect.x = 876;
         lightEffect.y = 193;
         _effectLayer.addChild(lightEffect);
         _effectMap["lightEffect"] = lightEffect;
         var butterfly1:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.butterfly1");
         butterfly1.scaleX = 1.45;
         butterfly1.scaleY = 1.45;
         butterfly1.x = 1125;
         butterfly1.y = 127;
         _effectLayer.addChild(butterfly1);
         _effectMap["butterfly1"] = butterfly1;
         var butterfly2:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.butterfly2");
         butterfly2.scaleX = 1.45;
         butterfly2.scaleY = 1.45;
         butterfly2.x = 1526;
         butterfly2.y = 109;
         _effectLayer.addChild(butterfly2);
         _effectMap["butterfly2"] = butterfly2;
         var dungeonEffect:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.dungeonEffect");
         dungeonEffect.x = 1410;
         dungeonEffect.y = 32;
         _effectLayer.addChild(dungeonEffect);
         _effectMap["dungeonEffect"] = dungeonEffect;
         var roomListEffect:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.roomListEffect");
         roomListEffect.scaleX = 0.36;
         roomListEffect.scaleY = 0.36;
         roomListEffect.x = 1980;
         roomListEffect.y = 113;
         _effectLayer.addChild(roomListEffect);
         _effectMap["roomListEffect"] = roomListEffect;
         var churchEffect:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.churchEffect");
         churchEffect.scaleX = 0.36;
         churchEffect.scaleY = 0.36;
         churchEffect.x = 2539;
         churchEffect.y = 280;
         _effectLayer.addChild(churchEffect);
         _effectMap["churchEffect"] = churchEffect;
         var labyrinthEffect:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.labyrinthEffect");
         labyrinthEffect.x = 2783;
         labyrinthEffect.y = 7;
         _effectLayer.addChild(labyrinthEffect);
         _effectMap["labyrinthEffect"] = labyrinthEffect;
         var ringStationEffect:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.ringStationEffect");
         ringStationEffect.scaleX = 0.36;
         ringStationEffect.scaleY = 0.36;
         ringStationEffect.x = 3474;
         ringStationEffect.y = 214;
         _effectLayer.addChild(ringStationEffect);
         _effectMap["ringStationEffect"] = ringStationEffect;
         var homeEffect2:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene.homeEffect2");
         homeEffect2.x = 3256;
         homeEffect2.y = 239;
         _effectLayer.addChild(homeEffect2);
         _effectMap["homeEffect2"] = homeEffect2;
      }
      
      private function createBuildTitles() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = btnTitlePos;
         for(var titleName in btnTitlePos)
         {
            createBuildTitle(titleName);
         }
      }
      
      private function createBuildTitle(titleName:String) : void
      {
         if(_buildTitleMap[titleName])
         {
            return;
         }
         var pos:Point = btnTitlePos[titleName];
         var titleImage:Image = StarlingMain.instance.createImage("hall_scene_build_title_" + titleName);
         titleImage.x = pos.x;
         titleImage.y = pos.y;
         _buildTitleLayer.addChild(titleImage);
         _buildTitleMap[titleName] = titleImage;
      }
      
      public function createBuild(btnName:String) : void
      {
         if(_buildNpcMap[btnName])
         {
            return;
         }
         var pos:Point = btnPos[btnName];
         var buildBtn:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene." + btnName);
         buildBtn.x = pos.x;
         buildBtn.y = pos.y;
         _buildLayer.addChild(buildBtn);
         _buildNpcMap[btnName] = buildBtn;
      }
      
      public function createNpc(btnName:String) : void
      {
         if(_buildNpcMap[btnName])
         {
            return;
         }
         var pos:Point = btnPos[btnName];
         var buildBtn:BoneMovieStarling = BoneMovieFactory.instance.creatBoneMovie("hallScene." + btnName);
         buildBtn.x = pos.x;
         buildBtn.y = pos.y;
         _npcLayer.addChild(buildBtn);
         _buildNpcMap[btnName] = buildBtn;
      }
      
      private function initBuilds() : void
      {
         var lv:int = PlayerManager.Instance.Self.Grade;
         setBuildState(0,lv >= 10?true:false);
         setBuildState(1,lv >= 3?true:false);
         setBuildState(2,lv >= 30?true:false);
         setBuildState(3,lv >= 25?true:false);
         setBuildState(4,lv >= 28?true:false);
         setBuildState(5,lv >= 46?true:false);
         setBuildState(6,true);
         setBuildState(7,GypsyNPCModel.getInstance().isStart());
         setBuildState(8,lv < 15?true:false,true);
         setBuildState(9,true);
         setBuildState(10,true);
         setBuildState(11,true);
         setBuildState(12,true);
         setBuildState(13,true);
         setBuildState(14,true);
         setBuildState(18,lv >= 15?true:false,true);
      }
      
      private function setBuildState(idx:int, enable:Boolean, isVisible:Boolean = false) : void
      {
         var btnName:String = _btnArray[idx];
         var buid:BoneMovieStarling = _buildNpcMap[btnName];
         var title:Image = _buildTitleMap[btnName];
         if(title)
         {
            title.visible = enable;
         }
         if(isVisible)
         {
            buid.visible = enable;
         }
      }
      
      public function setBuildVisible(btnName:String, isVisible:Boolean) : void
      {
         var buid:BoneMovieStarling = _buildNpcMap[btnName];
         if(buid)
         {
            buid.visible = isVisible;
         }
      }
      
      public function setCharacterFilter(btnName:String, value:Boolean) : void
      {
         var lastFilter:* = null;
         var buid:BoneMovieStarling = _buildNpcMap[btnName];
         if(buid)
         {
            lastFilter = buid.filter;
            lastFilter && lastFilter.dispose();
            buid.filter = !!value?BlurFilter.createGlow(16776960,1,8,0.5):null;
         }
      }
      
      private function hideGuideNpc() : void
      {
         if(PlayerManager.Instance.Self.Grade > 20)
         {
            setBuildVisible("guide",false);
         }
      }
      
      public function changeBuildNpcBtnAni(btnName:String, animationName:String) : void
      {
         var buid:BoneMovieStarling = _buildNpcMap[btnName];
      }
      
      public function removeBuildNpcBtn(btnName:String) : void
      {
         var buid:BoneMovieStarling = _buildNpcMap[btnName];
         if(buid)
         {
            buid.removeFromParent(true);
            delete _buildNpcMap[btnName];
         }
         var title:Image = _buildTitleMap[btnName];
         if(title)
         {
            title.removeFromParent(true);
            delete _buildTitleMap[btnName];
         }
      }
      
      public function getBuildNpcBtnByName(btnName:String) : BoneMovieStarling
      {
         return _buildNpcMap[btnName];
      }
      
      public function checkAndPlay(startCheckX:int, endCheckX:int) : void
      {
         var rect:* = null;
         var buildNpcBoneMovie:* = null;
         var effectBoneMovie:* = null;
         var boneMovie:* = null;
         var fixedStartCheckX:int = startCheckX - 70;
         var fixedEndCheckX:int = endCheckX + 70;
         if(_buildNpcEffectRectsMap == null)
         {
            if(BoneMovieFactory.instance.checkTextureAtlas("ui_hallScene_build_bones",0))
            {
               _buildNpcEffectRectsMap = {};
               var _loc13_:int = 0;
               var _loc12_:* = _buildNpcMap;
               for(var buildNpcName in _buildNpcMap)
               {
                  buildNpcBoneMovie = _buildNpcMap[buildNpcName];
                  rect = buildNpcBoneMovie.getBounds(buildNpcBoneMovie.parent);
                  _buildNpcEffectRectsMap[buildNpcName] = rect;
               }
               var _loc15_:int = 0;
               var _loc14_:* = _effectMap;
               for(var effectName in _effectMap)
               {
                  effectBoneMovie = _effectMap[effectName];
                  rect = effectBoneMovie.getBounds(effectBoneMovie.parent);
                  _buildNpcEffectRectsMap[effectName] = rect;
               }
            }
         }
         if(_buildNpcEffectRectsMap)
         {
            var _loc17_:int = 0;
            var _loc16_:* = _buildNpcEffectRectsMap;
            for(var nameKey in _buildNpcEffectRectsMap)
            {
               boneMovie = _buildNpcMap[nameKey];
               if(!boneMovie)
               {
                  boneMovie = _effectMap[nameKey];
               }
               if(boneMovie)
               {
                  rect = _buildNpcEffectRectsMap[nameKey];
                  if(rect.right > fixedStartCheckX && rect.left < fixedEndCheckX)
                  {
                     boneMovie.startClock();
                  }
                  else
                  {
                     boneMovie.stopClock();
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
