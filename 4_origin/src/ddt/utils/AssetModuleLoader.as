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
      
      public static function addModelLoader(type:String, loadType:int) : void
      {
         var list:Vector.<BaseLoader> = getLoaderResList(type,loadType);
         _loaderList = _loaderList.concat(list);
      }
      
      public static function addRequestLoader(loader:BaseLoader, isReset:Boolean = false) : void
      {
         if(isReset)
         {
            _loaderData.remove(loader.id);
         }
         _loaderList.push(loader);
      }
      
      public static function addCodeLoader(codeName:String, className:String) : void
      {
         var path:* = null;
         var codeLoader:* = null;
         if(PathManager.FLASHSITE && PathManager.FLASHSITE != "" && !CodeLoader.loaded(codeName))
         {
            path = PathManager.FLASHSITE + codeName;
            codeLoader = LoadResourceManager.Instance.createLoader(path,9);
            codeLoader.className = className;
            _loaderList.unshift(codeLoader);
         }
      }
      
      public static function startLoader(call:Function = null, params:Array = null, isSmallLoading:Boolean = true) : void
      {
         var i:int = 0;
         var loader:* = null;
         _loaderQueue.reset();
         _call = call;
         _params = params;
         var len:int = _loaderList.length;
         for(i = 0; i < len; )
         {
            loader = _loaderList[i] as BaseLoader;
            if(loader == null)
            {
               throw new Error("AssetModelLoader :: 加载项类型错误！请检查");
            }
            if(!_loaderData.hasKey(loader.id))
            {
               _loaderQueue.addLoader(loader);
            }
            i++;
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
            _loaderQueue.start(isSmallLoading);
         }
      }
      
      public static function startCodeLoader(call:Function = null, params:Array = null, isSmallLoading:Boolean = true, codeName:String = "4.png", className:String = "DDT_Core") : void
      {
         addCodeLoader(codeName,className);
         startLoader(call,params,isSmallLoading);
      }
      
      private static function getLoaderResList(type:String, loadType:int) : Vector.<BaseLoader>
      {
         var xmlLoader:* = null;
         var list:Vector.<BaseLoader> = new Vector.<BaseLoader>();
         if(PathManager.FLASHSITE == null || PathManager.FLASHSITE == "")
         {
            if(loadType >> 1 & 1)
            {
               xmlLoader = LoadResourceManager.Instance.createLoader(PathManager.getXMLPath(type),2);
               xmlLoader.analyzer = new XMLNativeAnalyzer(null);
               list.push(xmlLoader);
            }
         }
         if(loadType >> 0 & 1)
         {
            list.push(LoadResourceManager.Instance.createLoader(PathManager.getMornUIPath(type),8));
         }
         if(loadType >> 2 & 1)
         {
            list.push(LoadResourceManager.Instance.createLoader(PathManager.getSwfPath(type),4));
         }
         return list;
      }
      
      private static function __onLoadComplete(e:Event) : void
      {
         var i:int = 0;
         for(i = 0; i < _loaderQueue.loaders.length; )
         {
            if(_loaderQueue.loaders[i].isComplete)
            {
               _loaderData.add(_loaderQueue.loaders[i].id,true);
            }
            i++;
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
      
      private static function __onLoadClose(e:Event) : void
      {
         _loaderQueue.removeEventListener("complete",__onLoadComplete);
         _loaderQueue.removeEventListener("close",__onLoadClose);
      }
   }
}
