package manager.ddtcmd
{
	import consortion.ConsortionModelController;
	
	import ddt.manager.DDTSettings;
	
	public class ConsortionBankHandler extends AbstractCommandHandler
	{
		private const CMD:String = "#ks";
		public function ConsortionBankHandler()
		{
			super();
		}
		
		public override function get cmd() : String
		{
			return CMD;
		}
		
		public override function HandleCommand(param:Array):void
		{
			ConsortionModelController.Instance.alertBankFrame();
		}
	}
}