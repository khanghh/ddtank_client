package ddt.manager
{
	import com.pickgliss.toplevel.StageReferance;

import ddt.CoreManager;

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

		public function DebugManager(){super();}

		public static function getInstance() : DebugManager{return null;}

		public function get enabled() : Boolean{return false;}

		private function loadMonster() : void{}

		private function __progress(param1:ProgressEvent) : void{}

		private function __ioError(param1:IOErrorEvent) : void{}

		protected function __monsterComplete(param1:Event) : void{}

		public function startup(param1:String) : void{}

		private function onDebuggerConnect() : void{}

		public function shutdown() : void{}

		private function info() : void{}

//===================================================================================================
        public function handle(param1:String) : void
        {
            var args:Array = null;
            args = param1.split(" ");
            var ddtMgr:Class = null;
            try
            {
                ddtMgr = getDefinitionByName("ddt.manager::DDTManager") as Class;
                if (ddtMgr != null)
                    ddtMgr.Instance.handle(param1);
            }
            catch (e:Error)
            {
                ChatManager.Instance.sysChatYellow(e.getStackTrace());
            }
        }
	}
}
