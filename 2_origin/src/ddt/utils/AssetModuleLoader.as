package ddt.utils
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.CodeLoader;
   import com.pickgliss.loader.CodeModuleLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.TextLoader;
   import com.pickgliss.loader.XMLNativeAnalyzer;
   import ddt.manager.PathManager;
   import flash.events.Event;
   import road7th.data.DictionaryData;
   
   public class AssetModuleLoader
   {
      
      public static const UI_TYPE:int = 1;
      
      public static const XML_TYPE:int = 2;
      
      public static const SWF_TYPE:int = 4;
      
      public static const XML_SWF_TYPE:int = 6;
      
      public static const UI_SWF_TYPE:int = 5;
      
      public static const UI_XML_TYPE:int = 3;
      
      public static const UI_XML_SWF_TYPE:int = 7;
      
      private static var _loaderQueue:QueueLoaderUtil = new QueueLoaderUtil();
      
      private static var _loaderData:DictionaryData = new DictionaryData();
      
      private static var _loaderList:Vector.<BaseLoader> = new Vector.<BaseLoader>();
      
      private static var _call:Function;
      
      private static var _params:Array;
       
      
      public function AssetModuleLoader()
      {
         super();
      }
      
      public static function addModelLoader(param1:String, param2:int) : void
      {
         var _loc3_:Vector.<BaseLoader> = getLoaderResList(param1,param2);
         _loaderList = _loaderList.concat(_loc3_);
      }
      
      public static function addRequestLoader(param1:BaseLoader, param2:Boolean = false) : void
      {
         if(param2)
         {
            _loaderData.remove(param1.id);
         }
         _loaderList.push(param1);
      }
      
      public static function addCodeLoader(param1:String, param2:String) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(PathManager.FLASHSITE && PathManager.FLASHSITE != "" && !CodeLoader.loaded(param1))
         {
            _loc3_ = PathManager.FLASHSITE + param1;
            _loc4_ = LoadResourceManager.Instance.createLoader(_loc3_,9);
            _loc4_.className = param2;
            _loaderList.unshift(_loc4_);
         }
      }
      
      public static function startLoader(param1:Function = null, param2:Array = null, param3:Boolean = true) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         _loaderQueue.reset();
         _call = param1;
         _params = param2;
         var _loc5_:int = _loaderList.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loaderList[_loc6_] as BaseLoader;
            if(_loc4_ == null)
            {
               throw new Error("AssetModelLoader :: 加载项类型错误！请检查");
            }
            if(!_loaderData.hasKey(_loc4_.id))
            {
               _loaderQueue.addLoader(_loc4_);
            }
            _loc6_++;
         }
         _loaderList.splice(0,_loaderList.length);
         if(_loaderQueue.length <= 0)
         {
            if(_call)
            {
               _call.apply(null,_params);
            }
         }
         else
         {
            _loaderQueue.addEventListener("complete",__onLoadComplete);
            _loaderQueue.addEventListener("close",__onLoadClose);
            _loaderQueue.start(param3);
         }
      }
      
      public static function startCodeLoader(param1:Function = null, param2:Array = null, param3:Boolean = true, param4:String = "4.png", param5:String = "DDT_Core") : void
      {
         addCodeLoader(param4,param5);
         startLoader(param1,param2,param3);
      }
      
      private static function getLoaderResList(param1:String, param2:int) : Vector.<BaseLoader>
      {
         var _loc4_:* = null;
         var _loc3_:Vector.<BaseLoader> = new Vector.<BaseLoader>();
         if(PathManager.FLASHSITE == null || PathManager.FLASHSITE == "")
         {
            if(param2 >> 1 & 1)
            {
               _loc4_ = LoadResourceManager.Instance.createLoader(PathManager.getXMLPath(param1),2);
               _loc4_.analyzer = new XMLNativeAnalyzer(null);
               _loc3_.push(_loc4_);
            }
         }
         if(param2 >> 0 & 1)
         {
            _loc3_.push(LoadResourceManager.Instance.createLoader(PathManager.getMornUIPath(param1),8));
         }
         if(param2 >> 2 & 1)
         {
            _loc3_.push(LoadResourceManager.Instance.createLoader(PathManager.getSwfPath(param1),4));
         }
         return _loc3_;
      }
      
      private static function __onLoadComplete(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _loaderQueue.loaders.length)
         {
            if(_loaderQueue.loaders[_loc2_].isComplete)
            {
               _loaderData.add(_loaderQueue.loaders[_loc2_].id,true);
            }
            _loc2_++;
         }
         _loaderQueue.removeEventListener("complete",__onLoadComplete);
         _loaderQueue.removeEventListener("close",__onLoadClose);
         if(_call)
         {
            _call.apply(null,_params);
         }
         _call = null;
         _params = null;
      }
      
      private static function __onLoadClose(param1:Event) : void
      {
         _loaderQueue.removeEventListener("complete",__onLoadComplete);
         _loaderQueue.removeEventListener("close",__onLoadClose);
      }
   }
}
