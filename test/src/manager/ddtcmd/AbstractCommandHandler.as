package manager.ddtcmd
{
	import ddt.manager.DDTSettings;

	public class AbstractCommandHandler implements ICommandHandler
	{

		public function AbstractCommandHandler()
		{
		}
		
		public function get cmd() : String
		{
			return null;
		}
		
		public function HandleCommand(param:Array):void
		{
		}
	}
}