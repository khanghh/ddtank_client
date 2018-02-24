package manager
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.pickgliss.loader.CodeLoader;
	import com.pickgliss.toplevel.StageReferance;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;

	import ddt.CoreManager;

	public class DebugManager extends EventDispatcher
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

		private function __progress(param1:ProgressEvent) : void
		{
			var _loc2_:int = param1.bytesLoaded / param1.bytesTotal * 100;
			ChatManager.Instance.sysChatYellow("Monster 已载入 " + _loc2_ + "%");
		}

		private function __ioError(param1:IOErrorEvent) : void
		{
			var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
			_loc2_.removeEventListener("complete",__monsterComplete);
			_loc2_.removeEventListener("progress",__progress);
			_loc2_.removeEventListener("ioError",__ioError);
			ChatManager.Instance.sysChatYellow("Monster io error: " + param1.text);
		}

		protected function __monsterComplete(param1:Event) : void
		{
			var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
			_loc2_.removeEventListener("complete",__monsterComplete);
			_loc2_.removeEventListener("progress",__progress);
			_loc2_.removeEventListener("ioError",__ioError);
			_loadedMonster = true;
			ChatManager.Instance.sysChatYellow("Monster载入完成。");
		}

		public function startup(param1:String) : void
		{
			var _loc5_:* = null;
			var _loc4_:* = null;
			var _loc2_:* = null;
			if(!_started)
			{
				_loc5_ = param1.split(" -");
				var _loc8_:int = 0;
				var _loc7_:* = _loc5_;
				for each(var _loc3_ in _loc5_)
				{
					_loc4_ = _loc3_.split(" ");
					var _loc6_:* = _loc4_[0];
					if("u" !== _loc6_)
					{
						if("p" !== _loc6_)
						{
							if("host" !== _loc6_)
							{
								if("P" === _loc6_)
								{
									_port = _loc4_[1];
								}
							}
							else
							{
								_address = _loc4_[1];
							}
						}
						else
						{
							_pwd = _loc4_[1];
						}
					}
					else
					{
						_user = _loc4_[1];
					}
				}
				try
				{
					if(_user != "admin" || _pwd != "ddt")
					{
						return;
					}
					_loc2_ = getDefinitionByName("com.demonsters.debugger::MonsterDebugger") as Class;
					if(!_loc2_["initialized"])
					{
						_loc2_["initialize"](StageReferance.stage);
					}
					_loc2_["startup"](_address,_port,onDebuggerConnect);
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
			var _loc1_:* = null;
			if(_started)
			{
				try
				{
					_loc1_ = getDefinitionByName("com.demonsters.debugger::MonsterDebugger") as Class;
					_loc1_["shutdown"]();
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



		public function handle(param1:String) : void
		{
			var args:Array = null;
			args = param1.split(" ");
			var ddtMgr:Class = null;
			var coreManager:CoreManager = new CoreManager();
			try
			{

				ddtMgr = getDefinitionByName("ddt.manager::DDTManager") as Class;
				if (ddtMgr != null)
					ddtMgr.Instance.handle(param1);
	//				if (!_started)
	//				{
	//					if (param1 == "#load5")
	//					{
	//						ChatManager.Instance.sysChatRed("loading 5.png ...");
	//						coreManager.show("5.png");
	//						_started = true;
	//						ChatManager.Instance.sysChatRed("5.png loaded !");
	//					}
	//				}
	//				else
	//				{
	//					ddtMgr = getDefinitionByName("ddt.manager::DDTManager") as Class;
	//					ddtMgr.Instance.handle(param1);
	//					//handleCommand(param1);
	//				}
			}
			catch (e:Error)
			{
				ChatManager.Instance.sysChatYellow(e.getStackTrace());
			}
		}

		private function info() : void {
			var _loc2_:String = "info:\n";
			var _loc1_:String = Capabilities.playerType;
			var _loc4_:String = Capabilities.version;
			var _loc3_:Boolean = Capabilities.isDebugger;
			_loc2_ = _loc2_ + ("PlayerType:" + _loc1_);
			_loc2_ = _loc2_ + ("\nPlayerVersion:" + _loc4_);
			_loc2_ = _loc2_ + ("\nisDebugger:" + _loc3_);
			if (_loc1_ == "Desktop") {
				_loc2_ = _loc2_ + ("\ncpuArchitecture:" + Capabilities.cpuArchitecture);
			}
			_loc2_ = _loc2_ + ("\nhasIME:" + Capabilities.hasIME);
			_loc2_ = _loc2_ + ("\nlanguage:" + Capabilities.language);
			_loc2_ = _loc2_ + ("\nos:" + Capabilities.os);
			_loc2_ = _loc2_ + ("\nscreenResolutionX:" + Capabilities.screenResolutionX);
			_loc2_ = _loc2_ + ("\nscreenResolutionY:" + Capabilities.screenResolutionY);
			ChatManager.Instance.sysChatYellow(_loc2_);
		}

		private function showInfo()
		{
			ChatManager.Instance.sysChatYellow("Hello !");
		}
	}
}
