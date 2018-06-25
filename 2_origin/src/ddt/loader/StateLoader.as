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
      
      private static function getLoaderDataList(type:String) : Array
      {
         var list:Array = null;
         var _loc3_:* = type;
         if("consortia" !== _loc3_)
         {
            if("farm" !== _loc3_)
            {
               if("pyramid" === _loc3_)
               {
                  list = [LoaderCreate.Instance.creatPyramidLoader()];
               }
            }
            else
            {
               list = [LoaderCreate.Instance.creatFarmPoultryInfo()];
            }
         }
         else
         {
            list = [LoaderCreate.Instance.creatBadgeInfoLoader(),LoaderCreate.Instance.creatConsortiaWeekRewardLoader()];
         }
         return list;
      }
      
      public static function startStarlingBonesLoad(last:String, next:String, complete:Function) : void
      {
         last = last;
         next = next;
         complete = complete;
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
      
      private static function loadBones(next:String) : void
      {
         next = next;
         var list:Array = getLoadBonesList(next);
         BonesLoaderManager.instance.addEventListener("complete",function(e:BonesLoaderEvent):void
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
      
      private static function checkBonesAssetComplete(next:String) : Boolean
      {
         var list:Array = getLoadBonesList(next);
         if(list == null || list.length == 0)
         {
            return true;
         }
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var obj in list)
         {
            if(!BoneMovieFactory.instance.checkTextureAtlas(obj.atlas,obj.useTpye))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function getStarlingSceneResource($type:String) : Array
      {
         var path:String = PathManager.getUIPath();
         var imagePath:String = PathManager.SITE_MAIN;
         var list:Array = null;
         var _loc5_:* = $type;
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
                        list = [];
                     }
                     else
                     {
                        list = [{"url":path + "/starling/consortiaGuard/consortiaGuard.png"},{"url":path + "/starling/consortiaGuard/consortiaGuard.xml"},{"url":path + "/starling/default/default_resource.png"},{"url":path + "/starling/default/default_resource.xml"}];
                     }
                  }
                  else
                  {
                     list = [{"url":path + "/starling/consortia_domain_scene/consortia_domain_scene1.png"},{"url":path + "/starling/consortia_domain_scene/consortia_domain_scene1.xml"},{"url":path + "/starling/consortia_domain_scene/consortia_domain_scene2.png"},{"url":path + "/starling/consortia_domain_scene/consortia_domain_scene2.xml"},{"url":path + "/starling/default/default_resource.png"},{"url":path + "/starling/default/default_resource.xml"},{
                        "url":path + "/starling/consortia_domain_scene/consortia_domain_scene_build.png",
                        "useType":2
                     },{
                        "url":path + "/starling/consortia_domain_scene/consortia_domain_scene_build.xml",
                        "useType":2
                     }];
                  }
               }
               else
               {
                  list = [{"url":path + "/starling/demon_chi_you_scene/demon_chi_you_scene.png"},{"url":path + "/starling/demon_chi_you_scene/demon_chi_you_scene.xml"},{"url":path + "/starling/demon_chi_you_scene/demon_chi_you_scene2.png"},{"url":path + "/starling/demon_chi_you_scene/demon_chi_you_scene2.xml"}];
               }
            }
            else
            {
               list = [{"url":path + "/starling/game/game.png"},{"url":path + "/starling/game/game.xml"},{"url":path + "/starling/game/gameprop.png"},{"url":path + "/starling/game/gameprop.xml"}];
            }
         }
         else
         {
            list = [{"url":path + "/starling/hall_scene/hall_scene.png"},{"url":path + "/starling/hall_scene/hall_scene.xml"},{"url":path + "/starling/default/default_resource.png"},{"url":path + "/starling/default/default_resource.xml"}];
         }
         return list;
      }
      
      private static function getLoadBonesList(type:String) : Array
      {
         var list:Array = [];
         var _loc3_:* = type;
         if("main" !== _loc3_)
         {
            if("roomlist" !== _loc3_)
            {
               if("battleRoom" !== _loc3_)
               {
                  if("consortiaGuard" === _loc3_)
                  {
                     list = [{
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
         return list;
      }
   }
}
