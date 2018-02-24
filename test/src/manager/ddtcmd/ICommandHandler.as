package manager.ddtcmd
{
	public interface ICommandHandler
	{
		function HandleCommand(param:Array) : void;
		function get cmd() : String;
	}
}