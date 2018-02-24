package ddt.manager.ddtcmd
{
	import ddt.manager.ChatManager;
	import ddt.manager.DDTSettings;
	
	public class SettingsHandler extends AbstractCommandHandler
	{
		private const CMD:String = "#setting";
		public function SettingsHandler()
		{
			super();
		}
		
		public override function get cmd():String
		{
			return CMD;
		}
		
		public override function HandleCommand(param:Array):void
		{
			for each (var args:String in param)
			{
				var attrs:Array = args.split('=');
				switch (attrs[0])
				{

				}
			}
		}
	}
}