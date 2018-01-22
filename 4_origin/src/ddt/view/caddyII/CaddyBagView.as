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
         var _loc5_:* = 0;
         var _loc3_:* = null;
         var _loc6_:* = 0;
         var _loc1_:* = null;
         var _loc4_:* = 0;
         var _loc2_:* = null;
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
            _loc5_ = uint(0);
            while(_loc5_ < 25)
            {
               _loc3_ = new CaddyCell(_loc5_);
               _items.push(_loc3_);
               _loc3_.addEventListener("itemclick",__itemClick);
               _list.addChild(_loc3_);
               _loc5_++;
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
            _loc6_ = uint(0);
            while(_loc6_ < 25)
            {
               _loc1_ = new CaddyCell(_loc6_);
               _items.push(_loc1_);
               _loc1_.addEventListener("itemclick",__itemClick);
               _list.addChild(_loc1_);
               _loc6_++;
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
            _loc4_ = uint(0);
            while(_loc4_ < 25)
            {
               _loc2_ = new CaddyCell(_loc4_);
               _items.push(_loc2_);
               _loc2_.addEventListener("itemclick",__itemClick);
               _list.addChild(_loc2_);
               _loc4_++;
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
      
      private function _getConverteds(param1:PkgEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         if(_loc3_.bytesAvailable == 0)
         {
            return;
         }
         _CaddyInfo = new CaddyInfo();
         _CaddyInfo.isConver = _loc3_.readBoolean();
         _CaddyInfo.totalSorce = _loc3_.readInt();
         _CaddyInfo.lotteryScore = _loc3_.readInt();
         _loc3_.clear();
         _haveExchange.text = String(_CaddyInfo.lotteryScore);
         if(_CaddyInfo.totalSorce != 0 && !_CaddyInfo.isConver && isAlert)
         {
            isAlert = false;
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.convertedAll",_CaddyInfo.totalSorce),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc2_.mouseEnabled = false;
            _loc2_.addEventListener("response",_responseII);
         }
      }
      
      private function _getexchange(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _CaddyInfo.lotteryScore = _loc2_.readInt();
         _haveExchange.text = String(_CaddyInfo.lotteryScore);
      }
      
      private function _responseII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendconverted(true);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function _exchangeHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_CaddyInfo.lotteryScore < 30)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.exchangeText1"));
         }
         else
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.exchangeAll",Math.floor(_CaddyInfo.lotteryScore / 30)),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc2_.mouseEnabled = false;
            _loc2_.addEventListener("response",_responseIII);
         }
      }
      
      private function _convertedHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendconverted(isConver);
         isAlert = true;
      }
      
      private function _responseIII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseIII);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendExchange();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      protected function __openAllHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(CaddyModel.instance.bagInfo.itemNumber > 0)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.opennAll"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc2_.moveEnable = false;
            _loc2_.addEventListener("response",_responseIV);
         }
      }
      
      private function _responseIV(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendOpenAll();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
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
      
      private function __changeBadLuckNumber(param1:PlayerPropertyEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.changedProperties["BadLuckNumber"])
         {
            if(PlayerManager.Instance.Self.badLuckNumber == 0)
            {
               return;
            }
            _loc3_ = new InventoryItemInfo();
            _loc3_.TemplateID = 11550;
            ItemManager.fill(_loc3_);
            _loc2_ = new CaddyEvent("caddy_get_goodsinfo");
            _selectedGoodsInfo = _loc3_;
            _loc2_.info = _loc3_;
            dispatchEvent(_loc2_);
         }
      }
      
      private function _getAll(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(CaddyModel.instance.bagInfo.itemNumber > 0)
         {
            SocketManager.Instance.out.sendFinishRoulette();
         }
      }
      
      private function _sellAll(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(CaddyModel.instance.bagInfo.itemNumber > 0)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.sellAllNode") + getSellAllPriceString(),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc2_.moveEnable = false;
            _loc2_.addEventListener("response",_responseI);
         }
      }
      
      public function getSellAllPriceString() : String
      {
         var _loc2_:* = 0;
         var _loc1_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = CaddyModel.instance.bagInfo.items;
         for each(var _loc3_ in CaddyModel.instance.bagInfo.items)
         {
            if(_loc3_.ReclaimType == 1)
            {
               _loc2_ = Number(_loc2_ + _loc3_.ReclaimValue * _loc3_.Count);
            }
            else if(_loc3_.ReclaimType == 2)
            {
               _loc1_ = Number(_loc1_ + _loc3_.ReclaimValue * _loc3_.Count);
            }
         }
         return (_loc2_ > 0?_loc2_ + LanguageMgr.GetTranslation("tank.hotSpring.gold"):"") + (_loc2_ > 0 && _loc1_ > 0?",":"") + (_loc1_ > 0?_loc1_ + LanguageMgr.GetTranslation("tank.gameover.takecard.gifttoken"):"");
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendSellAll();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      public function _update(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = _loc4_;
         for(var _loc5_ in _loc4_)
         {
            _loc2_ = CaddyModel.instance.bagInfo.getItemAt(int(_loc5_));
            if(_loc2_)
            {
               _selectedGoodsInfo = _loc2_;
               _selectPlace = _loc2_.Place;
               _loc3_ = new CaddyEvent("caddy_get_goodsinfo");
               _loc3_.info = _selectedGoodsInfo;
               dispatchEvent(_loc3_);
            }
            else
            {
               _items[_loc5_].info = null;
            }
         }
      }
      
      public function __itemClick(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:CaddyCell = param1.data as CaddyCell;
         var _loc3_:int = (_loc4_.info as InventoryItemInfo).Count;
         var _loc2_:int = _getBagType(_loc4_.info as InventoryItemInfo);
         SocketManager.Instance.out.sendMoveGoods(5,_loc4_.place,_loc2_,-1,_loc3_);
      }
      
      private function _getBagType(param1:InventoryItemInfo) : int
      {
         var _loc2_:int = 0;
         if(param1.Property1 == "31")
         {
            return 21;
         }
         var _loc3_:* = param1.CategoryID;
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
                                          addr41:
                                          _loc2_ = 0;
                                       }
                                       _loc2_ = 13;
                                       §§goto(addr41);
                                    }
                                 }
                                 addr33:
                                 _loc2_ = 1;
                              }
                              addr32:
                              §§goto(addr33);
                           }
                           addr31:
                           §§goto(addr32);
                        }
                        addr30:
                        §§goto(addr31);
                     }
                     addr29:
                     §§goto(addr30);
                  }
                  addr28:
                  §§goto(addr29);
               }
               addr27:
               §§goto(addr28);
            }
            §§goto(addr27);
         }
         else if(param1.Property1 == "31")
         {
            _loc2_ = 21;
         }
         else
         {
            _loc2_ = 1;
         }
         return _loc2_;
      }
      
      public function findCell() : void
      {
         var _loc1_:* = null;
         if(_selectedGoodsInfo.TemplateID == 11550)
         {
            _loc1_ = localToGlobal(new Point(685,285));
         }
         else
         {
            _loc1_ = localToGlobal(new Point(_items[_selectPlace].x,_items[_selectPlace].y));
         }
         var _loc2_:CaddyEvent = new CaddyEvent("send_nullCell_poing");
         _loc2_.point = _loc1_;
         dispatchEvent(_loc2_);
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            if(_items[_loc1_].info != null)
            {
               return true;
            }
            _loc1_++;
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
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            ObjectUtils.disposeObject(_items[_loc1_]);
            _loc1_++;
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
