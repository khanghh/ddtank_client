/**
 * Created by hoanghongkhang on 6/23/17.
 */
package ddt.manager.ddtcmd
{
import consortion.ConsortionModelController;

import ddt.data.goods.InventoryItemInfo;
import ddt.data.goods.ItemTemplateInfo;
import ddt.manager.ChatManager;

import ddt.manager.DDTSettings;
import ddt.manager.GameSocketOut;
import ddt.manager.PlayerManager;
import ddt.manager.SocketManager;

public class RetrieveHandler extends AbstractCommandHandler
{
    private const CMD:String = "#tl";
    public function RetrieveHandler()
    {
        super();
    }

    public override function get cmd() : String
    {
        return CMD;
    }

    public override function HandleCommand(param:Array):void
    {
        var item1:int = 0;
        var item2:int = 0;
        var item3:int = 0;
        var item4:int = 0;
        var count:int = 0;
        for each (var args:String in param)
        {
            var attrs:Array = args.split('=');
            switch (attrs[0])
            {
                case "item1":
                    item1 = int(attrs[1]);
                    break;
                case "item2":
                    item2 = int(attrs[1]);
                    break;
                case "item3":
                    item3 = int(attrs[1]);
                    break;
                case "item4":
                    item4 = int(attrs[1]);
                    break;
                case "count":
                    count = int(attrs[1]);
                    break;
            }
        }

        ChatManager.Instance.sysChatYellow("count: " + count);

        if (item1 && item2 && item3 && item4 && count)
        {
            var arrItem1:Array.<InventoryItemInfo> = PlayerManager.Instance.Self.PropBag.findCellsByTempleteID(item1);
            var arrItem2:Array.<InventoryItemInfo> = PlayerManager.Instance.Self.PropBag.findCellsByTempleteID(item2);
            var arrItem3:Array.<InventoryItemInfo> = PlayerManager.Instance.Self.PropBag.findCellsByTempleteID(item3);
            var arrItem4:Array.<InventoryItemInfo> = PlayerManager.Instance.Self.PropBag.findCellsByTempleteID(item4);
            var i1:InventoryItemInfo = null;
            var i2:InventoryItemInfo = null;
            var i3:InventoryItemInfo = null;
            var i4:InventoryItemInfo = null;
            if (arrItem1.length > 0 && arrItem2.length > 0 && arrItem3.length > 0 && arrItem4.length > 0)
            {
                ChatManager.Instance.sysChatYellow("Bat dau");
                for (var i : int = count; i > 0; i--)
                {
                    if (i1 == null || i1.Count <= 0) i1 = arrItem1.pop();
                    if (i2 == null || i2.Count <= 0) i2 = arrItem2.pop();
                    if (i3 == null || i3.Count <= 0) i3 = arrItem3.pop();
                    if (i4 == null || i4.Count <= 0) i4 = arrItem4.pop();

                    if (i1 && i2 && i3 && i4)
                    {
                        if (i1.Count >= i && i2.Count >= i && i3.Count >= i && i4.Count >= i)
                        {
                            SocketManager.Instance.out.sendClearStoreBag();
                            SocketManager.Instance.out.sendMoveGoods(i1.BagType,i1.Place,12,1,1);
                            SocketManager.Instance.out.sendMoveGoods(i2.BagType,i2.Place,12,2,1);
                            SocketManager.Instance.out.sendMoveGoods(i3.BagType,i3.Place,12,3,1);
                            SocketManager.Instance.out.sendMoveGoods(i4.BagType,i4.Place,12,4,1);
                            SocketManager.Instance.out.sendEquipRetrieve();
                            SocketManager.Instance.out.sendClearStoreBag();
                            SocketManager.Instance.out.sendSaveDB();
                        }
                    }
                    else break;
                }
            }
            else
            {
                ChatManager.Instance.sysChatYellow("Không đủ vật phẩm");
            }
        }
    }
}
}