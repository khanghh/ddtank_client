/**
 * Created by hoanghongkhang on 6/23/17.
 */
package ddt.manager.ddtcmd
{
    import anotherDimension.controller.AnotherDimensionManager;
    import anotherDimension.model.AnotherDimensionResourceInfo;

    import consortion.ConsortionModelController;

    import ddt.data.goods.InventoryItemInfo;
    import ddt.data.goods.ItemTemplateInfo;
    import ddt.manager.ChatManager;

    import ddt.manager.DDTSettings;
    import ddt.manager.GameSocketOut;
    import ddt.manager.PlayerManager;
    import ddt.manager.SocketManager;

    import rutexp.RutExpManager;

    public class RutExpHandler extends AbstractCommandHandler
    {
        private const CMD:String = "#rutexp";

        public function RutExpHandler()
        {
            super();
        }

        public override function get cmd():String
        {
            return CMD;
        }

        public override function HandleCommand(param:Array):void
        {
            RutExpManager.Instance.toggleRutExp();
            ChatManager.Instance.sysChatYellow("RutExp: " + RutExpManager.Instance.IsRutExp);
        }
    }
}