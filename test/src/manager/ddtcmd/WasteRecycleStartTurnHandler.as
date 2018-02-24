package manager.ddtcmd
{
	import ddt.manager.DDTSettings;
	import ddt.manager.SocketManager;

	public class WasteRecycleStartTurnHandler extends AbstractCommandHandler
	{
		private const CMD:String = "#taitao";
		
		public function WasteRecycleStartTurnHandler()
		{
			super();
		}
		
		public override function get cmd():String
		{
			return CMD;
		}
		
		public override function HandleCommand(param:Array):void
		{
			var count:int = 0;
			var i:int = 0;
			if (param.length == 2)
			{
				count = int(param[1]);
				for	(i = 0; i < count; i++)
				{
					SocketManager.Instance.out.sendWasteRecycleStartTurn();
				}
			}
			else 
			{
				SocketManager.Instance.out.sendWasteRecycleStartTurn();
			}
		}
	}
}