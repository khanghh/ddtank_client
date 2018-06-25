package com.pickgliss.loader
{
   import cmodule.decry.CLibInit;
   import com.crypto.NewCrypto;
   import com.pickgliss.ui.ComponentSetting;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class ModuleLoader extends DisplayLoader
   {
      
      private static var loader:CLibInit = new CLibInit();
       
      
      private var _isEqual:Boolean;
      
      private var _name:String;
      
      private var _isSecondLoad:Boolean = false;
      
      public function ModuleLoader(id:int, url:String, domain:ApplicationDomain)
      {
         this.domain = domain;
         super(id,url);
      }
      
      public static function decry(src:ByteArray) : ByteArray
      {
         var lib:Object = loader.init();
         var bytes:ByteArray = lib.decry(src);
         return bytes;
      }
      
      public static function getDefinition(classname:String) : *
      {
         return getDefinitionByName(classname);
      }
      
      public static function hasDefinition(classname:String) : Boolean
      {
         return DisplayLoader.Context.applicationDomain.hasDefinition(classname);
      }
      
      override public function loadFromBytes(data:ByteArray) : void
      {
         _starTime = getTimer();
         _displayLoader.contentLoaderInfo.addEventListener("complete",__onContentLoadComplete);
         analyMd5(data);
      }
      
      override protected function __onDataLoadComplete(event:Event) : void
      {
         var temp:* = null;
         var tempII:* = null;
         removeEvent();
         unload();
         if(DisplayLoader.isDebug)
         {
            _displayLoader.contentLoaderInfo.addEventListener("complete",__onContentLoadComplete);
            if(_loader.data.length == 0)
            {
               return;
            }
            temp = _loader.data;
            temp = NewCrypto.decry(temp);
            if(temp[0] != 67 || temp[1] != 87 || temp[2] != 83)
            {
               temp = decry(temp);
            }
            if(domain != null)
            {
               _displayLoader.loadBytes(temp,DisplayLoader.Context);
            }
            else
            {
               _displayLoader.loadBytes(temp,Context);
            }
         }
         else
         {
            _displayLoader.contentLoaderInfo.addEventListener("complete",__onContentLoadComplete);
            if(_loader.data.length == 0)
            {
               return;
            }
            tempII = _loader.data;
            LoaderSavingManager.cacheFile(_url,tempII,false);
            analyMd5(tempII);
         }
      }
      
      public function analyMd5(content:ByteArray) : void
      {
         var temp:* = null;
         var name:String = getName();
         if(ComponentSetting.USEMD5 && (ComponentSetting.md5Dic[name] || hasHead(content)))
         {
            if(compareMD5(content,name))
            {
               try
               {
                  temp = new ByteArray();
                  content.position = 37;
                  content.readBytes(temp);
                  handleModule(temp);
               }
               catch(e:Error)
               {
                  if(ExternalInterface.available)
                  {
                     ExternalInterface.call("alert","出现问题了，点击确定重新加载！");
                  }
                  reload();
               }
            }
            else if(_isSecondLoad)
            {
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("alert",_currentLoadPath + ":is old");
               }
            }
            else
            {
               reload();
            }
         }
         else
         {
            handleModule(content);
         }
      }
      
      private function reload() : void
      {
         _url = _url.replace(ComponentSetting.FLASHSITE,ComponentSetting.BACKUP_FLASHSITE);
         _isLoading = false;
         startLoad(_url);
         _isSecondLoad = true;
      }
      
      private function getName() : String
      {
         var i:int = 0;
         var name:String = "";
         for(i = 0; i < ComponentSetting.MD5_OBJECT.length; )
         {
            if(_url.indexOf(ComponentSetting.MD5_OBJECT[i]) != -1)
            {
               name = _url.substring(_url.lastIndexOf("/") + 1,_url.indexOf(ComponentSetting.MD5_OBJECT[i]) + ComponentSetting.MD5_OBJECT[i].length);
            }
            i++;
         }
         return name.toLowerCase();
      }
      
      private function compareMD5(temp:ByteArray, fileName:String) : Boolean
      {
         var source:int = 0;
         var target:int = 0;
         var md5Bytes:ByteArray = new ByteArray();
         md5Bytes.writeUTFBytes(ComponentSetting.md5Dic[fileName]);
         md5Bytes.position = 0;
         temp.position = 5;
         while(md5Bytes.bytesAvailable > 0)
         {
            source = md5Bytes.readByte();
            target = temp.readByte();
            if(source != target)
            {
               return false;
            }
         }
         return true;
      }
      
      private function hasHead(temp:ByteArray) : Boolean
      {
         var source:int = 0;
         var target:int = 0;
         var road7Byte:ByteArray = new ByteArray();
         road7Byte.writeUTFBytes(ComponentSetting.swf_head);
         road7Byte.position = 0;
         temp.position = 0;
         while(road7Byte.bytesAvailable > 0)
         {
            source = road7Byte.readByte();
            target = temp.readByte();
            if(source != target)
            {
               return false;
            }
         }
         return true;
      }
      
      private function handleModule(temp:ByteArray) : void
      {
         temp.position = 0;
         temp = NewCrypto.decry(temp);
         if(temp[0] != 67 || temp[1] != 87 || temp[2] != 83)
         {
            temp = decry(temp);
         }
         if(domain != null)
         {
            _displayLoader.loadBytes(temp,new LoaderContext(false,domain));
         }
         else
         {
            _displayLoader.loadBytes(temp,Context);
         }
      }
      
      override public function get type() : int
      {
         return 4;
      }
   }
}
