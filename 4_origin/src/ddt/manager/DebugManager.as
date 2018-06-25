package ddt.manager
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.LoaderContext;
   import flash.utils.getDefinitionByName;
   
   public class DebugManager
   {
      
      private static const USER:String = "admin";
      
      private static const PWD:String = "ddt";
      
      private static var _ins:DebugManager;
       
      
      private var _user:String;
      
      private var _pwd:String;
      
      private var _address:String = "127.0.0.1";
      
      private var _port:String = "5800";
      
      private var _started:Boolean = false;
      
      private var _loadedMonster:Boolean = false;
      
      private var _loader:Loader;
      
      public function DebugManager()
      {
         super();
      }
      
      public static function getInstance() : DebugManager
      {
         if(_ins == null)
         {
            _ins = new DebugManager();
         }
         return _ins;
      }
      
      public function get enabled() : Boolean
      {
         return _started && _loadedMonster;
      }
      
      private function loadMonster() : void
      {
         if(!_loadedMonster)
         {
            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener("complete",__monsterComplete);
            _loader.contentLoaderInfo.addEventListener("progress",__progress);
            _loader.contentLoaderInfo.addEventListener("ioError",__ioError);
            _loader.load(new URLRequest(PathManager.getMonsterPath()),new LoaderContext(false,ApplicationDomain.currentDomain));
         }
      }
      
      private function __progress(event:ProgressEvent) : void
      {
         var rate:int = event.bytesLoaded / event.bytesTotal * 100;
         ChatManager.Instance.sysChatYellow("Monster 已载入 " + rate + "%");
      }
      
      private function __ioError(event:IOErrorEvent) : void
      {
         var info:LoaderInfo = event.currentTarget as LoaderInfo;
         info.removeEventListener("complete",__monsterComplete);
         info.removeEventListener("progress",__progress);
         info.removeEventListener("ioError",__ioError);
         ChatManager.Instance.sysChatYellow("Monster io error: " + event.text);
      }
      
      protected function __monsterComplete(event:Event) : void
      {
         var info:LoaderInfo = event.currentTarget as LoaderInfo;
         info.removeEventListener("complete",__monsterComplete);
         info.removeEventListener("progress",__progress);
         info.removeEventListener("ioError",__ioError);
         _loadedMonster = true;
         ChatManager.Instance.sysChatYellow("Monster载入完成。");
      }
      
      public function startup(str:String) : void
      {
         var arr:* = null;
         var param:* = null;
         var monsterRef:* = null;
         if(!_started)
         {
            arr = str.split(" -");
            var _loc8_:int = 0;
            var _loc7_:* = arr;
            for each(var s in arr)
            {
               param = s.split(" ");
               var _loc6_:* = param[0];
               if("u" !== _loc6_)
               {
                  if("p" !== _loc6_)
                  {
                     if("host" !== _loc6_)
                     {
                        if("P" === _loc6_)
                        {
                           _port = param[1];
                        }
                     }
                     else
                     {
                        _address = param[1];
                     }
                  }
                  else
                  {
                     _pwd = param[1];
                  }
               }
               else
               {
                  _user = param[1];
               }
            }
            try
            {
               if(_user != "admin" || _pwd != "ddt")
               {
                  return;
               }
               monsterRef = getDefinitionByName("com.demonsters.debugger::MonsterDebugger") as Class;
               if(!monsterRef["initialized"])
               {
                  monsterRef["initialize"](StageReferance.stage);
               }
               monsterRef["startup"](_address,_port,onDebuggerConnect);
               return;
            }
            catch(e:Error)
            {
               ChatManager.Instance.sysChatYellow(e.toString());
               return;
            }
         }
      }
      
      private function onDebuggerConnect() : void
      {
         ChatManager.Instance.sysChatYellow("Monster 已经启动。");
         _started = true;
      }
      
      public function shutdown() : void
      {
         var monsterRef:* = null;
         if(_started)
         {
            try
            {
               monsterRef = getDefinitionByName("com.demonsters.debugger::MonsterDebugger") as Class;
               monsterRef["shutdown"]();
               ChatManager.Instance.sysChatYellow("Monster 已经关闭。");
               _started = false;
               return;
            }
            catch(e:Error)
            {
               ChatManager.Instance.sysChatYellow(e.toString());
               return;
            }
         }
      }
      
      public function handle(str:String) : void
      {
         var op:* = null;
         if(!_started)
         {
            if(str.split(" ")[0] == "#loadmonster")
            {
               loadMonster();
            }
            else if(str.split(" ")[0] == "#debug-startup" && _loadedMonster)
            {
               startup(str);
            }
            else if(str.split(" ")[0] == "#info")
            {
               info();
            }
         }
         else if(_loadedMonster)
         {
            op = String(str.split(" ")[0]).replace("#","");
            var _loc3_:* = op;
            if("shutdown" === _loc3_)
            {
               shutdown();
            }
         }
      }
      
      private function info() : void
      {
         var output:String = "info:\n";
         var playerType:String = Capabilities.playerType;
         var playerVersion:String = Capabilities.version;
         var isDebugger:Boolean = Capabilities.isDebugger;
         output = output + ("PlayerType:" + playerType);
         output = output + ("\nPlayerVersion:" + playerVersion);
         output = output + ("\nisDebugger:" + isDebugger);
         if(playerType == "Desktop")
         {
            output = output + ("\ncpuArchitecture:" + Capabilities.cpuArchitecture);
         }
         output = output + ("\nhasIME:" + Capabilities.hasIME);
         output = output + ("\nlanguage:" + Capabilities.language);
         output = output + ("\nos:" + Capabilities.os);
         output = output + ("\nscreenResolutionX:" + Capabilities.screenResolutionX);
         output = output + ("\nscreenResolutionY:" + Capabilities.screenResolutionY);
         ChatManager.Instance.sysChatYellow(output);
      }
   }
}
