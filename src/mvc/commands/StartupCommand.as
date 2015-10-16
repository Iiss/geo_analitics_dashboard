package mvc.commands 
{
	import eu.alebianco.robotlegs.utils.impl.SequenceMacro;
	import ru.marstefo.liss.net.commands.LoadConfigCommand;
	import ru.marstefo.liss.net.commands.SFSConnectCommand;
	import ru.marstefo.liss.net.commands.SFSLoginCommand;
	import ru.marstefo.liss.net.commands.SFSJoinRoomCommand;
	import mvc.commands.SetupSessionCommand;
	/**
	 * ...
	 * @author liss
	 */
	public class StartupCommand extends SequenceMacro
	{
		override public function prepare():void 
		{
			add(LoadConfigCommand);
			add(SFSConnectCommand);
			add(SFSLoginCommand);
			add(SFSJoinRoomCommand);
		}	
	}
}