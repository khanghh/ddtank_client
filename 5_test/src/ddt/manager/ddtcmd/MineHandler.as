/**
 * Created by hoanghongkhang on 3/16/18.
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

    import flash.events.TimerEvent;

    import flash.utils.Timer;

    public class MineHandler extends AbstractCommandHandler
    {
        private const CMD:String = "#dig";

        private var _isDig:Boolean = false;

        private var _depth:int = 1;

        private var _digTimer:Timer;

        public function MineHandler()
        {
            _digTimer = new Timer(7000);
            super();
        }

        public override function get cmd() : String
        {
            return CMD;
        }

        private function __onTimer(param1:TimerEvent) : void
        {
            SocketManager.Instance.out.sendDigHandler(_depth);
        }

        public override function HandleCommand(param:Array):void
        {
            try
            {
                if (!_isDig)
                {
                    if (param.length > 1)
                    {
                        _depth = parseInt(param[1]);
                    }
                    _digTimer.addEventListener("timer", __onTimer);
                    _digTimer.start();
                    _isDig = true;
                    ChatManager.Instance.sysChatYellow("Bắt đầu đào khoáng ở tầng " + _depth.toString())
                }
                else
                {
                    if (param.length > 1)
                    {
                        _depth = parseInt(param[1]);
                        ChatManager.Instance.sysChatYellow("Bắt đầu đào khoáng ở tầng " + _depth.toString())
                    }
                    else {
                        _digTimer.stop();
                        _digTimer.removeEventListener("timer", __onTimer);
                        _isDig = false;
                        ChatManager.Instance.sysChatYellow("Đã dừng đào khoáng.")
                    }
                }
            }
            catch (e:Error) {
                ChatManager.Instance.sysChatYellow(e.getStackTrace());
            }
        }
    }
}