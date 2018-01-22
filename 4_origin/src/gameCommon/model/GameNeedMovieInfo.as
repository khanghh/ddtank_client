package gameCommon.model
{
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.StringUtils;
   import ddt.manager.PathManager;
   import flash.events.EventDispatcher;
   import gameCommon.LoadBombManager;
   
   public class GameNeedMovieInfo extends EventDispatcher
   {
       
      
      private var _type:int;
      
      public var path:String;
      
      private var _classPath:String;
      
      private var _loader:BaseLoader;
      
      public var bombId:int;
      
      public function GameNeedMovieInfo()
      {
         super();
      }
      
      public function get classPath() : String
      {
         return _classPath;
      }
      
      public function set classPath(param1:String) : void
      {
         _classPath = param1;
         if(_type == 4)
         {
            _classPath = _classPath.replace(/\./g,"_");
         }
         var _loc2_:String = classPath.replace("tank.resource.bombs.Bomb","");
         bombId = int(_loc2_);
      }
      
      public function get filePath() : String
      {
         var _loc1_:String = "";
         if(_type == 2)
         {
            _loc1_ = PathManager.SITE_MAIN;
         }
         return _loc1_ + path;
      }
      
      public function startLoad() : void
      {
         var _loc1_:* = null;
         if(StringUtils.endsWith(filePath.toLocaleLowerCase(),"jpg") || StringUtils.endsWith(filePath.toLocaleLowerCase(),"png"))
         {
            LoadResourceManager.Instance.creatAndStartLoad(filePath,0);
         }
         else
         {
            if(_type == 1)
            {
               LoadBombManager.Instance.loadLivingBomb(bombId);
            }
            if(_type == 2)
            {
               _loader = LoadResourceManager.Instance.createLoader(filePath,4);
               _loader.addEventListener("complete",__onLoaderNativeComplete);
               LoadResourceManager.Instance.startLoad(_loader);
            }
            if(_type == 3)
            {
               BonesLoaderManager.instance.removeEventListener("complete",__onLoaderBonesComplete);
               BonesLoaderManager.instance.addEventListener("complete",__onLoaderBonesComplete);
               LoadBombManager.Instance.loadLivingBomb3D(bombId);
            }
            if(_type == 4)
            {
               _loc1_ = PathManager.getBoneLivingPath();
               BoneMovieFactory.instance.model.addBoneVoByStyle(_classPath,_loc1_,2,0,"none");
               BonesLoaderManager.instance.removeEventListener("complete",__onLoaderBonesComplete);
               BonesLoaderManager.instance.addEventListener("complete",__onLoaderBonesComplete);
               BonesLoaderManager.instance.startLoader(_classPath,0,"fighting3d");
            }
         }
      }
      
      private function __onLoaderBonesComplete(param1:BonesLoaderEvent) : void
      {
         if(_type == 3 && LoadBombManager.Instance.getLivingBombComplete3D(bombId))
         {
            BonesLoaderManager.instance.removeEventListener("complete",__onLoaderBonesComplete);
            dispatchEvent(new LoaderEvent("complete",null));
         }
         else if(_type == 4 && param1.vo.styleName == classPath)
         {
            BonesLoaderManager.instance.removeEventListener("complete",__onLoaderBonesComplete);
            dispatchEvent(new LoaderEvent("complete",null));
         }
      }
      
      private function __onLoaderNativeComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__onLoaderNativeComplete);
         dispatchEvent(new LoaderEvent("complete",param1.loader));
      }
      
      public function get loader() : BaseLoader
      {
         return _loader;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
   }
}
