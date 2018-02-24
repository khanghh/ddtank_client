package manager.ddtcmd
{
	import ddt.manager.ChatManager;
	import ddt.manager.DDTSettings;
	
	import gameCommon.PVPAutoControl;

	public class AutoPVPHandler extends AbstractCommandHandler
	{
		private const CMD:String = "#autopvp";
		
		public function AutoPVPHandler()
		{
			super();
		}
		
		public override function get cmd():String
		{
			return CMD;
		}
		
		public override function HandleCommand(param:Array):void
		{
			var state:Boolean = false;
			for each (var args:String in param)
			{
				var attrs:Array = args.split('=');
				switch (attrs[0])
				{
					case "autostate":
						state = attrs[1] == "true" ? true : false;
						PVPAutoControl.Instance.setAutoState(state);
						break;
				}
			}
		}
	}
}