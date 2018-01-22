package ddt.manager.ddtcmd
{
	import ddt.manager.DDTSettings;
	import ddt.manager.SocketManager;

	public class DDQiYuanJoinRewardHandler extends AbstractCommandHandler
	{
		private const CMD:String = "#nhan";
		
		public function DDQiYuanJoinRewardHandler()
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
			if (param.length == 2)
			{
				count = int(param[1]);
				for	(var i:int = 0; i < count; i++)
				{
					SocketManager.Instance.out.getDDQiYuanJoinReward();
				}
			}
			else 
			{
				SocketManager.Instance.out.getDDQiYuanJoinReward();
			}
		}
	}
}