package ddt.view.caddyII
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   
   public class CaddyBagView extends Sprite implements Disposeable
   {
      
      public static const NUMBER:int = 5;
      
      public static const SUM_NUMBER:int = 25;
      
      public static const NULL_CELL_POINT:String = "send_nullCell_poing";
      
      public static const GET_GOODSINFO:String = "caddy_get_goodsinfo";
       
      
      private var _bg:MutipleImage;
      
      private var _list:SimpleTileList;
      
      protected var _sellAllBtn:BaseButton;
      
      protected var _getAllBtn:BaseButton;
      
      private var _openAll:SimpleBitmapButton;
      
      protected var _node:FilterFrameText;
      
      private var _convertedBtn:BaseButton;
      
      private var _node1:FilterFrameText;
      
      private var _exchangeBtn:SimpleBitmapButton;
      
      private var _exchangeTxt:FilterFrameText;
      
      private var _numBg:Image;
      
      private var _exchengBg:Bitmap;
      
      private var _haveExchange:FilterFrameText;
      
      private var _CaddyInfo:CaddyInfo;
      
      private var isConver:Boolean = false;
      
      private var isAlert:Boolean = false;
      
      private var _selectPlace:int = 0;
      
      private var _bg2:MovieImage;
      
      private var _selectedGoodsInfo:InventoryItemInfo;
      
      private var _items:Vector.<CaddyCell>;
      
      public function CaddyBagView()
      {
         super();
         initView();
         initEvents();
      }
      
      protected function initView() : void
      {
         var j:* = 0;
         var item1:* = null;
         var k:* = 0;
         var item2:* = null;
         var n:* = 0;
         var item3:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.LeftBG");
         addChild(_bg);
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("ddtCaddbagView");
         addChild(_bg2);
         _list = ComponentFactory.Instance.creatCustomObject("caddy.SimpleTileList",[5]);
         addChild(_list);
         _CaddyInfo = new CaddyInfo();
         if(CaddyModel.instance.type == 8 || CaddyModel.instance.type == 9)
         {
            _openAll = ComponentFactory.Instance.creatComponentByStylename("CaddyCardBoxBag.openAllBtn");
            addChild(_openAll);
         }
         if(CaddyModel.instance.type == 2 || CaddyModel.instance.type == 3 || CaddyModel.instance.type == 13)
         {
            _list = ComponentFactory.Instance.creatCustomObject("caddy.SimpleTileList",[5]);
            addChild(_list);
            _items = new Vector.<CaddyCell>();
            _list.beginChanges();
            for(j = uint(0); j < 25; )
            {
               item1 = new CaddyCell(j);
               _items.push(item1);
               item1.addEventListener("itemclick",__itemClick);
               _list.addChild(item1);
               j++;
            }
            _list.commitChanges();
            _sellAllBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.sellAllBtn");
            addChild(_sellAllBtn);
            _exchangeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.caddy.exchangeTxt1");
            _exchangeTxt.text = LanguageMgr.GetTranslation("tank.littlegame.exchange");
            _getAllBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.getAllBtn");
            addChild(_getAllBtn);
         }
         if(CaddyModel.instance.type == 1 || CaddyModel.instance.type == 10)
         {
            _list = ComponentFactory.Instance.creatCustomObject("caddy.SimpleTileList",[5]);
            addChild(_list);
            _items = new Vector.<CaddyCell>();
            _list.beginChanges();
            for(k = uint(0); k < 25; )
            {
               item2 = new CaddyCell(k);
               _items.push(item2);
               item2.addEventListener("itemclick",__itemClick);
               _list.addChild(item2);
               k++;
            }
            _node1 = ComponentFactory.Instance.creatComponentByStylename("asset.caddy.exchangeTxt");
            _node1.text = LanguageMgr.GetTranslation("tank.view.caddy.exchangeTxt");
            addChild(_node1);
            _list.commitChanges();
            _numBg = ComponentFactory.Instance.creatComponentByStylename("caddy.numberIII");
            addChild(_numBg);
            _numBg.width = 60;
            _exchengBg = ComponentFactory.Instance.creatBitmap("asset.awardSystem.exchange");
            addChild(_exchengBg);
            _convertedBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.convertedBtn");
            addChild(_convertedBtn);
            _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("core.shop.exchangeButton");
            PositionUtils.setPos(_exchangeBtn,"asset.caddy.exchangeBtn.pos");
            _exchangeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.caddy.exchangeTxt1");
            _exchangeTxt.text = LanguageMgr.GetTranslation("tank.littlegame.exchange");
            addChild(_exchangeBtn);
            _exchangeBtn.addChild(_exchangeTxt);
            _haveExchange = ComponentFactory.Instance.creatComponentByStylename("caddy.haveexchangeTxt");
            addChild(_haveExchange);
         }
         if(CaddyModel.instance.type == 12)
         {
            _bg2.height = 61;
            _bg2.x = 13;
            _bg2.y = 296;
            _list = ComponentFactory.Instance.creatCustomObject("caddy.SimpleTileList",[5]);
            addChild(_list);
            _items = new Vector.<CaddyCell>();
            _list.beginChanges();
            for(n = uint(0); n < 25; )
            {
               item3 = new CaddyCell(n);
               _items.push(item3);
               item3.addEventListener("itemclick",__itemClick);
               _list.addChild(item3);
               n++;
            }
            _list.commitChanges();
            _sellAllBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.sellAllBtn");
            _sellAllBtn.x = 185;
            addChild(_sellAllBtn);
            _getAllBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.getAllBtn");
            addChild(_getAllBtn);
         }
      }
      
      protected function initEvents() : void
      {
         if(CaddyModel.instance.type == 1 || CaddyModel.instance.type == 10)
         {
            SocketManager.Instance.out.sendconverted(isConver);
         }
         SocketManager.Instance.out.sendQequestBadLuck();
         if(_sellAllBtn)
         {
            _sellAllBtn.addEventListener("click",_sellAll);
         }
         if(_getAllBtn)
         {
            _getAllBtn.addEventListener("click",_getAll);
         }
         if(_openAll)
         {
            _openAll.addEventListener("click",__openAllHandler);
         }
         if(_convertedBtn)
         {
            _convertedBtn.addEventListener("click",_convertedHandler);
         }
         if(_exchangeBtn)
         {
            _exchangeBtn.addEventListener("click",_exchangeHandler);
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(215),_getConverteds);
         SocketManager.Instance.removeEventListener(PkgEvent.format(211),_getexchange);
         CaddyModel.instance.bagInfo.addEventListener("update",_update);
         PlayerManager.Instance.Self.addEventListener("propertychange",__changeBadLuckNumber);
      }
      
      private function _getConverteds(event:PkgEvent) : void
      {
         var alert:* = null;
         var pkg:PackageIn = event.pkg;
         if(pkg.bytesAvailable == 0)
         {
            return;
         }
         _CaddyInfo = new CaddyInfo();
         _CaddyInfo.isConver = pkg.readBoolean();
         _CaddyInfo.totalSorce = pkg.readInt();
         _CaddyInfo.lotteryScore = pkg.readInt();
         pkg.clear();
         _haveExchange.text = String(_CaddyInfo.lotteryScore);
         if(_CaddyInfo.totalSorce != 0 && !_CaddyInfo.isConver && isAlert)
         {
            isAlert = false;
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.convertedAll",_CaddyInfo.totalSorce),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert.mouseEnabled = false;
            alert.addEventListener("response",_responseII);
         }
      }
      
      private function _getexchange(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _CaddyInfo.lotteryScore = pkg.readInt();
         _haveExchange.text = String(_CaddyInfo.lotteryScore);
      }
      
      private function _responseII(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            SocketManager.Instance.out.sendconverted(true);
         }
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function _exchangeHandler(event:MouseEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         if(_CaddyInfo.lotteryScore < 30)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.exchangeText1"));
         }
         else
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.exchangeAll",Math.floor(_CaddyInfo.lotteryScore / 30)),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert.mouseEnabled = false;
            alert.addEventListener("response",_responseIII);
         }
      }
      
      private function _convertedHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendconverted(isConver);
         isAlert = true;
      }
      
      private function _responseIII(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",_responseIII);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            SocketManager.Instance.out.sendExchange();
         }
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      protected function __openAllHandler(event:MouseEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         if(CaddyModel.instance.bagInfo.itemNumber > 0)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.opennAll"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert.moveEnable = false;
            alert.addEventListener("response",_responseIV);
         }
      }
      
      private function _responseIV(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            SocketManager.Instance.out.sendOpenAll();
         }
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      protected function removeEvents() : void
      {
         if(_sellAllBtn)
         {
            _sellAllBtn.removeEventListener("click",_sellAll);
         }
         if(_convertedBtn)
         {
            _convertedBtn.removeEventListener("click",_convertedHandler);
         }
         if(_exchangeBtn)
         {
            _exchangeBtn.removeEventListener("click",_exchangeHandler);
         }
         if(_openAll)
         {
            _openAll.removeEventListener("click",__openAllHandler);
         }
         CaddyModel.instance.bagInfo.removeEventListener("update",_update);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__changeBadLuckNumber);
         SocketManager.Instance.removeEventListener(PkgEvent.format(215),_getConverteds);
         SocketManager.Instance.removeEventListener(PkgEvent.format(211),_getexchange);
      }
      
      private function __changeBadLuckNumber(event:PlayerPropertyEvent) : void
      {
         var itemInfo:* = null;
         var evt:* = null;
         if(event.changedProperties["BadLuckNumber"])
         {
            if(PlayerManager.Instance.Self.badLuckNumber == 0)
            {
               return;
            }
            itemInfo = new InventoryItemInfo();
            itemInfo.TemplateID = 11550;
            ItemManager.fill(itemInfo);
            evt = new CaddyEvent("caddy_get_goodsinfo");
            _selectedGoodsInfo = itemInfo;
            evt.info = itemInfo;
            dispatchEvent(evt);
         }
      }
      
      private function _getAll(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(CaddyModel.instance.bagInfo.itemNumber > 0)
         {
            SocketManager.Instance.out.sendFinishRoulette();
         }
      }
      
      private function _sellAll(e:MouseEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         if(CaddyModel.instance.bagInfo.itemNumber > 0)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.sellAllNode") + getSellAllPriceString(),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert.moveEnable = false;
            alert.addEventListener("response",_responseI);
         }
      }
      
      public function getSellAllPriceString() : String
      {
         var gold:* = 0;
         var gift:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = CaddyModel.instance.bagInfo.items;
         for each(var info in CaddyModel.instance.bagInfo.items)
         {
            if(info.ReclaimType == 1)
            {
               gold = Number(gold + info.ReclaimValue * info.Count);
            }
            else if(info.ReclaimType == 2)
            {
               gift = Number(gift + info.ReclaimValue * info.Count);
            }
         }
         return (gold > 0?gold + LanguageMgr.GetTranslation("tank.hotSpring.gold"):"") + (gold > 0 && gift > 0?",":"") + (gift > 0?gift + LanguageMgr.GetTranslation("tank.gameover.takecard.gifttoken"):"");
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            SocketManager.Instance.out.sendSellAll();
         }
         ObjectUtils.disposeObject(e.currentTarget);
      }
      
      public function _update(e:BagEvent) : void
      {
         var c:* = null;
         var evt:* = null;
         var data:Dictionary = e.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = data;
         for(var i in data)
         {
            c = CaddyModel.instance.bagInfo.getItemAt(int(i));
            if(c)
            {
               _selectedGoodsInfo = c;
               _selectPlace = c.Place;
               evt = new CaddyEvent("caddy_get_goodsinfo");
               evt.info = _selectedGoodsInfo;
               dispatchEvent(evt);
            }
            else
            {
               _items[i].info = null;
            }
         }
      }
      
      public function __itemClick(event:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var item:CaddyCell = event.data as CaddyCell;
         var count:int = (item.info as InventoryItemInfo).Count;
         var bagType:int = _getBagType(item.info as InventoryItemInfo);
         SocketManager.Instance.out.sendMoveGoods(5,item.place,bagType,-1,count);
      }
      
      private function _getBagType(info:InventoryItemInfo) : int
      {
         var type:int = 0;
         if(info.Property1 == "31")
         {
            return 21;
         }
         var _loc3_:* = info.CategoryID;
         if(11 !== _loc3_)
         {
            if(10 !== _loc3_)
            {
               if(12 !== _loc3_)
               {
                  if(20 !== _loc3_)
                  {
                     if(53 !== _loc3_)
                     {
                        if(78 !== _loc3_)
                        {
                           if(23 !== _loc3_)
                           {
                              if(30 !== _loc3_)
                              {
                                 if(34 !== _loc3_)
                                 {
                                    if(35 !== _loc3_)
                                    {
                                       if(36 !== _loc3_)
                                       {
                                          if(32 !== _loc3_)
                                          {
                                             if(33 !== _loc3_)
                                             {
                                             }
                                             addr58:
                                             type = 0;
                                          }
                                          type = 13;
                                          §§goto(addr58);
                                       }
                                    }
                                    addr48:
                                    type = 1;
                                 }
                                 addr47:
                                 §§goto(addr48);
                              }
                              addr46:
                              §§goto(addr47);
                           }
                           addr45:
                           §§goto(addr46);
                        }
                        addr44:
                        §§goto(addr45);
                     }
                     addr43:
                     §§goto(addr44);
                  }
                  addr42:
                  §§goto(addr43);
               }
               addr41:
               §§goto(addr42);
            }
            §§goto(addr41);
         }
         else if(info.Property1 == "31")
         {
            type = 21;
         }
         else
         {
            type = 1;
         }
         return type;
      }
      
      public function findCell() : void
      {
         var point:* = null;
         if(_selectedGoodsInfo.TemplateID == 11550)
         {
            point = localToGlobal(new Point(685,285));
         }
         else
         {
            point = localToGlobal(new Point(_items[_selectPlace].x,_items[_selectPlace].y));
         }
         var evt:CaddyEvent = new CaddyEvent("send_nullCell_poing");
         evt.point = point;
         dispatchEvent(evt);
      }
      
      public function addCell() : void
      {
         if(_selectedGoodsInfo.TemplateID != 11550)
         {
            _items[_selectPlace].info = _selectedGoodsInfo;
         }
      }
      
      public function checkCell() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            if(_items[i].info != null)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function get sellBtn() : BaseButton
      {
         if(_sellAllBtn)
         {
            return _sellAllBtn;
         }
         if(_openAll)
         {
            return _openAll;
         }
         if(_convertedBtn)
         {
            return _convertedBtn;
         }
         if(_exchangeBtn)
         {
            return _exchangeBtn;
         }
         return null;
      }
      
      public function get exchangeBtn() : BaseButton
      {
         if(_exchangeBtn)
         {
            return _exchangeBtn;
         }
         return null;
      }
      
      public function get getAllBtn() : BaseButton
      {
         return _getAllBtn;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvents();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_sellAllBtn)
         {
            ObjectUtils.disposeObject(_sellAllBtn);
         }
         _sellAllBtn = null;
         if(_getAllBtn)
         {
            ObjectUtils.disposeObject(_getAllBtn);
         }
         _getAllBtn = null;
         if(_openAll)
         {
            ObjectUtils.disposeObject(_openAll);
         }
         _openAll = null;
         for(i = 0; i < _items.length; )
         {
            ObjectUtils.disposeObject(_items[i]);
            i++;
         }
         _items = null;
         _selectedGoodsInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
