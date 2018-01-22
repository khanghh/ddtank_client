package ddt.loader
{
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import ddt.manager.PathManager;
   import ddt.view.UIModuleSmallLoading;
   import road7th.DDTAssetManager;
   import starling.loader.StarlingQueueLoader;
   
   public class StateLoader
   {
      
      private static var _loadCall:Function;
      
      private static var _starlingSceneLoader:StarlingQueueLoader;
      
      private static var _lastStarlingSceneLoader:StarlingQueueLoader;
      
      private static var _loadBonesList:Array;
       
      
      public function StateLoader()
      {
         super();
      }
      
      private static function loadComplete() : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.setLoadingAlpha(1);
         if(_loadCall)
         {
            _loadCall();
         }
         _loadCall = null;
      }
      
      private static function getLoaderDataList(param1:String) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:* = param1;
         if("consortia" !== _loc3_)
         {
            if("farm" !== _loc3_)
            {
               if("pyramid" === _loc3_)
               {
                  _loc2_ = [LoaderCreate.Instance.creatPyramidLoader()];
               }
            }
            else
            {
               _loc2_ = [LoaderCreate.Instance.creatFarmPoultryInfo()];
            }
         }
         else
         {
            _loc2_ = [LoaderCreate.Instance.creatBadgeInfoLoader(),LoaderCreate.Instance.creatConsortiaWeekRewardLoader()];
         }
         return _loc2_;
      }
      
      public static function startStarlingBonesLoad(param1:String, param2:String, param3:Function) : void
      {
         last = param1;
         next = param2;
         complete = param3;
         onStarlingSceneLoadComplete = function():void
         {
            UIModuleSmallLoading.Instance.progress = 50;
            if(_starlingSceneLoader)
            {
               _starlingSceneLoader.dispose();
            }
            _starlingSceneLoader = null;
            if(checkBonesAssetComplete(next))
            {
               loadComplete();
            }
            else
            {
               loadBones(next);
            }
         };
         _loadCall = complete;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         var starlingArr:Array = getStarlingSceneResource(next);
         var loadArr:Array = [];
         if(last != null && last != "")
         {
            var _loc6_:int = 0;
            var _loc5_:* = starlingArr;
            for each(assetInfo in starlingArr)
            {
               var matches:Array = StarlingQueueLoader.NAME_REGEX.exec(assetInfo.url);
               var useType:int = !!assetInfo.hasOwnProperty("useType")?assetInfo.useType:0;
               if(DDTAssetManager.instance.changeModule(matches[1],next,useType))
               {
                  trace(matches[1] + ":加载完成.....starlingQueueLoader");
               }
               else
               {
                  loadArr.push(assetInfo);
               }
            }
            var _loc8_:int = 0;
            var _loc7_:* = getLoadBonesList(next);
            for each(assetInfo in getLoadBonesList(next))
            {
               useType = !!assetInfo.hasOwnProperty("useType")?assetInfo.useType:0;
               if(DDTAssetManager.instance.changeModule(matches[1],next,useType))
               {
                  trace(matches[1] + ":加载完成.....starlingQueueLoader");
               }
            }
            DDTAssetManager.instance.removeAllResByModule();
            DDTAssetManager.instance.removeAllResByModule(last);
         }
         if(loadArr.length > 0)
         {
            UIModuleSmallLoading.Instance.setLoadingAlpha(0);
            _starlingSceneLoader = new StarlingQueueLoader();
            _starlingSceneLoader.load(loadArr,onStarlingSceneLoadComplete,next);
         }
         else
         {
            onStarlingSceneLoadComplete();
         }
      }
      
      private static function loadBones(param1:String) : void
      {
         next = param1;
         var list:Array = getLoadBonesList(next);
         BonesLoaderManager.instance.addEventListener("complete",function(param1:BonesLoaderEvent):void
         {
            if(checkBonesAssetComplete(next))
            {
               BonesLoaderManager.instance.removeEventListener("complete",arguments.callee);
               loadComplete();
            }
         });
         var _loc4_:int = 0;
         var _loc3_:* = list;
         for each(obj in list)
         {
            BonesLoaderManager.instance.startLoaderByAtlas(obj.atlas,next);
         }
      }
      
      private static function checkBonesAssetComplete(param1:String) : Boolean
      {
         var _loc3_:Array = getLoadBonesList(param1);
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return true;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            if(!BoneMovieFactory.instance.checkTextureAtlas(_loc2_.atlas,_loc2_.useTpye))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function getStarlingSceneResource(param1:String) : Array
      {
         var _loc3_:String = PathManager.getUIPath();
         var _loc2_:String = PathManager.SITE_MAIN;
         var _loc4_:Array = null;
         var _loc5_:* = param1;
         if("main" !== _loc5_)
         {
            if("fighting3d" !== _loc5_)
            {
               if("demon_chi_you" !== _loc5_)
               {
                  if("consortia_domain" !== _loc5_)
                  {
                     if("consortiaGuard" !== _loc5_)
                     {
                        _loc4_ = [];
                     }
                     else
                     {
                        _loc4_ = [{"url":_loc3_ + "/starling/consortiaGuard/consortiaGuard.png"},{"url":_loc3_ + "/starling/consortiaGuard/consortiaGuard.xml"},{"url":_loc3_ + "/starling/default/default_resource.png"},{"url":_loc3_ + "/starling/default/default_resource.xml"}];
                     }
                  }
                  else
                  {
                     _loc4_ = [{"url":_loc3_ + "/starling/consortia_domain_scene/consortia_domain_scene1.png"},{"url":_loc3_ + "/starling/consortia_domain_scene/consortia_domain_scene1.xml"},{"url":_loc3_ + "/starling/consortia_domain_scene/consortia_domain_scene2.png"},{"url":_loc3_ + "/starling/consortia_domain_scene/consortia_domain_scene2.xml"},{"url":_loc3_ + "/starling/default/default_resource.png"},{"url":_loc3_ + "/starling/default/default_resource.xml"},{
                        "url":_loc3_ + "/starling/consortia_domain_scene/consortia_domain_scene_build.png",
                        "useType":2
                     },{
                        "url":_loc3_ + "/starling/consortia_domain_scene/consortia_domain_scene_build.xml",
                        "useType":2
                     }];
                  }
               }
               else
               {
                  _loc4_ = [{"url":_loc3_ + "/starling/demon_chi_you_scene/demon_chi_you_scene.png"},{"url":_loc3_ + "/starling/demon_chi_you_scene/demon_chi_you_scene.xml"},{"url":_loc3_ + "/starling/demon_chi_you_scene/demon_chi_you_scene2.png"},{"url":_loc3_ + "/starling/demon_chi_you_scene/demon_chi_you_scene2.xml"}];
               }
            }
            else
            {
               _loc4_ = [{"url":_loc3_ + "/starling/game/game.png"},{"url":_loc3_ + "/starling/game/game.xml"},{"url":_loc3_ + "/starling/game/gameprop.png"},{"url":_loc3_ + "/starling/game/gameprop.xml"}];
            }
         }
         else
         {
            _loc4_ = [{"url":_loc3_ + "/starling/hall_scene/hall_scene.png"},{"url":_loc3_ + "/starling/hall_scene/hall_scene.xml"},{"url":_loc3_ + "/starling/default/default_resource.png"},{"url":_loc3_ + "/starling/default/default_resource.xml"}];
         }
         return _loc4_;
      }
      
      private static function getLoadBonesList(param1:String) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:* = param1;
         if("main" !== _loc3_)
         {
            if("roomlist" !== _loc3_)
            {
               if("battleRoom" !== _loc3_)
               {
                  if("consortiaGuard" === _loc3_)
                  {
                     _loc2_ = [{
                        "atlas":"consortiaGuardBones1",
                        "useType":0
                     },{
                        "atlas":"consortiaGuardBones2",
                        "useType":0
                     }];
                  }
               }
            }
         }
         return _loc2_;
      }
   }
}
